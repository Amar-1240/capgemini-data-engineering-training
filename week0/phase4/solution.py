# Phase 4 – Mini Project: Business Pipeline & Analytics
# Objective: Build an end-to-end data pipeline generating business insights
# Dataset: Hardcoded customers and sales data (same used in Phase 4A)
# Platform: SparkPlayground online compiler

from pyspark.sql import SparkSession
from pyspark.sql import functions as F

# Initialize Spark session
spark = SparkSession.builder.appName("Phase4_Business_Pipeline").getOrCreate()

# ─────────────────────────────────────────────
# STEP 1: EXTRACT – Load datasets
# Data covers all 3 segments: Gold >10000, Silver 5000-10000, Bronze <5000
# ─────────────────────────────────────────────

# Customers data
customers_data = [
    (1, "John", "Smith", "Springfield"),
    (2, "Emma", "Jones", "Centerville"),
    (3, "Olivia", "Brown", "Greenville"),
    (4, "Liam", "Johnson", "Riverside"),
    (5, "Noah", "Williams", "Lakeside"),
    (6, "Alice", "Miller", "Oakland"),
    (7, "Isabella", "Davis", "Boise"),
    (8, "James", "Martinez", "Des Moines"),
    (9, "Sophia", "Garcia", "Albany"),
    (10, "Lucas", "Rodriguez", "Portland")
]

# Sales data — amounts designed to cover Gold, Silver and Bronze segments
sales_data = [
    (1, 1, "2024-01-15", 3999.98),
    (2, 1, "2024-01-20", 2999.99),
    (3, 2, "2024-01-16", 5000.00),
    (4, 2, "2024-01-22", 8997.00),
    (5, 3, "2024-01-17", 4998.00),
    (6, 4, "2024-01-18", 11996.00),
    (7, 4, "2024-01-25", 1550.00),
    (8, 5, "2024-01-19", 6675.00),
    (9, 6, "2024-01-20", 4000.00),
    (10, 7, "2024-01-21", 10995.00),
    (11, 8, "2024-01-22", 2000.00),
    (12, 9, "2024-01-23", 7996.00),
    (13, 10, "2024-01-24", 5500.00),
    (14, 1, "2024-01-25", 1500.00),
    (15, 2, "2024-01-26", 3000.00)
]

customers = spark.createDataFrame(customers_data, ["customer_id", "first_name", "last_name", "city"])
sales = spark.createDataFrame(sales_data, ["sale_id", "customer_id", "sale_date", "total_amount"])

print("=== Customers ===")
customers.show()

print("=== Sales ===")
sales.show()

# ─────────────────────────────────────────────
# STEP 2: TRANSFORM – Clean data before processing
# Clean before joining to avoid propagating nulls
# ─────────────────────────────────────────────

# Remove rows with null customer_id (primary key cannot be null)
customers_clean = customers.dropna(subset=["customer_id"]).dropDuplicates()

# Remove null customer_id or total_amount in sales and filter invalid amounts
sales_clean = sales.dropna(subset=["customer_id", "total_amount"]) \
                   .dropDuplicates() \
                   .filter(F.col("total_amount") > 0)

print("=== Cleaned Customers ===")
customers_clean.show()

print("=== Cleaned Sales ===")
sales_clean.show()

# ─────────────────────────────────────────────
# STEP 3: JOIN – Combine customers and sales after cleaning
# ─────────────────────────────────────────────

# Inner join to get only customers who have made purchases
df_joined = customers_clean.join(sales_clean, on="customer_id", how="inner")

# ─────────────────────────────────────────────
# TASK 1: Daily Sales
# Output: date, total_sales
# ─────────────────────────────────────────────

print("Task 1: Daily Sales")
daily_sales = sales_clean.groupBy("sale_date") \
    .agg(F.round(F.sum("total_amount"), 2).alias("total_sales")) \
    .orderBy("sale_date")
daily_sales.show()

# ─────────────────────────────────────────────
# TASK 2: City-wise Revenue
# Output: city, total_revenue
# ─────────────────────────────────────────────

print("Task 2: City-wise Revenue")
city_revenue = df_joined.groupBy("city") \
    .agg(F.round(F.sum("total_amount"), 2).alias("total_revenue")) \
    .orderBy(F.desc("total_revenue"))
city_revenue.show()

# ─────────────────────────────────────────────
# TASK 3: Top 5 Customers by Total Spend
# Output: first_name, last_name, total_spend
# ─────────────────────────────────────────────

print("Task 3: Top 5 Customers by Total Spend")
top5_customers = df_joined.groupBy("customer_id", "first_name", "last_name") \
    .agg(F.round(F.sum("total_amount"), 2).alias("total_spend")) \
    .orderBy(F.desc("total_spend")) \
    .limit(5)
top5_customers.show()

# ─────────────────────────────────────────────
# TASK 4: Repeat Customers (more than 1 order)
# Output: customer_id, order_count
# ─────────────────────────────────────────────

print("Task 4: Repeat Customers (more than 1 order)")
repeat_customers = sales_clean.groupBy("customer_id") \
    .agg(F.count("sale_id").alias("order_count")) \
    .filter(F.col("order_count") > 1) \
    .orderBy(F.desc("order_count"))
repeat_customers.show()

# ─────────────────────────────────────────────
# TASK 5: Customer Segmentation
# Business logic: Gold > 10000, Silver 5000-10000, Bronze < 5000
# Output: first_name, last_name, total_spend, segment
# ─────────────────────────────────────────────

print("Task 5: Customer Segmentation")

# Calculate total spend per customer
customer_spend = df_joined.groupBy("customer_id", "first_name", "last_name") \
    .agg(F.round(F.sum("total_amount"), 2).alias("total_spend"))

# Apply segmentation logic using F.when()
customer_segment = customer_spend.withColumn(
    "segment",
    F.when(F.col("total_spend") > 10000, "Gold")
     .when((F.col("total_spend") >= 5000) & (F.col("total_spend") <= 10000), "Silver")
     .otherwise("Bronze")
)
customer_segment.select("first_name", "last_name", "total_spend", "segment") \
    .orderBy(F.desc("total_spend")).show()

# ─────────────────────────────────────────────
# TASK 6: Final Reporting Table
# Output: first_name, last_name, city, total_spend, order_count, segment
# ─────────────────────────────────────────────

print("Task 6: Final Reporting Table")

# Calculate order count per customer
order_count = sales_clean.groupBy("customer_id") \
    .agg(F.count("sale_id").alias("order_count"))

# Build final report by joining all metrics
final_df = customer_segment \
    .join(order_count, on="customer_id") \
    .join(customers_clean.select("customer_id", "city"), on="customer_id") \
    .select("first_name", "last_name", "city", "total_spend", "order_count", "segment") \
    .orderBy(F.desc("total_spend"))

final_df.show()

# ─────────────────────────────────────────────
# TASK 7: Save Output
# Save final reporting table as CSV
# ─────────────────────────────────────────────
final_df.write.mode("overwrite").csv("/samples/output/report")

# Stop Spark session
spark.stop()
