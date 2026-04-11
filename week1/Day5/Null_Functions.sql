/* =========================================
   TABLE CREATION
========================================= */

CREATE TABLE Employees (
    emp_id INT,
    name VARCHAR(50),
    salary INT,
    bonus INT,
    manager_id INT
);

INSERT INTO Employees VALUES
(1, 'Amit', 50000, NULL, 101),
(2, 'John', NULL, 5000, 102),
(3, 'Sara', 60000, NULL, NULL),
(4, 'David', NULL, NULL, 103),
(5, 'Priya', 45000, 3000, 101),
(6, 'Kiran', NULL, NULL, NULL),
(7, 'Ravi', 70000, 7000, 102),
(8, 'Neha', NULL, 2000, NULL);

--------------------------------------------------------

CREATE TABLE Orders (
    order_id INT,
    customer_name VARCHAR(50),
    amount INT,
    discount INT,
    coupon_code VARCHAR(20)
);

INSERT INTO Orders VALUES
(101, 'Amit', 1000, NULL, 'DISC10'),
(102, 'John', NULL, 50, NULL),
(103, 'Sara', 2000, NULL, 'DISC20'),
(104, 'David', NULL, NULL, NULL),
(105, 'Priya', 1500, 100, NULL),
(106, 'Kiran', NULL, NULL, 'DISC5'),
(107, 'Ravi', 3000, NULL, NULL),
(108, 'Neha', NULL, 200, 'DISC15');

--------------------------------------------------------

CREATE TABLE Products (
    product_id INT,
    product_name VARCHAR(50),
    price INT,
    category VARCHAR(50),
    stock INT
);

INSERT INTO Products VALUES
(1, 'Laptop', 50000, 'Electronics', 10),
(2, 'Phone', NULL, 'Electronics', NULL),
(3, 'Tablet', 30000, NULL, 5),
(4, 'Headphones', NULL, NULL, NULL),
(5, 'Monitor', 20000, 'Electronics', 0),
(6, 'Keyboard', NULL, 'Accessories', 15),
(7, 'Mouse', 500, NULL, NULL),
(8, 'Printer', NULL, 'Electronics', 3);

--------------------------------------------------------

/* ================= LEVEL 1 ================= */

/* 1 */
SELECT * FROM Employees WHERE salary IS NULL;

/* 2 */
SELECT * FROM Orders WHERE discount IS NOT NULL;

/* 3 */
SELECT * FROM Products WHERE category IS NULL;

/* 4 */
SELECT COUNT(*) FROM Employees WHERE manager_id IS NULL;

--------------------------------------------------------

/* ================= LEVEL 2 (ISNULL / IFNULL) ================= */

/* 5 */
SELECT emp_id, IFNULL(salary,0) AS salary FROM Employees;

/* 6 */
SELECT emp_id, IFNULL(bonus,1000) AS bonus FROM Employees;

/* 7 */
SELECT order_id, IFNULL(amount,500) AS amount FROM Orders;

/* 8 */
SELECT product_id, IFNULL(stock,0) AS stock FROM Products;

--------------------------------------------------------

/* ================= LEVEL 3 (COALESCE) ================= */

/* 9 */
SELECT emp_id, COALESCE(salary, bonus) AS earnings FROM Employees;

/* 10 */
SELECT emp_id, COALESCE(salary, bonus, 0) AS earnings FROM Employees;

/* 11 */
SELECT product_id, COALESCE(price,1000) AS price FROM Products;

/* 12 */
SELECT order_id, COALESCE(amount, discount, 0) AS payment FROM Orders;

--------------------------------------------------------

/* ================= LEVEL 4 (NULLIF) ================= */

/* 13 */
SELECT emp_id, NULLIF(salary,0) FROM Employees;

/* 14 */
SELECT order_id, NULLIF(discount,0) FROM Orders;

/* 15 */
SELECT amount / NULLIF(discount,0) FROM Orders;

/* 16 */
SELECT order_id, NULLIF(coupon_code,'DISC10') FROM Orders;

--------------------------------------------------------

/* ================= LEVEL 5 ================= */

/* 17 */
SELECT emp_id, 
COALESCE(salary,0) + COALESCE(bonus,0) AS total_income
FROM Employees;

/* 18 */
SELECT * FROM Employees 
WHERE salary IS NULL AND bonus IS NULL;

/* 19 */
SELECT * FROM Products 
WHERE price IS NULL AND category IS NOT NULL;

/* 20 */
SELECT * FROM Orders 
WHERE amount IS NULL AND discount IS NULL;

--------------------------------------------------------

/* ================= LEVEL 6 ================= */

/* 21 */
SELECT emp_id, COALESCE(salary, bonus, 1000) AS income 
FROM Employees;

/* 22 */
SELECT order_id, NULLIF(discount,0) FROM Orders;

/* 23 */
SELECT order_id,
COALESCE(amount,0) - COALESCE(discount,0) AS final_amount
FROM Orders;

/* 24 */
SELECT * FROM Employees 
WHERE salary IS NULL AND manager_id IS NOT NULL;