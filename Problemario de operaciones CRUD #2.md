# Problemario de operaciones CRUD #2

## Creacion de la base de datos

```sql
CREATE DATABASE tienda_virtual;

USE tienda_virtual;

CREATE TABLE productos (
    producto_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    precio DECIMAL(10, 2),
    stock INT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE clientes (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE,
    fecha_registro DATE DEFAULT CURDATE()
);

CREATE TABLE pedidos (
    pedido_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    fecha_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10, 2),
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE detalle_pedidos (
    detalle_id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    producto_id INT,
    cantidad INT,
    precio_unitario DECIMAL(10, 2),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (producto_id) REFERENCES productos(producto_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
);


```

## Ejercicios CREATE

1. **Inserta 5 productos diferentes en la tabla `productos`.**  
   
   *Instrucción:* Los productos deben incluir un nombre, categoría, precio y stock inicial.
   ```sql
   INSERT productos (nombre, categoria, precio, stock) 
   VALUES 
      ("Gansito", "Panecillo", 20.0, 10),
      ("Pingüinos", "Panecillo", 25.0, 20),
      ("Doritos Dinamita", "Frituras", 18.0, 40),
      ("Sabritas Naturales", "Frituras", 18.0, 20),
      ("Takis", "Frituras", 20.0, 20);
   ```

2. **Registra 3 clientes en la tabla `clientes`.**  
   
   *Instrucción:* Ingresa datos de nombre y correo para cada cliente. Asegúrate de que los correos sean únicos.
   ```sql
   INSERT INTO clientes (nombre, correo)VALUES
      ("Francisco", "ejemplo1@gmail.com"),
      ("Jose", "ejemplo2@gmail.com"),
      ("Antonio", "ejemplo3@gmail.com");
   ```

3. **Inserta 2 pedidos hechos por diferentes clientes.**  
   
   *Instrucción:* Cada pedido debe tener al menos 2 productos, especifica la cantidad y el precio unitario de cada uno.
   ```sql
   -- entidad fuerte, pedido
   INSERT INTO pedidos (cliente_id, total) VALUES 
      (1, 65.0),
      (2, 36.0);
   -- entidad debil, detalle_pedidos depende de pedidos
   INSERT INTO detalle_pedidos (pedido_id, producto_id, cantidad, precio_unitario) VALUES 
      (1, 1, 2, 20.0),
      (1, 2, 1, 25.0),
      (2, 3, 2, 18.0);
   ```

## Ejercicios READ

1. **Obtén una lista de todos los productos que tienen un stock mayor a 10 unidades.**  
   
   *Instrucción:* Muestra el `producto_id`, `nombre`, `precio` y `stock`.
   ```sql
   SELECT producto_id, nombre, precio, stock FROM productos WHERE stock > 10;
   ```

2. **Encuentra los pedidos realizados por un cliente en particular.** 
   
   *Instrucción:* Muestra el `nombre` del cliente, `pedido_id`, `fecha_pedido` y el `total`.
   ```sql
   SELECT clientes.nombre, pedidos.pedido_id, pedidos.fecha_pedido, pedidos.total
   FROM pedidos
   JOIN clientes ON pedidos.cliente_id = clientes.cliente_id
   WHERE clientes.nombre = 'Francisco';
   ```
3. **Muestra el total de ventas por cada producto.**  
   
   *Instrucción:* Agrupa por `producto_id` y muestra el `nombre` del producto y la cantidad total vendida en todos los pedidos.
   ```sql
   -- aqui especifio de que tabla voy a sacar los datos, ya que se usan varias
   SELECT productos.nombre, SUM(detalle_pedidos.cantidad) AS total_vendido
   FROM detalle_pedidos
   JOIN productos ON detalle_pedidos.producto_id = productos.producto_id
   GROUP BY productos.producto_id;
   ```
## Ejercicios UPDATE

1. **Actualiza el precio de todos los productos de una categoria aumentando un 15%.**  
   
   *Instrucción:* Usa la columna `categoria` para filtrar los productos.
   ```sql
   -- use el 1.15 ya que asi me devuelve el valor y no el porcentaje a sumar
   UPDATE productos SET precio = precio * 1.15 WHERE categoria = 'Panecillo';
   ```
2. **Modifica el correo de uno de los clientes por un nuevo correo electrónico.**
   
   *Instrucción:* Asegúrate de que el nuevo correo sea único.
   ```sql
   -- este correo no existe
   UPDATE clientes SET correo = 'nuevo_correo@gmail.com' WHERE cliente_id = 1;
   ```
3. **Corrige el stock de un producto cuyo stock actual es incorrecto.** 
   
   *Instrucción:* Busca el producto por su `producto_id` y actualiza el campo `stock`.
   ```sql
   UPDATE productos SET stock=30 WHERE producto_id=1;
   ```

## Ejercicos DELETE

1. **Elimina todos los productos de la tabla `productos` que no tienen stock disponible.** 
   
   *Instrucción:* Debes usar la columna `stock` para identificar productos con stock igual a 0.
   ```sql
   DELETE FROM productos WHERE stock = 0;
   ```

2. **Borra un pedido que fue cancelado por el cliente.** 
   
   *Instrucción:* Elimina el pedido junto con todos los registros relacionados en la tabla `detalle_pedidos`.
   ```sql
   -- ya que la entidad de detalles es debil por que depende de
   -- la entidad productos esta la debemos eliminar primero, si no, no se podria
   DELETE FROM detalle_pedidos WHERE pedido_id = 1;

   -- ahora si seguimos con la de prodcutos
   DELETE FROM pedidos WHERE pedido_id = 1;
   ```

3. **Elimina un cliente que ha solicitado la eliminación de su cuenta.**
   
   *Instrucción:* Asegúrate de borrar primero los registros relacionados en la tabla `pedidos` y luego el cliente de la tabla `clientes`.
   ```sql
   -- Primero eliminamos los detalles de los pedidos del cliente por la entidad debil
   DELETE FROM detalle_pedidos WHERE pedido_id IN (SELECT pedido_id FROM pedidos WHERE cliente_id = 1);
   
   -- Luego eliminamos los pedidos del cliente, esta es entidad fuerte de detalles pedidos
   -- pero entidad debil de cliente
   DELETE FROM pedidos WHERE cliente_id = 1;
   
   -- ahora si eliminamos al cliente
   DELETE FROM clientes WHERE cliente_id = 1; 
   ```




