-- 1) There are 121
USE sakila;
SELECT COUNT(DISTINCT last_name)
FROM actor;

-- 2) Only 1
USE sakila;
SELECT DISTINCT language_id
FROM film;

-- 3) 223
USE sakila;
SELECT COUNT(rating)
FROM film
WHERE rating = 'PG-13';

-- 4) 
USE sakila;
SELECT title, length
FROM film
WHERE release_year = 2006
ORDER BY length DESC
LIMIT 10;

-- 5) 266 days
USE sakila;
SELECT MAX(payment_date) AS TO_DATE
	, MIN(payment_date) AS FROM_DATE
    , DATEDIFF(MAX(payment_date), MIN(payment_date)) AS DURATION
FROM payment;

-- 6)
USE sakila;
SELECT *
	, month(return_date) AS MONTH_RETURNED
    , weekday(return_date) AS WEEKDAY_RETURNED
FROM rental
LIMIT 20;

-- 7)
USE sakila;
SELECT *
	, month(return_date) AS MONTH_RETURNED
    , weekday(return_date) AS WEEKDAY_RETURNED
    ,CASE WHEN weekday(return_date) > 4 THEN 'WEEKEND'
    ELSE 'WORKDAY' END AS day_type
FROM rental
LIMIT 20;

-- 8)
USE sakila;
SELECT COUNT(DISTINCT rental_id)
	, month(return_date) AS MONTH_RETURNED
    , YEAR(return_date) AS YEAR_RETURNED
FROM rental
WHERE YEAR(return_date) = (SELECT MAX(YEAR(return_date))
FROM rental)
AND month(return_date) = (SELECT MAX(month(return_date))
FROM rental);

-- 9)
USE sakila;
SELECT DISTINCT rating
FROM film;

-- 10)
USE sakila;
SELECT DISTINCT release_year
FROM film;

-- 11)
USE sakila;
SELECT title
FROM film
WHERE title LIKE '%ARMAGEDDON%';

-- 12)
USE sakila;
SELECT title
FROM film
WHERE title LIKE '%APOLLO%';

-- 13)
USE sakila;
SELECT title
FROM film
WHERE title LIKE '%APOLLO';

-- 14)
USE sakila;
SELECT title
FROM film
WHERE title REGEXP 'DATE';

-- 15)
USE sakila;
SELECT title, LENGTH(title)
FROM film
ORDER BY 2 DESC
LIMIT 10;

-- 16) 
USE sakila;
SELECT title, length
FROM film
ORDER BY length DESC
LIMIT 10;

-- 17) 
USE sakila;
SELECT title,special_features
FROM film
WHERE special_features REGEXP 'Behind the Scenes';

-- 18) 
USE sakila;
SELECT title,release_year
FROM film
ORDER BY 1, 2;

-- 19)
USE sakila;
ALTER TABLE staff 
	DROP COLUMN picture;
    
-- 20) 'Error Code: 1467. Failed to read auto-increment value from storage engine'
USE sakila;
SELECT *
FROM customer
WHERE last_name = 'SANDERS';

USE sakila;
SELECT *
FROM staff;

USE sakila;
ALTER TABLE staff AUTO_INCREMENT = 1; -- EVEN USING THIS I GOT ERROR TO AUTO INCREMENT
INSERT INTO staff (first_name, last_name, address_id, email, store_id, active, username)
SELECT first_name, last_name, address_id, email, store_id, active, first_name
FROM customer
WHERE customer_id;

-- 21)
-- customer_id=130
select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';

-- film_id=1
select film_id from sakila.film
where title = 'Academy Dinosaur';

-- staff_id=1
select staff_id from sakila.staff
where first_name = 'MIKE' and last_name = 'HILLYER';

-- inventory_id= 1 to 8
select inventory_id from sakila.inventory
where film_id = 1;

USE sakila;
SELECT *
FROM rental;

USE sakila;
INSERT INTO rental (rental_date, inventory_id, customer_id, staff_id)
VALUES (NOW(), 6, 130, 1);

-- 22)
USE sakila;
CREATE TABLE IF NOT EXISTS deleted_users
	(customer_id INT (22) NOT NULL,
    email VARCHAR(50) NOT NULL,
    deleted_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

INSERT INTO deleted_users (customer_id, email)
SELECT customer_id, email
FROM customer
WHERE active = 0;

SELECT *
FROM sakila.deleted_users;

-- GIVES ERROR TO DELETE DUE TO FOREIGN KEY CASCADE ISSUE
DELETE FROM sakila.customer
WHERE active = 0;

SELECT *
FROM sakila.customer
WHERE active = 0;