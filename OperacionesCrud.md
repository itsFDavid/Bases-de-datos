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
-- contraseña menor a 8 caracteres
INSERT Usuarios (Email, Password)  VALUES (
    "FDavid04@icloud.com",
    "1234567"
);
-- Contraseña mayor a 15 caracteres
INSERT Usuarios (Email, Password)  VALUES (
    "FDavid03@icloud.com",
    "1234567891234567"
);
-- Email repetido
INSERT Usuarios (Email, Password)  VALUES (
    "FDavid04@icloud.com",
    "123456789"
);

INSERT INTO Usuarios VALUES
    (DEFAULT, "FDavid04@icloud.com", "123456789"),
    (DEFAULT, "FDavid03@icloud.com", "987654321"),
    (DEFAULT, "FDavid02@icloud.com", "135791234"),
    (DEFAULT, "FDavid01@icloud.com", "091234489")
;

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

```sql
SELECT Email FROM Usuarios WHERE LENGTH(Password) > 8;

SELECT Email FROM Usuarios WHERE MOD(Id_usuario, 2) = 0;
```

## UPDATE
---
La operacion actualizar se utiliza para ***modificar registros existentes en la base de datos***. Esto se hace con la sentencia: 

`UPDATE`

Especificamos que datos cambiar y alicamos condiciones para identificar los registros a actualizar 

```sql
-- Ejemplo para actualizar la Password de de un Usuario por su I
UPDATE Usuarios SET Password="124324532f" WHERE Id_usuario = 52;

-- Ejemplo para actualizar el Email y Password de un usuario especifico
UPDATE Usuario SET Email="prueba@gmail.com", Password="kjncdibcd" WHERE Id_usuario=52;

```

**Ejercicio:**
Intenta actualizar registros con valores que violen las restricciones

```sql
UPDATE Usuarios SET Email="ejemplo0@gmail.com" WHERE Id_usuario=1;

UPDATE Usuarios SET Email="ejemplo0.gmail.com" WHERE Id_usuario=1;

UPDATE Usuarios SET Password="123" WHERE Id_usuario=1;

UPDATE Usuarios SET Password="1234567891233482793" WHERE Id_usuario=1;

```
## DELETE
La operacion *eliminar* ***se usa para borrar registros de la base de datos***. Esto se realiza con la sentencia:

`DELETE`

Debemos ser muy cuidadosos con esta operacion, ya que una vez que los datos son eliminados no pueden ser recuperados

```sql
-- Eliminar el usuario por el Id
DELETE FROM Usuarios WHERE Id_usuario=1;

-- Eliminar los usuarios con el Email especifico
DELETE FROM Usuarios WHERE Email="ejemplo1@gmail.com";

-- Eliminar todos los registros de la tlaba ES PELIGROSO, NO RECOMENDADO
DELETE FROM Usuarios;

-- Eliminar Usuarios cuya contraseña tenga menos de 10 caracteres
DELETE FROM Usuarios WHERE LENGTH(Password) < 10;
```

**Ejercicios:**
1. Eliminar usuarios cuyo email contenga uno 5 o mas 5
2. Eliminar usuarios que tengan una contraseña que contenga letras mayusculas usando expresiones regulares
3. Eliminar usuarios con contraseñas que contengan solo numeros
4. Eliminar usuarios que no tengan el dominio "gmail"

```sql
-- 1
DELETE FROM Usuarios WHERE Email REGEXP'[5]';

-- 2
DELETE FROM Usuarios WHERE Password REGEXP´[A-Z]´;

-- 3
DELETE FROM Usuarios WHERE Password REGEXP'[0-9]';

-- 4
DELETE FROM Usuarios HERE Email NOT LIKE "%_@gmail.%_";

```
