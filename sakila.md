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

```



