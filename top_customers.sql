-- Query: Top 5 Customers by Revenue (in Top Cities from Top Countries)
-- Purpose: Identify the most valuable individual customers located in the
-- largest Rockbuster markets (top countries → top cities).
-- Business Insight: This helps Rockbuster understand not only which regions 
-- matter most, but also who its highest-value customers are in those markets. 
-- Insights like this can guide loyalty programs and targeted outreach.

WITH top_countries AS (
    SELECT 
        co.country,
        COUNT(c.customer_id) AS customer_count
    FROM customer c
    JOIN address a ON c.address_id = a.address_id
    JOIN city ci ON a.city_id = ci.city_id
    JOIN country co ON ci.country_id = co.country_id
    GROUP BY co.country
    ORDER BY customer_count DESC
    LIMIT 10
),
top_cities AS (
    SELECT 
        ci.city,
        COUNT(c.customer_id) AS customer_count
    FROM customer c
    JOIN address a ON c.address_id = a.address_id
    JOIN city ci ON a.city_id = ci.city_id
    JOIN country co ON ci.country_id = co.country_id
    WHERE co.country IN (SELECT country FROM top_countries)
    GROUP BY ci.city
    ORDER BY customer_count DESC
    LIMIT 10
)
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    co.country,
    ci.city,
    SUM(p.amount) AS total_amount_paid
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE ci.city IN (SELECT city FROM top_cities)
GROUP BY c.customer_id, c.first_name, c.last_name, co.country, ci.city
ORDER BY total_amount_paid DESC
LIMIT 5;
