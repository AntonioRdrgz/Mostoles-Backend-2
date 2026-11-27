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