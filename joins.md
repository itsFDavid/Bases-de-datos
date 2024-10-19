# JOIN

#### Creacion de una tabla usuario


```sql
CREATE DATABASE usuarios_join;
USE usuarios_join;

CREATE TABLE rol(
    id_rol INT AUTO_INCREMENT PRIAMRY KEY
    role_name VARCHAR(30) NOT NULL
);

CREATE TABLE usuarios(
    usuario_id INT AUTO_INCREMENT PRIMARY KEY,
    nickname VARCHAR(12) UNIQUE NOT NULL,
    password VARCHAR(15) NOT NULL,
    id_rol INT,

    ADD CONSTRAIN CHECK(password) >6,
    FOREIGN KEY(id_rol) REFERENCES rol(id_rol)
);


```