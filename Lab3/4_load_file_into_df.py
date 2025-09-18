# Load CSV data into a new DataFrame
df_csv_loaded = spark.read.option("header", True).option("inferSchema", True).csv("dbfs:/masanski/synthetic_transactions_csv")

# Load Parquet data into a new DataFrame
df_parquet_loaded = spark.read.parquet("dbfs:/masanski/synthetic_transactions_parquet")

# Show samples
df_csv_loaded.show(5)
df_parquet_loaded.show(5)