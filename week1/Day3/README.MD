# 📊 Week 1 – Day 3 (SQL: CASE Statements & Window Functions)

## **Objective**
To develop advanced SQL problem-solving skills using **CASE statements (including nested CASE)** and **Window Functions** for conditional logic, ranking, and analytical computations on structured datasets.

---

## **Problem Summary**

Day 3 focuses on two major areas:

- **CASE WHEN & Nested CASE Logic**
- **Window Functions (ROW_NUMBER, RANK, DENSE_RANK)**

The datasets used include:
- Employee dataset with salary, experience, department, and performance rating  
- Employees and orders datasets for ranking and analytical operations  

The goal is to:
- Apply conditional transformations using CASE  
- Implement business logic directly in SQL  
- Perform ranking and ordering using window functions  
- Handle real-world decision-based scenarios  

---

## **Approach**

### **1. Data Setup**
- Created tables:
  - `Employee`
  - `employees`, `orders`
- Inserted structured sample data before applying transformations and queries  

---

### **2. CASE WHEN Implementation**

Solved multiple problems involving conditional logic:

#### 🔹 Basic CASE Conditions
- Salary hike based on experience and performance  
- Bonus calculation using department + performance  
- Employee categorization (High, Mid, Low performers)  

#### 🔹 Conditional Logic Design
- Multi-condition filtering using AND / OR  
- Business-rule-based classification  

#### 🔹 Nested CASE Statements
Handled complex scenarios like:
- Salary hike based on performance + salary + experience  
- Bonus calculation using multiple layered conditions  
- Promotion eligibility logic  
- Tax bracket classification  

---

### **3. Window Functions Implementation**

Solved analytical problems using:

#### 🔹 ROW_NUMBER()
- Assigning unique sequence to rows  
- Department-wise row numbering  
- Sorting based on salary and dates  

#### 🔹 RANK()
- Ranking employees based on salary  
- Department-wise ranking  
- Handling ties with gaps in ranking  

#### 🔹 DENSE_RANK()
- Ranking without gaps  
- Comparing ranking behavior with RANK()  

#### 🔹 Partitioning Concepts
- Using `PARTITION BY` for grouped analysis  
- Performing intra-group comparisons  

---

## **Key Concepts Covered**

- CASE WHEN and nested CASE logic  
- Conditional transformations in SQL  
- Window functions (ROW_NUMBER, RANK, DENSE_RANK)  
- Partitioning and ordering  
- Analytical vs aggregation functions  
- Implementing business rules in queries  

---

## **Folder Structure**

Day3/
│
├── Assignment_1.docx → CASE WHEN problem statements  
├── Assignment_1.sql → Solutions for CASE problems  
│
├── WFunctions1.docx → Window function problem statements  
├── WFunctions1.sql → Solutions for window function queries  
│
└── README.md  

---

## **Output / Results**

- Salary hike and bonus calculations  
- Employee performance categorization  
- Risk and eligibility classification  
- Ranked employee datasets  
- Department-wise analytical insights  
- Ordered and partitioned result sets  

---

## **Challenges Faced**

- Writing complex nested CASE conditions without logical errors  
- Managing multiple conditions cleanly  
- Understanding ranking differences (ROW_NUMBER vs RANK vs DENSE_RANK)  
- Applying correct partitioning logic  
- Avoiding incorrect ordering in window functions  

---

## **Learnings**

- CASE statements are powerful for embedding business logic in SQL  
- Nested CASE helps solve real-world multi-condition problems  
- Window functions enable advanced analytics beyond GROUP BY  
- Proper partitioning is critical for accurate results  
- Analytical thinking is required, not just syntax knowledge  

---

## **Conclusion**

Day 3 focused on applying conditional logic and analytical functions to simulate real-world business scenarios. It strengthened the ability to design smarter SQL queries that go beyond basic aggregation and joins, moving closer to real data engineering problem-solving.