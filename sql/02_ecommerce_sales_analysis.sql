-- Ecommerce Sales Analytics Portfolio Project
-- File: 02_ecommerce_sales_analysis.sql
-- SQL Server
-- Tables: project_customers, project_sales
use project-- this is database
-- ============================================================
-- 01. OVERALL SALES PERFORMANCE
-- ============================================================

SELECT
    SUM(price * quantity) AS total_revenue,
    SUM(quantity) AS total_units,
    COUNT(sale_id) AS total_sales
FROM project_sales;


-- ============================================================
-- 02. CATEGORY PERFORMANCE
-- ============================================================

SELECT
    category,
    SUM(price * quantity) AS total_revenue,
    SUM(quantity) AS total_units,
    COUNT(sale_id) AS total_sales
FROM project_sales
GROUP BY category
ORDER BY total_revenue DESC;


-- ============================================================
-- 03. CUSTOMER PERFORMANCE
-- ============================================================

SELECT
    c.customer_name,
    SUM(p.price * p.quantity) AS total_revenue,
    SUM(p.quantity) AS total_units,
    COUNT(p.sale_id) AS total_sales
FROM project_customers AS c
JOIN project_sales AS p
    ON c.customer_id = p.customer_id
GROUP BY c.customer_name
ORDER BY total_revenue DESC;


-- ============================================================
-- 04. PRODUCT PERFORMANCE
-- ============================================================

SELECT
    product,
    category,
    SUM(price * quantity) AS total_revenue,
    SUM(quantity) AS total_units,
    COUNT(sale_id) AS total_sales
FROM project_sales
GROUP BY product, category
ORDER BY total_revenue DESC;


-- ============================================================
-- 05. MONTHLY SALES PERFORMANCE
-- ============================================================

SELECT
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    SUM(price * quantity) AS total_revenue,
    SUM(quantity) AS total_units,
    COUNT(sale_id) AS total_sales
FROM project_sales
GROUP BY YEAR(sale_date), MONTH(sale_date)
ORDER BY year, month;


-- ============================================================
-- 06. CUSTOMER SEGMENTATION
-- ============================================================

SELECT
    c.customer_name,
    SUM(p.price * p.quantity) AS total_revenue,
    CASE
        WHEN SUM(p.price * p.quantity) >= 100000 THEN 'High Value'
        WHEN SUM(p.price * p.quantity) >= 50000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM project_customers AS c
JOIN project_sales AS p
    ON c.customer_id = p.customer_id
GROUP BY c.customer_name
ORDER BY total_revenue DESC;


-- ============================================================
-- 07. TOP 5 CUSTOMERS
-- ============================================================

SELECT TOP 5
    c.customer_name,
    SUM(p.price * p.quantity) AS total_revenue
FROM project_customers AS c
JOIN project_sales AS p
    ON c.customer_id = p.customer_id
GROUP BY c.customer_name
ORDER BY total_revenue DESC;


-- ============================================================
-- 08. REPEAT CUSTOMERS
-- ============================================================

SELECT
    c.customer_name,
    COUNT(p.sale_id) AS total_sales
FROM project_customers AS c
JOIN project_sales AS p
    ON c.customer_id = p.customer_id
GROUP BY c.customer_name
HAVING COUNT(p.sale_id) > 2
ORDER BY total_sales DESC;


-- ============================================================
-- 09. REVENUE BY YEAR
-- ============================================================

SELECT
    YEAR(sale_date) AS year,
    SUM(price * quantity) AS total_revenue,
    SUM(quantity) AS total_units,
    COUNT(sale_id) AS total_sales
FROM project_sales
GROUP BY YEAR(sale_date)
ORDER BY year;


-- ============================================================
-- 10. TOP 5 PRODUCTS BY REVENUE
-- ============================================================

SELECT TOP 5
    product,
    category,
    SUM(price * quantity) AS total_revenue
FROM project_sales
GROUP BY product, category
ORDER BY total_revenue DESC;


-- ============================================================
-- 11. REVENUE BY CATEGORY AND YEAR
-- ============================================================

SELECT
    YEAR(sale_date) AS year,
    category,
    SUM(price * quantity) AS total_revenue,
    SUM(quantity) AS total_units
FROM project_sales
GROUP BY YEAR(sale_date), category
ORDER BY year, total_revenue DESC;


-- ============================================================
-- 12. AVERAGE SALE VALUE
-- ============================================================

SELECT
    AVG(price * quantity) AS average_sale_value
FROM project_sales;


-- ============================================================
-- 13. CUSTOMERS ABOVE AVERAGE SPENDING
-- ============================================================

WITH customer_spending AS (
    SELECT
        c.customer_name,
        SUM(p.price * p.quantity) AS total_spent
    FROM project_customers AS c
    JOIN project_sales AS p
        ON c.customer_id = p.customer_id
    GROUP BY c.customer_name
)
SELECT
    customer_name,
    total_spent
FROM customer_spending
WHERE total_spent > (
    SELECT AVG(total_spent)
    FROM customer_spending
)
ORDER BY total_spent DESC;


-- ============================================================
-- 14. HIGHEST-SPENDING CUSTOMER
-- ============================================================

WITH customer_spending AS (
    SELECT
        c.customer_name,
        SUM(p.price * p.quantity) AS total_spent
    FROM project_customers AS c
    JOIN project_sales AS p
        ON c.customer_id = p.customer_id
    GROUP BY c.customer_name
)
SELECT
    customer_name,
    total_spent
FROM customer_spending
WHERE total_spent = (
    SELECT MAX(total_spent)
    FROM customer_spending
);


-- ============================================================
-- 15. CUSTOMER RANKING
-- ============================================================

SELECT
    c.customer_name,
    SUM(p.price * p.quantity) AS total_revenue,
    DENSE_RANK() OVER (
        ORDER BY SUM(p.price * p.quantity) DESC
    ) AS customer_rank
FROM project_customers AS c
JOIN project_sales AS p
    ON c.customer_id = p.customer_id
GROUP BY c.customer_name
ORDER BY customer_rank;


-- ============================================================
-- 16. 2026 MONTHLY REVENUE
-- ============================================================

SELECT
    MONTH(sale_date) AS month,
    SUM(price * quantity) AS total_revenue
FROM project_sales
WHERE YEAR(sale_date) = 2026
GROUP BY MONTH(sale_date)
ORDER BY month;


-- ============================================================
-- 17. CUSTOMERS WHO PURCHASED IN BOTH 2025 AND 2026
-- ============================================================

SELECT
    c.customer_name
FROM project_customers AS c
JOIN project_sales AS p
    ON c.customer_id = p.customer_id
GROUP BY c.customer_name
HAVING COUNT(DISTINCT YEAR(p.sale_date)) = 2
ORDER BY c.customer_name;


-- ============================================================
-- 18. CUSTOMER REVENUE BY CATEGORY
-- ============================================================

SELECT
    c.customer_name,
    p.category,
    SUM(p.price * p.quantity) AS total_revenue
FROM project_customers AS c
JOIN project_sales AS p
    ON c.customer_id = p.customer_id
GROUP BY
    c.customer_name,
    p.category
ORDER BY
    c.customer_name,
    total_revenue DESC;


-- ============================================================
-- 19. REVENUE BY CUSTOMER AND YEAR
-- ============================================================

SELECT
    c.customer_name,
    YEAR(p.sale_date) AS year,
    SUM(p.price * p.quantity) AS total_revenue
FROM project_customers AS c
JOIN project_sales AS p
    ON c.customer_id = p.customer_id
GROUP BY
    c.customer_name,
    YEAR(p.sale_date)
ORDER BY
    c.customer_name,
    year;


-- ============================================================
-- 20. PRODUCT PERFORMANCE BY YEAR
-- ============================================================

SELECT
    YEAR(sale_date) AS year,
    product,
    SUM(price * quantity) AS total_revenue,
    SUM(quantity) AS total_units
FROM project_sales
GROUP BY
    YEAR(sale_date),
    product
ORDER BY
    year,
    total_revenue DESC;
