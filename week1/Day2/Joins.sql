/*Create tables and insert sample data for employees, departments, and projects.*/
CREATE TABLE employees (
emp_id INT PRIMARY KEY,
emp_name VARCHAR(50),
manager_id INT,
dept_id INT
);
INSERT INTO employees (emp_id, emp_name, manager_id, dept_id) VALUES
(1, 'Karthik', NULL, 1),
(2, 'Ajay', 1, 1),
(3, 'Vijay', 1, 2),
(4, 'Vinay', 2, 2),
(5, 'Meena', 3, 3),
(6, 'Veer', NULL, 4),
(7, 'Keerthi', 4, 5),
(8, 'Priya', 4, 5);

CREATE TABLE departments (
dept_id INT PRIMARY KEY,
dept_name VARCHAR(50)
);

INSERT INTO departments (dept_id, dept_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Marketing'),
(5, 'Sales');

CREATE TABLE projects (
project_id INT PRIMARY KEY,
project_name VARCHAR(50),
emp_id INT
);

INSERT INTO projects (project_id, project_name, emp_id) VALUES
(1, 'Project A', 1),
(2, 'Project B', 2),
(3, 'Project C', 3),
(4, 'Project D', 4),
(5, 'Project E', 5);

/* 1. Retrieve names of employees and their managers (including those without managers) */
SELECT e.emp_name AS Employee, m.emp_name AS Manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;

/* 2. Display all employees and their departments (including those without departments) */
SELECT e.emp_name AS Employee, d.dept_name AS Department
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;

/* 3. Employees who report to a manager */
SELECT e.emp_name AS Employee, m.emp_name AS Manager
FROM employees e
JOIN employees m ON e.manager_id = m.emp_id;

/* 4. Total salary paid to each employee and department (includes depts with no employees) */
SELECT d.dept_name AS Department, e.emp_name AS Employee, SUM(p.salary) AS Total_Salary
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
LEFT JOIN projects p ON e.emp_id = p.emp_id
GROUP BY d.dept_name, e.emp_name;

/* 5. Employees who do not belong to any department */
SELECT emp_name AS Employee
FROM employees
WHERE dept_id IS NULL;

/* 6. Fetch employees and their projects (NULL for no project) */
SELECT e.emp_name AS Employee, p.project_name AS Project
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id;

/* 7. Employees who completed at least one project */
SELECT e.emp_name AS Employee, p.project_name AS Project
FROM employees e
JOIN projects p ON e.emp_id = p.emp_id;

/* 8. Ensure no project is omitted even if no employee is assigned */
SELECT e.emp_name AS Employee, p.project_name AS Project
FROM projects p
LEFT JOIN employees e ON p.emp_id = e.emp_id;

/* 9. Employees and salaries (NULL if no record) */
SELECT e.emp_name AS Employee, s.salary AS Salary
FROM employees e
LEFT JOIN salaries s ON e.emp_id = s.emp_id;

/* 10. Employees and departments (including those in no department) */
SELECT e.emp_name AS Employee, d.dept_name AS Department
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;

/* 11. All departments and employees (ensuring empty depts are included) */
SELECT d.dept_name AS Department, e.emp_name AS Employee
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id;

/* 12. Employees with contact info */
SELECT e.emp_name AS Employee, c.contact_info AS Contact
FROM employees e
LEFT JOIN contacts c ON e.emp_id = c.emp_id;

/* 13. Full list of employees and departments (Union simulates Full Outer Join) */
SELECT e.emp_name AS Employee, d.dept_name AS Department
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
UNION
SELECT e.emp_name AS Employee, d.dept_name AS Department
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id;

/* 14. Employees who have not completed any project */
SELECT e.emp_name AS Employee, p.project_name AS Project
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id
WHERE p.project_id IS NULL;

/* 15. Names of employees and projects (including those not working on any) */
SELECT e.emp_name AS Employee, p.project_name AS Project
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id;

/* 16. All projects and assigned employees (including projects with no employees) */
SELECT p.project_name AS Project, e.emp_name AS Employee
FROM projects p
LEFT JOIN employees e ON p.emp_id = e.emp_id;

/* 17. Employees with both a manager AND at least one project */
SELECT e.emp_name AS Employee, m.emp_name AS Manager, p.project_name AS Project
FROM employees e
JOIN employees m ON e.manager_id = m.emp_id
JOIN projects p ON e.emp_id = p.emp_id;

/* 18. Employees and departments (exclude those without a department) */
SELECT e.emp_name AS Employee, d.dept_name AS Department
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;

/* 19. Employees belonging to multiple departments */
SELECT e.emp_name AS Employee, COUNT(d.dept_id) as Dept_Count
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY e.emp_name
HAVING COUNT(d.dept_id) > 1;

/* 20. All departments and employees (including empty depts) */
SELECT d.dept_name AS Department, e.emp_name AS Employee
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id;

/* 21. Worked on a project but belongs to no department */
SELECT e.emp_name AS Employee, p.project_name AS Project
FROM employees e
JOIN projects p ON e.emp_id = p.emp_id
WHERE e.dept_id IS NULL;

/* 22. Total number of employees per department (including empty depts) */
SELECT d.dept_name AS Department, COUNT(e.emp_id) AS Employee_Count
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

/* 23. Employees and managers (exclude those without managers) */
SELECT e.emp_name AS Employee, m.emp_name AS Manager
FROM employees e
JOIN employees m ON e.manager_id = m.emp_id;

/* 24. Employees and managers (include those without managers) */
SELECT e.emp_name AS Employee, m.emp_name AS Manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;

/* 25. Department names and employee counts (including zero) */
SELECT d.dept_name AS Department, COUNT(e.emp_id) AS Employee_Count
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

/* 26. All employees and all departments (Union) */
SELECT e.emp_name AS Employee, d.dept_name AS Department
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
UNION
SELECT e.emp_name AS Employee, d.dept_name AS Department
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id;

/* 27. Employees without salary records */
SELECT e.emp_name AS Employee
FROM employees e
LEFT JOIN salaries s ON e.emp_id = s.emp_id
WHERE s.salary IS NULL;

/* 28. Employees and project assignments (include those with no project) */
SELECT e.emp_name AS Employee, p.project_name AS Project
FROM employees e
LEFT JOIN projects p ON e.emp_id = p.emp_id;

/* 29. Employees with department AND project assignments (includes NULLs) */
SELECT e.emp_name AS Employee, d.dept_name AS Department, p.project_name AS Project
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
LEFT JOIN projects p ON e.emp_id = p.emp_id;

/* 30. Employees belonging to at least one department (including those without) */
SELECT e.emp_name AS Employee, d.dept_name AS Department
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;

