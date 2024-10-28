# Consultas en la Base de Datos Sakila

Aquí se encuentra el [archivo SQL de Sakila](sakila.sql) en el cual se realizaron las consultas.

---

### Consulta de Prueba

```sql
SELECT * FROM actor WHERE LENGTH(first_name) > (SELECT AVG(LENGTH(first_name)) FROM actor);
```

---

### Consulta 2: Actores en Películas de Comedia

**Encuentra los actores que han participado en películas de la categoría `Comedy`.**

```sql
-- Encuentra la categoría 'Comedy'
SELECT * FROM category WHERE name = "Comedy";

-- Encuentra los films de la categoría 'Comedy'
SELECT * FROM film_category WHERE category_id = 5;

-- Encuentra los IDs de películas en la categoría 'Comedy'
SELECT film_id FROM film_category WHERE category_id = (SELECT category_id FROM category WHERE name = "Comedy");

-- Encuentra los actores en películas de la categoría 'Comedy'
SELECT actor_id FROM film_actor WHERE film_id IN (SELECT film_id FROM film_category WHERE category_id = (SELECT category_id FROM category WHERE name = "Comedy"));

-- Muestra nombres de los actores en películas de comedia
SELECT first_name, last_name FROM actor WHERE actor_id IN (SELECT actor_id FROM film_actor WHERE film_id IN (SELECT film_id FROM film_category WHERE category_id = (SELECT category_id FROM category WHERE name = "Comedy")));
```

**Nota:**  
- `IN`: Está dentro de la lista (TRUE).
- `NOT IN`: No está dentro de la lista (TRUE).

### Consulta 3: Clientes Sin Alquileres Recientes

**Encuentra a los clientes que no han realizado ningún alquiler en los últimos 30 días.**

```sql
SELECT customer_id FROM rental WHERE DATEDIFF(NOW(), rental_date) > 30; 

SELECT first_name, last_name FROM customer WHERE customer_id IN (SELECT customer_id FROM rental WHERE DATEDIFF(NOW(), rental_date) > 30);
```

### Consulta 4: Actores y Películas

**Muestra los nombres de los actores y los títulos de las películas en las que han participado.**

```sql
SELECT actor.first_name, actor.last_name, film.title
FROM actor
JOIN film_actor ON actor.actor_id = film_actor.actor_id
JOIN film ON film_actor.film_id = film.film_id;
```

### Consulta 5: Renta de Películas

**Ver las veces que se rentó una película.**

```sql
SELECT f.title, COUNT(r.rental_id) AS rental_count FROM film AS f
LEFT JOIN inventory AS i ON f.film_id = i.film_id
LEFT JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY f.title;
```

### Operaciones de Unión

**Unión**

```sql
SELECT first_name FROM actor UNION SELECT first_name FROM customer;
```

**Unión Todo**

```sql
SELECT first_name FROM actor UNION ALL SELECT first_name FROM customer;
```

**Intersección**

```sql
SELECT first_name FROM actor INTERSECT SELECT first_name FROM customer;
```

**Excepción**

```sql
SELECT first_name FROM actor EXCEPT SELECT first_name FROM customer;
```

### Tarea

**Devuelve las ciudades donde viven los clientes o empleados sin duplicados.**

```sql
-- Devuelve las ciudades de los clientes
SELECT DISTINCT city FROM city 
INNER JOIN address ON city.city_id = address.city_id
INNER JOIN customer ON address.address_id = customer.address_id;

-- Devuelve las ciudades de los empleados o staff
SELECT DISTINCT city FROM city 
INNER JOIN address ON city.city_id = address.city_id
INNER JOIN staff ON address.address_id = staff.address_id;
```