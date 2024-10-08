# Problemario para operaciones CRUD

## CREACION DE LA BASE DE DATOS

```sql
CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL CHECK (email LIKE '%_@_%._%'),
    telefono VARCHAR(15) CHECK (LENGTH(telefono) >= 10),
    direccion VARCHAR(255) NOT NULL
);
```

## Ejercicios CREATE

1. Inserta un cliente válido en la tabla.

2. Inserta un cliente sin especificar el campo `id_cliente`.

3. Intenta insertar un cliente con un formato de correo incorrecto (debería fallar).

4. Inserta múltiples clientes en una sola consulta.

5. Inserta un cliente con un número de teléfono de menos de 10 caracteres (debería fallar).

**RESULTADOS:**
```sql
-- 1
INSERT INTO clientes (
    id_cliente,
    nombre, email,
    telefono, direccion
)VALUES (
    DEFAULT, "Francisco",
    "FDavid@icloud.com",
    "1122334455",
    "Imaginaria"
);
-- 2
INSERT INTO clientes (
    nombre, email,
    telefono, direccion
) VALUES ("Francisco",
    "FDavid@icloud.com",
    "1122334455",
    "Imaginaria");
-- 3
INSERT INTO clientes (
    nombre, email,
    telefono, direccion
) VALUES ("Francisco",
    "FDavid@icloud",
    "1122334455",
    "Imaginaria");
-- 4
INSERT INTO clientes VALUES (
    ("Francisco", "ejemplo1@icloud.com", "1122334455", "Imaginaria"),
    ("Francisco", "ejemplo2@icloud.com", "1122334455", "Imaginaria"),
    ("Francisco", "ejemplo3@icloud.com", "1122334455", "Imaginaria"),
    ("Francisco", "ejemplo4@icloud.com", "1122334455", "Imaginaria"),
    ("Francisco", "ejemplo5@icloud.com", "1122334455", "Imaginaria")
);
-- 5
INSERT INTO clientes VALUES (
    "Francisco", "ejemplo1@icloud.com", "12345678", "Imaginaria"
);
```
## Ejercicios READ

1. Consulta todos los registros de la tabla `clientes`.

2. Consulta el `nombre` y `email` de todos los clientes.

3. Consulta los clientes cuyo número de teléfono empiece con "555".

4. Consulta los clientes cuyo nombre contenga "López".

5. Consulta los clientes ordenados por `nombre` en orden ascendente.

6. Consulta el `email` de los clientes cuyo id sea par.

7. Consulta los clientes con direcciones que contengan más de 10 caracteres.

**RESULTADOS:**
```sql
-- 1
SELECT * FROM clientes;
-- 2 
SELECT nombre, email FROM clientes;
-- 3
SELECT * FROM clientes WHERE telefono LIKE '555%';
-- 4 
SELECT * FROM clientes WHERE nombre LIKE '_López_';
-- 5
SELECT * FROM clientes ORDER BY nombre ASC;
-- 6
SELECT email FROM clientes WHERE MOD(id_cliente, 2) = 0;
-- 7
SELECT * FROM clientes WHERE LENGTH(direccion) > 10;
```

## Ejercicios UPDATE

1. Actualiza el número de teléfono de un cliente específico.

2. Cambia el `email` de un cliente con un `id_cliente` específico.

3. Intenta actualizar el correo de un cliente a un email que ya existe (debería fallar).

4. Actualiza la dirección de todos los clientes cuyos nombres contengan "López".

5. Incrementa los `id_cliente` de todos los clientes en 10 (esto es solo un ejercicio teórico).

**RESULTADOS:**
```sql
-- 1 
UPDATE clientes SET telefono="9876543210" WHERE id_cliente=1;
-- 2
UPDATE clientes SET email="ejemplo8@gmail.com" WHERE id_cliente=1;
-- 3
UPDATE clientes SET email="ejemplo8@gmail.com" WHERE id_cliente=1;
-- 4
UPDATE clientes SET direccion="Nueva imaginaria" WHERE nombre LIKE "_López_";

UPDATE clientes SET id_cliente=id_cliente+10;
```

## Ejercicios DELETE

1. Elimina un cliente específico con un `id_cliente` dado.

2. Elimina todos los clientes que tengan un número de teléfono que empiece con "555".

3. Elimina todos los clientes cuyo nombre contenga "Gómez".

4. Elimina todos los clientes con direcciones que contengan menos de 10 caracteres.

5. Elimina todos los registros de la tabla `clientes` (¡CUIDADO!).


