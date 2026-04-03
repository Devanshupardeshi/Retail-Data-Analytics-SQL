/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `COPY FROM` command to load data from csv Files to bronze tables.

Database:
    PostgreSQL

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    CALL bronze.load_bronze();
===============================================================================
*/

CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE PLPGSQL
AS $$
DECLARE 
    start_time TIMESTAMP; 
    end_time TIMESTAMP; 
    batch_start_time TIMESTAMP;
    batch_end_time TIMESTAMP;
    duration_seconds NUMERIC;
BEGIN
	batch_start_time := clock_timestamp(); -- Record start time
	RAISE NOTICE '================================================';
	RAISE NOTICE 'Loading Bronze Layer';
	RAISE NOTICE '================================================';
	
	RAISE NOTICE '------------------------------------------------';
	RAISE NOTICE 'Loading CRM Tables';
	RAISE NOTICE '------------------------------------------------';

	start_time := clock_timestamp(); -- Record start time
	RAISE NOTICE '>> Truncating Table: bronze.crm_cust_info';
	TRUNCATE TABLE bronze.crm_cust_info;
	RAISE NOTICE '>> Inserting Data Into: bronze.crm_cust_info';
	COPY bronze.crm_cust_info (cst_id,cst_key,cst_firstname,cst_lastname,
								cst_marital_status,cst_gndr,cst_create_date)
	FROM 'D:\cust_info.csv'
	DELIMITER ','
	CSV
	HEADER;
	end_time := clock_timestamp(); -- Record end time
	duration_seconds := EXTRACT(EPOCH FROM (end_time - start_time));
	RAISE NOTICE '>> Load Duration: % seconds', duration_seconds;
    RAISE NOTICE '>> -------------';

	start_time := clock_timestamp(); -- Record start time
	RAISE NOTICE '>> Truncating Table: bronze.crm_prd_info';
	TRUNCATE TABLE bronze.crm_prd_info;
	RAISE NOTICE '>> Inserting Data Into: bronze.crm_prd_info';
	COPY bronze.crm_prd_info (prd_id,prd_key,prd_nm,prd_cost,prd_line,prd_start_dt,prd_end_dt)
	FROM 'D:\prd_info.csv'
	DELIMITER ','
	CSV
	HEADER;
	end_time := clock_timestamp(); -- Record end time
	duration_seconds := EXTRACT(EPOCH FROM (end_time - start_time));
	RAISE NOTICE '>> Load Duration: % seconds', duration_seconds;
    RAISE NOTICE '>> -------------';

	start_time := clock_timestamp(); -- Record start time
	RAISE NOTICE '>> Truncating Table: bronze.crm_sales_details';
	TRUNCATE TABLE bronze.crm_sales_details;
	RAISE NOTICE '>> Inserting Data Into: bronze.crm_sales_details';
	COPY bronze.crm_sales_details (sls_ord_num,sls_prd_key,sls_cust_id,sls_order_dt,sls_ship_dt,
								   sls_due_dt,sls_sales,sls_quantity,sls_price)
	FROM 'D:\sales_details.csv'
	DELIMITER ','
	CSV
	HEADER;
	end_time := clock_timestamp(); -- Record end time
	duration_seconds := EXTRACT(EPOCH FROM (end_time - start_time));
	RAISE NOTICE '>> Load Duration: % seconds', duration_seconds;
    RAISE NOTICE '>> -------------';


	RAISE NOTICE '------------------------------------------------';
	RAISE NOTICE 'Loading ERP Tables';
	RAISE NOTICE '------------------------------------------------';
	

	start_time := clock_timestamp(); -- Record start time
	RAISE NOTICE '>> Truncating Table: bronze.erp_loc_a101';
	TRUNCATE TABLE bronze.erp_loc_a101;
	RAISE NOTICE '>> Inserting Data Into: bronze.erp_loc_a101';
	COPY bronze.erp_loc_a101 (cid,cntry)
	FROM 'D:\LOC_A101.csv'
	DELIMITER ','
	CSV
	HEADER;
	end_time := clock_timestamp(); -- Record end time
	duration_seconds := EXTRACT(EPOCH FROM (end_time - start_time));
	RAISE NOTICE '>> Load Duration: % seconds', duration_seconds;
    RAISE NOTICE '>> -------------';

	start_time := clock_timestamp(); -- Record start time
	RAISE NOTICE '>> Truncating Table: bronze.erp_cust_az12';
	TRUNCATE TABLE bronze.erp_cust_az12;
	RAISE NOTICE '>> Inserting Data Into: bronze.erp_cust_az12';
	COPY bronze.erp_cust_az12 (cid,bdate,gen)
	FROM 'D:\CUST_AZ12.csv'
	DELIMITER ','
	CSV
	HEADER;
	end_time := clock_timestamp(); -- Record end time
	duration_seconds := EXTRACT(EPOCH FROM (end_time - start_time));
	RAISE NOTICE '>> Load Duration: % seconds', duration_seconds;
    RAISE NOTICE '>> -------------';

	start_time := clock_timestamp(); -- Record start time
	RAISE NOTICE '>> Truncating Table: bronze.erp_px_cat_g1v2';
	TRUNCATE TABLE bronze.erp_px_cat_g1v2;
	RAISE NOTICE '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
	COPY bronze.erp_px_cat_g1v2 (id,cat,subcat,maintenance)
	FROM 'D:\PX_CAT_G1V2.csv'
	DELIMITER ','
	CSV
	HEADER;
	end_time := clock_timestamp(); -- Record end time
	duration_seconds := EXTRACT(EPOCH FROM (end_time - start_time));
	RAISE NOTICE '>> Load Duration: % seconds', duration_seconds;
    RAISE NOTICE '>> -------------';
	
	batch_end_time := clock_timestamp(); -- Record end time
	duration_seconds := EXTRACT(EPOCH FROM (batch_end_time - batch_start_time));
	RAISE NOTICE '==========================================';
	RAISE NOTICE '>> Loading Bronze Layer is Completed';
    RAISE NOTICE '>> Total Load Duration: % seconds ', duration_seconds;
	RAISE NOTICE '==========================================';

EXCEPTION
	WHEN others THEN
		RAISE NOTICE '==========================================';
		RAISE NOTICE '❌ ERROR OCCURED DURING LOADING BRONZE LAYER';
		RAISE NOTICE 'Error Message %', SQLERRM;
		RAISE NOTICE 'Error SQL State Code: %' , SQLSTATE;
		RAISE NOTICE '==========================================';
END
$$;
