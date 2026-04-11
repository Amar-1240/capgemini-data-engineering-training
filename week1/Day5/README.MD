# 📊 Week 1 – Day 5 (SQL: NULL Functions & REGEX)

## **Objective**

To develop strong SQL skills in handling:

* Missing or incomplete data using NULL functions
* Pattern matching and text extraction using REGEX

These concepts are critical for real-world data cleaning and transformation tasks.

---

## **Problem Summary**

Day 5 focuses on two key areas:

* **NULL Handling Functions (ISNULL, COALESCE, NULLIF)**
* **REGEX (Regular Expressions) for pattern extraction**

The datasets used include:

* Employees, Orders, and Products tables with NULL values 
* Regex practice dataset with structured and unstructured text patterns 

---

## **Approach**

### **1. Data Setup**

* Created tables:

  * `Employees`
  * `Orders`
  * `Products`
  * `regex_practice`
* Inserted structured sample data including NULL values and pattern-rich text

---

### **2. NULL Functions Implementation**

Solved multiple levels of problems:

#### 🔹 Basic NULL Handling

* Filtering NULL values using `IS NULL` and `IS NOT NULL`
* Counting NULL occurrences

#### 🔹 ISNULL / IFNULL

* Replacing NULL values with defaults
* Handling missing salary, bonus, stock, and amounts

#### 🔹 COALESCE

* Selecting first non-null value from multiple columns
* Creating fallback logic for incomplete data

#### 🔹 NULLIF

* Converting values to NULL based on conditions
* Avoiding divide-by-zero errors

#### 🔹 Real-World Scenarios

* Total income calculation (salary + bonus)
* Identifying missing data patterns
* Final payable amount after discount

---

### **3. REGEX Implementation**

Solved 20 pattern-based problems using regular expressions:

#### 🔹 Basic Pattern Extraction

* Extracting numbers from beginning and end
* Extracting first and last characters

#### 🔹 Intermediate Patterns

* Extracting digits within text
* Extracting alphabetic sequences
* Identifying country codes from phone numbers

#### 🔹 Email Parsing

* Extracting username (before @)
* Extracting domain and extensions

#### 🔹 Complex Patterns

* Extracting values between delimiters
* Matching specific numeric patterns
* Parsing structured identifiers (EMP001, ORD-11, etc.)

---

## **Key Concepts Covered**

* NULL handling functions (ISNULL, COALESCE, NULLIF)
* Filtering NULL values
* Data cleaning techniques
* REGEX pattern matching
* String parsing and extraction
* Handling inconsistent and messy data

---

## **Folder Structure**

Day5/
│
├── Null Functions.docx → NULL function concepts & questions
├── Null_Functions.sql → Solutions
│
├── REGEX BASIC ASSIGNMENT.docx → REGEX problem statements
├── REGEX BASIC ASSIGNMENT.sql → Solutions
│
└── README.md

---

## **Output / Results**

* Cleaned datasets with NULL values handled properly
* Accurate calculations despite missing data
* Extracted structured information from unstructured text
* Pattern-based data insights using REGEX

---

## **Challenges Faced**

* Understanding difference between ISNULL, COALESCE, and NULLIF
* Handling NULLs in arithmetic operations
* Writing correct REGEX patterns
* Debugging incorrect pattern matches
* Managing edge cases in text extraction

---

## **Learnings**

* NULL handling is essential for reliable data processing
* COALESCE is powerful for fallback logic
* REGEX is critical for text parsing and data cleaning
* Small mistakes in REGEX lead to completely wrong results
* Real-world data is messy and requires defensive SQL

---

## **Conclusion**

Day 5 focused on handling imperfect data and extracting meaningful insights using:

* NULL handling techniques
* Regular expressions

These skills are essential for data preprocessing and form a key part of real-world data engineering workflows.
