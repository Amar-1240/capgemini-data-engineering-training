# Phase 2 – Data Transformation using PySpark
# Dataset: customers.csv and sales.csv from SparkPlayground /samples/ folder
# Platform: SparkPlayground online compiler

from pyspark.sql import SparkSession
from pyspark.sql import functions as F

# Initialize Spark session
spark = SparkSession.builder.appName("Phase2_Joins_Aggregations").getOrCreate()

# Load customers dataset from SparkPlayground sample files
customers = spark.read.option("header", "true").csv("/samples/customers.csv")

# Load sales dataset from SparkPlayground sample files
sales = spark.read.option("header", "true").csv("/samples/sales.csv")

# Data cleaning: Remove rows where customer_id is null in both datasets
customers = customers.dropna(subset=["customer_id"])
sales = sales.dropna(subset=["customer_id"])

# Cast total_amount from string to double for numeric operations
sales = sales.withColumn("total_amount", F.col("total_amount").cast("double"))

# Create a joined DataFrame (left join to retain all customers including those with no sales)
df_joined = customers.join(sales, "customer_id", "left")

# Query 1: Total order amount for each customer
print("1. Total order amount for each customer")
res1 = sales.groupBy("customer_id") \
            .agg(F.round(F.sum("total_amount"), 2).alias("total_order_amount"))
res1.show()

# Query 2: Top 3 customers by total spend
print("2. Top 3 customers by total spend")
top3 = res1.orderBy(F.col("total_order_amount").desc()).limit(3)
top3.show()

# Query 3: Customers with no sales (using left join result where sale_id is null)
print("3. Customers with no orders")
no_orders = df_joined.filter(F.col("sale_id").isNull()) \
                     .select("first_name", "last_name", "customer_id")
no_orders.show()

# Query 4: City-wise total revenue
print("4. City-wise total revenue")
city_revenue = df_joined.groupBy("city") \
                        .agg(F.round(F.sum("total_amount"), 2).alias("city_total"))
city_revenue.show()

# Query 5: Average order amount per customer
print("5. Average order amount per customer")
avg_order = sales.groupBy("customer_id") \
                 .agg(F.round(F.avg("total_amount"), 2).alias("avg_spend"))
avg_order.show()

# Query 6: Customers with more than one order
print("6. Customers with more than one order")
frequent_customers = sales.groupBy("customer_id") \
                          .agg(F.count("sale_id").alias("order_count")) \
                          .filter(F.col("order_count") > 1)
frequent_customers.show()

# Query 7: Sort customers by total spend in descending order
print("7. Customers sorted by total spend descending")
sorted_spend = res1.sort(F.desc("total_order_amount"))
sorted_spend.show()

# Stop Spark session
spark.stop()