/*
¿Que son los objetos almacenados?
		
Cada vez que se va a ejecutar una consulta, entra en accion un componente del RDBMS (sistema de gestion de base de datos relacionadas) denominado analizador/optimizador de consulta, que estudia el plan de ejecucion de la consulta, es decir, lo que tiene que hace rpara devolvernos lo que se pide, unas veces con solo ir al indice sera suficiente, otras habra que unir tablas,etc., pero en cualquier caso es un tiempo que se pierde o se emplea que puede perjudicar el rendimiento del sistema.

Los objetos almacenados son un conjunto de sentencias de SQL que ya se guardan compilados, es decir, en el lenguaje que entiende el motor de base de datos, de forma tal que el analizador de consultas no tiene que pensar como ejecutar esa sentencia porque el plan de ejecucion ya esta guardado, compilado, conjuntamente con todas las demas sentencias.

Los objetos almacenados se guardan a nivel de la base de datos, no a nivel de tabla
    
Tipos de objetos almacenados

	1- Funciones
	2- Procedimientos Almacenados

	3- Triggers (Son creado por los DBA y odiados por los programadores). Realmente las reglas de negocio de la empresa se implementan en los Triggers. Un Trigger es un codigo que responde a un evento( insertar, borrar, actualizar datos de una o varias tablas, y cuando se alcanza una condicion concreta se dispara el codigo)
*/

/* ¿Que es una funcion almacenada, tambien conocida como Funcion definida por el usuario (User Defined Function), en adelante simplemente funcion?

Es un objeto que se crea con la sentencia CREATE FUNCTION y se llama con la clausula SELECT o dentro de una expresion.
Una funcion puede tener cero o muchos parametros de entrada y siempre tiene que devolver un valor, asociado al nombre de la funcion.*/

/* ¿Que es un Procedimiento Almacenado (Stored Procedure)?

Es un objeto que se crea con la sentencia CREATE PROCEDURE y se le llama con la sentencia CALL.
Un procedimiento almacenado(SP) puede tener cero o muchos parametros de entrada y cero o muchos parametros de valores de salida. 
*/

-- CREACION DE OBJETOS ALMACENADOS

use jardineria;

--  Para listar los productos de una gama concreta, que se recibe como parametro

/*
DELIMITER: Para definir un procedimiento almacenado, es necesario modificar temporalmente el caracter separador que se utiliza para delimitar las sentencias de SQL, el ; en este caso. 
No siempre tiene que ser $$, tambien puede ser cualquier caracter que no estes usando en el procedimiento almacenado(SP)
*/


DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `listar_productos`(in gama varchar(50))
BEGIN
	select * from producto p where p.gama = gama;
END$$
DELIMITER ;

-- Invocar o llamar al SP que se llama listar_productos

set @gamaProducto = "Frutales";
call listar_productos(@gamaProducto);

/* Otro ejemplo de creacion de SP:

	contar los productos que sean de una gama que se recibe como parametro y devolver el resultado
*/
DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `contar_productos`(in gama varchar(50), out total int)
BEGIN
	select count(*) into total from producto p where p.gama = gama;
END$$
DELIMITER ;

-- invocar el SP contar_productos
set @resultado = 0;
call contar_productos(@gamaProducto, @resultado);

-- ¿como consultar el parametro de salida o el resultado del SP anterior?

select @resultado `total de productos`;

select concat("el total de productos de la gama ", @gamaProducto, " es: ", @resultado);