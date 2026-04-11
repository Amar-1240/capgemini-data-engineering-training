# 📊 Week 1 – Day 6 (Advanced PySpark Pipeline – Car Sales Analytics)

## **Objective**
To build a complete end-to-end data pipeline using PySpark and SQL by handling real-world datasets, performing data cleaning, validation, transformations, and generating analytical insights including dealer-level analysis.

---

## **Problem Summary**

Day 6 focuses on a realistic data engineering scenario involving:

- **Customers Data**
- **Cars Data**
- **Sales Transactions**
- **Dealers Data**
- **Sales-Dealer Mapping**

The goal is to:
- Understand and clean raw datasets  
- Handle invalid and inconsistent data  
- Perform multi-table joins  
- Generate business-level insights  
- Apply window functions for analysis  
- Build a structured pipeline from raw data to final output  

---

## **Approach**

### **1. Data Setup**
- Loaded datasets from CSV files into PySpark environment  
- Created DataFrames for:
  - customers  
  - cars  
  - sales  
  - dealers  
  - sales_dealer  

---

### **2. Data Cleaning**

Handled real-world data issues:

#### 🔹 String Cleaning
- Trimmed spaces from names and city columns  

#### 🔹 Data Type Fixing
- Converted price and quantity to numeric types  
- Parsed sale_date into proper date format  

#### 🔹 Invalid Data Handling
- Converted negative car prices to absolute values  

#### 🔹 Foreign Key Validation
- Removed records where:
  - customer_id not present in customers  
  - car_id not present in cars  

---

### **3. Data Validation**

Performed validation checks:

#### 🔹 Orphan Detection
- Used LEFT ANTI JOIN to identify:
  - Invalid customer references  
  - Invalid car references  
  - Invalid sale_id mappings  

#### 🔹 Validation Report
- Counted invalid and inconsistent records  

---

### **4. Transformations**

Built core analytical datasets:

#### 🔹 Customer Revenue
- Total revenue per customer  
- Number of purchases  
- Total units bought  

#### 🔹 Brand-wise Sales
- Revenue, sales count, and units per car brand  
- Average price per brand  

#### 🔹 City-wise Revenue
- Revenue aggregated by customer city  

---

### **5. Dealer Analytics**

Generated dealer-level insights:

#### 🔹 Revenue per Dealer
- Total revenue, sales count, and units  

#### 🔹 Top Dealers
- Identified highest performing dealers  

#### 🔹 Dealer-City Contribution
- Calculated percentage contribution of each dealer within their city  

---

### **6. SQL Analysis**

Performed advanced analysis using SQL:

#### 🔹 Top 3 Customers per City
- Used `RANK()` window function  

#### 🔹 Monthly Revenue Trends
- Aggregated revenue by year-month  

#### 🔹 Repeat Customers
- Identified customers with multiple purchases  

---

## **Key Concepts Covered**

- PySpark DataFrame transformations  
- Data cleaning and preprocessing  
- Joins (inner, left anti)  
- Window functions (RANK)  
- SQL + PySpark integration  
- Pipeline-based thinking  
- Handling real-world inconsistent data  

---

## **Folder Structure**

Day6/  
│  
├── Raw Data/  
│   ├── cars.csv
│   ├── customers.csv  
│   ├── dealers.csv  
│   ├── sales.csv  
│   └── sales_dealer.csv  
│  
├── Outputs/  
│   ├── brand_sales/   
│   ├── city_revenue/ 
│   ├── customer_revenue/ 
│   ├── dealer_revenue/  
│   ├── monthly/  
│   ├── repeat/
│   └── top3/ 
│  
├── Solution.ipynb → Implementation  
├── Problem_Statement.pdf → Problem statement reference  
│  
└── README.md  

---

## **Output / Results**

- Customer-level revenue insights  
- Brand-wise performance analysis  
- City-wise revenue distribution  
- Dealer performance and contribution  
- Top customers per city  
- Monthly sales trends  
- Identification of repeat customers  

---

## **Challenges Faced**

- Handling inconsistent data types from CSV files  
- Managing invalid foreign key relationships  
- Ensuring correct joins across multiple datasets  
- Understanding window function behavior  
- Structuring a multi-phase pipeline  

---

## **Learnings**

- Data cleaning is the most critical part of any pipeline  
- Real-world datasets always contain inconsistencies  
- Window functions are powerful for ranking and analysis  
- Joins must be applied based on logic, not assumption  
- Structured pipeline design improves clarity and reliability  

---

## **Conclusion**

Day 6 focused on building a complete data engineering pipeline using PySpark and SQL. It covered the full lifecycle from raw data ingestion to final analytical outputs, including dealer-level insights and advanced SQL analysis. This strengthened the ability to design scalable and reliable data pipelines for real-world scenarios.