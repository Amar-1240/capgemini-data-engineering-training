# 👨‍💻 Capgemini Data Engineering Training

This repository contains my work for Capgemini Data Engineering Training. The focus of this training is to learn SQL and PySpark concepts and apply them to build data pipelines and perform basic analytics.

---
## 🗂️ Repository Structure

```
capgemini-data-engineering-training/
│
├── README.md
├── mini-project/                  → Upcoming work
│
├── week0/                         → SQL & PySpark Foundations
│   ├── phase0/                    → Databricks Certifications
│   ├── phase1/                    → Filtering & Selection
│   ├── phase2/                    → Joins & Aggregations
│   ├── phase3/                    → ETL Pipeline
│   ├── phase3A/                   → Data Quality & Cleaning
│   ├── phase4/                    → Business Pipeline & Analytics
│   ├── phase4A/                   → Bucketing & Segmentation
│   ├── phase5/                    → Databricks + Olist Pipeline
│   └── phase6/                    → Spark Playground Exit Sprint
│
├── week1/                         → Real-world datasets practice
│   ├── Day1/
│   ├── Day2_Olist/
│   ├── Day2_BFSI/
│   ├── Day3_Olist/
│   ├── Day3_BFSI/
│   ├── Day4_Olist/
│   ├── Day4_BFSI/
│   ├── Day5_Olist/
│   └── Day5_BFSI/
│
├── week2/                         → Upcoming work
└── week3/                         → Upcoming work
```


---

## 📊 Week 0 – SQL & PySpark Foundations

### **Objective**
To build a strong foundation in SQL and PySpark by working through multiple phases covering data cleaning, transformations, joins, analytics, and pipeline building.

---

### **Problem Summary**

Across all phases, the focus was on:

* Working with structured datasets (customers, orders, products)
* Handling dirty data (nulls, duplicates, invalid values)
* Performing joins and aggregations
* Applying window functions for advanced analytics
* Building end-to-end data pipelines
* Generating meaningful outputs for analysis

---

### **Approach**

1. **Data Loading**

   * Created or loaded datasets (CSV / sample data / real-world data in Phase 5)

2. **Data Cleaning**

   * Removed null values
   * Trimmed strings
   * Filtered invalid records (negative/null values)
   * Ensured valid join keys

3. **Transformations**

   * Filtering and selection
   * Joins (inner, left, anti)
   * Aggregations (sum, count, groupBy)
   * Segmentation (Gold/Silver/Bronze)

4. **Advanced Analytics**

   * Window functions:

     * RANK / DENSE_RANK
     * Running totals
     * LAG
   * Date-based analysis (monthly trends, cumulative sales)

5. **Pipeline Building**

   * Clean → Validate → Join → Aggregate → Analyze → Output

---

### **Key Technologies Used**

#### PySpark
* DataFrame API
* join(), groupBy(), agg()
* window functions
* date functions

#### SQL
* Joins and aggregations
* Window functions
* Subqueries (used instead of CTEs in DB Fiddle)

---

### **Special Notes**

* Phase 5 used **Databricks + real Olist dataset**
* Phase 6 used **Spark Playground with custom dirty dataset**
* SQL implementation required:
  * Replacing CTEs with subqueries (DB Fiddle limitation)
  * Avoiding reserved keywords (`rank` → `spend_rank`)

---

### **Output / Results**

* Filtered datasets  
* Customer spend analysis  
* Top customers per city  
* Running sales trends  
* Product/category insights  
* Customer segmentation  
* Final reporting datasets  

---

### **Challenges Faced**

* Handling null values and dirty data  
* Debugging incorrect joins  
* Managing transformation order  
* Databricks path issues (FileStore vs Volumes)  
* SQL errors due to:
  * CTE limitations  
  * Reserved keywords  
* Differences between environments:
  * Spark Playground vs Local vs Databricks  

---

### **Learnings**

* Importance of data cleaning before transformations  
* Real-world usage of window functions  
* Building structured pipelines instead of isolated queries  
* Understanding environment-specific behavior  
* Debugging systematically instead of guessing  

---

### **Folder Structure (All Phases in Week 0)**

Each phase (Phase 1 → Phase 6) follows this structure:

* solution.py (PySpark implementation)  
* queries.sql (SQL queries)  
* phaseX_problem_statement.pdf  
* Outputs/ (screenshots)  
* README.md  

⚠️ Exception:
* Phase 5 uses `solution.ipynb` instead of `solution.py`

---

## 👤 Author

Dwibhashyam Amarnath Sharma  
22PA1A1240  
Capgemini Data Engineering Trainee
