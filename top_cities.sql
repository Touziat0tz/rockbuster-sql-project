-- Query: Top 10 Cities by Customer Count (from Top 10 Countries)
-- Purpose: First, identify the top 10 countries by customer count. 
-- Then, return the top 10 cities (within those countries) ranked by customer count.
-- Business Insight: Helps Rockbuster zoom in on the most important cities in its
-- largest markets, guiding localized strategies for marketing and expansion.

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
)
SELECT 
    ci.city,
    co.country,
    COUNT(c.customer_id) AS customer_count
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id
WHERE co.country IN (SELECT country FROM top_countries)
GROUP BY ci.city, co.country
ORDER BY customer_count DESC
LIMIT 10;

