/* 
 * ¿que es una tabla derivada(derived table)?
 * 
 * es una expresion (combinacion de operadores y operandos, que hay que evaluar 
 * para obtener un resultado concretom en este caso, una expresion de tabla,
 *  se evalua y da como resultado un conjunto (ResultSet)de filas y columnas) de tabla,
 *  y se utiliza en la calusula FROM de la consulta principal, entre parentesis
 * 
 * Las tablas derivadas se utilizan como alternativa a las tablas temporales 
 * y existen consultas que no se pueden implementar si no se utiliza una tabla temportal o
 * mejor una tabla derivada
 * */

/* Una tabla temporal, como la que vamos a crear a continuacion, solo existira durante la sesion, es decir, durante la conexion que hemos establecido con el motor de base de datos, una vez que hemos cerrado la sesion la tabla temporal se elimina de forma automatica
 */

create database test;

use test;

-- creacion de la tabla temporal t1
create temporary table 	t1 (s1 int not null, s2 char(5) not null, s3 float not null);

insert into t1 values (1,'2',3.0), (2, '3',4.0);

table t1;

/* Creacion de la tabla derivada, a partir de la tabla temporal t1 en todos los casos
 * 
 * VARIANTE 1:
 * 
 * Sin definir alias para los campos de la expresion de tabla que aparece en la clausula FROM entre parentesis*/

select s1, s2, s3
from (select s1, s2, s3 from t1) dt;

/* VARIANTE 2:
 * 
 * definiendo alias para los campos de la expresion de tablas */

select sb1,sb2,sb3 
from (select s1 sb1, s2 sb2, s3 sb3 from t1) dt
where sb1 > 1;

/* VARIANTE 3:
 * 
 * Agregando una lista entre parentesis, con los nombres que le vamos a asignar a los campos de la expresion de tabla, es decir, a la tabla derivada */

select sb1, sb2, sb3
from (select * from t1) dt(sb1, sb2,sb3);

/* Preparando las condiciones para utilizar una tabla derivada en un tipo de consulta que no se puede efectuar sin la tabla derivada, o una tabla temporal*/

create temporary table t2( columna int not null);

insert into t2 values(2),(2),(2),(4), (4), (5),(5),(5);

table t2;

/* queremos obtener el promedio de la suma de los valores que son iguales en la tabla t2*/
-- en principio, la solucion seria la siguiente:

select AVG(SUM(columna))
from t2
group by columna;
/* error al ejecutar la sentencia anterior, muestra uso invalido de group by, por lo tanto lo elimino*/
select AVG(SUM(columna))
from t2;

-- Eliminando el group by tampoco funciona. Solucion: implica crear una tabla derivada

select AVG(dt.sumatoria_por_columna) `promedio de las sumas parciales`
from (select SUM(columna) sumatoria_por_columna from t2 group by columna) dt;

