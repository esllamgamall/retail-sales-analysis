-- =====================================================================
-- Retail Sales Analysis Project
-- Phase 5: SQL Stored Procedures
-- Objective: Create reusable MySQL stored procedures for business
-- analysis and reporting.
-- =====================================================================
-- Step 1: Select the database
-- Purpose: Select the Retail Sales Analysis database for the project.
-- =====================================================================

USE retail_sales_analysis;

-- =====================================================================
-- Step 2: Create Overall Sales Summary Procedure
-- Purpose: Create a reusable procedure that returns key overall
-- sales performance metrics.
-- =====================================================================

DELIMITER $$
CREATE PROCEDURE sp_sales_summary()
BEGIN
    SELECT
	SUM(total_amount) AS total_revenue,
	COUNT(transaction_id) AS total_transactions,
	SUM(quantity) AS total_quantity_sold,
	COUNT(DISTINCT customer_id) AS unique_customers,
	AVG(total_amount) AS average_order_value
    FROM retail_sales;
END $$
DELIMITER ;

-- =====================================================================
-- Step 3: Create Sales by Category Procedure
-- Purpose: Create a reusable procedure to analyze sales performance
-- across product categories.
-- =====================================================================

DELIMITER $$
CREATE PROCEDURE sp_sales_by_category()
BEGIN
    SELECT
	product_category,
	SUM(total_amount) AS total_revenue,
	SUM(quantity) AS total_quantity_sold,
	COUNT(transaction_id) AS total_transactions,
	AVG(total_amount) AS average_order_value
    FROM retail_sales
    GROUP BY product_category
    ORDER BY total_revenue DESC;
END $$
DELIMITER ;

-- =====================================================================
-- Step 4: Create Sales by Date Range Procedure
-- Purpose: Create a reusable procedure to analyze sales performance
-- for a specified transaction date range.
-- =====================================================================

DELIMITER $$
CREATE PROCEDURE sp_sales_by_date_range(IN p_start_date DATE, IN p_end_date DATE)
BEGIN
    SELECT
	SUM(total_amount) AS total_revenue,
	COUNT(transaction_id) AS total_transactions,
	SUM(quantity) AS total_quantity_sold,
	COUNT(DISTINCT customer_id) AS unique_customers,
	AVG(total_amount) AS average_order_value
    FROM retail_sales
    WHERE transaction_date BETWEEN p_start_date AND p_end_date;
END $$
DELIMITER ;

-- =====================================================================
-- EXECUTE STORED PROCEDURES
-- Purpose: Execute each stored procedure to verify it works correctly.
-- =====================================================================

CALL sp_sales_summary();
CALL sp_sales_by_category();
CALL sp_sales_by_date_range('2023-01-01', '2024-01-01');

-- =====================================================================
-- FINAL VERIFICATION
-- Purpose: Verify that the stored procedures were created successfully.
-- =====================================================================

SHOW PROCEDURE STATUS
WHERE Db = 'retail_sales_analysis';

-- =====================================================================
-- STORED PROCEDURE SUMMARY
-- =====================================================================
-- Created a stored procedure to retrieve overall sales performance metrics.
-- Created a stored procedure to retrieve sales performance by product category.
-- Created a stored procedure to retrieve sales performance for a specified date range.
-- Executed and verified all stored procedures successfully.
-- =====================================================================