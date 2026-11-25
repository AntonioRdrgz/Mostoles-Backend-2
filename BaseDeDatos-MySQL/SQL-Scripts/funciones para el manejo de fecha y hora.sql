/* En la documentacion oficial de MySQL 9.7 
 * 
 * https://dev.mysql.com/doc/refman/9.7/en/date-and-time-functions.html
 * 
 * utilizaremos la base de datos jardineria
 */

use jardineria;

-- para recuperar la fecha actual

select CURDATE();

-- sumar 31 dias a la fecha actual

select DATE_ADD(CURDATE(), INTERVAL 31 DAY);

-- recuperar el nombre del dia actual

select DAYNAME(CURRENT_DATE());

-- Para poder mostrar el nombre de los dias de la semana  y los meses del año en un idioma concreto

-- Primero recuperamos el valor de la variable que nos permite establecer el idioma

select @@lc_time_names;

 -- para establecer el idioma a español de España

set @@lc_time_names = 'es_ES';

-- utilizando la BBDD jardineria

-- Recuperar los pedidos que se han efectuado en los ultimos 5 dias del mes

use jardineria;

-- Para todas las variantes de solucion consideramos el campo fecha_pedido

-- variante 1 

-- consideramos el campo fecha_pedido de la tabla pedido

select * 
from pedido
where fecha_pedido >= date_sub(last_day (fecha_pedido), interval 5 day);

-- variante 2

-- Utilizando el operador between

select *
from pedido
where fecha_pedido between date_sub(last_day (fecha_pedido), interval 5 day)
and last_day(fecha_pedido);

 -- variante 3

-- utilizando daydiff

select *
from pedido
where DATEDIFF(last_day(fecha_pedido), fecha_pedido) <= 5;



