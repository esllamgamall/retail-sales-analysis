-- =====================================================================
-- Retail Sales Analysis Project
-- Phase 3: SQL Business Analysis
-- Objective: Answer meaningful business questions using SQL.
-- =====================================================================
-- Step 1: Select the database
-- Purpose: Select the database containing the retail_sales table.
-- =====================================================================

USE retail_sales_analysis;

-- =====================================================================
-- SECTION 1: OVERALL BUSINESS PERFORMANCE
-- =====================================================================
-- Question 1: What is the total revenue?
-- Purpose: Measure the total revenue generated across all transactions.
-- =====================================================================

SELECT SUM(total_amount) AS total_revenue
FROM retail_sales;

-- =====================================================================
-- Question 2: What is the total number of orders/transactions?
-- Purpose: Measure the total number of transactions recorded.
-- =====================================================================

SELECT COUNT(transaction_id) AS total_transactions
FROM retail_sales;
 
-- =====================================================================
-- Question 3: What is the total quantity sold?
-- Purpose: Measure the total number of products sold across all
-- transactions.
-- =====================================================================

SELECT SUM(quantity) AS total_quantity_sold
FROM retail_sales;

-- =====================================================================
-- Question 4: How many unique customers are there?
-- Purpose: Measure the total number of distinct customers.
-- =====================================================================

SELECT COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales;

-- =====================================================================
-- Question 5: What is the average order value?
-- Purpose: Calculate the average revenue generated per transaction.
-- =====================================================================

SELECT AVG(total_amount) AS average_order_value
FROM retail_sales;

-- =====================================================================
-- Question 6: What is the average quantity per transaction?
-- Purpose: Measure the average number of products purchased per
-- transaction.
-- =====================================================================

SELECT AVG(quantity) AS average_quantity_per_transaction
FROM retail_sales;

-- =====================================================================
-- SECTION 2: SALES BY PRODUCT CATEGORY
-- =====================================================================
-- Question 1: Which product category generates the most revenue?
-- Purpose: Identify the highest-revenue product categories.
-- =====================================================================

SELECT product_category,
SUM(total_amount) AS total_revenue
FROM retail_sales
GROUP BY product_category
ORDER BY total_revenue DESC;

-- ====================================================================
-- Question 2: Which product category has the highest quantity sold?
-- Purpose: Identify which product category sells the highest number
-- of units.
-- ====================================================================

SELECT product_category,
SUM(quantity) AS total_quantity_sold
FROM retail_sales
GROUP BY product_category
ORDER BY total_quantity_sold DESC;

-- ===================================================================
-- Question 3: How many transactions are there in each category?
-- Purpose: Measure transaction volume by product category.
-- ===================================================================

SELECT product_category,
COUNT(transaction_id) AS total_transactions
FROM retail_sales
GROUP BY product_category
ORDER BY total_transactions DESC;

-- ===================================================================
-- Question 4: What is the average order value for each category?
-- Purpose: Compare the average transaction value across product
-- categories.
-- ---------------------------------------------------------------------

SELECT product_category,
AVG(total_amount) AS average_order_value
FROM retail_sales
GROUP BY product_category
ORDER BY average_order_value DESC;

-- =====================================================================
-- SECTION 3: MONTHLY SALES PERFORMANCE
-- =====================================================================
-- Question 1: What is the total revenue for each month?
-- Purpose: Analyze monthly revenue performance and identify sales trends.
-- month_number is used to display months in chronological order.
-- =====================================================================

SELECT month_number, month,
SUM(total_amount) AS total_revenue
FROM retail_sales
GROUP BY month_number, month
ORDER BY month_number;

-- ====================================================================
-- Question 2: How many transactions occur each month?
-- Purpose: Measure monthly transaction volume.
-- ====================================================================

SELECT month_number, month,
COUNT(transaction_id) AS total_transactions
FROM retail_sales
GROUP BY month_number, month
ORDER BY month_number;

-- ====================================================================
-- Question 3: Which month generated the highest revenue?
-- Purpose: Identify the strongest-performing month by revenue.
-- ====================================================================

SELECT month_number, month,
SUM(total_amount) AS total_revenue
FROM retail_sales
GROUP BY month_number, month
ORDER BY total_revenue DESC
LIMIT 1;

-- ====================================================================
-- Question 4: Which month generated the lowest revenue?
-- Purpose: Identify the weakest-performing month by revenue.
-- ====================================================================

SELECT month_number, month,
SUM(total_amount) AS total_revenue
FROM retail_sales
GROUP BY month_number, month
ORDER BY total_revenue ASC
LIMIT 1;

-- =====================================================================
-- SECTION 4: QUARTERLY PERFORMANCE
-- =====================================================================
-- Question 1: What is the total revenue by quarter?
-- Purpose: Compare revenue performance across quarters.
-- =====================================================================

SELECT quarter,
SUM(total_amount) AS total_revenue
FROM retail_sales
GROUP BY quarter
ORDER BY quarter;

-- =====================================================================
-- Question 2: What is the total quantity sold by quarter?
-- Purpose: Measure product volume across each quarter.
-- =====================================================================

SELECT quarter,
SUM(quantity) AS total_quantity_sold
FROM retail_sales
GROUP BY quarter
ORDER BY quarter;

-- ====================================================================
-- Question 3: Which quarter generated the highest revenue?
-- Purpose: Identify the strongest-performing quarter by revenue.
-- ====================================================================

SELECT quarter,
SUM(total_amount) AS total_revenue
FROM retail_sales
GROUP BY quarter
ORDER BY total_revenue DESC
LIMIT 1;

-- =====================================================================
-- SECTION 5: GENDER ANALYSIS
-- =====================================================================
-- Question 1: What is the total revenue by gender?
-- Purpose: Compare revenue contribution across customer genders.
-- =====================================================================

SELECT gender,
SUM(total_amount) AS total_revenue
FROM retail_sales
GROUP BY gender
ORDER BY total_revenue DESC;

-- =====================================================================
-- Question 2: What is the number of transactions by gender?
-- Purpose: Compare transaction volume across customer genders.
-- =====================================================================

SELECT gender,
COUNT(transaction_id) AS total_transactions
FROM retail_sales
GROUP BY gender
ORDER BY total_transactions DESC;

-- ====================================================================
-- Question 3: What is the average order value by gender?
-- Purpose: Compare average transaction value across customer genders.
-- ====================================================================

SELECT gender,
AVG(total_amount) AS average_order_value
FROM retail_sales
GROUP BY gender
ORDER BY average_order_value DESC;

-- ====================================================================
-- Question 4: What is the quantity sold by gender?
-- Purpose: Compare total product quantity purchased across genders.
-- ====================================================================

SELECT gender,
SUM(quantity) AS total_quantity_sold
FROM retail_sales
GROUP BY gender
ORDER BY total_quantity_sold DESC;

-- =====================================================================
-- SECTION 6: AGE GROUP ANALYSIS
-- =====================================================================
-- Question 1: What is the total revenue by age group?
-- Purpose: Identify which customer age groups generate the most revenue.
-- =====================================================================

SELECT age_group,
SUM(total_amount) AS total_revenue
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

-- ====================================================================
-- Question 2: How many transactions came from each age group?
-- Purpose: Measure transaction volume across customer age groups.
-- ====================================================================

SELECT age_group,
COUNT(transaction_id) AS total_transactions
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

-- ====================================================================
-- Question 3: Which age group generates the highest revenue?
-- Purpose: Identify the highest-value customer age group.
-- ====================================================================

SELECT age_group,
SUM(total_amount) AS total_revenue
FROM retail_sales
GROUP BY age_group
ORDER BY total_revenue DESC
LIMIT 1;

-- ====================================================================
-- Question 4: What is the average order value by age group?
-- Purpose: Compare average spending per transaction across age groups.
-- ====================================================================

SELECT age_group,
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
-- SECTION 7: CUSTOMER ANALYSIS
-- =====================================================================
-- Question 1: Who are the top 10 customers by total spending?
-- Purpose: Identify the highest-value customers based on total spending.
-- =====================================================================

SELECT customer_id,
SUM(total_amount) AS total_spending
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spending DESC
LIMIT 10;

-- =====================================================================
-- Question 2: How many transactions has each top customer made?
-- Purpose: Identify transaction frequency among the top 10 customers.
-- =====================================================================

SELECT customer_id,
COUNT(transaction_id) AS total_transactions,
SUM(total_amount) AS total_spending
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spending DESC
LIMIT 10;

-- ======================================================================
-- Question 3: What is the average spending per customer?
-- Purpose: Calculate the average total spending across unique customers.
-- ======================================================================

SELECT AVG(customer_total_spending) AS average_spending_per_customer
FROM
(SELECT customer_id,
SUM(total_amount) AS customer_total_spending
FROM retail_sales
GROUP BY customer_id
) AS customer_spending;

-- =====================================================================
-- SECTION 8: ORDER VALUE ANALYSIS
-- =====================================================================
-- Question 1: How many transactions fall into each order value group?
-- Purpose: Measure transaction volume across order value categories.
-- =====================================================================

SELECT order_value_group,
COUNT(transaction_id) AS total_transactions
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

-- ======================================================================
-- Question 2: What percentage of transactions belong to each
-- order value group?
-- Purpose: Measure the share of total transactions represented by
-- each order value group.
-- ======================================================================

SELECT order_value_group,
COUNT(transaction_id) AS total_transactions,
ROUND(
COUNT(transaction_id) * 100.0 /
(SELECT COUNT(*) FROM retail_sales),2)
AS transaction_percentage
FROM retail_sales
GROUP BY order_value_group
ORDER BY transaction_percentage DESC;

-- ======================================================================
-- Question 3: Which order value group contributes the most revenue?
-- Purpose: Identify the order value group generating the highest
-- total revenue.
-- ======================================================================

SELECT order_value_group,
SUM(total_amount) AS total_revenue
FROM retail_sales
GROUP BY order_value_group
ORDER BY total_revenue DESC
LIMIT 1;

-- =====================================================================
-- SECTION 9: TOP PERFORMING TRANSACTIONS
-- =====================================================================
-- Question 1: What are the top 10 transactions by total amount?
-- Purpose: Identify the highest-value individual transactions.
-- =====================================================================

SELECT transaction_id, transaction_date, customer_id,
product_category, quantity, total_amount
FROM retail_sales
ORDER BY total_amount DESC
LIMIT 10;

-- =====================================================================
-- Question 2: What are the top 10 transactions by quantity?
-- Purpose: Identify transactions containing the highest number of units.
-- =====================================================================

SELECT transaction_id, transaction_date, customer_id,
product_category, quantity, total_amount
FROM retail_sales
ORDER BY quantity DESC
LIMIT 10;

-- =======================================================================
-- RETAIL SALES ANALYSIS SUMMARY
-- =======================================================================
-- 1.) Analyzed overall sales performance, revenue, transactions, and quantity sold.
-- 2.) Evaluated sales performance across product categories.
-- 3.) Analyzed monthly and quarterly sales trends.
-- 4.) Examined sales performance by gender and age group.
-- 5.) Identified top customers based on total spending and transaction activity.
-- 6.) Analyzed order value groups and transaction distribution.
-- 7.) Identified top-performing transactions based on revenue and quantity.
-- ========================================================================