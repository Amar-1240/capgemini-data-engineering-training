CREATE TABLE customers (
    customer_id   INT,
    customer_name VARCHAR(50),
    city          VARCHAR(50),
    age           INT
);


INSERT INTO customers VALUES
(1, 'Ravi',  'Hyderabad', 25),
(2, 'Sita',  'Chennai',   32),
(3, 'Arun',  'Hyderabad', 28),
(4, 'Meena', 'Bengaluru', 35),
(5, 'Kiran', 'Chennai',   22);

SELECT * FROM customers;

SELECT * FROM customers
WHERE city = 'Chennai';


SELECT * FROM customers
WHERE age > 25;


SELECT customer_name, city
FROM customers;


SELECT city, COUNT(*) AS customer_count
FROM customers
GROUP BY city
ORDER BY customer_count DESC;