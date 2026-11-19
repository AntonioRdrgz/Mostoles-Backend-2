use empresa;

-- Recuperar todos los empleados y sus numeros de telefono
select emp.nombre, emp.primerApellido, emp.segundoApellido, tel.numero
from empleados emp join telefonos tel on emp.id = tel.empleado_id ;

-- Recuperar los empleado tengan o no numeros de telefono
select emp.nombre, emp.primerApellido, emp.segundoApellido, tel.numero
from empleados emp left join telefonos tel on emp.id = tel.empleado_id ;

use world;

-- Ejercicio # 2 del Miercoles 18 de Nov: Recuperar los paises y el idioma hablado en cada pais,
-- siempre que sea una lengua oficial
select co.Name, cl.Language 
from country co join countrylanguage cl on co.Code = cl.CountryCode 
	and cl.IsOfficial = 'T';

-- Ejercicio # 3 del Miercoles 18 de Nov: Recuperar la ciudad mas poblada
-- y el nombre del pais donde se encuentra dicha ciudad
select ci.Name `Ciudad`, co.Name `Pais`, ci.Population
from city ci join country co on ci.CountryCode = co.Code
order by ci.Population desc
limit 1 ;

-- Ejercicio # 4 del Miercoles 18 de Nov. Modificar la consulta del Ejercicio # 2 
-- para que solamente se muestren resultados para España y todos los idiomas, 
-- no solo los oficiales
select co.Name, cl.Language 
from country co join countrylanguage cl on co.Code = cl.CountryCode 
	and co.Name = 'Spain';