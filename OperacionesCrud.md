# Operaciones CRUD en MySQL

Las operaciones *CRUD* son un conjunto de **4 operaciones fundamentales** en el *manejo de bases de datos*. *CRUD* es un acronimo que representa las siguientes operaciones.

| Operacion | Significado |
|-----------|-------------|
| **C**reate| Crear       |
| **R**ead  | Leer        |  
| **U**pdate| Actualizar  |
| **D**elete|  Borrar     |
  



**Primero creamos una tabla:**

```sql
CREATE TABLE Usuarios(
    Id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Password VARCHAR(15) NOT NULL,

    CHECK (Email LIKE "%_@_%._%"),
    CHECK (LENGTH(Password) >=8)
);
```

## CREATE
---
La operacion crear es responsable de ***insertar nuevos datos en la base de datos***. En MySQL se realiza con la sentencia: 

`INSERT INTO` ó `INSERT`

El proposito de la operacion es añadir el nuevo registro o fila a una tabla.

```sql
-- Ejemplo de una insercion valida usando todos los caracteres
INSERT INTO Usuarios VALUES (
    1, 
    "FDavid04@icloud.com", 
    "12345678"
);

-- Ejemplo de una insercion valida usando el comando DEFAULT
INSERT INTO Usuarios VALUES(
    DEFAULT,
    "FDavid04@icloud.com", 
    "12345678"
);
-- Ejemplo de una inscercion sin incluir el Id_usuario
INSERT Usuarios (Email, Password) VALUES (
    "FDavid04@icloud.com",
    "123456789"
);
```

### Ejercicio:
Identifica los errores que pueden salir con esta tabla e inserta 4 registros nuevos en un solo insert

```sql
--Error 1
INSERT Usuarios (Email, Password) VALUES (
    "error1",
    "12345678"
);
```

## READ
---
La operacion leer es utilizada para ***consultar o recuperar datos de la base datos***. Esto no modifica los datos, simplemente los extrae. En MySQL esta operacion se realiza con la sentencia:

`SELECT`
```sql
-- Ejemplo de consulta para todos los datos de una tabla:
SELECT * FROM Usuarios;

-- Ejemplo de consulta para un registro en especifico a travez del id:
SELECT * FROM Usuarios WHERE Id_usuario = 1;

-- Ejemplo de consulta para un registro con un email en especifico:
SELECT * FROM Usuarios WHERE Email = "FDavid04@icloud.com";

-- Ejemplo de consulta con solo el campo email:
SELECT Email FROM Usuarios;

-- Ejemplo de consulta con un condicional logico:
SELECT * FROM Usuarios WHERE LENGTH(Password) > 9;

```

**Ejercicio:**

Realiza una consulta que muestre solo el Email que coincida con una contraseña de mas de 8 caracteres y otra que realize otra consulta a los Id´s pares




