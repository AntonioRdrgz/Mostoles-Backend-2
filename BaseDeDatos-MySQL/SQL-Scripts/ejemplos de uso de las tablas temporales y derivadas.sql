<<<<<<< HEAD
/* Primero : Utilizaremos la base de datos empresa

¿que vamos a hacer? Eliminar los telefonos correspondientes a un empleado concreto

no siempre la base de datos es propiedad nuestra y podemos, por ejemplo, configurar las relaciones para que las actualizaciones y el borrado se propague en cascada a los hijos, porque no tenemos permisos o no somos DBA(data base administrator) para hacerlo. Ademas, los DBA acostumbran a exigir el uso de la PK( primary Key) en operaciones de borrado y actualizacion

es decir, que vamos a ver como se procede cuando no es posible que cuando se elimine o actualice un empleado los cambios se propaguen a telefonos y correos.alter

NOTA IMPORTANTE!!!!!! Hasta el momento las consultas de seleccion no las hemos realizado en el marco de una transaccion, pero el resto de las consultas se sugiere hacerlas en el marco de una transaccion, como es el borrado y las actualizaciones.
LAs sentencias de insert into, no.alter
¿que es una transaccion?



-- ¿ como se inicia una transaccion?

start transaction;
*/
=======
/*
 * Primero: Utilizaremos la base de datos empresa.
 * 
 * ¿Que vamos a hacer? Eliminar los telefonos correspondientes a un empleado concreto.
 * 
 * No siempre la base de datos es propiedad nuestra y podemos, por ejemplo, configurar las 
 * relaciones para que las actualizaciones el borrado se propague en cascada a los hijos, 
 * porque no somos DBA (Data Base Administrator) y no tenemos los privilegios para hacerlo,
 * ademas, los DBA acostumbran a exigir el uso de la PK (Primary Key) en operaciones de 
 * borrado y actualizacion.
 * 
 * Es decir, que vamos a ver como se procede cuando no es posible que cuando se elimine
 * o actualice un empleado los cambios se propagen a telefonos y correos.
 * 
 * NOTA IMPORTANTE!!!!! Hasta el momento la consultas de seleccion no las hemos realizado
 * en el marco de una transaccion, pero el resto de las consultas se sugiera hacerlas en el 
 * marco de una transaccion, como es el borrado y las actualizaciones, las sentencias 
 * de insert into, no.
 * 
 * ¿Que es una trasaccion? Es un conjunto de operaciones, un conjunto de sentencias SQL, en
 * este caso, que el sistema ve como si fuera una sola operacion, es una apuesta de todo o 
 * nada, es decir, que si falla alguna operacion hay que deshacer todas las demas (rollback) 
 * y si todas las operaciones han tenido exito, se confirman entonces (commit).
 * 
 * Es una muy buena practica de programacion tener las sentencias de rollback y commit entre 
 * comentarios y poderlas ejecutar sin descomentarlas.
 * 
 */

use empresa;

-- ¿Como se inicia una transaccion? 
start transaction;

/* Cuando se esta en una transaction las tablas de la base de datos no se modifican 
 * hasta que se ejecute un commit explicitamente */

/* Comprobar si es posible eliminar los telefonos correspondientes a un 
 * empleado sin especificar la PK de la tabla telefonos */

table telefonos;

delete from telefonos where empleado_id = 7;

/* En el caso que no haya sido posible ejecutar la sentencia anterior por la seguridad
 * esta bien configurada por los DBA, se procedera de la siguiente forma: */

/* VARIANTE # 1. 
 * 
 * Creando una tabla temporal con todos los id de la tabla telefonos */

create temporary table ids select id from telefonos;

table ids;

/* Para eliminar los telefonos del empleado cuyo id es 7, es decir los 
 * registros donde el campo empleado_id = 7 */
delete from telefonos where id = ANY (table ids) and empleado_id = 7;

/* Recordar que  = ANY es lo mismo que IN, pero != ANY no es lo mismo que 
 * NOT IN */
delete from telefonos where id IN (table ids) and empleado_id = 7;

/* ¿Por que hemos utilizado una tabla temporal en lugar de una subconsulta? */
delete from telefonos where id = ANY (select id from telefonos) and empleado_id = 7;

/* VARIANTE # 2.
 * 
 * Utilizando una derived table (tabla derivada)  */

delete telefonos 
from telefonos 
     join (select id from telefonos) dt on telefonos.id = dt.id 
where telefonos.empleado_id = 7;  

/* Si utilizamos el MySQL Workbench, la consulta anterior no da ninguna
 * advertencia, por no utilizar la clausula WHERE y utilizar el 
 * operador AND en su lugar */
     

-- rollback;
-- commit;


















>>>>>>> refs/remotes/origin/subconsultas
