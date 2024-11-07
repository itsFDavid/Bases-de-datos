CREATE DATABASE examen_Francisco_David;
USE examen_Francisco_David;


CREATE TABLE tienda(
	id_tienda INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	nombre_tienda VARCHAR(20) NOT NULL,
	direccion VARCHAR(255) NOT NULL,
	telefono VARCHAR(10) NOT NULL UNIQUE CHECK(LENGTH(telefono) = 10)
);

CREATE TABLE cliente(
	id_cliente INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	nombre_cliente VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL UNIQUE,
	telefono VARCHAR(10) NOT NULL UNIQUE CHECK(LENGTH(telefono) = 10)
);


CREATE TABLE tarjeta_puntos(
	id_tarjeta INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	id_tienda INT,
	id_cliente INT,
	puntos_acumulados DOUBLE(10,2) NOT NULL,
	fecha_ultima_actualizacion DATE NOT NULL,
	
	FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
	FOREIGN KEY (id_tienda) REFERENCES tienda(id_tienda)
);

CREATE TABLE transacciones (
	id_transaccion INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	id_tarjeta INT,
	monto_compra DOUBLE(10,2) NOT NULL,
	puntos_obtenidos DOUBLE(10,2) NOT NULL,
	fecha_transaccion DATE NOT NULL,
	
	FOREIGN KEY (id_tarjeta) REFERENCES tarjeta_puntos(id_tarjeta)

);


INSERT INTO cliente(nombre_cliente, email, telefono) 
VALUES
	("Pako", "pako1@gamil.com", "1234567892"),
	("Ejemplo", "ejemplo@gmail.com", "1234567891"),
	("Ejemplo2", "ejemplo1@gmail.com", "1234567812"),
	("Ejemplo3", "ejemplo2@gmail.com", "1234567813"),
	("Ejemplo4", "ejemplo3@gmail.com", "1234567814"),
	("Ejemplo5", "ejemplo4@gmail.com", "1234567815"),
	("Ejemplo6", "ejemplo5@gmail.com", "1234567816"),
	("Ejemplo7", "ejemplo6@gmail.com", "1234567817"),
	("Ejemplo8", "ejemplo7@gmail.com", "1234567818"),
	("Ejemplo9", "ejemplo8@gmail.com", "1234567819");

INSERT INTO tienda(nombre_tienda, direccion, telefono)
VALUES 
	("Tienda1", "canalejas", "1234567892"),
	("Tienda2", "jilo", "2903882379"),
	("Tienda3", "jilo2", "1234561234"),
	("Tienda4", "jilo3", "1234561235"),
	("Tienda5", "jilo4", "1234561236");

INSERT INTO tarjeta_puntos(id_tienda, id_cliente, puntos_acumulados, fecha_ultima_actualizacion)
VALUES
	(1, 12, 2039.12, "2024-10-9"),
	(2, 11, 2032.12, "2024-10-9"),
	(3, 13, 2324.12, "2024-10-9"),
	(4, 15, 897.12, "2024-10-9"),
	(5, 14, 209.12, "2024-10-9");
-- La tabla de transacciones la llene a mano

-- Vista 1
CREATE VIEW nombres_tienda AS
SELECT 
	tienda.nombre_tienda, 
    COUNT(tarjeta_puntos.id_cliente) AS num_clientes
FROM tienda
INNER JOIN tarjeta_puntos ON tienda.id_tienda = tarjeta_puntos.id_tienda
INNER JOIN cliente ON tarjeta_puntos.id_cliente = cliente.id_cliente
GROUP BY tienda.nombre_tienda;

SELECT * FROM nombres_tienda;


-- Vista 2
CREATE VIEW clientes_transacciones_ultimos_dias AS
SELECT 
    cliente.nombre_cliente, 
    COUNT(transacciones.id_transaccion) AS num_transacciones
FROM cliente
INNER JOIN tarjeta_puntos ON cliente.id_cliente = tarjeta_puntos.id_cliente
INNER JOIN transacciones ON tarjeta_puntos.id_tarjeta = transacciones.id_tarjeta
WHERE transacciones.fecha_transaccion >= CURDATE() - INTERVAL 3 DAY
GROUP BY cliente.nombre_cliente;
   
SELECT * FROM clientes_transacciones_ultimos_dias;

-- Vista 3
CREATE VIEW clientes_monto_total_ultimo_mes AS
SELECT 
    cliente.nombre_cliente, 
    SUM(transacciones.monto_compra) AS monto_total_compras
FROM cliente
INNER JOIN tarjeta_puntos ON cliente.id_cliente = tarjeta_puntos.id_cliente
INNER JOIN transacciones ON tarjeta_puntos.id_tarjeta = transacciones.id_tarjeta
WHERE transacciones.fecha_transaccion >= CURDATE() - INTERVAL 1 MONTH
GROUP BY cliente.nombre_cliente;

SELECT * FROM clientes_monto_total_ultimo_mes;
