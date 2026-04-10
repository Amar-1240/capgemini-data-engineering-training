# 📊 Week 1 – Day 2 (SQL: GROUP BY & JOINS)

## **Objective**
To strengthen SQL fundamentals by solving structured problems on GROUP BY operations and different types of JOINS using sample datasets.

---

## **Problem Summary**

Day 2 focuses on two main areas:

- **GROUP BY & Aggregations (Assignment 3)**
- **JOINS (Inner, Left, Right, Full) with real scenarios**

The datasets used include:
- Employee and Sales tables for aggregation problems :contentReference[oaicite:0]{index=0}  
- Employees, Departments, and Projects tables for join-based queries :contentReference[oaicite:1]{index=1}  

The goal is to understand how to:
- Aggregate data correctly  
- Apply conditions using HAVING  
- Combine multiple tables using joins  
- Solve real-world relational problems  

---

## **Approach**

### **1. Data Setup**
- Created tables using SQL:
  - `Employee`, `Sales`
  - `employees`, `departments`, `projects`
- Inserted sample data for all tables before performing queries :contentReference[oaicite:2]{index=2}  

---

### **2. GROUP BY Operations (Assignment 3)**

Solved 30 problems covering:

#### 🔹 Basic Aggregations
- SUM, COUNT, AVG, MIN, MAX  
- Department-wise salary analysis  

#### 🔹 GROUP BY with Conditions
- Filtering using WHERE and HAVING  
- Applying conditions on aggregated results  

#### 🔹 GROUP BY with JOINS
- Combined Employee and Sales tables  
- Calculated total sales, counts, and averages  

#### 🔹 Advanced Queries
- Employee-wise sales + salary analysis  
- Product-based aggregations  
- Top performers and department insights  

---

### **3. JOINS Implementation**

Implemented different types of joins:

- **INNER JOIN** → Only matching records  
- **LEFT JOIN** → All left + matching right  
- **RIGHT JOIN** → All right + matching left  
- **FULL OUTER JOIN** → All records from both tables  

Solved 30 join-based problems including:

- Employee–Manager relationships  
- Employee–Department mapping  
- Employee–Project assignments  
- Identifying missing relationships (NULL cases)  
- Real-world scenarios like:
  - Employees without departments  
  - Departments without employees  
  - Employees without projects  

---

## **Key Concepts Covered**

- GROUP BY and aggregation functions  
- HAVING vs WHERE  
- Multi-table joins  
- Handling NULL values in joins  
- Writing structured and optimized SQL queries  

---

## **Folder Structure**

Day2/
│
├── Assignment_3.docx → GROUP BY problem statements
├── Assignment3.sql → Solutions for GROUP BY queries
│
├── Joins.docx → JOIN concepts and problems
├── Joins.sql → Solutions for JOIN queries
│
└── README.md


---

## **Output / Results**

- Department-wise salary analysis  
- Employee sales insights  
- Product-level aggregation results  
- Employee–department–project relationships  
- Identification of missing or unmatched records  

---

## **Challenges Faced**

- Choosing correct join type based on problem  
- Understanding when to use HAVING vs WHERE  
- Managing NULL values in join outputs  
- Writing queries for real-world scenarios instead of simple cases  

---

## **Learnings**

- Strong understanding of GROUP BY operations  
- Practical usage of joins in relational data  
- Handling edge cases like missing relationships  
- Writing structured SQL for real-world problems  

---

## **Conclusion**

Day 2 helped in building a solid foundation in SQL by combining aggregation and joins. It improved problem-solving skills and provided hands-on experience with real-world query scenarios.