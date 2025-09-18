from pyspark.sql.functions import col

# 1. Check for transactions with negative amounts
negative_amounts = df_clean.filter(col("amount") < 0)
print("Negative amount transactions:", negative_amounts.count())
negative_amounts.show(5)

# 2. Check for nulls in key fields
nulls_in_keys = df_clean.filter(
    col("transaction_id").isNull() |
    col("customer_id").isNull() |
    col("amount").isNull() |
    col("date").isNull()
)
print("Rows with nulls in key fields:", nulls_in_keys.count())
nulls_in_keys.show(5)

# 3. Basic statistics for numeric fields
df_clean.describe(["amount"]).show()

# 4. Count total records after cleaning
print("Total records after cleaning:", df_clean.count())