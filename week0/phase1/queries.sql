-- Phase 1 – Filtering and Selection
-- Dataset: customers (customer_id, customer_name, city, age)
-- Platform: DB Fiddle

-- Create customers table
CREATE TABLE customers (
    customer_id   INT,
    customer_name VARCHAR(50),
    city          VARCHAR(50),
    age           INT
);

-- Insert sample data
INSERT INTO customers VALUES
(1, 'Ravi',  'Hyderabad', 25),
(2, 'Sita',  'Chennai',   32),
(3, 'Arun',  'Hyderabad', 28),
(4, 'Meena', 'Bengaluru', 35),
(5, 'Kiran', 'Chennai',   22);

-- Exercise 1: Show all customers
SELECT * FROM customers;

-- Exercise 2: Filter customers from Chennai only
SELECT * FROM customers
WHERE city = 'Chennai';

-- Exercise 3: Filter customers whose age is greater than 25
SELECT * FROM customers
WHERE age > 25;

-- Exercise 4: Select only customer_name and city columns
SELECT customer_name, city
FROM customers;

-- Exercise 5: Count number of customers in each city
SELECT city, COUNT(*) AS customer_count
FROM customers
GROUP BY city
ORDER BY customer_count DESC;