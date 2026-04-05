-- Phase 4A – Bucketing & Segmentation in SQL
-- Objective: Convert continuous spend values into customer segments
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

-- Insert sample data (same as Phase 4)
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

-- Task 1: Gold/Silver/Bronze segmentation using CASE WHEN (fixed thresholds)
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

-- Task 2: Count customers per segment
SELECT
    CASE
        WHEN total_spend > 10000                THEN 'Gold'
        WHEN total_spend BETWEEN 5000 AND 10000 THEN 'Silver'
        ELSE 'Bronze'
    END AS segment,
    COUNT(*) AS customer_count
FROM (
    SELECT customer_id, ROUND(SUM(total_amount), 2) AS total_spend
    FROM sales
    GROUP BY customer_id
) spend_summary
GROUP BY segment
ORDER BY segment;

-- Task 3: Quantile-based segmentation
-- Approximating 33rd and 66th percentile using subquery ranking
SELECT
    c.first_name,
    c.last_name,
    ROUND(SUM(s.total_amount), 2) AS total_spend,
    CASE
        WHEN SUM(s.total_amount) > (
            SELECT MAX(total_spend) * 0.66
            FROM (
                SELECT customer_id, SUM(total_amount) AS total_spend
                FROM sales GROUP BY customer_id
            ) t
        ) THEN 'Top Tier'
        WHEN SUM(s.total_amount) > (
            SELECT MAX(total_spend) * 0.33
            FROM (
                SELECT customer_id, SUM(total_amount) AS total_spend
                FROM sales GROUP BY customer_id
            ) t
        ) THEN 'Mid Tier'
        ELSE 'Low Tier'
    END AS quantile_segment
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spend DESC;

-- Task 4: Compare fixed threshold vs quantile-based segmentation
SELECT
    c.first_name,
    c.last_name,
    ROUND(SUM(s.total_amount), 2) AS total_spend,
    CASE
        WHEN SUM(s.total_amount) > 10000                THEN 'Gold'
        WHEN SUM(s.total_amount) BETWEEN 5000 AND 10000 THEN 'Silver'
        ELSE 'Bronze'
    END AS fixed_segment,
    CASE
        WHEN SUM(s.total_amount) > (
            SELECT MAX(total_spend) * 0.66
            FROM (SELECT customer_id, SUM(total_amount) AS total_spend FROM sales GROUP BY customer_id) t
        ) THEN 'Top Tier'
        WHEN SUM(s.total_amount) > (
            SELECT MAX(total_spend) * 0.33
            FROM (SELECT customer_id, SUM(total_amount) AS total_spend FROM sales GROUP BY customer_id) t
        ) THEN 'Mid Tier'
        ELSE 'Low Tier'
    END AS quantile_segment
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spend DESC;

-- Task 5: Reflection – Fixed thresholds are more useful for business reporting
-- because they reflect actual business rules defined by stakeholders.
-- Quantile-based is useful for exploratory analysis when thresholds are unknown.
-- Fixed segment distribution summary:
SELECT
    CASE
        WHEN total_spend > 10000                THEN 'Gold'
        WHEN total_spend BETWEEN 5000 AND 10000 THEN 'Silver'
        ELSE 'Bronze'
    END AS segment,
    COUNT(*)                        AS customer_count,
    ROUND(MIN(total_spend), 2)      AS min_spend,
    ROUND(MAX(total_spend), 2)      AS max_spend,
    ROUND(AVG(total_spend), 2)      AS avg_spend
FROM (
    SELECT customer_id, ROUND(SUM(total_amount), 2) AS total_spend
    FROM sales
    GROUP BY customer_id
) spend_summary
GROUP BY segment
ORDER BY avg_spend DESC;