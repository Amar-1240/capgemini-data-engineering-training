# 📊 Week 1 – Day 3 (SQL: Advanced CASE Logic, Data Manipulation & Window Functions)

## **Objective**

To develop advanced SQL problem-solving skills using:

* Complex CASE WHEN logic (including multi-level and real-world scenarios)
* Data transformation using string, numeric, and date functions
* Window functions for ranking and analytical computations

---

## **Problem Summary**

Day 3 focuses on three major areas:

* **Advanced CASE WHEN Logic (Assignment 2 – CustomerUsage)**
* **Data Manipulation (Assignment_StrDataNum)**
* **Window Functions (ROW_NUMBER, RANK, DENSE_RANK)**

The datasets used include:

* CustomerUsage dataset for business decision logic 
* Multiple structured datasets for transformation problems (salary, orders, subscriptions, etc.) 
* Employees dataset for ranking and analytical operations 

---

## **Approach**

### **1. Data Setup**

* Created multiple tables:

  * `CustomerUsage`
  * Data manipulation tables (salary, orders, subscriptions, etc.)
  * `employees`
* Inserted structured sample data before applying queries and transformations

---

### **2. Advanced CASE WHEN Logic (Assignment 2)**

Solved business-oriented problems using structured decision logic:

#### 🔹 Customer Behavior Analysis

* Plan upgrade suggestions
* Usage classification (heavy, moderate, light users)
* Voice vs data preference

#### 🔹 Business Decision Logic

* Offer eligibility and discounts
* Reward tier classification
* Plan mismatch detection

#### 🔹 Multi-Condition CASE Logic

* Nested conditions using AND / OR
* Priority-based evaluation
* Real-world telecom scenarios

---

### **3. Data Manipulation (Assignment_StrDataNum)**

Solved complex transformation problems combining multiple SQL concepts:

#### 🔹 String, Number & Date Functions

* Name formatting (UPPER, LOWER, CONCAT)
* Mathematical operations (ROUND, MOD, POWER, ABS)
* Date calculations (DATEDIFF, TIMESTAMPDIFF, MONTHNAME)

#### 🔹 Multi-Concept Queries

* Salary and bonus calculations
* Subscription validation and duration analysis
* Order delay and delivery tracking

#### 🔹 Real-World Logic Problems

* Risk classification (loan, salary, tax)
* Fraud detection scenarios
* Attendance and performance evaluation
* Financial and behavioral analysis

---

### **4. Window Functions Implementation**

Implemented analytical queries using:

#### 🔹 ROW_NUMBER()

* Unique row assignment
* Department-wise ranking
* Sorting based on salary and joining date

#### 🔹 RANK()

* Ranking with gaps
* Salary-based ranking
* Department-level comparisons

#### 🔹 DENSE_RANK()

* Ranking without gaps
* Clean ranking for analytical insights

#### 🔹 Partitioning Concepts

* Group-based calculations using `PARTITION BY`
* Comparing data within categories

---

## **Key Concepts Covered**

* Advanced CASE WHEN and nested logic
* Data transformation using multiple SQL functions
* Window functions (ROW_NUMBER, RANK, DENSE_RANK)
* Partitioning and ordering
* Combining multiple SQL concepts in a single query
* Implementing real-world business rules

---

## **Folder Structure**

Day3/
│
├── Assignment_2.docx → Advanced CASE WHEN problems (CustomerUsage)
├── Assignment_2.sql → Solutions
│
├── Assignment_StrDataNum.docx → Data manipulation problems
├── Assignment_StrDataNum.sql → Solutions
│
├── WFunctions1.docx → Window function problems
├── WFunctions1.sql → Solutions
│
└── README.md

---

## **Output / Results**

* Customer usage and business insights
* Advanced classification and decision-based outputs
* Data transformation results combining multiple functions
* Ranked and partitioned datasets
* Analytical insights using window functions

---

## **Challenges Faced**

* Handling complex multi-condition CASE logic
* Combining multiple functions in a single query
* Avoiding logical conflicts in nested CASE statements
* Understanding ranking differences in window functions
* Managing query readability with increasing complexity

---

## **Learnings**

* CASE statements can model real-world business decisions
* Combining functions is key to solving complex SQL problems
* Window functions provide powerful analytical capabilities
* Logical structuring matters more than syntax
* Real SQL problems require combining multiple concepts

---

## **Conclusion**

Day 3 moved beyond basic SQL into real-world problem-solving by combining:

* Advanced conditional logic
* Data transformation techniques
* Analytical functions

It strengthened the ability to write complex, structured queries similar to real data engineering scenarios.
