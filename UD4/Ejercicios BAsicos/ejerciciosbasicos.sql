USE instituto;
--Ejercicio 01
SELECT * FROM alumno
WHERE id = 1;

--Ejercicio 02
SELECT * FROM alumno
WHERE teléfono = 692735409;

--Ejercicio 03
SELECT * FROM alumno
WHERE es_repetidor LIKE 'sí';

--Ejercicio 04 
SELECT * FROM alumno
WHERE es_repetidor LIKE 'no';

--Ejercicio 05 
SELECT * FROM alumno
WHERE fecha_nacimiento < '1993-1-1';

--Ejercicio 06 
SELECT * FROM alumno
WHERE fecha_nacimiento > '1994-1-1';

--Ejercicio 07
SELECT * FROM alumno
WHERE fecha_nacimiento > '1994-1-1'
AND es_repetidor LIKE 'no';

--Ejercicio 08
SELECT * FROM alumno
WHERE YEAR(fecha_nacimiento) = '1998'; 

--Ejercicio 09
SELECT *
FROM alumno
WHERE YEAR(fecha_nacimiento) != '1998';

--Ejercico 10
SELECT * 
FROM alumno
WHERE fecha_nacimiento BETWEEN '01-01-1998' AND '31-05-1998';

--Ejercicio 11
SELECT nombre , REVERSE (nombre) AS nombre_invertido
FROM alumno;

--Ejercicio 12
SELECT CONCAT(nombre, apellido1, apellido2) AS nombrecompleto,
REVERSE (CONCAT(nombre, apellido1, apellido2)) AS nombrecompleto_invertido
FROM alumno;

--Ejercicio 13
SELECT UPPER(CONCAT(nombre,' ', apellido1,' ', apellido2)) AS Nombre_Completo_Mayuscula,
REVERSE (CONCAT(nombre,' ', apellido1,' ', apellido2)) AS Nombre_Completo_Invertido_Minusculas
FROM alumno;

--Ejercicio 14
SELECT CONCAT(nombre,' ', apellido1,' ', apellido2) AS Nombre_Completo,
LEN (CONCAT(nombre,' ', apellido1,' ', apellido2)) AS Numero_Caracteres
FROM alumno;

--Ejercicio 15
SELECT CONCAT(nombre,' ', apellido1,' ', apellido2) AS Nombre_Completo,
LOWER (CONCAT(nombre,'.',apellido1,'@ies.org')) AS Correo_Electronico
FROM alumno;

--Ejercicio 16
SELECT CONCAT(nombre,' ', apellido1,' ', apellido2) AS Nombre_Completo,
LOWER (CONCAT(nombre,'.',apellido1,'@ies.org')) AS Correo_Electronico,
CONCAT(REVERSE(apellido2),YEAR(fecha_nacimiento)) AS Contraseña
FROM alumno;

