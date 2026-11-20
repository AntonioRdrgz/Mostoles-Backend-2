/*Las funciones de agregado,tambien llamadas operaciones de agregado agrupan registros para obtener un resultado */
/* VARIABLE: el concepto de variable es un contenedor (identificador) que almacena un valor o conjunto de valores en la memoria de un ordenador
 y les asigna un nombre único. 
 Imagina una caja con una etiqueta donde puedes guardar cualquier cosa: números, texto, listas... 
 Este nombre es como un apodo que le das al valor para poder referirte a él más adelante en tu programa.
 Es un identificador, un nombre, que se le asigna a una zona o ubicacion de memoria RAM del equipo
 y que en principio solamente puede almacenar un valor de un tipo de datos concreto, por ejemplo un entero(INT), una cadena de caracteres(VARCHAR), etc.*/
/*¿que es una funcion? Tambien llamada en los inicios de la programacion rutina o subrutina, es un conjunto de sentencias
 o instrucciones de un lenguaje de programacion (basic, ensamblador, fortran, pastal, python, php, javascript, rust, etc.)
 que se declara una sola vez, ya sea en el propio programa o en una biblioteca aparte (library), y que se le asigna un nombre, y posteriormente puede ser invocado o llamada todas las veces que hagan falta desde cualquier parte del programa que estemos desarrollando */

use world;

-- ejemplo: queremos contar el total de paises que hay en la tabla Country
SELECT 
    COUNT(Name) `Total de Paises`
FROM
    country;

-- cuando tenemos un poco de experiencia, la sentencia anterior la escribimos como:

SELECT 
    COUNT(*) `Total de Paises`
FROM
    country;

-- Contar cuantos paises hay por region

select Region, count(*) `total de paises` 
from country
group by Region
order by `total de paises` desc;

-- De la consulta anterior mostrar solamente los resultados para las regiones que tienen más de 10 paises

select Region, count(*) `total de paises` 
from country
group by Region
having `total de paises` > 10
order by `total de paises` desc;

-- Quiero la misma consulta anterior excluyendo los paises que todavia no han obtenido su independencia

SELECT 
    Region, COUNT(*) `total de paises`
FROM
    country
WHERE
    IndepYear IS NOT NULL
GROUP BY Region
HAVING `total de paises` > 10
ORDER BY `total de paises` DESC;

/*NOTA IMPORTANTE:
En una sentencia de SQL donde se utilicen funciones de agregado(count(), MAX(), MIN(), AVG(), SUM(), etc.), los campos que no esten afectados por una funcion de agregado, hay que incluirlos en la clausula GROUP BY.
Si no se utilizan funciones de agregado o no se agrupa, las clausulas WHERE y HAVING se pueden usar indistintamente, es decir, son intercambiables.
pero si se agrupa para filtrar o evaluaar condiciones antes de agrupar (GROUP BY), se utiliza la clausula WHERE, y para operar sobre los resultados agrupados se utilizaria la clausula HAVING.*/

-- EJERCICIO 1 del miercoles 18 noviembre 
-- Recuperar el total de habitantes que hay por continente y region
-- Excluir del resultado aquellos paises que tengan una poblacion inferior al millon de habitantes o que no hayan obtenido su independencia todavia. 
-- ordenar el resultado por el total de poblacion, mostrando las regiones que tienen menos habitantes primero, y solo mostrar los registros con mas de 5 millones de habitantes

SELECT 
    Continent Continente,
    Region Regiones,
    SUM(Population) `total de habitantes`
FROM
    country
WHERE
    Population > 1000000
        AND IndepYear IS NOT NULL
GROUP BY Continent , Region
HAVING `total de habitantes` > 5000000
ORDER BY `total de habitantes` ASC;
 
 -- 



-- sentencias SQL auxiliares
table country;