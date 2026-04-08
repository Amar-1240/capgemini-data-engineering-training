-- ============================================================
-- Phase 6 – FINAL SQL (DB Fiddle, MySQL 8)
-- ============================================================

-- =========================
-- CREATE TABLES
-- =========================

CREATE TABLE customers (
    customer_id INT,
    name        VARCHAR(100),
    email       VARCHAR(100),
    city        VARCHAR(50)
);

CREATE TABLE orders (
    order_id    INT,
    customer_id INT,
    order_date  DATE,
    amount      INT
);

-- =========================
-- INSERT DATA
-- =========================

INSERT INTO customers VALUES
(1, 'John Doe', 'john@example.com',  'Hyderabad'),
(2, 'Alice ',   'alice@example.com', 'Chennai'),
(3, NULL,       'bob@example.com',   'Bangalore'),
(4, 'David',    NULL,                'Mumbai'),
(5, 'Eva',      'eva@example.com',   'Hyderabad'),
(6, 'Frank',    'frank@example.com', 'Delhi');

INSERT INTO orders VALUES
(101, 1,  '2024-01-01', 1000),
(102, 2,  '2024-01-02', 2000),
(103, 3,  '2024-01-03', -500),
(104, 99, '2024-01-04', 1500),
(105, 1,  '2024-01-05', NULL),
(106, 5,  '2024-01-06', 3000),
(107, 5,  '2024-01-07', 3000);

-- ============================================================
-- PRACTICE SET A – JOIN DRILLS
-- ============================================================

-- A1: INNER JOIN
SELECT o.order_id, o.amount, c.name, c.city
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- A2: LEFT JOIN
SELECT o.order_id, o.customer_id, o.amount, c.name, c.city
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id;

-- A3: INVALID (LEFT ANTI)
SELECT o.*
FROM orders o
LEFT JOIN customers c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- ============================================================
-- PRACTICE SET B – WINDOW FUNCTIONS
-- ============================================================

-- B1: Top 3 per city
WITH customers_clean AS (
    SELECT customer_id, TRIM(name) AS name, city
    FROM customers
    WHERE name IS NOT NULL
),
orders_clean AS (
    SELECT *
    FROM orders
    WHERE amount IS NOT NULL AND amount > 0
)
SELECT *
FROM (
    SELECT
        c.name,
        c.city,
        SUM(o.amount) AS total_spend,
        RANK() OVER (PARTITION BY c.city ORDER BY SUM(o.amount) DESC) AS city_rank
    FROM customers_clean c
    JOIN orders_clean o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.name, c.city
) t
WHERE city_rank <= 3;

-- B2: Running total
WITH orders_clean AS (
    SELECT *
    FROM orders
    WHERE amount IS NOT NULL AND amount > 0
)
SELECT
    order_id,
    order_date,
    amount,
    SUM(amount) OVER (ORDER BY order_date) AS running_total
FROM orders_clean;

-- B3: Global rank
WITH customers_clean AS (
    SELECT customer_id, TRIM(name) AS name, city
    FROM customers
    WHERE name IS NOT NULL
),
orders_clean AS (
    SELECT *
    FROM orders
    WHERE amount IS NOT NULL AND amount > 0
)
SELECT *
FROM (
    SELECT
        c.name,
        c.city,
        SUM(o.amount) AS total_spend,
        RANK() OVER (ORDER BY SUM(o.amount) DESC) AS spend_rank
    FROM customers_clean c
    JOIN orders_clean o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.name, c.city
) t;

-- B4: LAG
WITH customers_clean AS (
    SELECT customer_id, TRIM(name) AS name
    FROM customers
),
orders_clean AS (
    SELECT *
    FROM orders
    WHERE amount IS NOT NULL AND amount > 0
)
SELECT
    c.name,
    o.order_id,
    o.order_date,
    o.amount,
    LAG(o.amount) OVER (PARTITION BY o.customer_id ORDER BY o.order_date) AS prev_amount
FROM orders_clean o
JOIN customers_clean c ON o.customer_id = c.customer_id;

-- ============================================================
-- PRACTICE SET C – DATE ANALYSIS
-- ============================================================

-- C1: Date parts
WITH orders_clean AS (
    SELECT *
    FROM orders
    WHERE amount IS NOT NULL AND amount > 0
)
SELECT
    order_id,
    order_date,
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    DAY(order_date) AS day
FROM orders_clean;

-- C2: Monthly sales
WITH orders_clean AS (
    SELECT *
    FROM orders
    WHERE amount IS NOT NULL AND amount > 0
)
SELECT
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    COUNT(*) AS total_orders,
    SUM(amount) AS revenue
FROM orders_clean
GROUP BY year, month;

-- C3: Days since order
WITH orders_clean AS (
    SELECT *
    FROM orders
    WHERE amount IS NOT NULL AND amount > 0
)
SELECT
    order_id,
    order_date,
    amount,
    DATEDIFF(CURDATE(), order_date) AS days_since
FROM orders_clean;

-- C4: Monthly trend + cumulative
WITH monthly AS (
    SELECT
        YEAR(order_date) AS year,
        MONTH(order_date) AS month,
        SUM(amount) AS revenue
    FROM orders
    WHERE amount IS NOT NULL AND amount > 0
    GROUP BY year, month
)
SELECT
    year,
    month,
    revenue,
    SUM(revenue) OVER (ORDER BY year, month) AS cumulative_revenue
FROM monthly;

-- ============================================================
-- PRACTICE SET D – FINAL PIPELINE
-- ============================================================

WITH customers_clean AS (
    SELECT customer_id, TRIM(name) AS name, city
    FROM customers
    WHERE name IS NOT NULL AND email IS NOT NULL
),
orders_clean AS (
    SELECT *
    FROM orders
    WHERE amount IS NOT NULL AND amount > 0
)
SELECT
    c.customer_id,
    c.name,
    c.city,
    SUM(o.amount) AS total_spend,
    COUNT(o.order_id) AS total_orders,
    RANK() OVER (ORDER BY SUM(o.amount) DESC) AS spend_rank
    FROM customers_clean c
    JOIN orders_clean o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.name, c.city;