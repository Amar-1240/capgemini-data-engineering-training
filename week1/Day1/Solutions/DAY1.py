# Databricks notebook source
df = spark.read.csv("/Volumes/workspace/default/day1files/C1.csv",header=True,inferSchema=True)

# COMMAND ----------

df.display()

# COMMAND ----------

# MAGIC %md
# MAGIC ### Handle "blank" values --->NULL

# COMMAND ----------

from pyspark.sql.functions import *
df = df.replace(['blank','Blank'],None)
df.display()

# COMMAND ----------

# MAGIC %md
# MAGIC ### Fix Country Column (Standardization)

# COMMAND ----------

#from pyspark.sql.functions import *
df=df.withColumn("Country",upper(col("Country")))
df.display()

# COMMAND ----------

# MAGIC %md
# MAGIC ### Fill NULL Values

# COMMAND ----------

df=df.fillna({
    "joinDate":"01-01-2023" , 
    "Category":"Unknown",
    "Sales":0
    })
df.display()

# COMMAND ----------

# MAGIC %md
# MAGIC ### Remove Negative Sales

# COMMAND ----------

df=df.filter(col("Sales")>=0)
df.display()

# COMMAND ----------

# MAGIC %md
# MAGIC ###Remove Duplicates

# COMMAND ----------

df=df.dropDuplicates(["CustomerID"])
df.display()

# COMMAND ----------

# MAGIC %md
# MAGIC ### Save cleaned Data

# COMMAND ----------

df.write.mode("overwrite").csv("/Volumes/workspace/default/day1files/C2.csv",header=True)

# COMMAND ----------

# MAGIC %md
# MAGIC ###Final Code

# COMMAND ----------

from pyspark.sql.functions import *

df = spark.read.csv("/Volumes/workspace/default/day1files/C1.csv",header=True,inferSchema=True)

df = df.replace(['blank','Blank'],None)\
    .withColumn("Country",upper(col("Country")))\
    .fillna({
    "joinDate":"01-01-2023" ,  
    "Category":"Unknown",
    "Sales":0
    })\
    .filter(col("Sales")>=0)\
    .dropDuplicates(["CustomerID"])

df.write.mode("overwrite").csv("/Volumes/workspace/default/day1files/C2.csv",header=True)

# COMMAND ----------

df.display()