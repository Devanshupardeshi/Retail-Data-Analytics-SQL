/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a three schemas within the database named 'DataWarehouse':
	'bronze', 'silver', and 'gold' after checking if it already exists.
    If the schemas exists, it is dropped and recreated.
	
WARNING:
    Running this script will drop all three Schemas 'bronze', 'silver', and 'gold' in database if it exists. 
    All data in the Schems will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

-- Create Schemas
DROP SCHEMA IF EXISTS bronze; --Drop the schema if it exists
CREATE SCHEMA bronze;

DROP SCHEMA IF EXISTS silver; --Drop the schema if it exists
CREATE SCHEMA silver;

DROP SCHEMA IF EXISTS gold; --Drop the schema if it exists
CREATE SCHEMA gold;