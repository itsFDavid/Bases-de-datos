# Vistas

En este arcivho utilizamos esta base de datos: [tienda](tienda.sql) para realizar las consultas y creacion de vistas

---

## Ejercicios

`Ejercicio 1`:

Crea una vista que muestre los detalles de los administradores y las tiendas que administran
incluyendo el nombre de los usuarios, nombre de la tienda y estado en el que se encuentran

```sql
CREATE VIEW details_admin AS
SELECT admin.username AS administrador, 
user.username AS usuario, store.name AS tienda, admin.status AS status_admin, store.status AS status_tienda, user.status AS status_user
FROM admin 
INNER JOIN store ON store.id_admin = admin.id_admin
INNER JOIN user ON store.id_store = user.id_store;

SELECT * FROM details_admin;
```

