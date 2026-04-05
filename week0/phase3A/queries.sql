-- Phase 3A – Data Quality & Cleaning Challenge
-- Objective: Identify and clean messy data before aggregation
-- Platform: DB Fiddle (MySQL)

-- Create messy customers table
CREATE TABLE customers (
    customer_id INT,
    name        VARCHAR(50),
    city        VARCHAR(50),
    age         INT
);

-- Insert messy data with nulls, duplicates and invalid values
INSERT INTO customers VALUES
(1,    'Ravi',  'Hyderabad', 25),
(2,    NULL,    'Chennai',   32),
(NULL, 'Arun',  'Hyderabad', 28),
(4,    'Meena', NULL,        30),
(4,    'Meena', NULL,        30),
(5,    'John',  'Bangalore', -5);

-- Identify null values in each column
SELECT
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS customer_id_nulls,
    SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END)        AS name_nulls,
    SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END)        AS city_nulls,
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END)         AS age_nulls
FROM customers;

-- Identify duplicate rows
SELECT customer_id, name, city, age, COUNT(*) AS count
FROM customers
GROUP BY customer_id, name, city, age
HAVING COUNT(*) > 1;

-- Identify invalid age records
SELECT * FROM customers WHERE age <= 0;

-- Clean: remove null customer_id, fill missing city, remove duplicates, filter invalid age
SELECT DISTINCT
    customer_id,
    COALESCE(name, 'Unknown') AS name,
    COALESCE(city, 'Unknown') AS city,
    age
FROM customers
WHERE customer_id IS NOT NULL
AND age > 0;


-- Rows before and after cleaning, Rows removed
SELECT 
    COUNT(*) AS rows_before,
    COUNT(CASE WHEN customer_id IS NOT NULL AND age > 0 THEN 1 END) AS rows_after,
    COUNT(*) - COUNT(CASE WHEN customer_id IS NOT NULL AND age > 0 THEN 1 END) AS rows_removed
FROM customers;

-- Aggregation: customers per city after cleaning
SELECT
    COALESCE(city, 'Unknown') AS city,
    COUNT(DISTINCT customer_id) AS customer_count
FROM customers
WHERE customer_id IS NOT NULL
AND age > 0
GROUP BY city
ORDER BY customer_count DESC;