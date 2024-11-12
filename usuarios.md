# Ejercicios sobre Privilegios de Usuarios en MySQL
---

## Ejercicio 1: Crear un Usuario con privilegios especificos

- **Crea un usuario llamado empleado con la contraseña empleado123**
- **Asigna al usuario empleado permisos de solo lectura `SELECT` sobre la base de datos empresa_db**
- **El usuario empleado no debe poder modificar ni eliminar datos en empresa_db**

```sql
CREATE USER "empleado"@"localhost" IDENTIFIED BY "empleado123";

GRANT SELECT ON empresa_db.* TO "empleado"@"localhost";

REVOKE UPDATE, DELETE ON empresa_db.* FROM "empleado"@"localhost";
```


## Ejercicio 2: Revocar privilegios y modificar permisos

- **El usuario empleado anteriormente tenia permisos de solo lectura sobre la base de datos de empresa_db**
- **Ahora, revoca el privilegio `SELECT` al usuario empleado y asigna el privilegio `INSERT` para que pueda agregar datos a las tablas de empresa_db**


## Ejercicio 3: Asignar privilegios globales

- **Crea un usuario llamado admin_db con la contraseña admin123**
- **Asigna al usuario admin_db privilegios globales para crear y eliminar bases de datos `CREATE` y `DROP` asi como para gestionar usuarios `CREATE USER` y `DROP USER`**

## Ejercicio 4: Ver privilegios de un usuario

- **El usuario admin_db tiene privilegios para crear y eliminar bases de datos**
- **Usando el comando adecuado, verifica los privilegios asignados al usuario admin_db en el servidor MySQL**

