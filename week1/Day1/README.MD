# 📊 Week 1 – Day 1 (Data Cleaning Pipeline)

## **Objective**
To practice data cleaning and preprocessing on real-world datasets using PySpark by handling missing values, standardizing data, removing invalid records, and generating clean output datasets.

---

## **Problem Summary**

Day 1 focuses on working with two datasets:

- **Customer Dataset (C1.csv)**
- **Orders Dataset (orders.csv)**

Both datasets contain inconsistencies such as:
- Null and blank values  
- Incorrect formats  
- Duplicate records  
- Invalid values (e.g., negative sales)  

The goal is to clean and transform the data into a usable format.

---

## **Approach**

### **1. Data Loading**
- Loaded datasets from CSV files using PySpark
- Enabled schema inference and headers for proper structure

---

### **2. Data Cleaning**

#### **Customer Dataset (C1)**
- Replaced `"blank"` values with `NULL`
- Standardized `Country` column using uppercase transformation
- Filled missing values:
  - `joinDate` → default value
  - `Category` → `"Unknown"`
  - `Sales` → `0`
- Removed records with negative sales
- Dropped duplicate records based on `CustomerID`

---

#### **Orders Dataset**
- Handled missing values in `amount` column by replacing with `0`

---

### **3. Transformations**
- Applied column-level transformations using:
  - `withColumn()`
  - `fillna()`
  - `replace()`
- Filtered invalid data
- Ensured data consistency

---

### **4. Output Generation**
- Saved cleaned datasets into output CSV files
- Used overwrite mode to ensure updated results

---

## **Key Technologies Used**

### **PySpark**
- DataFrame API  
- `withColumn()`, `fillna()`, `filter()`  
- `dropDuplicates()`  
- CSV read/write operations  

---

## **Folder Structure**
Day1/
│
├── raw_data/
│ ├── C1.csv
│ └── orders.csv
│
├── solutions/
│ ├── DAY1.py
│ └── Orders.py
│
├── outputs/
│ ├── C2.csv
│ └── orders_1.csv
│
└── README.md

---

## **Output / Results**

- Cleaned customer dataset without nulls, duplicates, and invalid values  
- Standardized country values  
- Orders dataset with no missing amount values  
- Structured datasets ready for further analysis  

---

## **Challenges Faced**

- Handling inconsistent values like `"blank"`  
- Ensuring correct order of transformations  
- Managing null handling across multiple columns  

---

## **Learnings**

- Importance of data cleaning before analysis  
- Using PySpark transformations effectively  
- Handling real-world messy datasets  
- Building a structured data cleaning pipeline  

---

## **Conclusion**

This task provided hands-on experience in cleaning and preparing datasets using PySpark. It reinforced the importance of preprocessing steps before performing any analysis or building data pipelines.