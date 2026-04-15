SQL Analysis

This project uses advanced SQL techniques to extract meaningful business insights.

Key Concepts Used:
Aggregations (SUM, AVG)
Joins (INNER JOIN)
Window Functions (RANK, ROW_NUMBER)
Common Table Expressions (CTEs)
Business Metrics (Revenue, AOV, Churn)

The analysis focuses on understanding revenue trends, customer behavior, and product performance.


SELECT SUM(amount) AS total_revenue
FROM orders;

SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(amount) AS revenue
FROM orders
GROUP BY month
ORDER BY month;

SELECT 
    user_id,
    SUM(amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(amount) DESC) AS rank
FROM orders
GROUP BY user_id;

WITH customer_spending AS (
    SELECT 
        user_id,
        SUM(amount) AS total_spent
    FROM orders
    GROUP BY user_id
)
SELECT 
    user_id,
    total_spent,
    CASE 
        WHEN total_spent > 2000 THEN 'High Value'
        ELSE 'Low Value'
    END AS segment
FROM customer_spending;

SELECT 
    p.category,
    SUM(o.amount) AS revenue
FROM orders o
JOIN products p 
ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;

SELECT 
    u.region,
    SUM(o.amount) AS revenue
FROM orders o
JOIN users u 
ON o.user_id = u.user_id
GROUP BY u.region
ORDER BY revenue DESC;

SELECT user_id
FROM orders
GROUP BY user_id
HAVING MAX(order_date) < '2024-02-01';

SELECT AVG(amount) AS avg_order_value
FROM orders;

SELECT 
    order_date,
    SUM(amount) OVER (ORDER BY order_date) AS running_revenue
FROM orders;
