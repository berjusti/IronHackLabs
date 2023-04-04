#1 Which actor has appeared in the most films?

USE sakila;
SELECT first_name, last_name, film_actor.actor_id, COUNT(*) FROM actor
JOIN film_actor 
ON film_actor.actor_id = actor.actor_id
GROUP BY actor_id
ORDER BY COUNT(*) DESC
LIMIT 1;

SELECT first_name, last_name, COUNT(actor_id) AS film_count
FROM actor 
JOIN film_actor 
USING (actor_id)
GROUP BY actor_id
ORDER BY film_count DESC
LIMIT 1;

#2 Most active customer (the customer that has rented the most number of films)
SELECT first_name, last_name, COUNT(rental_id) AS most_active FROM customer
JOIN rental USING(customer_id)
GROUP BY first_name, last_name
ORDER BY most_active DESC
LIMIT 1;

#3 List number of films per category.
SELECT name, COUNT(film_id) AS films_per_category FROM category
JOIN film_category 
USING(category_id)
GROUP BY name
ORDER BY name, films_per_category;

#4 Display the first and last names, as well as the address, of each staff member.
SELECT first_name, last_name, address FROM staff
JOIN address USING(address_id);

#5 get films titles where the film language is either English or italian, and whose titles starts with letter "M" , sorted by title descending.
SELECT title, `name` FROM film
JOIN language USING(language_id)
WHERE (name = 'Italian' OR name = 'English') AND title LIKE 'M%'
ORDER BY title DESC;

#6 Display the total amount rung up by each staff member in August of 2005.
SELECT first_name, last_name, SUM(amount) AS total FROM staff
JOIN payment 
USING(staff_id)
WHERE payment_date >= '2005-08-01 00:00:00' AND payment_date < '2005-09-01 00:00:00'
GROUP BY staff_id
ORDER BY total;

#7 List each film and the number of actors who are listed for that film.
SELECT title, COUNT(actor_id) AS actors_listed FROM film
JOIN film_actor USING(film_id)
GROUP BY title
ORDER BY actors_listed DESC;

#8 Using the tables payment and customer and the JOIN command, list the total paid by each customer.
# List the customers alphabetically by last name.
SELECT first_name, last_name, SUM(amount) AS total_paid FROM payment
JOIN customer USING(customer_id)
GROUP BY first_name, last_name
ORDER BY last_name, total_paid;

#9 Write sql statement to check if you can find any actor who never particiapted in any film.
SELECT actor_id FROM actor
JOIN film_actor USING(actor_id)
WHERE film_id IS NULL; # here not sure which one, but intuition tells me its film_id 
#not actor_id as inner join would only result in the actors that have been in the movies

#10 get the addresses that have NO customers, and ends with the letter "e"
-- SELECT address, address2 FROM customer
-- JOIN address USING(address_id)
-- WHERE address LIKE '%e' AND address2 IS NULL;

-- SELECT address FROM address
-- LEFT JOIN customer
-- ON address.address_id = customer.address_id
-- WHERE address2 IS NULL AND address LIKE "%e";


# OPTIONAL

