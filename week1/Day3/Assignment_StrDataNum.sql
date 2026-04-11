/* =====================================================
   QUESTION 1: Employee Compensation Classification
===================================================== */

CREATE TABLE employee_payments (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    base_salary DECIMAL(10,2),
    bonus DECIMAL(10,2),
    joining_date DATE
);

INSERT INTO employee_payments VALUES
(1,'karthik','Data',75000.75,5000.50,'2019-03-15'),
(2,'veena','HR',65000.40,4000.25,'2021-06-20'),
(3,'ravi','Data',85000.90,6000.75,'2016-01-10'),
(4,'anil','Finance',70000.10,NULL,'2020-09-01'),
(5,'suresh','HR',60000.55,3000.30,'2022-11-25');

/* Query */
SELECT 
    CONCAT(UCASE(LEFT(emp_name,1)), LCASE(SUBSTRING(emp_name,2))) AS proper_name,
    ROUND(base_salary + IFNULL(bonus,0)) AS total_income,
    YEAR(joining_date) AS joining_year,
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, joining_date, CURDATE()) > 7 THEN 'Senior'
        WHEN TIMESTAMPDIFF(YEAR, joining_date, CURDATE()) BETWEEN 4 AND 7 THEN 'Mid'
        ELSE 'Junior'
    END AS experience_level
FROM employee_payments;

--------------------------------------------------------

/* =====================================================
   QUESTION 2: Order Delivery Delay Analysis
===================================================== */

CREATE TABLE orders_delivery (
    order_id INT,
    customer_name VARCHAR(50),
    order_date DATE,
    delivery_date DATE,
    order_amount DECIMAL(10,2)
);

INSERT INTO orders_delivery VALUES
(101,'rajesh','2025-01-01','2025-01-05',12500.75),
(102,'meena','2025-01-10','2025-01-10',8400.40),
(103,'arun','2025-01-15','2025-01-20',15600.90),
(104,'pooja','2025-01-18',NULL,9200.10);

/* Query */
SELECT 
    UPPER(customer_name) AS customer,
    DATEDIFF(IFNULL(delivery_date, CURDATE()), order_date) AS delivery_days,
    TRUNCATE(order_amount,1) AS truncated_amount,
    CASE 
        WHEN delivery_date IS NULL THEN 'Pending'
        WHEN DATEDIFF(delivery_date, order_date) = 0 THEN 'Same Day'
        WHEN DATEDIFF(delivery_date, order_date) > 3 THEN 'Delayed'
        ELSE 'On Time'
    END AS status
FROM orders_delivery;

--------------------------------------------------------

/* =====================================================
   QUESTION 3: Customer Spending Pattern
===================================================== */

CREATE TABLE customer_spending (
    cust_id INT,
    cust_name VARCHAR(50),
    city VARCHAR(30),
    purchase_amount DECIMAL(10,2),
    purchase_date DATE
);

INSERT INTO customer_spending VALUES
(1,'amit','mumbai',12000.75,'2024-12-01'),
(2,'neha','delhi',8500.40,'2024-12-15'),
(3,'rohit','mumbai',15500.90,'2024-11-20'),
(4,'kavya','chennai',6000.10,'2024-10-05');

/* Query */
SELECT 
    CONCAT(UCASE(LEFT(cust_name,1)), LCASE(SUBSTRING(cust_name,2))) AS name,
    MONTHNAME(purchase_date) AS month_name,
    ROUND(purchase_amount) AS rounded_amount,
    ABS(purchase_amount) AS abs_amount,
    CASE 
        WHEN purchase_amount > 15000 THEN 'High'
        WHEN purchase_amount BETWEEN 8000 AND 15000 THEN 'Medium'
        ELSE 'Low'
    END AS category
FROM customer_spending;

--------------------------------------------------------

/* =====================================================
   QUESTION 4: Subscription Validity Check
===================================================== */

CREATE TABLE subscriptions (
    user_id INT,
    user_email VARCHAR(100),
    start_date DATE,
    end_date DATE,
    subscription_fee DECIMAL(10,2)
);

INSERT INTO subscriptions VALUES
(1,'karthik@gmail.com','2024-01-01','2025-01-01',12000.50),
(2,'veena@yahoo.com','2024-06-15','2024-12-15',8500.75),
(3,'ravi@hotmail.com','2023-03-01','2024-03-01',15000.90);

/* Query */
SELECT 
    SUBSTRING_INDEX(user_email,'@',-1) AS domain,
    TIMESTAMPDIFF(MONTH,start_date,end_date) AS duration_months,
    FORMAT(subscription_fee,2) AS formatted_fee,
    DATEDIFF(end_date, CURDATE()) AS remaining_days,
    CASE 
        WHEN end_date < CURDATE() THEN 'Expired'
        WHEN DATEDIFF(end_date, CURDATE()) <= 30 THEN 'Expiring Soon'
        ELSE 'Active'
    END AS status
FROM subscriptions;

--------------------------------------------------------

/* =====================================================
   QUESTION 5: Loan EMI Risk Categorization
===================================================== */

CREATE TABLE loan_details (
    loan_id INT,
    customer_name VARCHAR(50),
    loan_amount DECIMAL(12,2),
    interest_rate DECIMAL(5,2),
    loan_start DATE
);

INSERT INTO loan_details VALUES
(201,'suresh',500000.75,8.5,'2022-01-10'),
(202,'mahesh',750000.40,9.2,'2021-05-20'),
(203,'anita',300000.90,7.8,'2023-07-01');

/* Query */
SELECT 
    UPPER(customer_name) AS name,
    POWER(1 + interest_rate/100, 1/12) AS monthly_interest,
    TIMESTAMPDIFF(YEAR, loan_start, CURDATE()) AS years,
    ROUND(loan_amount * (interest_rate/100)) AS emi,
    CASE 
        WHEN interest_rate > 9 THEN 'High Risk'
        WHEN interest_rate BETWEEN 8 AND 9 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk
FROM loan_details;
/* =====================================================
   QUESTION 6: Employee Attendance Evaluation
===================================================== */

CREATE TABLE attendance (
    emp_id INT,
    emp_name VARCHAR(50),
    total_days INT,
    present_days INT,
    record_date DATE
);

INSERT INTO attendance VALUES
(1,'karthik',30,28,'2025-01-31'),
(2,'veena',30,22,'2025-01-31'),
(3,'ravi',30,18,'2025-01-31');

/* Query */
SELECT 
    LOWER(emp_name) AS name,
    ROUND((present_days / total_days) * 100, 2) AS attendance_percent,
    MONTHNAME(record_date) AS month_name,
    (total_days - present_days) AS absent_days,
    CASE 
        WHEN (present_days / total_days) * 100 >= 90 THEN 'Excellent'
        WHEN (present_days / total_days) * 100 BETWEEN 75 AND 89 THEN 'Average'
        ELSE 'Poor'
    END AS performance
FROM attendance;

--------------------------------------------------------

/* =====================================================
   QUESTION 7: Product Discount Validation
===================================================== */

CREATE TABLE product_sales (
    product_id INT,
    product_name VARCHAR(50),
    mrp DECIMAL(10,2),
    selling_price DECIMAL(10,2),
    sale_date DATE
);

INSERT INTO product_sales VALUES
(1,'Laptop',75000.75,68000.50,'2025-01-10'),
(2,'Mobile',35000.40,33000.25,'2025-01-12'),
(3,'Tablet',25000.90,26000.75,'2025-01-15');

/* Query */
SELECT 
    CONCAT(UCASE(LEFT(product_name,1)), LCASE(SUBSTRING(product_name,2))) AS product,
    ABS(mrp - selling_price) AS discount_amount,
    ROUND(((mrp - selling_price)/mrp) * 100, 2) AS discount_percent,
    DAYNAME(sale_date) AS day_name,
    CASE 
        WHEN selling_price < mrp THEN 'Valid Discount'
        WHEN selling_price > mrp THEN 'Overpriced'
        ELSE 'No Discount'
    END AS status
FROM product_sales;

--------------------------------------------------------

/* =====================================================
   QUESTION 8: Insurance Policy Aging
===================================================== */

CREATE TABLE insurance_policies (
    policy_id INT,
    holder_name VARCHAR(50),
    premium_amount DECIMAL(10,2),
    policy_start DATE,
    policy_end DATE
);

INSERT INTO insurance_policies VALUES
(301,'arjun',12000.50,'2023-01-01','2026-01-01'),
(302,'megha',8500.75,'2022-06-15','2025-06-15'),
(303,'vinod',15000.90,'2021-03-01','2024-03-01');

/* Query */
SELECT 
    UPPER(holder_name) AS name,
    TIMESTAMPDIFF(YEAR, policy_start, policy_end) AS duration_years,
    DATEDIFF(policy_end, CURDATE()) AS remaining_days,
    ROUND(premium_amount) AS rounded_premium,
    CASE 
        WHEN policy_end < CURDATE() THEN 'Expired'
        WHEN TIMESTAMPDIFF(YEAR, policy_start, policy_end) >= 3 THEN 'Long Term'
        ELSE 'Mid Term'
    END AS policy_status
FROM insurance_policies;

--------------------------------------------------------

/* =====================================================
   QUESTION 9: Salary Increment Simulation
===================================================== */

CREATE TABLE salary_revision (
    emp_id INT,
    emp_name VARCHAR(50),
    current_salary DECIMAL(10,2),
    rating INT,
    last_hike DATE
);

INSERT INTO salary_revision VALUES
(1,'karthik',75000.75,5,'2023-01-01'),
(2,'veena',65000.40,4,'2024-01-01'),
(3,'ravi',85000.90,3,'2022-01-01');

/* Query */
SELECT 
    LOWER(emp_name) AS name,
    TIMESTAMPDIFF(YEAR, last_hike, CURDATE()) AS years_since_hike,
    CASE 
        WHEN rating = 5 THEN current_salary * 0.20
        WHEN rating = 4 THEN current_salary * 0.15
        WHEN rating = 3 THEN current_salary * 0.10
        ELSE 0
    END AS increment,
    ROUND(
        current_salary + 
        CASE 
            WHEN rating = 5 THEN current_salary * 0.20
            WHEN rating = 4 THEN current_salary * 0.15
            WHEN rating = 3 THEN current_salary * 0.10
            ELSE 0
        END
    ) AS new_salary,
    CASE 
        WHEN rating = 5 THEN 'High Increment'
        WHEN rating = 4 THEN 'Moderate'
        ELSE 'No Increment'
    END AS category
FROM salary_revision;

--------------------------------------------------------

/* =====================================================
   QUESTION 10: Customer Account Status Evaluation
===================================================== */

CREATE TABLE bank_accounts (
    account_id INT,
    customer_name VARCHAR(50),
    balance DECIMAL(12,2),
    last_transaction DATE,
    branch VARCHAR(30)
);

INSERT INTO bank_accounts VALUES
(501,'ramesh',125000.75,'2024-12-20','hyderabad'),
(502,'sita',8500.40,'2023-06-15','delhi'),
(503,'manoj',-2500.90,'2025-01-05','mumbai');

/* Query */
SELECT 
    CONCAT(UCASE(LEFT(branch,1)), LCASE(SUBSTRING(branch,2))) AS branch_name,
    ABS(balance) AS abs_balance,
    DATEDIFF(CURDATE(), last_transaction) AS days_since_txn,
    SIGN(balance) AS balance_sign,
    CASE 
        WHEN balance < 0 THEN 'Overdrawn'
        WHEN DATEDIFF(CURDATE(), last_transaction) > 365 THEN 'Dormant'
        ELSE 'Active'
    END AS account_status
FROM bank_accounts;

/* =====================================================
   LEVEL 1 – QUESTION 1: Salary Risk Flagging Based on Tax Shock
===================================================== */

CREATE TABLE salary_audit (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    tax_percent DECIMAL(5,2),
    last_revision DATE
);

INSERT INTO salary_audit VALUES
(1,'karthik',75000.75,10.5,'2022-01-15'),
(2,'veena',65000.40,18.0,'2023-06-01'),
(3,'ravi',85000.90,25.0,'2020-11-20');

/* Query */
SELECT 
    LOWER(emp_name) AS name,
    ROUND(salary - (salary * tax_percent/100)) AS net_salary,
    YEAR(last_revision) AS revision_year,
    TIMESTAMPDIFF(MONTH, last_revision, CURDATE()) AS months_since,
    CASE 
        WHEN tax_percent > 20 AND TIMESTAMPDIFF(MONTH, last_revision, CURDATE()) > 24 THEN 'Tax Shock'
        WHEN tax_percent BETWEEN 15 AND 20 THEN 'Review Needed'
        ELSE 'Stable'
    END AS status
FROM salary_audit;

--------------------------------------------------------

/* =====================================================
   QUESTION 2: Bonus Abuse Detection
===================================================== */

CREATE TABLE bonus_monitor (
    emp_code INT,
    emp_name VARCHAR(50),
    base_salary DECIMAL(10,2),
    bonus DECIMAL(10,2),
    bonus_date DATE
);

INSERT INTO bonus_monitor VALUES
(101,'Anil',70000.10,30000.00,'2025-01-10'),
(102,'Suresh',60000.55,3000.30,'2024-03-15'),
(103,'Ravi',85000.90,15000.75,'2023-12-01');

/* Query */
SELECT 
    CONCAT(UCASE(LEFT(emp_name,1)), LCASE(SUBSTRING(emp_name,2))) AS name,
    ROUND((bonus/base_salary)*100,2) AS bonus_percent,
    DAYNAME(bonus_date) AS day_name,
    ABS(base_salary - bonus) AS diff,
    CASE 
        WHEN (bonus/base_salary)*100 > 30 AND DAYNAME(bonus_date) IN ('Saturday','Sunday') THEN 'Suspicious'
        WHEN (bonus/base_salary)*100 <= 20 THEN 'Normal'
        ELSE 'Audit'
    END AS status
FROM bonus_monitor;

--------------------------------------------------------

/* =====================================================
   QUESTION 3: Experience Parity Validation
===================================================== */

CREATE TABLE employee_experience (
    emp_id INT,
    emp_name VARCHAR(50),
    joining_date DATE,
    declared_experience INT,
    salary DECIMAL(10,2)
);

INSERT INTO employee_experience VALUES
(1,'Veena','2018-07-01',4,65000.40),
(2,'Ravi','2014-01-10',12,85000.90),
(3,'Anil','2020-09-01',3,70000.10);

/* Query */
SELECT 
    UPPER(emp_name) AS name,
    TIMESTAMPDIFF(YEAR, joining_date, CURDATE()) AS actual_exp,
    declared_experience - TIMESTAMPDIFF(YEAR, joining_date, CURDATE()) AS diff,
    FLOOR(salary) AS salary_floor,
    CASE 
        WHEN declared_experience > TIMESTAMPDIFF(YEAR, joining_date, CURDATE()) THEN 'Overstated'
        WHEN declared_experience < TIMESTAMPDIFF(YEAR, joining_date, CURDATE()) THEN 'Understated'
        ELSE 'Matched'
    END AS status
FROM employee_experience;

--------------------------------------------------------

/* =====================================================
   QUESTION 4: Salary Digit Pattern Analysis
===================================================== */

CREATE TABLE salary_digits (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    credit_date DATE
);

INSERT INTO salary_digits VALUES
(1,'Karthik',75000.75,'2025-01-01'),
(2,'Veena',65000.40,'2025-01-02'),
(3,'Suresh',60000.55,'2025-01-03');

/* Query */
SELECT 
    RIGHT(emp_name,2) AS last_chars,
    DAY(credit_date) AS day_of_month,
    FLOOR(salary) AS salary_int,
    MOD(FLOOR(salary),10) AS mod_val,
    CASE 
        WHEN MOD(FLOOR(salary),10) = DAY(credit_date) THEN 'Pattern Match'
        ELSE 'No Match'
    END AS status
FROM salary_digits;

--------------------------------------------------------

/* =====================================================
   QUESTION 5: Odd–Even Salary Compliance
===================================================== */

CREATE TABLE payroll_control (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    payment_date DATE
);

INSERT INTO payroll_control VALUES
(1,'Ravi',85000.90,'2025-01-15'),
(2,'Anil',70000.10,'2025-01-16'),
(3,'Veena',65000.40,'2025-01-17');

/* Query */
SELECT 
    LOWER(emp_name) AS name,
    DAYNAME(payment_date) AS weekday,
    ROUND(salary) AS salary_round,
    MOD(ROUND(salary),2) AS parity,
    CASE 
        WHEN MOD(ROUND(salary),2) = 0 AND DAY(payment_date)%2 = 1 THEN 'Violation'
        ELSE 'Compliant'
    END AS status
FROM payroll_control;

--------------------------------------------------------

/* =====================================================
   QUESTION 6: Salary Inflation Drift
===================================================== */

CREATE TABLE inflation_watch (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    last_hike DATE
);

INSERT INTO inflation_watch VALUES
(1,'Karthik',75000.75,'2019-01-01'),
(2,'Veena',65000.40,'2022-01-01'),
(3,'Ravi',85000.90,'2017-01-01');

/* Query */
SELECT 
    CONCAT(UCASE(LEFT(emp_name,1)), LCASE(SUBSTRING(emp_name,2))) AS name,
    TIMESTAMPDIFF(YEAR, last_hike, CURDATE()) AS years,
    POWER(TIMESTAMPDIFF(YEAR, last_hike, CURDATE()),2) AS growth_factor,
    ROUND(salary * POWER(1.05, TIMESTAMPDIFF(YEAR, last_hike, CURDATE()))) AS adjusted_salary,
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, last_hike, CURDATE()) > 5 THEN 'High Inflation Risk'
        WHEN TIMESTAMPDIFF(YEAR, last_hike, CURDATE()) > 2 THEN 'Moderate'
        ELSE 'Low'
    END AS category
FROM inflation_watch;

--------------------------------------------------------

/* =====================================================
   QUESTION 7: Salary Sign Integrity Check
===================================================== */

CREATE TABLE salary_integrity (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    record_date DATE
);

INSERT INTO salary_integrity VALUES
(1,'Anil',-70000.10,'2025-01-10'),
(2,'Veena',65000.40,'2025-01-10'),
(3,'Ravi',0.00,'2025-01-10');

/* Query */
SELECT 
    UPPER(emp_name) AS name,
    YEAR(record_date) AS year,
    SIGN(salary) AS sign_val,
    ABS(salary) AS abs_salary,
    CASE 
        WHEN salary < 0 THEN 'Negative Error'
        WHEN salary = 0 THEN 'Zero Salary'
        ELSE 'Valid'
    END AS status
FROM salary_integrity;

--------------------------------------------------------

/* =====================================================
   QUESTION 8: Name Length vs Salary Correlation
===================================================== */

CREATE TABLE name_salary (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    join_date DATE
);

INSERT INTO name_salary VALUES
(1,'Karthik',75000.75,'2019-03-15'),
(2,'Veena',65000.40,'2021-06-20'),
(3,'Ravi',85000.90,'2016-01-10');

/* Query */
SELECT 
    LENGTH(emp_name) AS name_length,
    TIMESTAMPDIFF(YEAR, join_date, CURDATE()) AS years,
    ROUND(salary) AS salary_round,
    CASE 
        WHEN LENGTH(emp_name) > TIMESTAMPDIFF(YEAR, join_date, CURDATE()) THEN 'Name Bias'
        ELSE 'Neutral'
    END AS status
FROM name_salary;

--------------------------------------------------------

/* =====================================================
   QUESTION 9: Salary Spike Detection by Month
===================================================== */

CREATE TABLE salary_monthly (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    paid_date DATE
);

INSERT INTO salary_monthly VALUES
(1,'Karthik',75000.75,'2025-01-31'),
(2,'Veena',65000.40,'2025-02-28'),
(3,'Ravi',85000.90,'2025-03-31');

/* Query */
SELECT 
    MONTHNAME(paid_date) AS month,
    CEIL(salary) AS salary_ceil,
    LAST_DAY(paid_date) AS last_day,
    CASE 
        WHEN paid_date = LAST_DAY(paid_date) THEN 'End Month Spike'
        ELSE 'Regular'
    END AS status
FROM salary_monthly;

--------------------------------------------------------

/* =====================================================
   QUESTION 10: Salary Digit Sum Audit
===================================================== */

CREATE TABLE digit_audit (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    audit_date DATE
);

INSERT INTO digit_audit VALUES
(1,'Anil',70000.10,'2025-01-01'),
(2,'Veena',65000.40,'2025-01-02');

/* Query */
SELECT 
    LEFT(emp_name,1) AS first_char,
    FLOOR(salary) AS salary_int,
    DAY(audit_date) AS day_val,
    CASE 
        WHEN MOD(FLOOR(salary),9) = DAY(audit_date) THEN 'Digit Alert'
        ELSE 'Normal'
    END AS status
FROM digit_audit;

/* =====================================================
   QUESTION 11: Weekend Salary Credit Fraud Detection
===================================================== */

CREATE TABLE salary_credit_audit (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    credit_date DATE,
    bank_code VARCHAR(10)
);

INSERT INTO salary_credit_audit VALUES
(1,'Karthik',75000.75,'2025-01-04','HDFC01'),
(2,'Veena',65000.40,'2025-01-06','ICIC02'),
(3,'Ravi',85000.90,'2025-01-05','SBIN03'),
(4,'Anil',70000.10,'2025-01-07','AXIS04'),
(5,'Suresh',60000.55,'2025-01-11','HDFC01');

/* Query */
SELECT 
    emp_name,
    LEFT(bank_code,4) AS bank_prefix,
    DAYNAME(credit_date) AS day_name,
    ROUND(salary) AS rounded_salary,
    MOD(ROUND(salary),5) AS mod_check,
    CASE 
        WHEN DAYNAME(credit_date) IN ('Saturday','Sunday') 
             AND MOD(ROUND(salary),5) = 0 THEN 'Weekend Fraud'
        WHEN LEFT(bank_code,4) = 'HDFC' THEN 'Bank Review'
        ELSE 'Normal'
    END AS status
FROM salary_credit_audit;

--------------------------------------------------------

/* =====================================================
   QUESTION 12: Salary Credit Time Drift Analysis
===================================================== */

CREATE TABLE salary_time_drift (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    credit_ts DATETIME
);

INSERT INTO salary_time_drift VALUES
(1,'Karthik',75000.75,'2025-01-10 23:45:00'),
(2,'Veena',65000.40,'2025-01-10 09:15:00'),
(3,'Ravi',85000.90,'2025-01-11 00:10:00'),
(4,'Anil',70000.10,'2025-01-09 18:30:00'),
(5,'Suresh',60000.55,'2025-01-10 02:50:00');

/* Query */
SELECT 
    LOWER(emp_name) AS name,
    HOUR(credit_ts) AS hour,
    FLOOR(salary) AS floor_salary,
    ABS(FLOOR(salary) - HOUR(credit_ts)) AS diff,
    CASE 
        WHEN HOUR(credit_ts) BETWEEN 0 AND 3 THEN 'Midnight Drift'
        WHEN HOUR(credit_ts) > 18 THEN 'After Hours'
        ELSE 'Business Hours'
    END AS category
FROM salary_time_drift;

--------------------------------------------------------

/* =====================================================
   QUESTION 13: Salary Decimal Precision Audit
===================================================== */

CREATE TABLE salary_precision (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,4),
    record_date DATE
);

INSERT INTO salary_precision VALUES
(1,'Karthik',75000.7567,'2025-01-01'),
(2,'Veena',65000.4044,'2025-01-02'),
(3,'Ravi',85000.9099,'2025-01-03'),
(4,'Anil',70000.1001,'2025-01-04'),
(5,'Suresh',60000.5555,'2025-01-05');

/* Query */
SELECT 
    emp_name,
    TRUNCATE(salary,2) AS truncated_salary,
    ABS(ROUND(salary,2) - TRUNCATE(salary,2)) AS precision_diff,
    DAYNAME(record_date) AS day_name,
    LENGTH(emp_name) AS name_length,
    CASE 
        WHEN ABS(ROUND(salary,2) - TRUNCATE(salary,2)) > 0.01 THEN 'Precision Loss'
        ELSE 'Safe'
    END AS status
FROM salary_precision;

--------------------------------------------------------

/* =====================================================
   QUESTION 14: Salary Growth Power Index
===================================================== */

CREATE TABLE salary_growth (
    emp_id INT,
    emp_name VARCHAR(50),
    base_salary DECIMAL(10,2),
    growth_rate DECIMAL(5,2),
    last_hike DATE
);

INSERT INTO salary_growth VALUES
(1,'Karthik',75000.75,1.08,'2019-01-01'),
(2,'Veena',65000.40,1.05,'2021-01-01'),
(3,'Ravi',85000.90,1.12,'2017-01-01'),
(4,'Anil',70000.10,1.03,'2022-01-01'),
(5,'Suresh',60000.55,1.06,'2020-01-01');

/* Query */
SELECT 
    UPPER(emp_name) AS name,
    TIMESTAMPDIFF(YEAR, last_hike, CURDATE()) AS years,
    POWER(growth_rate, TIMESTAMPDIFF(YEAR, last_hike, CURDATE())) AS growth_factor,
    ROUND(base_salary * POWER(growth_rate, TIMESTAMPDIFF(YEAR, last_hike, CURDATE()))) AS projected_salary,
    CASE 
        WHEN base_salary * POWER(growth_rate, TIMESTAMPDIFF(YEAR, last_hike, CURDATE())) > 150000 THEN 'Explosive Growth'
        WHEN TIMESTAMPDIFF(YEAR, last_hike, CURDATE()) > 3 THEN 'Controlled'
        ELSE 'Stagnant'
    END AS category
FROM salary_growth;

--------------------------------------------------------

/* =====================================================
   QUESTION 15: Salary Symmetry Check
===================================================== */

CREATE TABLE salary_symmetry (
    emp_id INT,
    emp_name VARCHAR(50),
    salary DECIMAL(10,2),
    processed_date DATE
);

INSERT INTO salary_symmetry VALUES
(1,'Karthik',75557.75,'2025-01-15'),
(2,'Veena',64446.40,'2025-01-16'),
(3,'Ravi',85858.90,'2025-01-17'),
(4,'Anil',70007.10,'2025-01-18'),
(5,'Suresh',60000.55,'2025-01-19');

/* Query */
SELECT 
    CONCAT(UCASE(LEFT(emp_name,1)), LCASE(SUBSTRING(emp_name,2))) AS name,
    FLOOR(salary) AS salary_int,
    REVERSE(FLOOR(salary)) AS reversed_salary,
    DAYNAME(processed_date) AS day_name,
    CASE 
        WHEN FLOOR(salary) = REVERSE(FLOOR(salary)) THEN 'Symmetric Pay'
        ELSE 'Asymmetric'
    END AS status
FROM salary_symmetry;