# 📊 Week 1 – Day 2 (SQL: CASE, GROUP BY & JOINS)

## **Objective**

To strengthen SQL fundamentals by solving structured problems on:

* CASE WHEN logic (decision-based queries)
* GROUP BY operations with aggregations
* Different types of JOINS using relational datasets

---

## **Problem Summary**

Day 2 focuses on two core areas:

* **CASE WHEN Logic (Assignment 1)**
* **GROUP BY & Aggregations (Assignment 3)**
* **JOINS (Inner, Left, Right, Full) with real scenarios**

The datasets used include:

* Employee dataset for CASE-based problems
* Employee & Sales tables for aggregation problems
* Employees, Departments, Projects tables for join-based queries

---

## **Approach**

### **1. Data Setup**

* Created multiple tables:

  * `Employee`
  * `Employee`, `Sales`
  * `employees`, `departments`, `projects`
* Inserted structured sample data before solving queries

---

### **2. CASE WHEN Logic (Assignment 1)**

Solved multiple scenario-based problems covering:

#### 🔹 Conditional Logic

* Salary hike based on performance and experience
* Bonus calculation using department + rating
* Risk analysis and employee categorization

#### 🔹 Nested CASE

* Multi-level decision making
* Salary hike based on salary + experience + rating
* Promotion eligibility logic

---

### **3. GROUP BY Operations (Assignment 3)**

Solved 30 problems covering:

#### 🔹 Basic Aggregations

* SUM, COUNT, AVG, MIN, MAX
* Department-wise salary analysis

#### 🔹 GROUP BY with Conditions

* Filtering using WHERE and HAVING
* Applying conditions on aggregated results

#### 🔹 GROUP BY with JOINS

* Combined Employee and Sales tables
* Calculated total sales, counts, and averages

#### 🔹 Advanced Queries

* Employee-wise salary + sales analysis
* Product-based aggregation
* Top performers and department insights

---

### **4. JOINS Implementation**

Implemented different types of joins:

* **INNER JOIN** → Only matching records
* **LEFT JOIN** → All left + matching right
* **RIGHT JOIN** → All right + matching left
* **FULL OUTER JOIN (via UNION)** → All records from both tables

Solved 30 real-world problems including:

* Employee–Manager relationships
* Employee–Department mapping
* Employee–Project assignments
* Identifying missing relationships (NULL cases)

---

## **Key Concepts Covered**

* CASE WHEN and nested logic
* GROUP BY and aggregation functions
* HAVING vs WHERE
* Multi-table joins
* Handling NULL values
* Writing structured SQL for real-world problems

---

## **Folder Structure**

Day2/
│
├── Assignment_1.docx → CASE WHEN problems (Employee)
├── Assignment_1.sql → Solutions
│
├── Assignment_3.docx → GROUP BY problems
├── Assignment3.sql → Solutions
│
├── Joins.docx → JOIN concepts and problems
├── Joins.sql → Solutions
│
└── README.md

---

## **Output / Results**

* Employee performance classification
* Department-wise salary and sales analysis
* Product-level aggregation
* Employee–department–project relationships
* Identification of missing or unmatched records

---

## **Challenges Faced**

* Structuring complex CASE WHEN logic
* Deciding correct priority of conditions
* Choosing appropriate join type
* Handling NULL values in joins
* Writing queries for real-world scenarios

---

## **Learnings**

* Strong understanding of conditional SQL logic
* Practical usage of joins and aggregations
* Handling edge cases and missing data
* Writing structured SQL queries for real-world problems

---

## **Conclusion**

Day 2 focused on strengthening SQL fundamentals through:

* Conditional logic (CASE)
* Aggregation (GROUP BY)
* Relational operations (JOINS)

It builds a strong foundation for writing real-world SQL queries instead of just theoretical ones.
