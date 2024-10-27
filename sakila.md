# Consultas en la base de datos sakila

Aqui se encuentra el [Archivo sql de sakila](sakila.sql) en el cual se realizaron las consultas


### Consulta de prueba

```sql
SELECT * FROM actor WHERE LENGTH (first_name) > (SELECT AVG(LENGTH(first_name)) FROM actor);
```

### Consulta 2
**Encuentra los actores que han participado en peliculas de la categoria `Comedy`**
```sql
SELECT * FROM category WHERE name = "Comedy";

SELECT * FROM film_category WHERE category_id = 5;

SELECT film_id FROM film_category WHERE category_id = (SELECT category_id FROM category WHERE name = "Comedy");

SELECT actor_id FROM film_actor WHERE film_id IN (SELECT film_id FROM film_category WHERE category_id = (SELECT category_id FROM category WHERE name = "Comedy"));

SELECT first_name, last_name FROM actor WHERE actor_id IN (SELECT actor_id FROM film_actor WHERE film_id IN (SELECT film_id FROM film_category WHERE category_id = (SELECT category_id FROM category WHERE name = "Comedy")));
```

IN: Esta dentro de la lista (TRUE)

NOT IN: No esta dentro de la lista (TRUE)

### Consulta 3
**Encuentra a los clientes que no han realizado ningun alquiler en los ultimos 30 dias**
```sql
SELECT customer_id FROM rental WHERE DATEDIFF(NOW(), rental_date) > 30; 

SELECT first_name, last_name FROM customer WHERE customer_id IN (SELECT customer_id FROM rental WHERE DATEDIFF(NOW(), rental_date) > 30);
```

### Consulta 4
**Muestra los nombres de los actores y los titulos de las peliculas en las que han participado**
```sql
SELECT actor.first_name, actor.last_name, film.title
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id;
```

### Consulta 5
**Ver las veces que se rento una pelicula**
```sql
SELECT f.title, COUNT(r.rental_id) AS rental_count FROM film AS f
LEFT JOIN  inventory AS i ON f.film_id = i.film_id
LEFT JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY f.title;
```

### Operaciones de union
**Union**
```sql
SELECT first_name FROM actor UNION SELECT first_name FROM customer;
```

**Union All**
```sql
SELECT first_name FROM actor UNION ALL SELECT first_name FROM customer;
```

**Interseccion**
```sql
SELECT first_name FROM actor INTERSECT SELECT first_name FROM customer;
```
**Excepcion**
```sql
SELECT first_name FROM actor EXCEPT SELECT first_name FROM customer;
```

### Tarea

**Devuelve las ciudades donde viven los clientes o empleados sin duplicados**
```sql
-- Devuelve las ciudades de los clientes
SELECT DISTINCT city FROM city 
INNER JOIN address ON  city.city_id = address.city_id
INNER JOIN customer ON address.address_id = customer.address_id;

-- Devuelve las ciudades de los empleados o staff
SELECT DISTINCT city FROM city 
INNER JOIN address ON  city.city_id = address.city_id
INNER JOIN staff ON address.address_id = staff.address_id;
```