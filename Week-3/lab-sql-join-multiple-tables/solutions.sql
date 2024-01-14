USE sakila;

-- Write a query to display for each store its store ID, city, and country.
SELECT store_id, city, country 
	FROM store
		JOIN address
			ON store.address_id = address.address_id
		JOIN city
			ON address.city_id = city.city_id
		JOIN country
			ON city.country_id = country.country_id;
            
-- Write a query to display how much business, in dollars, each store brought in.
SELECT store.store_id, SUM(payment.amount) as total_amount
	FROM store
		JOIN staff
			ON store.store_id = staff.store_id
		JOIN payment
			ON staff.staff_id = payment.staff_id
		GROUP BY store.store_id;
        
-- What is the average running time of films by category?
SELECT category.name, AVG(film.rental_duration) 
	from film
		JOIN film_category
			ON film.film_id = film_category.film_id
		JOIN category
			ON film_category.category_id = category.category_id
		GROUP BY category.name;
	
-- Which film categories are longest?
SELECT category.name, SUM(film.length) as films_length
	from film
		JOIN film_category
			ON film.film_id = film_category.film_id
		JOIN category
			ON film_category.category_id = category.category_id
		GROUP BY category.name
        ORDER BY films_length DESC;
        
-- Display the most frequently rented movies in descending order.
SELECT film.title, count(rental.rental_id) as rental_times
	from film
		JOIN inventory
			ON film.film_id = inventory.film_id
		JOIN rental
			ON inventory.inventory_id = rental.inventory_id
		GROUP BY film.title
		ORDER BY rental_times DESC
        LIMIT 10;

-- List the top five genres in gross revenue in descending order.
SELECT category.name, sum(film.rental_rate) AS gross_revenue
	 from film
		JOIN film_category
			ON film.film_id = film_category.film_id
		JOIN category
			ON film_category.category_id = category.category_id
		GROUP BY category.name
        ORDER BY gross_revenue DESC
        LIMIT 5;

-- Is "Academy Dinosaur" available for rent from Store 1?

SELECT film.title, rental.rental_date, rental.return_date
	 FROM film
		JOIN inventory
			ON film.film_id = inventory.film_id
		JOIN rental
			ON inventory.inventory_id = rental.inventory_id
		WHERE film.title= "Academy Dinosaur"
			AND store_id = 1
			ORDER BY rental.rental_date DESC
            limit 1;
Footer