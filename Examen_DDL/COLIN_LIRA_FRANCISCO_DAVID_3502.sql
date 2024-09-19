/*
 * Francisco David Colin Lira
 * Grupo: 3502
 * Ingenieria en Sistemas Computacionales
 * 
 */

CREATE DATABASE examen_DDL;

USE examen_DDL;


CREATE TABLE Clientes(
	Id_Cliente INT AUTO_INCREMENT,
	Nombre_Cliente VARCHAR(100) NOT NULL,
	Apellido1_Cliente VARCHAR(100) NOT NULL,
	Apellido2_Cliente VARCHAR(100),
	Email_Cliente VARCHAR(100) NOT NULL UNIQUE,
	
	PRIMARY KEY (Id_Cliente)
);


CREATE TABLE Pedidos(
	Id_Pedido INT AUTO_INCREMENT,
	Id_Cliente INT,
	Fecha_Pedido DATE NOT NULL,
	
	PRIMARY KEY (Id_Pedido),
	FOREIGN KEY (Id_Cliente) REFERENCES Clientes(Id_Cliente)
);


DESCRIBE Clientes;

ALTER TABLE Clientes ADD Telefono_Cliente INT NOT NULL;

DESCRIBE Clientes;

ALTER TABLE Clientes DROP Email_Cliente;

DESCRIBE Clientes;

SHOW TABLES;

DROP TABLE Pedidos;

SHOW TABLES;





