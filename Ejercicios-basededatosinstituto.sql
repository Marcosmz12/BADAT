--Ejercicio01
USE instituto;
INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, tel�fono) 
VALUES ('Laura', 'G�mez', 'Garc�a', '2000-02-15', 'no', '654987321');

SELECT * FROM alumno;

--Ejercicio 02
DELETE FROM alumno 
WHERE tel�fono LIKE '692735409';

--Ejercicio 03


--Ejercicio 04 
INSERT INTO alumno (nombre , apellido1 , apellido2 , fecha_nacimiento, es_repetidor , tel�fono) 
VALUES ('Carlos', 'L�pez', 'Mart�nez', '1997-05-10', 's�' , NULL);

--Ejercicio 05
DELETE alumno WHERE id = 3;

--Ejercicio 06 


--Ejercicio 07
INSERT INTO alumno (nombre , apellido1 , apellido2 , fecha_nacimiento, es_repetidor , tel�fono)
VALUES ('Ra�l', 'S�nchez', 'Ruiz', '1995-12-25', 'no' , '622345678');

--Ejercicio 08
DELETE FROM alumno WHERE tel�fono IS NULL;
SELECT * FROM alumno;

--Ejercicio 09 


--Ejercicio 10
INSERT INTO alumno (nombre , apellido1 , apellido2 , fecha_nacimiento, es_repetidor , tel�fono)
VALUES ('Ana', 'Torres', 'Garc�a', '1999-11-30', 's�' , '687654321');

--Ejercicio 11
DELETE alumno WHERE es_repetidor = 's�';

--Ejercicio 12


--Ejercicio 13 
INSERT INTO alumno (nombre , apellido1 , apellido2 , fecha_nacimiento, es_repetidor , tel�fono)
VALUES ('Marta', 'P�rez', 'L�pez', '1993-08-20', 'no', '634567890');
SELECT * FROM alumno;

--Ejercicio 14 
DELETE FROM alumno WHERE fecha_nacimiento < '1990-01-01';

--Ejercicio 15


--Ejercicio 16
INSERT INTO alumno (nombre , apellido1 , apellido2 , fecha_nacimiento, es_repetidor , tel�fono)
VALUES ('Javier', 'Rodr�guez', 'Garc�a', '1992-01-05', 'no', NULL);

--Ejercicio 17 
DELETE FROM alumno WHERE nombre = 'Antonio';

--Ejercicio 18


--Ejercicio 19 
INSERT INTO alumno (nombre , apellido1 , apellido2 , fecha_nacimiento, es_repetidor , tel�fono)
VALUES ('Sof�a', 'Mart�nez', 'Ruiz', '1998-10-10', 's�', '609876543');
SELECT * FROM alumno;

--Ejercicio 20 
DELETE FROM alumno WHERE apellido2 = 'Ortega';