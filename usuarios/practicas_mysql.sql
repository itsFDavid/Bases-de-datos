
-- Práctica 1: Creación de usuarios

-- Ejercicio 1: Crear un usuario básico
CREATE USER 'biblioteca_usuario'@'localhost' IDENTIFIED BY 'password123';

-- Ejercicio 2: Crear un usuario para acceso remoto
CREATE USER 'usuario_remoto'@'%' IDENTIFIED BY 'remote123';

-- Ejercicio 3: Usuario con restricciones de contraseña
CREATE USER 'usuario_seguro'@'%' IDENTIFIED BY 'seguro123'
PASSWORD EXPIRE INTERVAL 90 DAY FAILED_LOGIN_ATTEMPTS 5;

-- Ejercicio 4: Crear varios usuarios a la vez
CREATE USER 'admin_biblioteca'@'localhost' IDENTIFIED BY 'admin123';
CREATE USER 'lector'@'192.168.0.100' IDENTIFIED BY 'lector123';
CREATE USER 'editor'@'%' IDENTIFIED BY 'editor123';

-- Ejercicio 5: Verificación de usuarios creados
SELECT User, Host FROM mysql.user;

-- Práctica 2: Manipulación de usuarios

-- Ejercicio 1: Otorgar permisos básicos
GRANT SELECT ON biblioteca.* TO 'lector'@'%';

-- Ejercicio 2: Otorgar permisos de escritura
GRANT INSERT, UPDATE ON biblioteca.libros TO 'editor'@'%';

-- Ejercicio 3: Revocar permisos específicos
REVOKE UPDATE ON biblioteca.libros FROM 'editor'@'%';

-- Ejercicio 4: Modificar permisos existentes
GRANT SELECT, SHOW DATABASES ON *.* TO 'lector'@'%';

-- Ejercicio 5: Eliminar usuarios
DROP USER 'usuario_remoto'@'%';

-- Práctica 3: Roles de usuario

-- Ejercicio 1: Crear roles básicos
CREATE ROLE 'rol_lector';
CREATE ROLE 'rol_editor';
GRANT SELECT ON biblioteca.* TO 'rol_lector';
GRANT INSERT, UPDATE, DELETE ON biblioteca.libros TO 'rol_editor';

-- Ejercicio 2: Asignar roles a usuarios
GRANT 'rol_lector' TO 'lector'@'%';
GRANT 'rol_editor' TO 'editor'@'%';

-- Ejercicio 3: Revocar un rol
REVOKE 'rol_editor' FROM 'editor'@'%';

-- Ejercicio 4: Activar roles
SET ROLE 'rol_lector';

-- Ejercicio 5: Ver roles asignados
SELECT * FROM information_schema.applicable_roles;

-- Ejercicio 6: Crear un rol combinado
CREATE ROLE 'rol_administrador';
GRANT 'rol_lector', 'rol_editor' TO 'rol_administrador';
GRANT 'rol_administrador' TO 'admin_biblioteca'@'localhost';
