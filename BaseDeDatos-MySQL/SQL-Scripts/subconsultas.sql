use world;

/* Recuperar el pais y la poblacion del pais que tiene mas habitantes, consulta que 
ya habiamos implementado, pero de una forma nada eficiente utilizando order by y limit */
select Name `Pais`, Population `Población`
from country
where Population = (select max(Population) from country);

-- Ejercicio # 1 del Jueves 19 de Nov. Recuperar la ciudad que tiene mas habitantes 
-- y el pais donde se encuentra dicha ciudad, utilizando una subconsulta.
select ci.Name `Ciudad`, co.Name `Pais`, ci.Population
from city ci join country co on ci.CountryCode = co.Code
where ci.Population = (select max(Population) from city);

use tienda;

/* Tipos de Subconsultas:

1- Subconsultas de fila: Devuelven multiples columnas (campos) y una sola fila 
2- Subconsultas de tabla: Pueden devolver una o varias columnas y entre cero y 
   varias filas 
3- Subconsultas escalares: Devuelven una columna y una fila (una celda), es decir 
   un valor  */

/* Subconsultas en la clausula WHERE */

/*
   Por ejemplo: Suponga que queremos conocer el nombre del producto
   que tiene mayor precio.
   
   La solucion, una de las posibles, seria: Realizar una primera consulta, que es
   la subconsulta, para recuperar el precio maximo y, a continuacion, en la 
   consulta principal bucar el nombre del producto cuyo precio coincide con el 
   valor del precio maximo: 

*/ 
select nombre, precio
from producto
where precio = (select max(precio) from producto);

use tienda;

/* Subconsulta en la clausula HAVING 

   Recuperar un listado con todos los nombres de los fabricantes que tienen
   el mismo numero de productos que el fabricante Asus */
 
 select fabricante.nombre, count(*) `Total de Productos`
 from fabricante join producto on fabricante.id = producto.id_fabricante
 group by fabricante.nombre
 having `Total de Productos` = (
 
	select count(producto.id_fabricante) 
    from fabricante join producto on fabricante.id = producto.id_fabricante
    and fabricante.nombre = 'Asus'
 
 );
   
-- Ejercicio # 2 del Jueves 19 de Nov
-- Eliminar del listado anterior al fabricante Asus
select fabricante.nombre, count(*) `Total de Productos`
 from fabricante join producto on 
   fabricante.id = producto.id_fabricante and fabricante.nombre != 'Asus' 
 group by fabricante.nombre
 having `Total de Productos` = (
 
	select count(producto.id_fabricante) 
    from fabricante join producto on fabricante.id = producto.id_fabricante
    and fabricante.nombre = 'Asus'
 
 );

/* 
   Subconsulta en la Clausula FROM 
	
   Recuperar el listado de todos los productos que tienen un precio
   mayor o igual al precio promedio, o medio, de todos los productos 
   de su mismo fabricante
   
 */

select producto.*
from producto join (
	select id_fabricante, avg(precio) precioPromedio
    from producto
    group by id_fabricante) t on producto.id_fabricante = t.id_fabricante 
    and producto.precio >= precioPromedio
    order by precio desc;
    
/* Por sugerencia y cortesia de Elias, la consulta anterior es mejor implementarla utilizando NATURAL JOIN, en 
lugar de INNER JOIN, porque el NATURAL JOIN es perfecto cuando hay campos en las dos tablas que tiene el mismo 
nombre, y nos evita utilizar la clausula ON USING */

/* Uso de la clausula USING */

select producto.*
from producto join (
	select id_fabricante, avg(precio) precioPromedio
    from producto
    group by id_fabricante) t using(id_fabricante) 
    where producto.precio >= precioPromedio
    order by precio desc;
    
/* Uso de NATURAL JOIN */

select producto.*
from producto natural join (
	select id_fabricante, avg(precio) precioPromedio
    from producto
    group by id_fabricante) t 
    where producto.precio >= precioPromedio
    order by precio desc;
    
/* OPERADORES QUE PODEMOS UTILIZAR EN LAS SUBCONSULTAS 

 1. Operadores basicos de comparacion (>, >=, <, <=, !=, <>, =) 
 2. Predicados (Predicate (Condicion que se evalua) ANY (SOME) y ALL 
 3- Predicados IN y NOT IN 
 4- Predicado EXISTS y NOT EXISTS */
 
 /* Los Operadores basicos de comparacion se utilizan cuando queremos comparar una expresion
 con el valor que devuelve una subconsulta */
 
<<<<<<< HEAD
 /*
	subconsulta para el uso de los operadores basicos de comparacion:
    
    recuperar todos los productos que tienen un precio mayor o igual al producto mas caro del fabricante "Asus"
 */
=======
 /* 
	Subconsulta para el uso del los operadore basicos de comparcion:
    
    Recuperar todos los productos que tienen un precio mayor o igual al producto mas caro 
    del fabricante "Asus"
 
 */
 
select *
from producto
where precio >= (
       select max(producto.precio) from producto join fabricante
       on producto.id_fabricante = fabricante.id and fabricante.nombre = 'Asus'
);

/* ¿La consulta anterior la podemos rescribir utilizando la clausula USING? (FALSO)

Porque la clausula USING presupone que en ambas tablas exista el mismo campo 

Por lo anterior comentamos la consulta siguiente, que sintaxticamente no tiene error, pero
a la hor de ejecutarla falla */

/* 
>>>>>>> refs/remotes/origin/subconsultas

select *
from producto
where precio >= (
<<<<<<< HEAD
		select max(producto.precio) from producto join fabricante
        on producto.id_fabricante = fabricante.id and fabricante.nombre = 'Asus')
;

/* Uso de los operadores ANY y ALL en subconsultas

Estos operadores se utilizan conjuntamente con los operadores basicos relacionales >< !=

Y el operador ANY es equivalente al operador SOME, se pueden utilizar de la misma forma
*/
-- ejemplo: vamos a reescribir la misma consulta anterior 
=======
       select max(producto.precio) from producto join fabricante
       using(id_fabricante) 
       where fabricante.nombre = 'Asus'
);

*/

/* Uso de los operadores ANY y ALL en subconsultas 

Estos operadores se utilizan conjuntamente con los operadores basicos relacionales 

Y el operador ANY es equivalente al operador SOME, se pueden utilizar de la misma forma 

*/

/* Ejemplo: Vamos a rescribir la misma consulta anterior que recupera todos los productos
que tienen un precio mayor o igual que todos los producto del fabricante Asus */
>>>>>>> refs/remotes/origin/subconsultas

select *
from producto
where precio >= ALL (
	select precio from producto join fabricante on producto.id_fabricante = fabricante.id
<<<<<<< HEAD
		and fabricante.nombre = "Asus"
);
-- Ejemplo de uso del operador ANY: Recuperar el nombre de los fabricantes que tienen productos asociados

SELECT 
    nombre
FROM
    fabricante
WHERE
    id = ANY (SELECT 
            id_fabricante
        FROM
            producto
);
            
-- recuperar los nombres de los fabricantes que NO tienen productos asociacios

select nombre
from fabricante
where id != ALL( select id_fabricante from producto);

/* USo de los operadores IN y NOT INN

tener en cuenta lo siguiente: 

IN es equivalente a ANY, pero NOT IN no es equivalente a != ANY pero si a != ALL
*/

use jardineria;

/* Recuperar un listado de todos los clientes que no han realizado ningun pedido, utilizando los operadores IN y NOT IN 
*/


select *
from cliente
where codigo_cliente not in (select codigo_cliente from pedido);

/* La consulta siguiente no lleva subconsulta, es solo para puntualizar
algunos aspectos a la hora de recuperar registros de mas de una tabla 

Por ejemplo: Recuperar los clientes con sus pedidos y el nombre del 
representante de ventas del cliente */

SELECT 
    cli.nombre_cliente,
    ped.codigo_pedido,
    emp.nombre `Representante de Ventas`
FROM
    cliente cli
        NATURAL JOIN
    pedido ped
        JOIN
    empleado emp ON cli.codigo_empleado_rep_ventas = emp.codigo_empleado;
=======
		and fabricante.nombre = 'Asus'
);

/* Ejemplo de uso del operador ANY 

Recuperar el nombre de los fabricantes que tienen productos asociados */

select nombre
from fabricante
where id = ANY (select id_fabricante from producto);

/* Recuperar los nobres de los fabricantes que NO tienen productos asociados */
select nombre
from fabricante
where id != ALL (select id_fabricante from producto);

/* Uso de los operadores IN y NOT IN 

Tener en cuenta lo siguiente: 

IN es equivalente a = ANY, pero NOT IN no es equivalente a != ANY 
pero SI a != ALL */

use jardineria;

/* Recuperar un listado de todos los clientes que no han realizado ningun
pedido, utilizando los operadores IN y NOT IN */
select *
from cliente
where codigo_cliente not in (select codigo_cliente from pedido);

/* La consulta siguiente no lleva subconsulta, es solo para puntualizar
algunos aspectos a la hora de recuperar registros de mas de una tabla 

Por ejemplo: Recuperar los clientes con sus pedidos y el nombre del 
representante de ventas del cliente */

SELECT 
    cli.nombre_cliente,
    ped.codigo_pedido,
    emp.nombre `Representante de Ventas`
FROM
    cliente cli
        NATURAL JOIN
    pedido ped
        JOIN
    empleado emp ON cli.codigo_empleado_rep_ventas = emp.codigo_empleado;

/* USO DE LOS OPERADORES EXISTS y NOT EXISTS 

Este tipo de operadores se emplementan con subconsultas correalacionadas, es decir,
subconsultas que hacen referencia a una o varias de la consulta que la contiene o cualquier
consulta mas exterior

A modo de ejemplo devolver un listado de los clientes que no han realizado ningun pedido */

select * 
from cliente
where not exists (select * from pedido 
                      where cliente.codigo_cliente = pedido.codigo_cliente);
                      
/* En la consulta anterior, concretamente en la subconsulta, inicialmente en la select
especificamos el campot codigo_cliente, pero finalmente lo cambiamos por * y el resultado
es exactamente el mismo */

/* Mas informacion respecto a las subconsultas CORRELACIONADAS 

A modo de ejemplo: Recuperar un listado de todos los productos 
que tienen un precio mayor o igual a la media de todos los productos 
de su mismo fabricante 

Para la solucion poner en uso la base de datos tienda */

use tienda;

SELECT 
    *
FROM
    producto p1
WHERE
    p1.precio >= (SELECT 
            AVG(p2.precio)
        FROM
            producto p2
        WHERE
            p2.id_fabricante = p1.id_fabricante);

/* Listado de los productos que tienen un precio mayor o igual 
a la media de todos los productos de ese mismo fabricante. 

Solucion aportada por Elias */

use tienda;
SELECT 
    nombre, precio, id_fabricante
FROM
    producto prod
WHERE
    EXISTS( SELECT 
            *
        FROM
            producto
        WHERE
            prod.precio >= (SELECT 
                    AVG(precio)
                FROM
                    producto p
                WHERE
                    p.id_fabricante = prod.id_fabricante));


/* 
	Otro ejemplo de uso del operador EXISTS  en las subconsultas. 
    
    Utilizando la base de datos ejemplo_exists, se pide lo siguiente:
    
    
    ¿Que tipo de tienda (almacen (store)) esta presente en una o mas ciudades?
    
     
*/

use ejemplo_exists;

table cities;
table stores;
table cities_stores; 

select store_type
from stores 
where exists (
	select * from cities_stores 
	where cities_stores.store_type = stores.store_type 
);
>>>>>>> refs/remotes/origin/subconsultas

/* USO DE LOS OPERADORES EXISTS y NOT EXISTS 

Este tipo de operadores se emplementan con subconsultas correalacionadas, es decir,
subconsultas que hacen referencia a una o varias de la consulta que la contiene o cualquier
consulta mas exterior

A modo de ejemplo devolver un listado de los clientes que no han realizado ningun pedido */

select * 
from cliente
where not exists (select * from pedido 
                      where cliente.codigo_cliente = pedido.codigo_cliente);
                      
/* En la consulta anterior, concretamente en la subconsulta, inicialmente en la select
especificamos el campot codigo_cliente, pero finalmente lo cambiamos por * y el resultado
es exactamente el mismo */

/* Mas informacion respecto a las subconsultas CORRELACIONADAS 

A modo de ejemplo: Recuperar un listado de todos los productos 
que tienen un precio mayor o igual a la media de todos los productos 
de su mismo fabricante 

Para la solucion poner en uso la base de datos tienda */

use tienda;

select *
from producto p1
where p1.precio >= (
	select avg(p2.precio)
	from producto p2
	where p2.id_fabricante = p1.id_fabricante
);

/*Listado de los productos que tienen un precio mayor o igual a la media de todos los productos de ese mismo fabricante (version Elias)*/
use tienda;
SELECT nombre, precio, id_fabricante
FROM producto prod WHERE EXISTS (
SELECT * FROM producto WHERE prod.precio>= (
SELECT AVG(precio) FROM producto p WHERE p.id_fabricante = prod.id_fabricante)
);

/* 
	otro ejemplo de uso del operador EXISTS en las subconsultas
    
    utilizando la base de datos ejemplo_exists, se pide lo siguiente:
    
    
    que tipo de tienda o almacen esta presente en una o más ciudades
    
 */
    
 use ejemplo_exists;
 table cities;
 table stores;
 table cities_stores;
 
 SELECT store_type
 from stores
 where exists ( 
 	select * from cities_stores 
 	where cities_stores.store_type = stores.store_type
 );
 
 
 


-- Consultas auxiliares
table fabricante;
table producto;





