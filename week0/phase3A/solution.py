# Phase 3A – Data Quality and Cleaning Challenge
# Datasets: customers.csv, sales.csv, products.json, titanic.parquet from SparkPlayground /samples/
# Platform: SparkPlayground online compiler

from pyspark.sql import SparkSession
from pyspark.sql import functions as F
from pyspark.sql.types import DoubleType, IntegerType

# Initialize Spark session
spark = SparkSession.builder.appName("Phase3A_DataQuality_Cleaning").getOrCreate()

# ─────────────────────────────────────────────────────────────
# Load datasets from SparkPlayground sample files
# ─────────────────────────────────────────────────────────────
customers = spark.read.option("header", "true").csv("/samples/customers.csv")
sales = spark.read.option("header", "true").csv("/samples/sales.csv")
products = spark.read.option("multiLine", "true").json("/samples/products.json")
titanic = spark.read.parquet("/samples/titanic.parquet")

# ─────────────────────────────────────────────────────────────
# Exercise 1: Data Quality Inspection
# ─────────────────────────────────────────────────────────────
print("=" * 60)
print("Exercise 1: Data Quality Inspection")
print("=" * 60)

# 1a. Inspect schemas
print("\n--- customers schema ---")
customers.printSchema()

print("\n--- sales schema ---")
sales.printSchema()

print("\n--- products schema ---")
products.printSchema()

print("\n--- titanic schema ---")
titanic.printSchema()

# 1b. Count null values per column in customers
print("\n--- Null counts in customers ---")
customers.select([
    F.count(F.when(F.col(c).isNull(), 1)).alias(c)
    for c in customers.columns
]).show()

# 1c. Count null values per column in sales
print("\n--- Null counts in sales ---")
sales.select([
    F.count(F.when(F.col(c).isNull(), 1)).alias(c)
    for c in sales.columns
]).show()

# 1d. Count null values per column in titanic
print("\n--- Null counts in titanic ---")
titanic.select([
    F.count(F.when(F.col(c).isNull(), 1)).alias(c)
    for c in titanic.columns
]).show()

# 1e. Detect duplicate records
print("\n--- Duplicate detection ---")
customers_total = customers.count()
customers_distinct = customers.distinct().count()
print(f"customers: total rows = {customers_total}, distinct rows = {customers_distinct}, duplicates = {customers_total - customers_distinct}")

sales_total = sales.count()
sales_distinct = sales.distinct().count()
print(f"sales: total rows = {sales_total}, distinct rows = {sales_distinct}, duplicates = {sales_total - sales_distinct}")

# ─────────────────────────────────────────────────────────────
# Exercise 2: Null Value Handling
# ─────────────────────────────────────────────────────────────
print("\n" + "=" * 60)
print("Exercise 2: Null Value Handling")
print("=" * 60)

# 2a. Drop rows where customer_id is null (critical key column)
print("\n--- Drop rows with null customer_id ---")
customers_clean = customers.dropna(subset=["customer_id"])
print(f"customers before dropna: {customers.count()}, after: {customers_clean.count()}")

# 2b. Fill missing city values with 'Unknown'
print("\n--- Fill null city with 'Unknown' ---")
customers_clean = customers_clean.fillna({"city": "Unknown"})
customers_clean.show()

# 2c. Drop rows where sale_id or customer_id is null in sales
print("\n--- Drop rows with null sale_id or customer_id in sales ---")
sales_clean = sales.dropna(subset=["sale_id", "customer_id"])
print(f"sales before dropna: {sales.count()}, after: {sales_clean.count()}")

# 2d. Use coalesce to fill null total_amount with 0.0
print("\n--- Fill null total_amount with 0.0 using coalesce ---")
sales_clean = sales_clean.withColumn(
    "total_amount",
    F.coalesce(F.col("total_amount").cast(DoubleType()), F.lit(0.0))
)

# 2e. Fill missing Age in titanic with median-style fill (use fillna with a fixed value)
print("\n--- Fill null Age in titanic with 30 (default) ---")
titanic_clean = titanic.fillna({"Age": 30.0, "Embarked": "S", "Cabin": "Unknown"})
print(f"titanic null Age before: {titanic.filter(F.col('Age').isNull()).count()}, after: {titanic_clean.filter(F.col('Age').isNull()).count()}")

# ─────────────────────────────────────────────────────────────
# Exercise 3: Duplicate Removal
# ─────────────────────────────────────────────────────────────
print("\n" + "=" * 60)
print("Exercise 3: Duplicate Removal")
print("=" * 60)

# 3a. Remove exact duplicate rows from customers
print("\n--- Remove exact duplicate rows from customers ---")
customers_deduped = customers_clean.dropDuplicates()
print(f"customers after dropDuplicates (exact): {customers_deduped.count()}")

# 3b. Remove duplicates based on customer_id only (keep first occurrence)
print("\n--- Remove duplicates based on customer_id only ---")
customers_deduped = customers_clean.dropDuplicates(subset=["customer_id"])
print(f"customers after dropDuplicates(subset=['customer_id']): {customers_deduped.count()}")
customers_deduped.show()

# 3c. Remove duplicate sales records based on sale_id
print("\n--- Remove duplicate sale records based on sale_id ---")
sales_deduped = sales_clean.dropDuplicates(subset=["sale_id"])
print(f"sales after dropDuplicates(subset=['sale_id']): {sales_deduped.count()}")

# ─────────────────────────────────────────────────────────────
# Exercise 4: Data Format Standardisation
# ─────────────────────────────────────────────────────────────
print("\n" + "=" * 60)
print("Exercise 4: Data Format Standardisation")
print("=" * 60)

# 4a. Trim whitespace from all string columns in customers
print("\n--- Trim whitespace from string columns ---")
string_cols = [f.name for f in customers_deduped.schema.fields if str(f.dataType) == "StringType()"]
for col_name in string_cols:
    customers_deduped = customers_deduped.withColumn(col_name, F.trim(F.col(col_name)))
customers_deduped.show()

# 4b. Standardise email to lowercase
print("\n--- Standardise email to lowercase ---")
if "email" in customers_deduped.columns:
    customers_deduped = customers_deduped.withColumn("email", F.lower(F.trim(F.col("email"))))
    customers_deduped.select("customer_id", "email").show()

# 4c. Remove non-numeric characters from phone column
print("\n--- Remove non-numeric characters from phone ---")
if "phone" in customers_deduped.columns:
    customers_deduped = customers_deduped.withColumn(
        "phone", F.regexp_replace(F.col("phone"), r"[^0-9]", "")
    )
    customers_deduped.select("customer_id", "phone").show()

# 4d. Cast total_amount to double in sales
print("\n--- Cast total_amount to double in sales ---")
sales_deduped = sales_deduped.withColumn("total_amount", F.col("total_amount").cast(DoubleType()))

# 4e. Cast Age and Fare to double in titanic (they may already be correct type from parquet)
print("\n--- Cast Age and Fare to double in titanic ---")
titanic_clean = titanic_clean \
    .withColumn("Age", F.col("Age").cast(DoubleType())) \
    .withColumn("Fare", F.col("Fare").cast(DoubleType())) \
    .withColumn("Pclass", F.col("Pclass").cast(IntegerType()))
titanic_clean.printSchema()

# ─────────────────────────────────────────────────────────────
# Exercise 5: Outlier Detection
# ─────────────────────────────────────────────────────────────
print("\n" + "=" * 60)
print("Exercise 5: Outlier Detection using Statistical Methods")
print("=" * 60)

# 5a. Detect outliers in total_amount using IQR method
print("\n--- Outlier detection in sales total_amount (IQR method) ---")
quantiles = sales_deduped.approxQuantile("total_amount", [0.25, 0.75], 0.01)
q1 = quantiles[0]
q3 = quantiles[1]
iqr = q3 - q1
lower_bound = q1 - 1.5 * iqr
upper_bound = q3 + 1.5 * iqr
print(f"Q1={q1}, Q3={q3}, IQR={iqr}, Lower bound={lower_bound}, Upper bound={upper_bound}")

# Flag outlier rows
sales_flagged = sales_deduped.withColumn(
    "is_outlier",
    F.when(
        (F.col("total_amount") < lower_bound) | (F.col("total_amount") > upper_bound),
        True
    ).otherwise(False)
)
print("\nOutlier records in sales:")
sales_flagged.filter(F.col("is_outlier") == True).show()

# 5b. Detect outliers in titanic Fare using IQR method
print("\n--- Outlier detection in titanic Fare (IQR method) ---")
fare_quantiles = titanic_clean.approxQuantile("Fare", [0.25, 0.75], 0.01)
fare_q1 = fare_quantiles[0]
fare_q3 = fare_quantiles[1]
fare_iqr = fare_q3 - fare_q1
fare_lower = fare_q1 - 1.5 * fare_iqr
fare_upper = fare_q3 + 1.5 * fare_iqr
print(f"Fare Q1={fare_q1}, Q3={fare_q3}, IQR={fare_iqr}, Lower={fare_lower}, Upper={fare_upper}")

titanic_flagged = titanic_clean.withColumn(
    "fare_outlier",
    F.when(
        (F.col("Fare") < fare_lower) | (F.col("Fare") > fare_upper),
        True
    ).otherwise(False)
)
print(f"Titanic fare outlier count: {titanic_flagged.filter(F.col('fare_outlier') == True).count()}")
titanic_flagged.filter(F.col("fare_outlier") == True).select("PassengerId", "Name", "Fare", "fare_outlier").show(10)

# ─────────────────────────────────────────────────────────────
# Exercise 6: Quality Report – Before vs After Cleaning
# ─────────────────────────────────────────────────────────────
print("\n" + "=" * 60)
print("Exercise 6: Data Quality Report (Before vs After)")
print("=" * 60)

# Before cleaning metrics
before_cust_rows = customers.count()
before_cust_nulls = customers.filter(F.col("customer_id").isNull()).count()
before_cust_dups = before_cust_rows - customers.distinct().count()

before_sales_rows = sales.count()
before_sales_nulls = sales.filter(F.col("sale_id").isNull()).count()
before_sales_dups = before_sales_rows - sales.distinct().count()

# After cleaning metrics
after_cust_rows = customers_deduped.count()
after_cust_nulls = customers_deduped.filter(F.col("customer_id").isNull()).count()
after_cust_dups = after_cust_rows - customers_deduped.distinct().count()

after_sales_rows = sales_deduped.count()
after_sales_nulls = sales_deduped.filter(F.col("sale_id").isNull()).count()
after_sales_dups = after_sales_rows - sales_deduped.distinct().count()

# Display quality report
quality_report = spark.createDataFrame([
    ("customers", before_cust_rows, before_cust_nulls, before_cust_dups,
     after_cust_rows, after_cust_nulls, after_cust_dups),
    ("sales", before_sales_rows, before_sales_nulls, before_sales_dups,
     after_sales_rows, after_sales_nulls, after_sales_dups),
], ["dataset", "before_rows", "before_nulls", "before_dups",
    "after_rows", "after_nulls", "after_dups"])

print("\nData Quality Report:")
quality_report.show()

# Stop Spark session
spark.stop()
