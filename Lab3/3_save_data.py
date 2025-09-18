# Save to DBFS in CSV format
df.write.mode("overwrite").option("header", True).csv("dbfs:/masanski/synthetic_transactions_csv")

# Save to DBFS in Parquet format
df.write.mode("overwrite").parquet("dbfs:/masanski/synthetic_transactions_parquet")

# Explanation:
# - Use CSV for interoperability and human readability, but it is slower and less efficient for big data.
# - Use Parquet for analytics and Spark processing: it is columnar, compressed, and much faster for large datasets.
# - Copilot helps format DBFS paths (e.g., "dbfs:/tmp/...") and set write options (like header=True for CSV).