#### Base de datos

```sql
use empresa_db;

select * from clientes;

UPDATE clientes SET saldo = 20 WHERE id_usuario = 1;


UPDATE clientes SET saldo = saldo + 32 WHERE id_usuario = 2;
UPDATE clientes SET saldo = saldo - 32 WHERE id_usuario = 1;
```

```sql
-- TRANSCACCIONES
set autocommit = 1;

start transaction;
	UPDATE clientes SET saldo = saldo - 32 WHERE id_usuario = 1;
	UPDATE clientes SET saldo = saldo + 32 WHERE id_usuario = 2;
	rollback;
	select * from clientes;
	commit;
	rollback;
	insert into clientes (saldo) values (0909);
	rollback;

start transaction;
	select * from clientes where id_usuario = 2;
	call transactionMoney(60);
```
	

	
	
####  funcion

```sql
DELIMITER $$
$$
create procedure saludar3()
begin 
	select "Hola mundo";
end$$
DELIMITER ;
-- 
```


```sql
-- create procedure transactionMoney(in money DOUBLE(18,2))

DELIMITER $$
$$
create procedure transactionMoney(in money DOUBLE(18,2))
begin
	select saldo into @saldo from clientes where id_usuario = 1;
	if @saldo < money then
		rollback;
		select saldo, "No hay saldo suficiebnte" from clientes where id_usuario = 1;
	else
		UPDATE clientes SET saldo = saldo - money WHERE id_usuario = 1;
		UPDATE clientes SET saldo = saldo + money WHERE id_usuario = 2;
		commit;
		select * from clientes;
		select "Saldo actualizado";
	end if;
end$$
DELIMITER ;

drop procedure transactionMoney;
call saludar3();

```