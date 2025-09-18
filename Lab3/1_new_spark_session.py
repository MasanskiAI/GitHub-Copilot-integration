# Initialize a Spark session in a Databricks notebook

from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("DatabricksSparkSession") \
    .getOrCreate()

# Example: Print Spark version
print(spark.version)