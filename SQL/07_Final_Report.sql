-- =====================================================================
-- Retail Sales Analysis Project
-- Phase 7: Final Report
-- Objective: Create a concise, business-focused final report based on
-- the analysis completed throughout the project.
-- =====================================================================
-- Step 1: Select the database
-- Purpose: Select the Retail Sales Analysis database for the final report.
-- =====================================================================

USE retail_sales_analysis;

-- =====================================================================
-- SECTION 1: OVERALL BUSINESS PERFORMANCE
-- Purpose: Retrieve the primary business KPIs from the existing
-- retail_sales table.
-- =====================================================================

SELECT
SUM(total_amount) AS total_revenue,
COUNT(transaction_id) AS total_transactions,
SUM(quantity) AS total_quantity_sold,
COUNT(DISTINCT customer_id) AS unique_customers,
AVG(total_amount) AS average_order_value
FROM retail_sales;

-- =====================================================================
-- SECTION 2: PRODUCT CATEGORY PERFORMANCE
-- Purpose: Evaluate category-level revenue, quantity, transactions,
-- and average order value.
-- =====================================================================
-- Question 1: Which product category generated the highest revenue?
-- =====================================================================

SELECT product_category,
SUM(total_amount) AS total_revenue
FROM retail_sales
GROUP BY product_category
ORDER BY total_revenue DESC
LIMIT 1;

-- =====================================================================
-- Question 2: Which product category generated the lowest revenue?
-- =====================================================================

SELECT product_category,
SUM(total_amount) AS total_revenue
FROM retail_sales
GROUP BY product_category
ORDER BY total_revenue ASC
LIMIT 1;
-- ====================================================================
-- Question 3: Which product category has the highest quantity sold?
-- ====================================================================

SELECT product_category,
SUM(quantity) AS total_quantity_sold
FROM retail_sales
GROUP BY product_category
ORDER BY total_quantity_sold DESC
LIMIT 1;

-- =====================================================================
-- SECTION 3: CUSTOMER AND DEMOGRAPHIC INSIGHTS
-- Purpose: Analyze customer behavior across gender, age groups,
-- and individual customer spending.
-- =====================================================================
-- Question 1: What is the total revenue by gender?
-- =====================================================================

SELECT gender,
SUM(total_amount) AS total_revenue,
COUNT(transaction_id) AS total_transactions,
SUM(quantity) AS total_quantity_sold,
AVG(total_amount) AS average_order_value
FROM retail_sales
GROUP BY gender
ORDER BY total_revenue DESC;
-- =====================================================================
-- Question 2: Which age group generated the highest revenue?
-- =====================================================================

SELECT age_group,
SUM(total_amount) AS total_revenue
FROM retail_sales
GROUP BY age_group
ORDER BY total_revenue DESC
LIMIT 1;

-- =====================================================================
-- Question 3: What is the revenue performance by age group?
-- Age groups are displayed in logical age order.
-- =====================================================================

SELECT age_group,
SUM(total_amount) AS total_revenue,
COUNT(transaction_id) AS total_transactions,
AVG(total_amount) AS average_order_value
FROM retail_sales
GROUP BY age_group
ORDER BY
CASE
	WHEN age_group = '18-25' THEN 1
	WHEN age_group = '26-35' THEN 2
	WHEN age_group = '36-45' THEN 3
    WHEN age_group = '46-55' THEN 4
    ELSE 5
END;

-- =====================================================================
--  Question 4: Who are the top 10 customers by total spending?
-- =====================================================================

SELECT customer_id,
SUM(total_amount) AS total_spending,
COUNT(transaction_id) AS total_transactions
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spending DESC
LIMIT 10;

-- =====================================================================
-- SECTION 4: TIME-BASED SALES PERFORMANCE
-- Purpose: Evaluate monthly and quarterly revenue trends and identify
-- the strongest and weakest periods.
-- =====================================================================
-- Question 1: What is the monthly revenue performance?
-- Months are displayed chronologically using month_number.
-- =====================================================================

SELECT month_number, month,
SUM(total_amount) AS total_revenue,
COUNT(transaction_id) AS total_transactions,
SUM(quantity) AS total_quantity_sold
FROM retail_sales
GROUP BY month_number, month
ORDER BY month_number;

-- =====================================================================
-- Question 2: Which month generated the highest revenue?
-- =====================================================================

SELECT month_number, month,
SUM(total_amount) AS total_revenue
FROM retail_sales
GROUP BY month_number, month
ORDER BY total_revenue DESC
LIMIT 1;

-- =====================================================================
-- Question 3: Which month generated the lowest revenue?
-- =====================================================================

SELECT month_number, month,
SUM(total_amount) AS total_revenue
FROM retail_sales
GROUP BY month_number, month
ORDER BY total_revenue ASC
LIMIT 1;

-- ====================================================================
-- Question 4: What is the quarterly revenue performance?
-- ====================================================================

SELECT quarter, 
SUM(total_amount) AS total_revenue,
SUM(quantity) AS total_quantity_sold,
COUNT(transaction_id) AS total_transactions
FROM retail_sales
GROUP BY quarter
ORDER BY quarter;

-- ===================================================================
-- Question 5: Which quarter generated the highest revenue?
-- ===================================================================

SELECT quarter,
SUM(total_amount) AS total_revenue
FROM retail_sales
GROUP BY quarter
ORDER BY total_revenue DESC
LIMIT 1;

-- =====================================================================
-- SECTION 5: ORDER VALUE ANALYSIS
-- Purpose: Evaluate transaction distribution across the existing
-- order value groups and identify the most important revenue pattern.
-- =====================================================================
-- Question 1: What is the transaction distribution by order value group?
-- =====================================================================

SELECT order_value_group,
COUNT(transaction_id) AS total_transactions,
ROUND(COUNT(transaction_id) * 100.0 /(SELECT COUNT(*) FROM retail_sales),
2) AS transaction_percentage
FROM retail_sales
GROUP BY order_value_group
ORDER BY transaction_percentage DESC;

-- =====================================================================
-- Question 2: Which order value group contributes the most revenue?
-- =====================================================================

SELECT order_value_group,
SUM(total_amount) AS total_revenue,
COUNT(transaction_id) AS total_transactions
FROM retail_sales
GROUP BY order_value_group
ORDER BY total_revenue DESC
LIMIT 1;

-- ========================================================================
-- Question 3: What is the revenue contribution of each order value group?
-- ========================================================================

SELECT order_value_group,
SUM(total_amount) AS total_revenue,
ROUND(SUM(total_amount) * 100.0 /(SELECT SUM(total_amount) FROM retail_sales),
2) AS revenue_percentage
FROM retail_sales
GROUP BY order_value_group
ORDER BY revenue_percentage DESC;

-- ================================================================================
-- FINAL REPORT SUMMARY
-- ================================================================================
-- Calculated overall retail sales performance and key business KPIs.
-- Identified top-performing product categories by revenue and quantity sold.
-- Analyzed customer revenue by gender, age group, and top customers.
-- Evaluated monthly and quarterly sales performance and seasonal trends.
-- Analyzed transaction distribution and revenue contribution by order value group.
-- Identified key revenue and customer performance patterns from the analysis.
-- Summarized key retail sales metrics to support data-driven decision-making.
-- ================================================================================