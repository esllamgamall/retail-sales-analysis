-- =====================================================================
-- Retail Sales Analysis Project
-- Phase 2: Data Preparation
-- Objective: Create helper columns to support business analysis.
-- =====================================================================
-- =====================================================================
-- Step 1: Select the database
-- Purpose: Select the Retail Sales Analysis database for the project.
-- =====================================================================

USE retail_sales_analysis;

-- =====================================================================
-- Step 2: Review transaction amount distribution
-- Purpose: Review the distribution of total transaction amounts before
-- creating the order_value_group ranges.
-- =====================================================================

SELECT
    MIN(total_amount) AS minimum_total_amount,
    MAX(total_amount) AS maximum_total_amount,
    AVG(total_amount) AS average_total_amount
FROM retail_sales;

-- =====================================================================
-- Step 3: Create age group column
-- Purpose: Categorize customers into age groups for demographic analysis.
-- =====================================================================

ALTER TABLE retail_sales
ADD COLUMN age_group VARCHAR(20);
SET SQL_SAFE_UPDATES = 0;

-- =====================================================================
-- Step 4: Populate age group
-- Purpose: Assign each customer to an age group based on the age column.
-- =====================================================================

UPDATE retail_sales
SET age_group =
    CASE
	WHEN age BETWEEN 18 AND 25 THEN '18-25'
	WHEN age BETWEEN 26 AND 35 THEN '26-35'
	WHEN age BETWEEN 36 AND 45 THEN '36-45'
	WHEN age BETWEEN 46 AND 55 THEN '46-55'
	ELSE '56+'
    END;

-- =====================================================================
-- Step 5: Create month column
-- Purpose: Create a month column containing the month name from the
-- transaction_date column.
-- =====================================================================

ALTER TABLE retail_sales
ADD COLUMN month VARCHAR(10);

-- =====================================================================
-- Step 6: Populate month
-- Purpose: Extract the full month name from transaction_date.
-- =====================================================================

UPDATE retail_sales
SET month = MONTHNAME(transaction_date);

-- =====================================================================
-- Step 7: Create month number column
-- Purpose: Create a numeric month column so month names can be sorted
-- chronologically in SQL reports.
-- January = 1 through December = 12.
-- =====================================================================

ALTER TABLE retail_sales
ADD COLUMN month_number INT;

-- =====================================================================
-- Step 8: Populate month number
-- Purpose: Extract the numeric month from transaction_date.
-- =====================================================================

UPDATE retail_sales
SET month_number = MONTH(transaction_date);

-- =====================================================================
-- Step 9: Create quarter column
-- Purpose: Create a quarter column based on transaction_date.
-- The result will be Q1, Q2, Q3, or Q4.
-- =====================================================================

ALTER TABLE retail_sales
ADD COLUMN quarter VARCHAR(2);

-- =====================================================================
-- Step 10: Populate quarter
-- Purpose: Assign each transaction to its corresponding quarter.
-- Q1 = January–March
-- Q2 = April–June
-- Q3 = July–September
-- Q4 = October–December
-- =====================================================================

UPDATE retail_sales
SET quarter =
    CASE
	WHEN MONTH(transaction_date) BETWEEN 1 AND 3 THEN 'Q1'
	WHEN MONTH(transaction_date) BETWEEN 4 AND 6 THEN 'Q2'
	WHEN MONTH(transaction_date) BETWEEN 7 AND 9 THEN 'Q3'
	WHEN MONTH(transaction_date) BETWEEN 10 AND 12 THEN 'Q4'
    END;

-- =====================================================================
-- Step 11: Create order value group column
-- Purpose: Categorize transactions into business-friendly order value
-- ranges based on total_amount.
--
-- Order value groups:
-- Less than $100
-- $100–$149
-- $150–$499
-- $500–$999
-- $1,000+
--
-- These ranges provide useful separation between small, medium, and
-- high-value transactions while accommodating transactions up to
-- approximately $200,000.
-- =====================================================================

ALTER TABLE retail_sales
ADD COLUMN order_value_group VARCHAR(20);

-- =====================================================================
-- Step 12: Populate order value group
-- Purpose: Assign each transaction to an order value group based on
-- total_amount.
-- =====================================================================

UPDATE retail_sales
SET order_value_group =
    CASE
	WHEN total_amount < 100 THEN 'Less than $100'
	WHEN total_amount BETWEEN 100 AND 149 THEN '$100-$149'
	WHEN total_amount BETWEEN 150 AND 499 THEN '$150-$499'
	WHEN total_amount BETWEEN 500 AND 999 THEN '$500-$999'
	ELSE '$1,000+'
    END;

-- =====================================================================
-- Step 13: Verify the new helper columns
-- Purpose: Display sample records to confirm that all helper columns
-- have been populated correctly.
-- =====================================================================

SELECT transaction_id, transaction_date,
age, age_group,
total_amount, order_value_group,
month, month_number,
quarter
FROM retail_sales
LIMIT 10;

-- =====================================================================
-- Step 14: Validate age group distribution
-- Purpose: Check the number of records in each age group.
-- =====================================================================

SELECT age_group,
COUNT(*) AS record_count
FROM retail_sales
GROUP BY age_group
ORDER BY age_group;

-- =====================================================================
-- Step 15: Validate month distribution
-- Purpose: Check the number of records for each month and verify that
-- the months can be sorted chronologically using month_number.
-- =====================================================================

SELECT month_number, month,
COUNT(*) AS record_count
FROM retail_sales
GROUP BY month_number, month
ORDER BY month_number;

-- =====================================================================
-- Step 16: Validate quarter distribution
-- Purpose: Check the number of records in each quarter.
-- =====================================================================

SELECT quarter,
COUNT(*) AS record_count
FROM retail_sales
GROUP BY quarter
ORDER BY quarter;

-- =====================================================================
-- Step 17: Validate order value group distribution
-- Purpose: Check the number of records in each order value group and
-- determine whether the selected ranges provide a useful distribution.
-- =====================================================================

SELECT order_value_group,
COUNT(*) AS record_count
FROM retail_sales
GROUP BY order_value_group
ORDER BY
    CASE
	WHEN order_value_group = 'Less than $100' THEN 1
	WHEN order_value_group = '$100-$149' THEN 2
	WHEN order_value_group = '$150-$499' THEN 3
	WHEN order_value_group = '$500-$999' THEN 4
	ELSE 5
    END;

-- =====================================================================
-- Step 18: Validate helper column completeness
-- Purpose: Confirm that the newly created helper columns have been
-- populated and identify any missing values.
-- =====================================================================

SELECT
COUNT(*) AS total_records,
COUNT(age_group) AS age_group_count,
COUNT(month) AS month_count,
COUNT(month_number) AS month_number_count,
COUNT(quarter) AS quarter_count,
COUNT(order_value_group) AS order_value_group_count
FROM retail_sales;

-- =====================================================================
-- Step 19: Final table structure
-- Purpose: Review the final table structure and verify that the new
-- helper columns have been added with appropriate data types.
-- =====================================================================

DESCRIBE retail_sales;

-- =====================================================================
-- Step 20: Final record count validation
-- Purpose: Verify that the total number of records has remained
-- unchanged after adding the helper columns.
-- =====================================================================

SELECT COUNT(*) AS total_records
FROM retail_sales;

-- =====================================================================
-- Data Preparation Notes
-- =====================================================================
-- 1. Created age_group using the age column with five business-friendly
--    categories: 18-25, 26-35, 36-45, 46-55, and 56+.
-- 2. Created month using transaction_date to store full month names.
-- 3. Created month_number using transaction_date to support chronological
--    sorting of month names in SQL and Power BI.
-- 4. Created quarter using transaction_date with Q1, Q2, Q3, and Q4
--    classifications.
-- 5. Reviewed the transaction amount distribution before defining
--    order value groups.
-- 6. Created order_value_group using business-friendly transaction
--    amount ranges from less than $100 through $1,000+.
-- 7. Validated the distribution and completeness of all newly created
--    helper columns.
-- 8. Performed final table structure and record count validation.
-- The original transaction data was not modified, deleted, or replaced.
-- Phase 2 only added helper columns required for business analysis,
-- Power BI reporting, and future SQL analysis.