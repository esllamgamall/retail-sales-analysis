-- =====================================================================
-- Retail Sales Analysis Project
-- Phase 6: Advanced SQL
-- Objective: Demonstrate practical advanced SQL techniques for
-- business analysis and data analyst reporting.
-- =====================================================================
-- Step 1: Select the database
-- Purpose: Select the Retail Sales Analysis database for the project.
-- =====================================================================

USE retail_sales_analysis;

-- =====================================================================
-- SECTION 1: CTE - MONTHLY REVENUE ANALYSIS
-- Purpose: Use a Common Table Expression (CTE) to calculate monthly
-- revenue and identify the month with the highest revenue.
-- =====================================================================

WITH monthly_revenue AS
(
SELECT month_number, month,
SUM(total_amount) AS monthly_revenue
FROM retail_sales
GROUP BY
month_number,
month
)
SELECT month_number, month, monthly_revenue
FROM monthly_revenue
ORDER BY monthly_revenue DESC
LIMIT 1;

-- =====================================================================
-- SECTION 2: PRODUCT CATEGORY RANKING
-- Purpose: Rank product categories based on total revenue using
-- the RANK window function.
-- =====================================================================

WITH category_revenue AS
(
SELECT product_category,
SUM(total_amount) AS total_revenue
FROM retail_sales
GROUP BY product_category
)

SELECT product_category, total_revenue,
DENSE_RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM category_revenue
ORDER BY revenue_rank;

-- =====================================================================
-- SECTION 3: CUSTOMER RANKING
-- Purpose: Use a CTE and window function to rank customers based
-- on their total spending.
-- =====================================================================

WITH customer_spending AS
(
SELECT customer_id, 
SUM(total_amount) AS total_spending
FROM retail_sales
GROUP BY customer_id
)

SELECT customer_id, total_spending,
DENSE_RANK() OVER (ORDER BY total_spending DESC) AS spending_rank
FROM customer_spending
ORDER BY spending_rank;

-- =====================================================================
-- SECTION 4: RUNNING TOTAL
-- Purpose: Calculate cumulative monthly revenue using a window
-- function and display the months in chronological order.
-- =====================================================================

WITH monthly_revenue AS
(
SELECT month_number, month,
SUM(total_amount) AS monthly_revenue
FROM retail_sales
GROUP BY month_number, month
)

SELECT month_number, month, monthly_revenue,
SUM(monthly_revenue) OVER (ORDER BY month_number) AS cumulative_revenue
FROM monthly_revenue
ORDER BY month_number;

-- =====================================================================
-- SECTION 5: REVENUE CONTRIBUTION
-- Purpose: Calculate the percentage contribution of each product
-- category to total company revenue.
-- =====================================================================

WITH category_revenue AS
(
SELECT product_category,
SUM(total_amount) AS total_revenue
FROM retail_sales
GROUP BY product_category
)

SELECT product_category, total_revenue,
ROUND(total_revenue * 100.0 /SUM(total_revenue) OVER (),2) AS revenue_percentage
FROM category_revenue
ORDER BY revenue_percentage DESC;

-- =====================================================================
-- SECTION 6: MONTHLY PERFORMANCE COMPARISON
-- Purpose: Compare each month's revenue with the previous month
-- using the LAG window function.
-- =====================================================================

WITH monthly_revenue AS
(
SELECT month_number, month,
SUM(total_amount) AS monthly_revenue
FROM retail_sales
GROUP BY month_number, month
)

SELECT month_number, month, monthly_revenue,
LAG(monthly_revenue) OVER (ORDER BY month_number) AS previous_month_revenue,
monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY month_number) AS revenue_difference
FROM monthly_revenue
ORDER BY month_number;

-- =====================================================================
-- SECTION 7: TOP 5 CUSTOMER ANALYSIS
-- Purpose: Use a CTE and RANK window function to identify the
-- top 5 customers based on total spending.
-- =====================================================================

WITH customer_spending AS
(
SELECT customer_id,
SUM(total_amount) AS total_spending
FROM retail_sales
GROUP BY customer_id
),

ranked_customers AS
(
SELECT customer_id, total_spending,
DENSE_RANK() OVER (ORDER BY total_spending DESC) AS spending_rank
FROM customer_spending
)

SELECT customer_id, total_spending, spending_rank
FROM ranked_customers
WHERE spending_rank <= 5
ORDER BY spending_rank;

-- =====================================================================
-- ADVANCED SQL SUMMARY
-- =====================================================================
-- -- 1.) Used CTEs to simplify monthly revenue and customer analysis.
-- -- 2.) Used window functions to rank product categories and customers.
-- -- 3.) Calculated cumulative monthly revenue using SUM OVER.
-- -- 4.) Calculated product category revenue contribution as a percentage.
-- -- 5.) Compared monthly revenue with the previous month using LAG.
-- -- 6.) Identified the top customers using CTEs and ranking functions.
-- =====================================================================