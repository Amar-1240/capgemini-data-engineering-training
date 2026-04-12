# 📊 Week 2 – Day 1 (Advanced PySpark Pipeline – Insurance Domain)

## **Objective**
To build a complete end-to-end data engineering pipeline using PySpark by working on an insurance dataset, focusing on data cleaning, validation, transformations, and analytical insights related to customers, policies, claims, and agents.

---

## **Problem Summary**

Day 1 focuses on a real-world insurance domain scenario involving:

- **Customers Data**
- **Policies Data**
- **Claims Data**
- **Agents Data**
- **Policy-Agent Mapping**

The goal is to:
- Understand relationships between datasets  
- Clean and preprocess raw data  
- Validate data integrity  
- Perform multi-table joins  
- Generate business insights such as risk and premium analysis  
- Apply window functions for ranking  

This follows a structured pipeline approach instead of writing isolated queries :contentReference[oaicite:0]{index=0}  

---

## **Approach**

### **1. Data Setup**
- Loaded all CSV files into PySpark DataFrames  
- Verified schema using `printSchema()`  
- Checked row counts for each dataset  
- Understood relationships:
  - Customer → Policy → Claim → Agent  

---

### **2. Issues Identified**

During initial analysis, the following issues were found:

- Negative values in **premium** and **claim_amount**  
- Null values in key columns (customer_id, policy_id)  
- Inconsistent string formatting (city names)  
- Invalid foreign key relationships:
  - Policies without valid customers  
  - Claims without valid policies  
- Risk of duplication due to improper joins  

---

### **3. Data Cleaning**

Applied multiple cleaning steps:

#### 🔹 Handling Invalid Values
- Removed records with negative premium and claim_amount  

#### 🔹 Null Handling
- Dropped records with missing critical keys  
- Filled non-critical null values where needed  

#### 🔹 String Standardization
- Trimmed spaces  
- Standardized city names using proper casing  

#### 🔹 Data Type Fixing
- Converted date columns to proper date format  
- Ensured numeric columns are correctly typed  

---

### **4. Data Validation**

Performed validation to ensure correctness:

#### 🔹 Referential Integrity Checks
- Used **LEFT ANTI JOIN** to find:
  - Policies without customers  
  - Claims without policies  

#### 🔹 Row Count Validation
- Compared row counts before and after joins  
- Ensured no unexpected data explosion  

#### 🔹 Aggregation Validation
- Verified:
  - Total premium is positive  
  - Total claims are logically consistent  

---

### **5. Transformations**

Built core analytical datasets:

#### 🔹 Customer Metrics
- Total premium per customer  
- Total claim amount per customer  
- Risk score = total_claim / total_premium  

#### 🔹 City-wise Analysis
- Aggregated premium and claims by city  

---

### **6. Window Functions**

Applied analytical functions:

#### 🔹 Risk Ranking
- Ranked customers based on risk score per city  

#### 🔹 Agent Ranking
- Ranked agents based on total premium handled  

---

## **Key Concepts Covered**

- Data cleaning and preprocessing  
- Referential integrity validation  
- Joins (inner, left, left anti)  
- Aggregations and groupBy  
- Window functions (RANK, DENSE_RANK)  
- Pipeline-based data engineering approach  

---

## **Folder Structure**

Day1/  
│  
├── Raw Data/  
│   ├── customers.csv  
│   ├── policies.csv  
│   ├── claims.csv  
│   ├── agents.csv  
│   └── policy_agent.csv  
│  
├── Outputs/  
│   ├── customer_metrics.csv  
│   ├── city_metrics.csv  
│   ├── top_risky_customers.csv  
│   └── agent_ranking.csv  
│  
├── Solution.ipynb → Implementation  
├── Problem_Statement.pdf → Problem reference  
│  
└── README.md  

---

## **Output / Results**

- Customer-level premium and claim analysis  
- Risk score calculation for each customer  
- City-wise premium and claim distribution  
- Top risky customers per city  
- Agent performance ranking  

---

## **Key Insights from Analysis**

- Customers with high claim-to-premium ratio represent higher risk  
- Certain cities show higher aggregated claims compared to premium  
- A small number of agents contribute to a large portion of total premium  
- Data cleaning significantly impacts final results accuracy  

---

## **Challenges Faced**

- Handling negative and inconsistent data  
- Managing joins without duplication  
- Ensuring referential integrity across multiple tables  
- Structuring pipeline in logical steps instead of single queries  

---

## **Learnings**

- Data validation is as important as transformation  
- Real-world datasets are always inconsistent  
- Window functions provide powerful analytical capabilities  
- Proper pipeline design avoids errors and improves clarity  

---

## **Conclusion**

Day 1 of Week 2 focused on building a structured data engineering pipeline in the insurance domain. It emphasized data cleaning, validation, and transformation before analysis, helping in developing a strong foundation for handling real-world data pipelines effectively.