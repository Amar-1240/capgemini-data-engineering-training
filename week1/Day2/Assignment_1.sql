CREATE TABLE Employee (
emp_id INT,
emp_name VARCHAR(50),
department VARCHAR(50),
salary INT,
experience INT,
performance_rating CHAR(1)
);
INSERT INTO Employee (emp_id, emp_name, department, salary, experience, performance_rating)
VALUES
(1, 'Karthik', 'Engineering', 95000, 9, 'A'),
(2, 'Prathik', 'HR', 55000, 4, 'B'),
(3, 'Vinay', 'Finance', 78000, 10, 'B'),
(4, 'Vijay', 'Marketing', 48000, 3, 'C'),
(5, 'Anil', 'Engineering', 88000, 6, 'A'),
(6, 'Suresh', 'Finance', 92000, 12, 'A'),
(7, 'Ramesh', 'HR', 46000, 2, 'C'),
(8, 'Mahesh', 'Marketing', 67000, 7, 'B'),
(9, 'Rajesh', 'Engineering', 72000, 5, 'B'),
(10,'Naveen', 'Finance', 61000, 6, 'C'),
(11,'Deepak', 'HR', 83000, 11, 'A'),
(12,'Arjun', 'Engineering', 54000, 3, 'C'),
(13,'Kiran', 'Marketing', 76000, 8, 'A'),
(14,'Rohit', 'Finance', 68000, 4, 'B'),
(15,'Pavan', 'HR', 59000, 5, 'B'),
(16,'Srikanth', 'Engineering', 102000, 14, 'A'),
(17,'Manoj', 'Finance', 47000, 2, 'C'),
(18,'Varun', 'Marketing', 52000, 6, 'B'),
(19,'Ashok', 'HR', 74000, 9, 'A'),
(20,'Sunil', 'Engineering', 66000, 4, 'B'),
(21,'Nikhil', 'Finance', 86000, 7, 'A'),
(22,'Harish', 'Marketing', 45000, 1, 'C'),
(23,'Vamsi', 'Engineering', 79000, 8, 'B'),
(24,'Chaitanya','HR', 91000, 13, 'A'),
(25,'Lokesh', 'Finance', 58000, 5, 'B');

/* Problem 1: Salary Hike Based on Experience and Performance */
SELECT *,
CASE
    WHEN experience >= 8 AND performance_rating = 'A' THEN '20% hike'
    WHEN experience >= 5 AND performance_rating = 'B' THEN '15% hike'
    WHEN performance_rating = 'C' THEN 'No hike'
    ELSE '10% hike'
END AS HikePercent
FROM Employee;

/* 2) Problem 2: Bonus Calculation Based on Department and Performance */
SELECT *,
CASE 
    WHEN department = 'Finance' THEN
        CASE 
            WHEN performance_rating = 'A' THEN '20% bonus'
            WHEN performance_rating = 'B' THEN '15% bonus'
            WHEN performance_rating = 'C' THEN '5% bonus'
        END
    WHEN department = 'Engineering' THEN
        CASE 
            WHEN performance_rating = 'A' THEN '18% bonus'
            WHEN performance_rating = 'B' THEN '12% bonus'
            WHEN performance_rating = 'C' THEN '3% bonus'
        END
    ELSE '10% bonus'
END AS Bonus
FROM Employee;

/* Problem 3: Categorizing Employees by Salary Range and Performance */
SELECT *,
CASE
    WHEN salary > 80000 AND performance_rating = 'A' THEN 'High Performer'
    WHEN salary BETWEEN 50000 AND 80000 AND performance_rating = 'B' THEN 'Mid Performer'
    WHEN salary < 50000 OR performance_rating = 'C' THEN 'Low Performer'
    ELSE 'Mid Performer'
END AS Performance
FROM Employee;

/* Problem 4: Risk Assessment Based on Experience and Department */
SELECT *,
CASE
    WHEN department = 'HR' THEN
        CASE 
            WHEN experience < 5 THEN 'High Risk'
            ELSE 'Low Risk'
        END
    WHEN department IN ('Engineering', 'Finance') THEN
        CASE 
            WHEN experience > 8 THEN 'Low Risk'
            ELSE 'Medium Risk'
        END
    ELSE 'Medium Risk'
END AS RiskLevel
FROM Employee;

/* Nested CASE Problem 1: Salary Hike Based on Performance, Salary, Experience */
SELECT *,
CASE 
    WHEN performance_rating = 'A' THEN
        CASE 
            WHEN salary > 80000 AND experience > 5 THEN '25% hike'
            WHEN salary > 80000 THEN '20% hike'
            WHEN salary BETWEEN 50000 AND 80000 THEN '15% hike'
        END
    WHEN performance_rating = 'B' THEN
        CASE 
            WHEN experience > 5 THEN '12% hike'
            ELSE '10% hike'
        END
    ELSE 'No hike'
END AS NestedHike
FROM Employee;

/* Nested CASE Problem 2: Department and Performance Bonus */
SELECT *,
CASE 
    WHEN department = 'Finance' THEN
        CASE 
            WHEN performance_rating = 'A' AND experience > 10 THEN '25% bonus'
            ELSE '20% bonus'
        END
    WHEN department = 'HR' THEN
        CASE 
            WHEN performance_rating = 'B' OR experience > 5 THEN '15% bonus'
            ELSE '10% bonus'
        END
    ELSE '8% bonus'
END AS DeptBonus
FROM Employee;

/* Nested CASE Problem 3: Employee Categorization */
SELECT *,
CASE 
    WHEN salary > 70000 THEN
        CASE 
            WHEN performance_rating = 'A' AND experience > 8 THEN 'Top Performer'
            WHEN experience < 8 THEN 'Mid Performer'
        END
    WHEN salary BETWEEN 50000 AND 70000 THEN
        CASE 
            WHEN performance_rating = 'A' THEN 'Rising Star'
            ELSE 'Average Performer'
        END
    ELSE 'Low Performer'
END AS Category
FROM Employee;

/* Nested CASE Problem 4: Tax Bracket */
SELECT *,
CASE 
    WHEN salary > 90000 THEN
        CASE 
            WHEN experience > 10 THEN '35% Tax'
            ELSE '30% Tax'
        END
    WHEN salary BETWEEN 60000 AND 90000 THEN
        CASE 
            WHEN experience > 5 THEN '25% Tax'
            ELSE '20% Tax'
        END
    ELSE '15% Tax'
END AS TaxBracket
FROM Employee;

/* Nested CASE Problem 5: Promotion Eligibility */
SELECT *,
CASE 
    WHEN performance_rating = 'A' THEN
        CASE 
            WHEN salary > 75000 AND experience > 7 THEN 'Eligible for Senior Role'
            ELSE 'Eligible for Junior Role'
        END
    WHEN performance_rating = 'B' THEN
        CASE 
            WHEN experience > 5 THEN 'Eligible for Consideration'
            ELSE 'Not Eligible'
        END
    ELSE 'Not Eligible'
END AS PromotionStatus
FROM Employee;
