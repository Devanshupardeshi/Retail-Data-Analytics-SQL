import sqlite3
import pandas as pd
import os
import time

# --- Configuration ---
DB_NAME = "data_warehouse.db"
BASE_PATH = "Data Warehouse/row_dataset"
OUTPUT_PATH = "EDA + Advanced Data Analysis/dataset"

CRM_PATH = os.path.join(BASE_PATH, "source_crm")
ERP_PATH = os.path.join(BASE_PATH, "source_erp")

# Ensure output directory exists
if not os.path.exists(OUTPUT_PATH):
    os.makedirs(OUTPUT_PATH)

def run_pipeline():
    conn = sqlite3.connect(DB_NAME)
    cursor = conn.cursor()

    print("================================================")
    print("🚀 Starting SQL Data Warehouse Simulation")
    print("================================================")

    # --- 1. Bronze Layer (Raw Ingestion) ---
    print("\n[BRONZE] Loading Raw Data...")
    
    # CRM Data
    pd.read_csv(os.path.join(CRM_PATH, "cust_info.csv")).to_sql("bronze_crm_cust_info", conn, if_exists="replace", index=False)
    pd.read_csv(os.path.join(CRM_PATH, "prd_info.csv")).to_sql("bronze_crm_prd_info", conn, if_exists="replace", index=False)
    pd.read_csv(os.path.join(CRM_PATH, "sales_details.csv")).to_sql("bronze_crm_sales_details", conn, if_exists="replace", index=False)
    
    # ERP Data
    pd.read_csv(os.path.join(ERP_PATH, "CUST_AZ12.csv")).to_sql("bronze_erp_cust_az12", conn, if_exists="replace", index=False)
    pd.read_csv(os.path.join(ERP_PATH, "LOC_A101.csv")).to_sql("bronze_erp_loc_a101", conn, if_exists="replace", index=False)
    pd.read_csv(os.path.join(ERP_PATH, "PX_CAT_G1V2.csv")).to_sql("bronze_erp_px_cat_g1v2", conn, if_exists="replace", index=False)
    
    print("✅ Bronze Layer Completed.")

    # --- 2. Silver Layer (Cleansing & Normalization) ---
    print("\n[SILVER] Cleansing & Harmonizing Data...")

    # CRM Customer Info: Trim, Deduplicate, Normalize Gender/Status
    cursor.execute("""
        CREATE TABLE silver_crm_cust_info AS
        SELECT cst_id, cst_key, 
               TRIM(cst_firstname) as cst_firstname, 
               TRIM(cst_lastname) as cst_lastname,
               CASE WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single' 
                    WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married' 
                    ELSE 'n/a' END as cst_marital_status,
               CASE WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female' 
                    WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male' 
                    ELSE 'n/a' END as cst_gndr,
               cst_create_date
        FROM (
            SELECT *, ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) as rn 
            FROM bronze_crm_cust_info
        ) WHERE rn = 1;
    """)

    # CRM Product Info: Key splitting, handling nulls
    cursor.execute("""
        CREATE TABLE silver_crm_prd_info AS
        SELECT prd_id, 
               REPLACE(SUBSTR(prd_key, 1, 5), '-', '_') as cat_id,
               SUBSTR(prd_key, 7) as prd_key,
               prd_nm,
               COALESCE(prd_cost, 0) as prd_cost,
               CASE WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain' 
                    WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road' 
                    WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales' 
                    WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring' 
                    ELSE 'n/a' END as prd_line,
               prd_start_dt
        FROM bronze_crm_prd_info;
    """)

    # CRM Sales: Date format conversion (YYYYMMDD string -> YYYY-MM-DD), Price logic
    cursor.execute("""
        CREATE TABLE silver_crm_sales_details AS
        SELECT sls_ord_num, sls_prd_key, sls_cust_id,
               CASE WHEN sls_order_dt = 0 THEN NULL 
                    ELSE SUBSTR(CAST(sls_order_dt as TEXT), 1, 4) || '-' || SUBSTR(CAST(sls_order_dt as TEXT), 5, 2) || '-' || SUBSTR(CAST(sls_order_dt as TEXT), 7, 2) END as sls_order_dt,
               sls_sales, sls_quantity, sls_price
        FROM bronze_crm_sales_details;
    """)

    # ERP Data Cleansing
    cursor.execute("""
        CREATE TABLE silver_erp_cust_az12 AS
        SELECT CASE WHEN CID LIKE 'NAS%' THEN SUBSTR(CID, 4) ELSE CID END as cid,
               BDATE,
               CASE WHEN UPPER(TRIM(GEN)) IN ('F', 'FEMALE') THEN 'Female'
                    WHEN UPPER(TRIM(GEN)) IN ('M', 'MALE') THEN 'Male'
                    ELSE 'n/a' END as gen
        FROM bronze_erp_cust_az12;
    """)

    cursor.execute("""
        CREATE TABLE silver_erp_loc_a101 AS
        SELECT REPLACE(CID, '-', '') as cid,
               CASE WHEN TRIM(CNTRY) IN ('US', 'USA') THEN 'United States'
                    WHEN TRIM(CNTRY) = 'DE' THEN 'Germany'
                    ELSE TRIM(CNTRY) END as cntry
        FROM bronze_erp_loc_a101;
    """)
    
    print("✅ Silver Layer Completed.")

    # --- 3. Gold Layer (Fact & Dimensions) ---
    print("\n[GOLD] Building Star Schema...")

    # Fact Sales: Enriched Sales Data
    cursor.execute("""
        CREATE TABLE gold_fact_sales AS
        SELECT s.sls_ord_num, s.sls_prd_key, s.sls_cust_id, s.sls_order_dt,
               s.sls_sales, s.sls_quantity, s.sls_price
        FROM silver_crm_sales_details s;
    """)

    # Dim Customers: Master Customer Table
    cursor.execute("""
        CREATE TABLE gold_dim_customers AS
        SELECT c.cst_id, c.cst_key, c.cst_firstname, c.cst_lastname, c.cst_gndr, l.cntry
        FROM silver_crm_cust_info c
        LEFT JOIN silver_erp_loc_a101 l ON c.cst_key = l.cid;
    """)

    # Dim Products: Master Product Table
    cursor.execute("""
        CREATE TABLE gold_dim_products AS
        SELECT p.prd_id, p.prd_key, p.prd_nm, p.prd_cost, p.prd_line, cat.cat, cat.subcat
        FROM silver_crm_prd_info p
        LEFT JOIN bronze_erp_px_cat_g1v2 cat ON p.cat_id = cat.id;
    """)

    print("✅ Gold Layer Completed.")

    # --- 4. Analytics Reports ---
    print("\n[ANALYTICS] Generating Business Reports...")

    # Customer Report
    customer_report = pd.read_sql_query("""
        SELECT c.cst_id, c.cst_firstname, c.cst_lastname, c.cntry,
               COUNT(f.sls_ord_num) as total_orders,
               SUM(f.sls_sales) as total_sales,
               AVG(f.sls_sales) as avg_order_value
        FROM gold_dim_customers c
        JOIN gold_fact_sales f ON c.cst_id = f.sls_cust_id
        GROUP BY 1, 2, 3, 4
        ORDER BY total_sales DESC;
    """, conn)
    customer_report.to_csv(os.path.join(OUTPUT_PATH, "gold.report_customers.csv"), index=False)

    # Product Report
    product_report = pd.read_sql_query("""
        SELECT p.prd_nm, p.cat, p.subcat,
               SUM(f.sls_quantity) as total_quantity_sold,
               SUM(f.sls_sales) as total_revenue
        FROM gold_dim_products p
        JOIN gold_fact_sales f ON p.prd_key = f.sls_prd_key
        GROUP BY 1, 2, 3
        ORDER BY total_revenue DESC;
    """, conn)
    product_report.to_csv(os.path.join(OUTPUT_PATH, "gold.report_products.csv"), index=False)

    print(f"📊 Reports Saved to: {OUTPUT_PATH}")
    print("\n[SUMMARY]")
    print(f"- Total Customers Processed: {len(customer_report)}")
    print(f"- Total Products Analyzed: {len(product_report)}")
    print("================================================")
    print("🎉 Pipeline Execution Finished Successfully!")
    print("================================================")

    conn.close()

if __name__ == "__main__":
    run_pipeline()
