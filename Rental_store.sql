
-- //top 10 most Featured Actors//
SELECT 
    a.first_name || ' ' || a.last_name AS actor_name,
    COUNT(fa.film_id) AS total_films
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY actor_name
ORDER BY total_films DESC
LIMIT 10;


-- Film sales by Category
SELECT 
    c.name AS category,
    COUNT(f.film_id) AS total_films,
    SUM(p.amount) AS total_sales
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY category
ORDER BY total_sales DESC;


--Employee Salary Breakdown by Department

SELECT 
    e.department,
    COUNT(*) AS total_employees,
    ROUND(AVG(e.salary), 2) AS avg_salary,
    ROUND(MAX(e.salary), 2) AS max_salary
FROM employee e
GROUP BY e.department;

--Customer Activity Analysis

SELECT 
    c.first_name || ' ' || c.last_name AS customer_name,
    COUNT(r.rental_id) AS total_rentals,
    SUM(p.amount) AS total_spent
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 10;


--Finding the flop films

SELECT 
    f.title,
    f.release_year,
    fa.flop
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.flop = TRUE;

--CTE: Monthly Revenue

WITH MonthlyRevenue AS (
    SELECT 
        DATE_TRUNC('month', p.payment_date) AS month,
        SUM(p.amount) AS total_revenue
    FROM payment p
    GROUP BY month
)
SELECT * FROM MonthlyRevenue ORDER BY month;


 -- Film Popularity
SELECT 
    f.title,
    COUNT(r.rental_id) AS rental_count,
    RANK() OVER (ORDER BY COUNT(r.rental_id) DESC) AS rank
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rank
LIMIT 5;

