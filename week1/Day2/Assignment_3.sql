/*Creating Employee and Sales tables*/

CREATE TABLE Employee (
emp_id INT PRIMARY KEY,
emp_name VARCHAR(50),
department VARCHAR(50),
salary DECIMAL(10, 2),
joining_date DATE
);
INSERT INTO Employee (emp_id, emp_name, department, salary, joining_date) VALUES
(1, 'Karthik', 'HR', 60000.00, '2021-01-15'),
(2, 'Pratik', 'Finance', 70000.00, '2021-03-10'),
(3, 'Veer', 'HR', 55000.00, '2021-06-20'),
(4, 'Priya', 'Finance', 80000.00, '2022-01-05'),
(5, 'Ajay', 'Engineering', 75000.00, '2020-11-01'),
(6, 'Vijay', 'Engineering', 78000.00, '2019-05-22'),
(7, 'Veena', 'HR', 62000.00, '2023-03-12'),
(8, 'Meena', 'Marketing', 65000.00, '2022-08-18');
CREATE TABLE Sales (
sales_id INT PRIMARY KEY,
emp_id INT,
product VARCHAR(50),
amount DECIMAL(10, 2),
sale_date DATE
);
INSERT INTO Sales (sales_id, emp_id, product, amount, sale_date) VALUES
(1, 1, 'Laptop', 50000.00, '2023-01-15'),
(2, 2, 'Mobile', 30000.00, '2023-02-18'),
(3, 3, 'Tablet', 20000.00, '2023-02-25'),
(4, 4, 'Laptop', 45000.00, '2023-03-05'),
(5, 5, 'Mobile', 35000.00, '2023-03-12'),
(6, 6, 'Tablet', 25000.00, '2023-03-20'),
(7, 7, 'Laptop', 60000.00, '2023-04-01'),
(8, 8, 'Mobile', 40000.00, '2023-04-10');


/* Finding the total salary for each department in the Employee table. */
SELECT department, SUM(salary) AS total_salary 
FROM Employee 
GROUP BY department;

/* Counting the number of employees in each department. */
SELECT department, COUNT(emp_id) AS count_of_employees 
FROM Employee 
GROUP BY department;

/* Calculating the average salary of employees in each department. */
SELECT department, AVG(salary) AS avg_salary 
FROM Employee 
GROUP BY department;

/* Finding the maximum salary in each department. */
SELECT department, MAX(salary) AS max_salary 
FROM Employee 
GROUP BY department;

/* Finding the minimum salary in each department. */
SELECT department, MIN(salary) AS min_salary 
FROM Employee 
GROUP BY department;

/* Finding the total salary for departments where the total salary exceeds 100,000. */
SELECT department, SUM(salary) AS total_salary 
FROM Employee 
GROUP BY department 
HAVING SUM(salary) > 100000;

/* Counting the number of employees in departments with more than 2 employees. */
SELECT department, COUNT(emp_id) AS count_of_employees 
FROM Employee 
GROUP BY department 
HAVING COUNT(emp_id) > 2;

/* Calculating the average salary for employees who joined after 2021-01-01, grouped by department. */
SELECT department, AVG(salary) AS avg_salary 
FROM Employee 
WHERE joining_date > '2021-01-01' 
GROUP BY department;

/* Finding the departments where the maximum salary is greater than 75,000. */
SELECT department, MAX(salary) AS max_salary 
FROM Employee 
GROUP BY department 
HAVING MAX(salary) > 75000;

/* Finding the departments where the minimum salary is less than 150,000. */
SELECT department, MIN(salary) AS min_salary 
FROM Employee 
GROUP BY department 
HAVING MIN(salary) < 150000;

/* Finding the total number of employees grouped by department, but only include departments with more than 1 employee. */
SELECT department, COUNT(emp_id) AS count_of_employees 
FROM Employee 
GROUP BY department 
HAVING COUNT(emp_id) > 1;

/* Calculating the total salary of each department and show only those where the total exceeds 125,000. */
SELECT department, SUM(salary) AS total_salary 
FROM Employee 
GROUP BY department 
HAVING SUM(salary) > 125000;

/* Count the number of employees in each department, but include only departments with more than 2 employees. */
SELECT department, COUNT(emp_id) AS count_of_employees 
FROM Employee 
GROUP BY department 
HAVING COUNT(emp_id) > 2;

/* Find the average salary in each department where the average salary is above 60,000. */
SELECT department, AVG(salary) AS avg_salary 
FROM Employee 
GROUP BY department 
HAVING AVG(salary) > 60000;

/* Show departments where the sum of salaries is between 100,000 and 200,000. */
SELECT department, SUM(salary) AS total_salary 
FROM Employee 
GROUP BY department 
HAVING SUM(salary) BETWEEN 100000 AND 200000;

/* Find the total sales amount for each employee. */
SELECT emp_id, SUM(amount) AS total_sales_amount 
FROM Sales 
GROUP BY emp_id;

/* List the number of sales made by each employee. */
SELECT emp_id, COUNT(sales_id) AS total_sales_count 
FROM Sales 
GROUP BY emp_id;

/* Find the total sales amount grouped by product. */
SELECT product, SUM(amount) AS total_sales_amount 
FROM Sales 
GROUP BY product;

/* Calculate the average sales amount for each product. */
SELECT product, AVG(amount) AS avg_sales_amount 
FROM Sales 
GROUP BY product;

/* Find employees who have made more than 2 sales, grouped by their names. */
SELECT e.emp_name, COUNT(s.sales_id) AS total_sales_count 
FROM Employee e 
JOIN Sales s ON e.emp_id = s.emp_id 
GROUP BY e.emp_name 
HAVING COUNT(s.sales_id) > 2;

/* Calculate the total salary and total sales amount for each employee, grouped by their names. */
SELECT e.emp_name, SUM(e.salary) AS total_salary, SUM(s.amount) AS total_sales_amount 
FROM Employee e 
JOIN Sales s ON e.emp_id = s.emp_id 
GROUP BY e.emp_name;

/* Count the number of unique products sold by each employee. */
SELECT e.emp_name, COUNT(DISTINCT s.product) AS unique_products_sold 
FROM Employee e 
JOIN Sales s ON e.emp_id = s.emp_id 
GROUP BY e.emp_name;

/* Find the highest sales amount made by each employee. */
SELECT e.emp_name, MAX(s.amount) AS highest_sales_amount 
FROM Employee e 
JOIN Sales s ON e.emp_id = s.emp_id 
GROUP BY e.emp_name;

/* Calculate the total sales amount grouped by product and filtered by products where the total exceeds 50,000. */
SELECT product, SUM(amount) AS total_sales_amount 
FROM Sales 
GROUP BY product 
HAVING SUM(amount) > 50000;

/* Find the departments with the highest average sales amount. */
SELECT e.department, AVG(s.amount) AS avg_sales_amount 
FROM Employee e 
JOIN Sales s ON e.emp_id = s.emp_id 
GROUP BY e.department 
ORDER BY avg_sales_amount DESC 
LIMIT 1;

/* Find the department with the highest total sales amount. */
SELECT e.department, SUM(s.amount) AS total_sales_amount 
FROM Employee e 
JOIN Sales s ON e.emp_id = s.emp_id 
GROUP BY e.department 
ORDER BY total_sales_amount DESC 
LIMIT 1;

/* Show the top 3 employees with the highest total sales amount, grouped by employee names. */
SELECT e.emp_name, SUM(s.amount) AS total_sales_amount 
FROM Employee e 
JOIN Sales s ON e.emp_id = s.emp_id 
GROUP BY e.emp_name 
ORDER BY total_sales_amount DESC 
LIMIT 3;

/* Calculate the total number of employees and the average salary, grouped by the year of joining. */
SELECT YEAR(joining_date) AS joining_year, COUNT(emp_id) AS total_employees, AVG(salary) AS avg_salary 
FROM Employee 
GROUP BY YEAR(joining_date);

/* Find the total sales amount for each department (using a join between Employee and Sales). */
SELECT e.department, SUM(s.amount) AS total_sales_amount 
FROM Employee e 
JOIN Sales s ON e.emp_id = s.emp_id 
GROUP BY e.department;

/* Show employees who have not made any sales, grouped by their department. */
SELECT e.emp_name, e.department 
FROM Employee e 
LEFT JOIN Sales s ON e.emp_id = s.emp_id 
WHERE s.sales_id IS NULL 
GROUP BY e.emp_name, e.department;
