-- Query: Top Film Genres by Total Revenue
-- Purpose: Calculate total revenue generated for each film genre.
-- Business Insight: Identifying which genres generate the most revenue helps
-- Rockbuster prioritize content acquisition and licensing for its streaming platform.

SELECT
    ca.name AS genre,
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category ca ON fc.category_id = ca.category_id
GROUP BY ca.name
ORDER BY total_revenue DESC;
