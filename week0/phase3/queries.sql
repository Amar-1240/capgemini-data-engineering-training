-- Phase 2 – Data Transformation using SQL
-- Dataset: customers and orders tables
-- Platform: DB Fiddle

-- Create customers table
CREATE TABLE customers (
    customer_id   INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city          VARCHAR(100)
);

-- Create orders table
CREATE TABLE orders (
    order_id     INT PRIMARY KEY,
    customer_id  INT,
    order_amount DECIMAL(10, 2)
);

-- Insert sample data into customers
INSERT INTO customers VALUES
(1, 'Amit',  'Hyderabad'),
(2, 'Sneha', 'Bangalore'),
(3, 'Rahul', 'Chennai'),
(4, 'Priya', 'Hyderabad');

-- Insert sample data into orders
INSERT INTO orders VALUES
(1, 1, 150.00),
(2, 1, 250.00),
(3, 2, 500.00);

-- Query 1: Total order amount for each customer
SELECT customer_id, SUM(order_amount) AS total_order_amount
FROM orders
GROUP BY customer_id;

-- Query 2: Top 3 customers by total spend
SELECT customer_id, SUM(order_amount) AS total_order_amount
FROM orders
GROUP BY customer_id
ORDER BY total_order_amount DESC
LIMIT 3;

-- Query 3: Customers with no orders (left join to find unmatched records)
SELECT c.customer_id, c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Query 4: City-wise total revenue
SELECT c.city, SUM(o.order_amount) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city;

-- Query 5: Average order amount per customer
SELECT customer_id, AVG(order_amount) AS avg_order_val
FROM orders
GROUP BY customer_id;

-- Query 6: Customers with more than one order
SELECT customer_id, COUNT(order_id) AS order_count
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1;

-- Query 7: Sort customers by total spend in descending order
SELECT customer_id, SUM(order_amount) AS total_spend
FROM orders
GROUP BY customer_id
ORDER BY total_spend DESC;