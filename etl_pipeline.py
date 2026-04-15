 Python ETL & Automation

This project includes an automated ETL pipeline built using Python.
Workflow:

 Extract data from CSV
 Transform and clean data using Pandas
 Load data into MySQL database
 Automate pipeline execution
 Add logging and error handling

This simulates a real-world data engineering workflow.


import pandas as pd
import mysql.connector
import logging

# Logging setup
logging.basicConfig(filename='pipeline.log', level=logging.INFO)

try:
    logging.info("Pipeline started")

    # Extract
    orders = pd.read_csv("../data/orders.csv")
    users = pd.read_csv("../data/users.csv")
    products = pd.read_csv("../data/products.csv")

    # Transform
    orders.fillna(0, inplace=True)
    orders['order_date'] = pd.to_datetime(orders['order_date'])

    # Connect to MySQL
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="your_password",
        database="ecommerce_project"
    )
    cursor = conn.cursor()

    # Load data (example: orders)
    for _, row in orders.iterrows():
        cursor.execute("""
            INSERT INTO orders (order_id, user_id, product_id, amount, order_date)
            VALUES (%s, %s, %s, %s, %s)
        """, tuple(row))

    conn.commit()

    logging.info("Pipeline completed successfully")

except Exception as e:
    logging.error(f"Pipeline failed: {e}")
    print("Error:", e)



import schedule
import time
import os

def run_pipeline():
    os.system("python etl_pipeline.py")

schedule.every().day.at("10:00").do(run_pipeline)

while True:
    schedule.run_pending()
    time.sleep(1)

if orders['amount'].sum() < 10000:
    print("Alert: Revenue dropped!")
