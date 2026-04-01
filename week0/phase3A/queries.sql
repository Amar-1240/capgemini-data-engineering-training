-- Phase 3A – Data Quality and Cleaning Challenge
-- Dataset: customers and sales tables with intentional quality issues
-- Platform: DB Fiddle

-- ─────────────────────────────────────────────────────────────
-- Create tables with realistic data quality issues
-- ─────────────────────────────────────────────────────────────

CREATE TABLE customers (
    customer_id   INT,
    customer_name VARCHAR(100),
    city          VARCHAR(100),
    email         VARCHAR(150),
    phone         VARCHAR(20),
    age           INT
);

CREATE TABLE sales (
    sale_id       INT,
    customer_id   INT,
    sale_date     DATE,
    total_amount  DECIMAL(10, 2),
    category      VARCHAR(50)
);

-- Insert sample data with quality issues (nulls, duplicates, bad formatting)
INSERT INTO customers VALUES
(1,  'Amit Sharma',   'Hyderabad',  'amit@example.com',    '9876543210', 34),
(2,  '  Sneha Rao  ', 'Bangalore',  'SNEHA@EXAMPLE.COM',   '98-765-4321', 28),
(3,  'Rahul Kumar',   NULL,         'rahul@example.com',   NULL,          45),
(4,  'Priya Singh',   'Chennai',    'priya@example.com',   '9123456789',  29),
(5,  NULL,            'Hyderabad',  NULL,                  '9000000001',  NULL),
(6,  'Amit Sharma',   'Hyderabad',  'amit@example.com',    '9876543210', 34),  -- duplicate of row 1
(7,  'Meena Iyer',    'Pune',       'meena@example.com',   '(91)8888-8888', 52),
(8,  'Kiran Das',     'Kolkata',    'kiran@example.com',   '7777777777',  NULL);

INSERT INTO sales VALUES
(101, 1,  '2024-01-10', 250.00,   'Electronics'),
(102, 2,  '2024-01-15', 89.50,    'Clothing'),
(103, 1,  '2024-02-01', 5000.00,  'Electronics'),
(104, 3,  '2024-02-10', NULL,     'Furniture'),
(105, 4,  '2024-02-20', 120.00,   'Clothing'),
(106, 1,  '2024-03-05', 300.00,   'Electronics'),
(107, NULL,'2024-03-10', 75.00,   'Books'),
(102, 2,  '2024-01-15', 89.50,    'Clothing'),  -- duplicate of row 102
(108, 5,  '2024-03-15', 18000.00, 'Electronics'),  -- potential outlier
(109, 6,  '2024-03-20', 95.00,    'Books');

-- ─────────────────────────────────────────────────────────────
-- Query 1: Check null values
-- ─────────────────────────────────────────────────────────────

-- 1a. Count null values per column in customers
SELECT
    SUM(CASE WHEN customer_id   IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
    SUM(CASE WHEN customer_name IS NULL THEN 1 ELSE 0 END) AS null_customer_name,
    SUM(CASE WHEN city          IS NULL THEN 1 ELSE 0 END) AS null_city,
    SUM(CASE WHEN email         IS NULL THEN 1 ELSE 0 END) AS null_email,
    SUM(CASE WHEN phone         IS NULL THEN 1 ELSE 0 END) AS null_phone,
    SUM(CASE WHEN age           IS NULL THEN 1 ELSE 0 END) AS null_age
FROM customers;

-- 1b. Count null values per column in sales
SELECT
    SUM(CASE WHEN sale_id      IS NULL THEN 1 ELSE 0 END) AS null_sale_id,
    SUM(CASE WHEN customer_id  IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
    SUM(CASE WHEN sale_date    IS NULL THEN 1 ELSE 0 END) AS null_sale_date,
    SUM(CASE WHEN total_amount IS NULL THEN 1 ELSE 0 END) AS null_total_amount,
    SUM(CASE WHEN category     IS NULL THEN 1 ELSE 0 END) AS null_category
FROM sales;

-- 1c. Show rows with null customer_id in customers
SELECT * FROM customers
WHERE customer_id IS NULL;

-- 1d. Show rows with null total_amount in sales
SELECT * FROM sales
WHERE total_amount IS NULL;

-- ─────────────────────────────────────────────────────────────
-- Query 2: Remove duplicates
-- ─────────────────────────────────────────────────────────────

-- 2a. Detect duplicate customer records (same customer_id appearing more than once)
SELECT customer_id, COUNT(*) AS occurrences
FROM customers
WHERE customer_id IS NOT NULL
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- 2b. Detect duplicate sale records (same sale_id appearing more than once)
SELECT sale_id, COUNT(*) AS occurrences
FROM sales
WHERE sale_id IS NOT NULL
GROUP BY sale_id
HAVING COUNT(*) > 1;

-- 2c. View unique customers only (deduplicate using MIN to keep lowest rowid equivalent)
SELECT MIN(customer_id) AS customer_id, customer_name, city, email, phone, age
FROM customers
WHERE customer_id IS NOT NULL
GROUP BY customer_name, city, email, phone, age;

-- 2d. Remove duplicate sales rows (keep one occurrence per sale_id)
SELECT DISTINCT sale_id, customer_id, sale_date, total_amount, category
FROM sales
WHERE sale_id IS NOT NULL AND customer_id IS NOT NULL;

-- ─────────────────────────────────────────────────────────────
-- Query 3: Standardise formats
-- ─────────────────────────────────────────────────────────────

-- 3a. Trim whitespace from customer_name and standardise email to lowercase
SELECT
    customer_id,
    TRIM(customer_name)      AS customer_name,
    city,
    LOWER(TRIM(email))       AS email,
    phone,
    age
FROM customers
WHERE customer_id IS NOT NULL;

-- 3b. Remove non-numeric characters from phone numbers
-- (SQL REPLACE used iteratively to strip common separators)
SELECT
    customer_id,
    TRIM(customer_name) AS customer_name,
    REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(phone, '-', ''), '(', ''), ')', ''), ' ', ''), '+91', '') AS phone_clean
FROM customers
WHERE customer_id IS NOT NULL;

-- 3c. Fill null city with 'Unknown' and null age with 0
SELECT
    customer_id,
    TRIM(customer_name)              AS customer_name,
    COALESCE(city, 'Unknown')        AS city,
    LOWER(TRIM(email))               AS email,
    COALESCE(age, 0)                 AS age
FROM customers
WHERE customer_id IS NOT NULL;

-- 3d. Fill null total_amount with 0.00 in sales
SELECT
    sale_id,
    customer_id,
    sale_date,
    COALESCE(total_amount, 0.00) AS total_amount,
    category
FROM sales
WHERE sale_id IS NOT NULL AND customer_id IS NOT NULL;

-- ─────────────────────────────────────────────────────────────
-- Query 4: Detect outliers
-- ─────────────────────────────────────────────────────────────

-- 4a. Find statistical summary of total_amount in sales
SELECT
    MIN(total_amount)                          AS min_amount,
    MAX(total_amount)                          AS max_amount,
    AVG(total_amount)                          AS avg_amount,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_amount) AS q1,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_amount) AS q3
FROM sales
WHERE total_amount IS NOT NULL;

-- 4b. Flag outliers using IQR method (values outside Q1 - 1.5*IQR or Q3 + 1.5*IQR)
WITH stats AS (
    SELECT
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_amount) AS q1,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_amount) AS q3
    FROM sales
    WHERE total_amount IS NOT NULL
),
bounds AS (
    SELECT
        q1,
        q3,
        (q3 - q1)             AS iqr,
        q1 - 1.5 * (q3 - q1) AS lower_bound,
        q3 + 1.5 * (q3 - q1) AS upper_bound
    FROM stats
)
SELECT
    s.sale_id,
    s.customer_id,
    s.total_amount,
    b.lower_bound,
    b.upper_bound,
    CASE
        WHEN s.total_amount < b.lower_bound OR s.total_amount > b.upper_bound
        THEN 'OUTLIER'
        ELSE 'NORMAL'
    END AS outlier_flag
FROM sales s
CROSS JOIN bounds b
WHERE s.total_amount IS NOT NULL
ORDER BY s.total_amount DESC;

-- 4c. Show only outlier records
WITH stats AS (
    SELECT
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_amount) AS q1,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_amount) AS q3
    FROM sales
    WHERE total_amount IS NOT NULL
),
bounds AS (
    SELECT
        q1 - 1.5 * (q3 - q1) AS lower_bound,
        q3 + 1.5 * (q3 - q1) AS upper_bound
    FROM stats
)
SELECT s.sale_id, s.customer_id, s.total_amount
FROM sales s
CROSS JOIN bounds b
WHERE s.total_amount < b.lower_bound OR s.total_amount > b.upper_bound;

-- ─────────────────────────────────────────────────────────────
-- Query 5: Generate quality report
-- ─────────────────────────────────────────────────────────────

-- 5a. Quality report for customers table: before vs after cleaning metrics
SELECT
    'customers'                                                  AS dataset,
    COUNT(*)                                                     AS before_total_rows,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END)        AS before_null_key,
    (SELECT COUNT(*) - COUNT(DISTINCT customer_id || customer_name || COALESCE(city,'') || COALESCE(email,''))
     FROM customers)                                             AS before_duplicates,
    COUNT(DISTINCT customer_id)                                  AS after_unique_rows,
    0                                                            AS after_null_key,
    0                                                            AS after_duplicates
FROM customers;

-- 5b. Quality report for sales table: before vs after cleaning metrics
SELECT
    'sales'                                                      AS dataset,
    COUNT(*)                                                     AS before_total_rows,
    SUM(CASE WHEN sale_id IS NULL OR customer_id IS NULL THEN 1 ELSE 0 END) AS before_null_key,
    (SELECT COUNT(*) - COUNT(DISTINCT CAST(sale_id AS VARCHAR))
     FROM sales WHERE sale_id IS NOT NULL)                       AS before_duplicates,
    COUNT(DISTINCT sale_id)                                      AS after_unique_rows,
    0                                                            AS after_null_key,
    0                                                            AS after_duplicates
FROM sales;

-- 5c. Combined quality summary view
SELECT
    'customers' AS dataset,
    (SELECT COUNT(*) FROM customers)                                                  AS total_rows,
    (SELECT SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) FROM customers)     AS null_key_rows,
    (SELECT COUNT(*) - COUNT(DISTINCT customer_id) FROM customers WHERE customer_id IS NOT NULL) AS duplicate_ids,
    (SELECT SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END) FROM customers)            AS null_optional_col1,
    (SELECT SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) FROM customers)             AS null_optional_col2
UNION ALL
SELECT
    'sales'     AS dataset,
    (SELECT COUNT(*) FROM sales)                                                      AS total_rows,
    (SELECT SUM(CASE WHEN sale_id IS NULL OR customer_id IS NULL THEN 1 ELSE 0 END) FROM sales) AS null_key_rows,
    (SELECT COUNT(*) - COUNT(DISTINCT sale_id) FROM sales WHERE sale_id IS NOT NULL) AS duplicate_ids,
    (SELECT SUM(CASE WHEN total_amount IS NULL THEN 1 ELSE 0 END) FROM sales)        AS null_optional_col1,
    0                                                                                 AS null_optional_col2;
