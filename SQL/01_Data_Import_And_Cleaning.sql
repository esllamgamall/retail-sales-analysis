-- =====================================================================
-- Retail Sales Analysis Project
-- Phase 1: Data Import & Cleaning
-- Objective: Prepare the dataset for analysis
-- =====================================================================
-- =====================================================================
-- Step 1: Select the database
-- Purpose: Select the database containing the retail sales dataset.
-- =====================================================================

USE retail_sales_analysis;

-- =====================================================================
-- Step 2: View available tables
-- Purpose: Verify that the retail_sales_dataset table has been imported
-- successfully.
-- =====================================================================

SHOW TABLES;

-- =====================================================================
-- Step 3: Rename the table
-- Purpose: Rename the imported retail_sales_dataset table to the more
-- professional and consistent name retail_sales.
-- =====================================================================

RENAME TABLE retail_sales_dataset TO retail_sales;

-- =====================================================================
-- Step 4: Check column names and data types
-- Purpose: Review all columns and confirm their current data types
-- before cleaning.
-- =====================================================================

DESCRIBE retail_sales;

-- =====================================================================
-- Step 5: Preview the first 10 rows
-- Purpose: Display the first 10 records to verify the imported data.
-- =====================================================================

SELECT *
FROM retail_sales
LIMIT 10;

-- =====================================================================
-- Step 6: Rename columns for consistency
-- Purpose: Standardize all column names using lowercase letters and
-- underscores between words.
-- =====================================================================

ALTER TABLE retail_sales
RENAME COLUMN `Transaction ID` TO transaction_id,
RENAME COLUMN `Date` TO transaction_date,
RENAME COLUMN `Customer ID` TO customer_id,
RENAME COLUMN `Gender` TO gender,
RENAME COLUMN `Age` TO age,
RENAME COLUMN `Product Category` TO product_category,
RENAME COLUMN `Quantity` TO quantity,
RENAME COLUMN `Price per Unit` TO price_per_unit,
RENAME COLUMN `Total Amount` TO total_amount;

-- =====================================================================
-- Step 7: Verify standardized column names
-- Purpose: Confirm that all column names now follow the lowercase
-- snake_case naming convention.
-- =====================================================================

DESCRIBE retail_sales;

-- =====================================================================
-- Step 8: Check duplicate transaction IDs
-- Purpose: Identify duplicate transaction IDs that may represent
-- duplicate sales records.
-- =====================================================================

SELECT transaction_id,
COUNT(*) AS duplicate_count
FROM retail_sales
GROUP BY transaction_id
HAVING COUNT(*) > 1;

-- =====================================================================
-- Step 9: Check unique customers
-- Purpose: Verify the number of unique customers in the dataset.
-- =====================================================================

SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales;

-- =====================================================================
-- Step 10: Check NULL values
-- Purpose: Check for NULL values in the key transaction, customer,
-- and date columns.
-- =====================================================================

SELECT
COUNT(*) AS total_rows,
COUNT(transaction_id) AS transaction_ids,
COUNT(transaction_date) AS transaction_dates,
COUNT(customer_id) AS customer_ids,
COUNT(gender) AS genders,
COUNT(age) AS ages,
COUNT(product_category) AS product_categories,
COUNT(quantity) AS quantities,
COUNT(price_per_unit) AS price_per_units,
COUNT(total_amount) AS total_amounts
FROM retail_sales;

-- =====================================================================
-- Step 11: Check blank values
-- Purpose: Identify empty or whitespace-only values in text columns.
-- =====================================================================

SELECT *
FROM retail_sales
WHERE TRIM(transaction_id) = ''
OR TRIM(customer_id) = ''
OR TRIM(gender) = ''
OR TRIM(product_category) = '';

-- =====================================================================
-- Step 12: Check transaction date range
-- Purpose: Validate the earliest and latest transaction dates in the
-- dataset.
-- =====================================================================

SELECT
MIN(transaction_date) AS earliest_transaction_date,
MAX(transaction_date) AS latest_transaction_date
FROM retail_sales;

-- =====================================================================
-- Step 13: Check numeric range
-- Purpose: Review the minimum and maximum values of the main numeric
-- columns to identify unreasonable or invalid values.
-- =====================================================================

SELECT
MIN(age) AS min_age,
MAX(age) AS max_age,
MIN(quantity) AS min_quantity,
MAX(quantity) AS max_quantity,
MIN(price_per_unit) AS min_price_per_unit,
MAX(price_per_unit) AS max_price_per_unit,
MIN(total_amount) AS min_total_amount,
MAX(total_amount) AS max_total_amount
FROM retail_sales;

-- =====================================================================
-- Step 14: Review final data types
-- Purpose: Confirm that all columns have appropriate data types after
-- the cleaning and standardization process.
-- =====================================================================

DESCRIBE retail_sales;

-- =====================================================================
-- Step 15: Final dataset validation
-- Purpose: Perform final validation checks to confirm that the
-- retail_sales dataset is ready for analysis.
-- =====================================================================

-- Check total records
SELECT COUNT(*) AS total_records
FROM retail_sales;

-- Check distinct transaction IDs
SELECT COUNT(DISTINCT transaction_id) AS unique_transaction_ids
FROM retail_sales;

-- Check distinct customer IDs
SELECT COUNT(DISTINCT customer_id) AS unique_customer_ids
FROM retail_sales;

-- Preview the final cleaned dataset
SELECT *
FROM retail_sales
LIMIT 10;

-- =====================================================================
-- Cleaning Notes
-- =====================================================================

-- 1. Verified the total number of records.
-- 2. Standardized the column names using snake_case.
-- 3. Checked for duplicate transaction IDs.
-- 4. Verified the unique customer count.
-- 5. Checked for NULL and blank values.
-- 6. Validated the transaction date range.
-- 7. Checked numeric ranges and data types.
-- 8. Performed final dataset validation before analysis.


