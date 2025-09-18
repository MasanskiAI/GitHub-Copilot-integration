from pyspark.sql import SparkSession
from pyspark.sql.types import StructType, StructField, IntegerType, DoubleType, StringType, DateType
from datetime import datetime, timedelta
import random

# Initialize Spark session
spark = SparkSession.builder.appName("SyntheticTransactions").getOrCreate()

# Define schema
schema = StructType([
    StructField("transaction_id", IntegerType(), False),
    StructField("customer_id", IntegerType(), False),
    StructField("amount", DoubleType(), False),
    StructField("date", DateType(), False),
    StructField("payment_method", StringType(), False)
])

# Generate synthetic data
payment_methods = ["Credit Card", "Debit Card", "PayPal", "Bank Transfer", "Cash"]
base_date = datetime(2024, 1, 1)
data = []

for i in range(1, 101):
    transaction_id = i
    customer_id = random.randint(1, 20)
    amount = round(random.uniform(10, 500), 2)
    date = base_date + timedelta(days=random.randint(0, 180))
    payment_method = random.choice(payment_methods)
    data.append((transaction_id, customer_id, amount, date.date(), payment_method))

# Create DataFrame
df = spark.createDataFrame(data, schema)

# Show sample
df.show(10)