-- =====================================================================
-- Retail Sales Analysis Project
-- Phase 4: SQL Views
-- Objective: Create reusable SQL views to simplify reporting,
-- support dashboard development, and improve query efficiency.
-- =====================================================================
-- Step 1: Select the database
-- Purpose: Select the Retail Sales Analysis database for the project.
-- =====================================================================

USE retail_sales_analysis;

-- =====================================================================
-- Step 2: Create overall sales summary view
-- Purpose: Create a reusable view containing key overall sales KPIs.
-- =====================================================================

CREATE OR REPLACE VIEW vw_sales_summary AS
SELECT
SUM(total_amount) AS total_revenue,
COUNT(transaction_id) AS total_transactions,
SUM(quantity) AS total_quantity_sold,
COUNT(DISTINCT customer_id) AS unique_customers,
AVG(total_amount) AS average_order_value
FROM retail_sales;

-- =====================================================================
-- Step 3: Create monthly revenue view
-- Purpose: Create a reusable monthly sales view for trend analysis.
-- =====================================================================

CREATE OR REPLACE VIEW vw_monthly_revenue AS
SELECT month_number, month,
SUM(total_amount) AS total_revenue,
COUNT(transaction_id) AS total_transactions,
SUM(quantity) AS total_quantity_sold
FROM retail_sales
GROUP BY
month_number,
month;

-- =====================================================================
-- Step 4: Create category performance view
-- Purpose: Create a reusable view to evaluate sales performance
-- across product categories.
-- =====================================================================

CREATE OR REPLACE VIEW vw_category_performance AS
SELECT product_category,
SUM(total_amount) AS total_revenue,
SUM(quantity) AS total_quantity_sold,
COUNT(transaction_id) AS total_transactions,
AVG(total_amount) AS average_order_value
FROM retail_sales
GROUP BY product_category;

-- =====================================================================
-- Step 5: Create customer segment view
-- Purpose: Create a reusable view to analyze customer performance
-- across age groups.
-- =====================================================================

CREATE OR REPLACE VIEW vw_customer_segment AS
SELECT age_group,
COUNT(DISTINCT customer_id) AS unique_customers,
COUNT(transaction_id) AS total_transactions,
SUM(total_amount) AS total_revenue,
AVG(total_amount) AS average_order_value
FROM retail_sales
GROUP BY age_group;

-- =====================================================================
-- Step 6: Create gender performance view
-- Purpose: Create a reusable view to compare sales and customer
-- performance across genders.
-- =====================================================================

CREATE OR REPLACE VIEW vw_gender_performance AS
SELECT gender,
COUNT(DISTINCT customer_id) AS unique_customers,
COUNT(transaction_id) AS total_transactions,
SUM(quantity) AS total_quantity_sold,
SUM(total_amount) AS total_revenue,
AVG(total_amount) AS average_order_value
FROM retail_sales
GROUP BY gender;

-- =====================================================================
-- Step 7: Verify all views
-- Purpose: Confirm that the required SQL views were created
-- successfully.
-- =====================================================================

SHOW FULL TABLES
WHERE Table_type = 'VIEW';

-- =====================================================================
-- Step 7.1: Test overall sales summary view
-- Purpose: Verify the overall sales KPI view.
-- =====================================================================

SELECT *
FROM vw_sales_summary;

-- =====================================================================
-- Step 7.2: Test monthly revenue view
-- Purpose: Verify monthly sales results and display months
-- chronologically using month_number.
-- =====================================================================

SELECT *
FROM vw_monthly_revenue
ORDER BY month_number;

-- =====================================================================
-- Step 7.3: Test category performance view
-- Purpose: Verify category performance and display categories
-- from highest to lowest revenue.
-- =====================================================================

SELECT *
FROM vw_category_performance
ORDER BY total_revenue DESC;

-- =====================================================================
-- Step 7.4: Test customer segment view
-- Purpose: Verify customer performance by age group and display
-- age groups in logical order.
-- =====================================================================

SELECT *
FROM vw_customer_segment
ORDER BY
CASE
WHEN age_group = '18-25' THEN 1
WHEN age_group = '26-35' THEN 2
WHEN age_group = '36-45' THEN 3
WHEN age_group = '46-55' THEN 4
ELSE 5
END;

-- =====================================================================
-- Step 7.5: Test gender performance view
-- Purpose: Verify sales and customer performance by gender.
-- =====================================================================

SELECT *
FROM vw_gender_performance
ORDER BY total_revenue DESC;

-- =====================================================================
-- Step 8: Verify the final view list
-- Purpose: Confirm that all required views exist and no unnecessary
-- duplicate views were created.
-- =====================================================================

SHOW FULL TABLES
WHERE Table_type = 'VIEW';

-- =====================================================================
-- SQL VIEW SUMMARY
-- =====================================================================
-- 1.) vw_sales_summary provides overall business KPIs including
-- revenue, transactions, quantity sold, unique customers, and
-- average order value.
-- 2.) vw_monthly_revenue supports monthly sales trend analysis
-- using revenue, transactions, and quantity sold.
-- 3.) vw_category_performance evaluates revenue, quantity,
-- transactions, and average order value by product category.
-- 4.) vw_customer_segment analyzes customer performance across
-- age groups using customers, transactions, revenue, and order value.
-- 5.) vw_gender_performance compares customer and sales performance
-- across genders.
-- =====================================================================