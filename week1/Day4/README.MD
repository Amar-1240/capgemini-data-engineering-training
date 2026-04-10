# 📊 Week 1 – Day 4 (Advanced SQL Assignment – Student Submission Analysis)

## **Objective**
To analyze student submission data using SQL and PySpark by handling real-world data inconsistencies such as duplicate records, invalid entries, and multiple email mappings, with a focus on joins and window functions.

---

## **Problem Summary**

Day 4 focuses on a real-world data analysis scenario involving:

- **Student Master Data**
- **Task 1 Responses**
- **Task 1 File 2 (duplicates + invalid records)**

The goal is to:
- Clean and normalize data  
- Map multiple emails to a single student  
- Identify valid, invalid, and missing submissions  
- Detect duplicate submissions using window functions  
- Generate final classification of all students  

---

## **Approach**

### **1. Data Setup**
- Loaded datasets from CSV files into Spark / SQL environment  
- Created structured views/tables for:
  - students  
  - responses  
  - responses2  

---

### **2. Data Cleaning**

Handled real-world data issues:

#### 🔹 Column Cleaning
- Removed unwanted spaces in column names  
- Renamed columns to meaningful names  

#### 🔹 Email Normalization
- Converted emails to lowercase  
- Trimmed spaces  
- Ensured consistent format  

#### 🔹 Timestamp Handling
- Parsed multiple timestamp formats  
- Used safe conversion methods to avoid errors  

---

### **3. Data Merging**

Combined both response datasets:

#### 🔹 Full Outer Join
- Merged `responses_clean` and `responses2_clean`  

#### 🔹 COALESCE Usage
- Filled missing values from alternate dataset  

#### 🔹 Duplicate Email Handling
- Removed personal email entries if same GitHub exists with college email  

---

### **4. Core Analysis**

#### 🔹 Valid Submissions
- Identified using INNER JOIN with student email mapping  

#### 🔹 Invalid Submissions
- Emails not present in student master (LEFT ANTI JOIN)  

#### 🔹 Not Submitted
- Students with no submission records  

---

### **5. Duplicate Detection (Window Functions)**

Used:

- `ROW_NUMBER() OVER (PARTITION BY student_id ORDER BY submission_time)`

#### 🔹 Logic
- First submission → valid  
- Remaining → duplicates  

---

### **6. Advanced Insights**

- Counted submissions per student  
- Identified students using both emails  
- Generated final classification:

| Status         | Description |
|---------------|------------|
| Submitted     | Valid single submission |
| Duplicate     | Multiple submissions |
| Not Submitted | No submission |
| Invalid       | Email not in master |

---

## **Key Concepts Covered**

- SQL Joins (Inner, Left, Anti, Full Outer)  
- Window Functions (ROW_NUMBER)  
- Data Cleaning & Normalization  
- Handling inconsistent real-world datasets  
- Building structured data pipelines  

---

## **Folder Structure**

Day4/
│
├── raw_data/  
│   ├── Capgemini Databricks VITB-2026 (1).csv  
│   ├── Task 1 (Responses).csv  
│   └── Task 1 file 2.csv  
│
├── Solution.ipynb → Implementation  
├── Problem_Statement → Problem statement reference  
│
└── README.md  

---

## **Output / Results**

- Cleaned and unified dataset  
- Valid vs Invalid submission identification  
- Duplicate submission detection  
- Final classified dataset for all students  

---

## **Challenges Faced**

- Handling messy column names with spaces  
- Dealing with multiple timestamp formats  
- Mapping emails correctly across datasets  
- Removing duplicate and redundant records  
- Choosing correct join strategies  

---

## **Learnings**

- Real-world data is always inconsistent and requires preprocessing  
- Window functions are more effective than GROUP BY for duplicate handling  
- Joins must be chosen carefully based on logic  
- Data cleaning is the foundation of any pipeline  
- Structured thinking is more important than just writing queries  

---

## **Conclusion**

Day 4 focused on solving a real-world data problem involving multiple datasets and inconsistencies. It helped in building a complete pipeline from raw data cleaning to final classification using SQL and PySpark, strengthening practical data engineering skills.