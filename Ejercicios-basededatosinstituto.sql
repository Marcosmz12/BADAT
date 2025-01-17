--Ejercicio01
USE instituto;
INSERT INTO alumno (nombre, apellido1, apellido2, fecha_nacimiento, es_repetidor, teléfono) 
VALUES ('Laura', 'Gómez', 'García', '2000-02-15', 'no', '654987321');

SELECT * FROM alumno;

--Ejercicio 02
DELETE FROM alumno 
WHERE teléfono LIKE '692735409';

--Ejercicio 03


--Ejercicio 04 
INSERT INTO alumno (nombre , apellido1 , apellido2 , fecha_nacimiento, es_repetidor , teléfono) 
VALUES ('Carlos', 'López', 'Martínez', '1997-05-10', 'sí' , NULL);

--Ejercicio 05
DELETE alumno WHERE id = 3;

--Ejercicio 06 


--Ejercicio 07
INSERT INTO alumno (nombre , apellido1 , apellido2 , fecha_nacimiento, es_repetidor , teléfono)
VALUES ('Raúl', 'Sánchez', 'Ruiz', '1995-12-25', 'no' , '622345678');

--Ejercicio 08
DELETE FROM alumno WHERE teléfono IS NULL;
SELECT * FROM alumno;

--Ejercicio 09 


--Ejercicio 10
INSERT INTO alumno (nombre , apellido1 , apellido2 , fecha_nacimiento, es_repetidor , teléfono)
VALUES ('Ana', 'Torres', 'García', '1999-11-30', 'sí' , '687654321');

--Ejercicio 11
DELETE alumno WHERE es_repetidor = 'sí';

--Ejercicio 12


--Ejercicio 13 
INSERT INTO alumno (nombre , apellido1 , apellido2 , fecha_nacimiento, es_repetidor , teléfono)
VALUES ('Marta', 'Pérez', 'López', '1993-08-20', 'no', '634567890');
SELECT * FROM alumno;

--Ejercicio 14 
DELETE FROM alumno WHERE fecha_nacimiento < '1990-01-01';

--Ejercicio 15


--Ejercicio 16
INSERT INTO alumno (nombre , apellido1 , apellido2 , fecha_nacimiento, es_repetidor , teléfono)
VALUES ('Javier', 'Rodríguez', 'García', '1992-01-05', 'no', NULL);

--Ejercicio 17 
DELETE FROM alumno WHERE nombre = 'Antonio';

--Ejercicio 18


--Ejercicio 19 
INSERT INTO alumno (nombre , apellido1 , apellido2 , fecha_nacimiento, es_repetidor , teléfono)
VALUES ('Sofía', 'Martínez', 'Ruiz', '1998-10-10', 'sí', '609876543');
SELECT * FROM alumno;

--Ejercicio 20 
DELETE FROM alumno WHERE apellido2 = 'Ortega';