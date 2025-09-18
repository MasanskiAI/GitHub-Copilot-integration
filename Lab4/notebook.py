from pyspark.sql import SparkSession
from pyspark.sql.types import StructType, StructField, IntegerType, StringType, FloatType, DateType, TimestampType
import random
from datetime import datetime, timedelta
from pyspark.sql import Row
from pyspark.sql.functions import sum as _sum, round as _round
from pyspark.sql.functions import month, year, count
from pyspark.sql.functions import broadcast

spark = SparkSession.builder.appName("GasOilBrokers").getOrCreate()

# 1. Brokers Table
brokers_schema = StructType([
    StructField("broker_id", IntegerType(), False),
    StructField("name", StringType(), False),
    StructField("email", StringType(), False),
    StructField("phone", StringType(), True),
    StructField("company", StringType(), True)
])

brokers_df = spark.createDataFrame([], brokers_schema)

# 2. Clients Table
clients_schema = StructType([
    StructField("client_id", IntegerType(), False),
    StructField("name", StringType(), False),
    StructField("industry", StringType(), True),
    StructField("contact_email", StringType(), False),
    StructField("location", StringType(), True)
])

clients_df = spark.createDataFrame([], clients_schema)

# 3. Products Table
products_schema = StructType([
    StructField("product_id", IntegerType(), False),
    StructField("product_name", StringType(), False),
    StructField("product_type", StringType(), False),  # e.g., 'Oil', 'Gas'
    StructField("unit", StringType(), False)           # e.g., 'barrel', 'MMBtu'
])

products_df = spark.createDataFrame([], products_schema)

# 4. Transactions Table
transactions_schema = StructType([
    StructField("transaction_id", IntegerType(), False),
    StructField("broker_id", IntegerType(), False),
    StructField("client_id", IntegerType(), False),
    StructField("product_id", IntegerType(), False),
    StructField("quantity", FloatType(), False),
    StructField("price_per_unit", FloatType(), False),
    StructField("transaction_date", DateType(), False)
])

transactions_df = spark.createDataFrame([], transactions_schema)

# 5. Deliveries Table
deliveries_schema = StructType([
    StructField("delivery_id", IntegerType(), False),
    StructField("transaction_id", IntegerType(), False),
    StructField("delivery_date", DateType(), False),
    StructField("delivery_status", StringType(), False),  # e.g., 'Pending', 'Completed'
    StructField("delivery_location", StringType(), True)
])

deliveries_df = spark.createDataFrame([], deliveries_schema)

# Helper functions
def random_date(start, end):
    return start + timedelta(days=random.randint(0, (end - start).days))

def random_phone():
    return f"+1-{random.randint(200,999)}-{random.randint(100,999)}-{random.randint(1000,9999)}"

def random_email(name):
    domains = ["example.com", "broker.com", "client.org", "oilgas.com"]
    return f"{name.lower().replace(' ','.')}{random.randint(1,99)}@{random.choice(domains)}"

def random_company():
    companies = ["PetroTrade", "GasLink", "OilMasters", "EnergyBrokers", "FuelConnect"]
    return random.choice(companies)

def random_industry():
    industries = ["Manufacturing", "Transportation", "Utilities", "Retail", "Chemicals", "Construction"]
    return random.choice(industries)

def random_location():
    locations = ["Houston", "New York", "London", "Dubai", "Singapore", "Rotterdam", "Tokyo", "Calgary"]
    return random.choice(locations)

def random_product_type():
    return random.choice(["Oil", "Gas"])

def random_unit(product_type):
    return "barrel" if product_type == "Oil" else "MMBtu"

# 1. Brokers Table (500 rows)
brokers_data = []
for i in range(1, 501):
    name = f"Broker {i}"
    brokers_data.append(Row(
        broker_id=i,
        name=name,
        email=random_email(name),
        phone=random_phone(),
        company=random_company()
    ))
brokers_df = spark.createDataFrame(brokers_data, brokers_schema)

# 2. Clients Table (500 rows)
clients_data = []
for i in range(1, 501):
    name = f"Client {i}"
    clients_data.append(Row(
        client_id=i,
        name=name,
        industry=random_industry(),
        contact_email=random_email(name),
        location=random_location()
    ))
clients_df = spark.createDataFrame(clients_data, clients_schema)

# 3. Products Table (500 rows)
products_data = []
for i in range(1, 501):
    product_type = random_product_type()
    products_data.append(Row(
        product_id=i,
        product_name=f"{product_type} Product {i}",
        product_type=product_type,
        unit=random_unit(product_type)
    ))
products_df = spark.createDataFrame(products_data, products_schema)

# 4. Transactions Table (3000 rows)
transactions_data = []
start_date = datetime(2022, 1, 1)
end_date = datetime(2024, 6, 1)
for i in range(1, 3001):
    broker_id = random.randint(1, 500)
    client_id = random.randint(1, 500)
    product_id = random.randint(1, 500)
    quantity = round(random.uniform(100, 10000), 2)
    price_per_unit = round(random.uniform(20, 120), 2)
    transaction_date = random_date(start_date, end_date)
    transactions_data.append(Row(
        transaction_id=i,
        broker_id=broker_id,
        client_id=client_id,
        product_id=product_id,
        quantity=quantity,
        price_per_unit=price_per_unit,
        transaction_date=transaction_date
    ))
transactions_df = spark.createDataFrame(transactions_data, transactions_schema)

# 5. Deliveries Table (3000 rows, one per transaction, with varied statuses)
delivery_statuses = ["Pending", "Completed", "In Transit", "Cancelled", "Delayed"]
deliveries_data = []
for i in range(1, 3001):
    transaction = transactions_data[i-1]
    base_date = transaction.transaction_date
    status = random.choices(
        delivery_statuses, 
        weights=[0.2, 0.6, 0.1, 0.05, 0.05], 
        k=1
    )[0]
    if status == "Completed":
        delivery_date = base_date + timedelta(days=random.randint(1, 10))
    elif status == "Pending":
        delivery_date = base_date + timedelta(days=random.randint(10, 30))
    elif status == "In Transit":
        delivery_date = base_date + timedelta(days=random.randint(5, 15))
    elif status == "Cancelled":
        delivery_date = base_date + timedelta(days=random.randint(1, 5))
    elif status == "Delayed":
        delivery_date = base_date + timedelta(days=random.randint(15, 40))
    deliveries_data.append(Row(
        delivery_id=i,
        transaction_id=transaction.transaction_id,
        delivery_date=delivery_date,
        delivery_status=status,
        delivery_location=random_location()
    ))
deliveries_df = spark.createDataFrame(deliveries_data, deliveries_schema)

# Test results
print("Brokers Table:")
brokers_df.show(5, truncate=False)

print("Clients Table:")
clients_df.show(5, truncate=False)

print("Products Table:")
products_df.show(5, truncate=False)

print("Transactions Table:")
transactions_df.show(5, truncate=False)

print("Deliveries Table:")
deliveries_df.show(5, truncate=False)

# 1. Cache frequently used DataFrames (after creation)
brokers_df.cache()
clients_df.cache()
products_df.cache()
transactions_df.cache()
deliveries_df.cache()

# 2. Repartition large DataFrames before heavy aggregations (after creation)
transactions_df = transactions_df.repartition("broker_id")
deliveries_df = deliveries_df.repartition("delivery_status")

print("Performance optimizations applied.")

# Analytical queries
# Total transaction volume and value per broker
broker_volume_value_df = transactions_df.groupBy("broker_id").agg(
    _sum("quantity").alias("total_volume"),
    _round(_sum(transactions_df.quantity * transactions_df.price_per_unit), 2).alias("total_value")
).join(brokers_df, "broker_id")

print("Total transaction volume and value per broker:")
broker_volume_value_df.select("broker_id", "name", "total_volume", "total_value").show(10, truncate=False)

# Top 5 clients by transaction value
top_clients_df = transactions_df.groupBy("client_id").agg(
    _sum(transactions_df.quantity * transactions_df.price_per_unit).alias("total_value")
).join(clients_df, "client_id").orderBy("total_value", ascending=False).limit(5)

print("Top 5 clients by transaction value:")
top_clients_df.select("client_id", "name", "total_value").show(truncate=False)

# Monthly transaction trends
monthly_trends_df = transactions_df.withColumn("year", year("transaction_date")) \
    .withColumn("month", month("transaction_date")) \
    .groupBy("year", "month") \
    .agg(
        count("transaction_id").alias("transaction_count"),
        _sum("quantity").alias("total_volume"),
        _round(_sum(transactions_df.quantity * transactions_df.price_per_unit), 2).alias("total_value")
    ) \
    .orderBy("year", "month")

print("Monthly transaction trends:")
monthly_trends_df.show(12, truncate=False)

# Delivery performance metrics
delivery_performance_df = deliveries_df.groupBy("delivery_status").agg(
    count("delivery_id").alias("count")
).orderBy("count", ascending=False)

print("Delivery performance metrics:")
delivery_performance_df.show(truncate=False)

# Data validation
print("Data validation checks:")

# 1. Check for missing/nulls in required columns
print("Missing/nulls in required columns:")
for df, name, required_cols in [
    (brokers_df, "Brokers", ["broker_id", "name", "email"]),
    (clients_df, "Clients", ["client_id", "name", "contact_email"]),
    (products_df, "Products", ["product_id", "product_name", "product_type", "unit"]),
    (transactions_df, "Transactions", ["transaction_id", "broker_id", "client_id", "product_id", "quantity", "price_per_unit", "transaction_date"]),
    (deliveries_df, "Deliveries", ["delivery_id", "transaction_id", "delivery_date", "delivery_status"])
]:
    for col in required_cols:
        null_count = df.filter(df[col].isNull()).count()
        if null_count > 0:
            print(f"{name}: {col} has {null_count} nulls.")

# 2. Check for negative amounts in quantity and price_per_unit
neg_qty = transactions_df.filter(transactions_df.quantity < 0).count()
neg_price = transactions_df.filter(transactions_df.price_per_unit < 0).count()
if neg_qty > 0:
    print(f"Transactions: {neg_qty} rows with negative quantity.")
if neg_price > 0:
    print(f"Transactions: {neg_price} rows with negative price_per_unit.")

# 3. Referential integrity: orphaned foreign keys
# Transactions: broker_id, client_id, product_id must exist
missing_brokers = transactions_df.join(brokers_df, "broker_id", "left_anti").count()
missing_clients = transactions_df.join(clients_df, "client_id", "left_anti").count()
missing_products = transactions_df.join(products_df, "product_id", "left_anti").count()
if missing_brokers > 0:
    print(f"Transactions: {missing_brokers} rows with broker_id not in Brokers.")
if missing_clients > 0:
    print(f"Transactions: {missing_clients} rows with client_id not in Clients.")
if missing_products > 0:
    print(f"Transactions: {missing_products} rows with product_id not in Products.")

# Deliveries: transaction_id must exist
missing_transactions = deliveries_df.join(transactions_df, "transaction_id", "left_anti").count()
if missing_transactions > 0:
    print(f"Deliveries: {missing_transactions} rows with transaction_id not in Transactions.")

print("Data validation complete.")