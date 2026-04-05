-- Phase 4 – Mini Project: Business Pipeline & Analytics
-- Objective: Build end-to-end SQL pipeline generating business insights
-- Platform: DB Fiddle (MySQL)

-- Create customers table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name  VARCHAR(50),
    last_name   VARCHAR(50),
    city        VARCHAR(50)
);

-- Create sales table
CREATE TABLE sales (
    sale_id      INT PRIMARY KEY,
    customer_id  INT,
    sale_date    DATE,
    total_amount DECIMAL(10, 2)
);

-- Insert customers data
INSERT INTO customers VALUES
(1,  'John',     'Smith',     'Springfield'),
(2,  'Emma',     'Jones',     'Centerville'),
(3,  'Olivia',   'Brown',     'Greenville'),
(4,  'Liam',     'Johnson',   'Riverside'),
(5,  'Noah',     'Williams',  'Lakeside'),
(6,  'Alice',    'Miller',    'Oakland'),
(7,  'Isabella', 'Davis',     'Boise'),
(8,  'James',    'Martinez',  'Des Moines'),
(9,  'Sophia',   'Garcia',    'Albany'),
(10, 'Lucas',    'Rodriguez', 'Portland');

-- Insert sales data (amounts cover Gold >10000, Silver 5000-10000, Bronze <5000)
INSERT INTO sales VALUES
(1,  1,  '2024-01-15', 3999.98),
(2,  1,  '2024-01-20', 2999.99),
(3,  2,  '2024-01-16', 5000.00),
(4,  2,  '2024-01-22', 8997.00),
(5,  3,  '2024-01-17', 4998.00),
(6,  4,  '2024-01-18', 11996.00),
(7,  4,  '2024-01-25', 1550.00),
(8,  5,  '2024-01-19', 6675.00),
(9,  6,  '2024-01-20', 4000.00),
(10, 7,  '2024-01-21', 10995.00),
(11, 8,  '2024-01-22', 2000.00),
(12, 9,  '2024-01-23', 7996.00),
(13, 10, '2024-01-24', 5500.00),
(14, 1,  '2024-01-25', 1500.00),
(15, 2,  '2024-01-26', 3000.00);

-- Task 1: Daily Sales
SELECT
    sale_date,
    ROUND(SUM(total_amount), 2) AS total_sales
FROM sales
WHERE total_amount > 0
GROUP BY sale_date
ORDER BY sale_date;

-- Task 2: City-wise Revenue
SELECT
    c.city,
    ROUND(SUM(s.total_amount), 2) AS total_revenue
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
WHERE s.total_amount > 0
GROUP BY c.city
ORDER BY total_revenue DESC;

-- Task 3: Top 5 Customers by Total Spend
SELECT
    c.first_name,
    c.last_name,
    ROUND(SUM(s.total_amount), 2) AS total_spend
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spend DESC
LIMIT 5;

-- Task 4: Repeat Customers (more than 1 order)
SELECT
    customer_id,
    COUNT(sale_id) AS order_count
FROM sales
GROUP BY customer_id
HAVING COUNT(sale_id) > 1
ORDER BY order_count DESC;

-- Task 5: Customer Segmentation
SELECT
    c.first_name,
    c.last_name,
    ROUND(SUM(s.total_amount), 2) AS total_spend,
    CASE
        WHEN SUM(s.total_amount) > 10000                THEN 'Gold'
        WHEN SUM(s.total_amount) BETWEEN 5000 AND 10000 THEN 'Silver'
        ELSE 'Bronze'
    END AS segment
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spend DESC;

-- Task 6: Final Reporting Table
SELECT
    c.first_name,
    c.last_name,
    c.city,
    ROUND(SUM(s.total_amount), 2) AS total_spend,
    COUNT(s.sale_id) AS order_count,
    CASE
        WHEN SUM(s.total_amount) > 10000                THEN 'Gold'
        WHEN SUM(s.total_amount) BETWEEN 5000 AND 10000 THEN 'Silver'
        ELSE 'Bronze'
    END AS segment
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.city
ORDER BY total_spend DESC;