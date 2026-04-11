/* =====================================================
   WINDOW FUNCTIONS – ROW_NUMBER, RANK, DENSE_RANK
===================================================== */

-- =========================================
-- TABLE CREATION
-- =========================================
CREATE TABLE employees (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    join_date DATE
);

-- =========================================
-- INSERT DATA
-- =========================================
INSERT INTO employees VALUES
(1, 'Amit', 'Chennai', 2000, '2023-01-01'),
(2, 'Ravi', 'Hyderabad', 1500, '2023-01-02'),
(3, 'Sneha', 'Chennai', 3000, '2023-01-03'),
(4, 'Kiran', 'Bangalore', 2500, '2023-01-04'),
(5, 'Priya', 'Chennai', 2000, '2023-01-05'),
(6, 'Arjun', 'Hyderabad', 1800, '2023-01-06'),
(7, 'Neha', 'Bangalore', 2200, '2023-01-07'),
(8, 'Vikas', 'Chennai', 3000, '2023-01-08'),
(9, 'Anjali', 'Hyderabad', 1700, '2023-01-09'),
(10, 'Rahul', 'Bangalore', 2600, '2023-01-10'),
(11, 'Suresh', 'Chennai', 2800, '2023-01-11'),
(12, 'Pooja', 'Hyderabad', 1600, '2023-01-12'),
(13, 'Manoj', 'Bangalore', 2400, '2023-01-13'),
(14, 'Divya', 'Chennai', 2100, '2023-01-14'),
(15, 'Karthik', 'Hyderabad', 1900, '2023-01-15'),
(16, 'Meena', 'Bangalore', 2300, '2023-01-16'),
(17, 'Raj', 'Chennai', 2700, '2023-01-17'),
(18, 'Simran', 'Hyderabad', 2000, '2023-01-18'),
(19, 'Deepak', 'Bangalore', 2500, '2023-01-19'),
(20, 'Nisha', 'Chennai', 2600, '2023-01-20');

--------------------------------------------------------

/* ================= ROW_NUMBER() ================= */

/* 1. Row number based on highest salary */
SELECT *,
ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num
FROM employees;

/* 2. Row number within each department (salary desc) */
SELECT *,
ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_row
FROM employees;

/* 3. Row number based on latest joining */
SELECT *,
ROW_NUMBER() OVER (ORDER BY join_date DESC) AS latest_join
FROM employees;

/* 4. Row number within department by earliest joining */
SELECT *,
ROW_NUMBER() OVER (PARTITION BY department ORDER BY join_date ASC) AS dept_join_rank
FROM employees;

/* 5. Row number based on salary lowest first */
SELECT *,
ROW_NUMBER() OVER (ORDER BY salary ASC) AS low_salary_rank
FROM employees;

/* 6. Row number within department alphabetically */
SELECT *,
ROW_NUMBER() OVER (PARTITION BY department ORDER BY emp_name) AS name_rank
FROM employees;

--------------------------------------------------------

/* ================= RANK() ================= */

/* 7. Rank employees by salary (highest first) */
SELECT *,
RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;

/* 8. Rank within department by salary */
SELECT *,
RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_rank
FROM employees;

/* 9. Rank based on latest joining */
SELECT *,
RANK() OVER (ORDER BY join_date DESC) AS join_rank
FROM employees;

/* 10. Rank employees by name */
SELECT *,
RANK() OVER (ORDER BY emp_name) AS name_rank
FROM employees;

/* 11. Rank within department lowest salary */
SELECT *,
RANK() OVER (PARTITION BY department ORDER BY salary ASC) AS low_rank
FROM employees;

--------------------------------------------------------

/* ================= DENSE_RANK() ================= */

/* 12. Dense rank based on salary */
SELECT *,
DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_salary_rank
FROM employees;

/* 13. Dense rank within department */
SELECT *,
DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_dense_rank
FROM employees;

/* 14. Dense rank based on joining date */
SELECT *,
DENSE_RANK() OVER (ORDER BY join_date DESC) AS dense_join_rank
FROM employees;

/* 15. Dense rank lowest salary */
SELECT *,
DENSE_RANK() OVER (ORDER BY salary ASC) AS dense_low_rank
FROM employees;

/* 16. Dense rank within department by joining */
SELECT *,
DENSE_RANK() OVER (PARTITION BY department ORDER BY join_date ASC) AS dept_join_dense
FROM employees;

--------------------------------------------------------

/* ================= BONUS: REAL USE CASES ================= */

/* 17. Top 3 highest salary employees */
SELECT *
FROM (
    SELECT *,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS rn
    FROM employees
) t
WHERE rn <= 3;

/* 18. Highest salary per department */
SELECT *
FROM (
    SELECT *,
    ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS rn
    FROM employees
) t
WHERE rn = 1;

/* 19. Second highest salary */
SELECT *
FROM (
    SELECT *,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM employees
) t
WHERE rnk = 2;

/* 20. Compare ranking differences */
SELECT emp_name, salary,
RANK() OVER (ORDER BY salary DESC) AS rank_val,
DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank_val
FROM employees;