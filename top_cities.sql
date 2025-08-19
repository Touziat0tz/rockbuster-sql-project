-- Query: Top 10 Cities by Customer Count
-- Purpose: Identify the cities with the largest number of Rockbuster customers.
-- Business Insight: Helps Rockbuster understand where its biggest urban markets are,
-- which can guide city-level marketing campaigns or local partnerships.

WITH top_cities AS (
    SELECT 
        ci.city,
        co.country,
        COUNT(c.customer_id) AS customer_count
    FROM customer c
    JOIN address a ON c.address_id = a.address_id
    JOIN city ci ON a.city_id = ci.city_id
    JOIN country co ON ci.country_id = co.country_id
    GROUP BY ci.city, co.country
    ORDER BY customer_count DESC
    LIMIT 10
)
SELECT *
FROM top_cities;
