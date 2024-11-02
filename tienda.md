# Vistas

En este arcivho utilizamos esta base de datos: [tienda](tienda.sql) para realizar las consultas y creacion de vistas

---

## Ejercicios

`Ejercicio 1`:

Crea una vista que muestre los detalles de los administradores y las tiendas que administran incluyendo el nombre de los usuarios, nombre de la tienda y estado en el que se encuentran

```sql
CREATE VIEW details_admin AS
SELECT admin.username AS administrador, 
user.username AS usuario, store.name AS tienda, admin.status AS status_admin, store.status AS status_tienda, user.status AS status_user
FROM admin 
INNER JOIN store ON store.id_admin = admin.id_admin
INNER JOIN user ON store.id_store = user.id_store;

SELECT * FROM details_admin;
```


`Ejercicio 2`:

Crea una vista que muestre la transaccion realizadas para las tarjetas, incluye el id cliente, el nombre de la tienda, fecha de la transaccion, la cantidad de puntos obtenidos y el monto de la transaccion 


```sql
CREATE VIEW transacciones_tarjetas AS
SELECT 
    client.id_client AS id_cliente,
    store.name AS nombre_tienda,
    transaction.date AS fecha_transaccion,
    transaction.points AS puntos_obtenidos,
    transaction.amount AS monto_transaccion
FROM transaction
JOIN card_points ON transaction.id_card = card_points.id_card
JOIN client ON card_points.id_client = client.id_client
JOIN store ON card_points.id_store = store.id_store;

SELECT * FROM transacciones_tarjetas; 
```