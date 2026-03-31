# Phase 1 – Filtering and Selection
# Dataset: customers (customer_id, customer_name, city, age)
# Platform: SparkPlayground online compiler

from pyspark.sql import SparkSession
from pyspark.sql import functions as F

# Initialize Spark session
spark = SparkSession.builder.appName("Phase1_Filtering_Selection").getOrCreate()

# Create customers DataFrame with sample data
customers = spark.createDataFrame([
    (1, "Ravi",  "Hyderabad", 25),
    (2, "Sita",  "Chennai",   32),
    (3, "Arun",  "Hyderabad", 28),
    (4, "Meena", "Bengaluru", 35),
    (5, "Kiran", "Chennai",   22)
], ["customer_id", "customer_name", "city", "age"])

# Exercise 1: Show all customers
print("Exercise 1: Show all customers")
customers.show()

# Exercise 2: Filter customers from Chennai only
print("Exercise 2: Customers from Chennai")
customers.filter(F.col("city") == "Chennai").show()

# Exercise 3: Filter customers whose age is greater than 25
print("Exercise 3: Customers with age > 25")
customers.filter(F.col("age") > 25).show()

# Exercise 4: Select only customer_name and city columns
print("Exercise 4: customer_name and city only")
customers.select("customer_name", "city").show()

# Exercise 5: Count number of customers in each city
print("Exercise 5: Customer count by city")
customers.groupBy("city") \
    .agg(F.count("customer_id").alias("customer_count")) \
    .orderBy(F.desc("customer_count")) \
    .show()