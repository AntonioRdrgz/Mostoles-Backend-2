use empresa;

-- Recuperar todos los empleados y sus numeros de telefono
select emp.nombre, emp.primerApellido, emp.segundoApellido, tel.numero
from empleados emp inner join telefonos tel on emp.id = tel.empleados_id;

-- Recuperar los empleados tengan o no numeros de telefono
select emp.nombre, emp.primerApellido, emp.segundoApellido, tel.numero
from empleados emp left join telefonos tel on emp.id = tel.empleados_id;

use world;

-- Ejercicio 2: Recuperar los paises y el idioma hablado en cada pais siempre que sea una lengua oficial
select pais.Name, idioma.Language
from country pais inner join countrylanguage idioma on pais.Code = idioma.CountryCode
where IsOfficial = true;

-- Ejercicio 3: Recuperar la ciudad mas poblada y el nombre del pais donde se encuentra dicha ciudad

select country.Name ciudad, city.name pais, max(city.population) `total de habitantes`
from country inner join city on country.code = city.countrycode
group by ciudad, pais
order by `total de habitantes` asc;

-- Ejercicio 4: Modificar la consulta del ejercicio 2 para que solamente se muestren resultados para España y todos los idiomas, no solo los oficiales
select pais.Name Pais, idioma.Language Idioma
from country pais inner join countrylanguage idioma on pais.Code = idioma.CountryCode
where pais.name = "Spain"
group by pais.Name, idioma.Language;

-- 
table city;