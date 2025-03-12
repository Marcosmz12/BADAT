USE cientificos;

--Ejercicio 01
CREATE VIEW nombres_cientificos
	AS SELECT dni , nombre 
	FROM cientifico;

SELECT * FROM nombres_cientificos;

--Ejercicio 02 
CREATE VIEW proyecto_horas AS 
	SELECT codigo , nombre , horas 
	FROM proyecto
	WHERE horas > 100; 

SELECT * FROM  proyecto_horas;

--Ejercicio 03 
CREATE VIEW proyecto_menos_horas AS 
	SELECT TOP (3) codigo , nombre , horas 
	FROM proyecto 
	ORDER BY horas;

SELECT * FROM proyecto_menos_horas;

--Ejercicio 04 
CREATE VIEW nombre_letra_e AS 
	SELECT dni , nombre 
	FROM cientifico
	WHERE nombre LIKE '%e%';

SELECT * FROM nombre_letra_e;

--Ejercicio 05
CREATE VIEW nombre_proyecto AS 
	SELECT cientifico.nombre AS nombre_cienticfico, proyecto.nombre AS nombre_proyecto 
	FROM cientifico
	INNER JOIN asignadoa ON cientifico.dni = asignadoa.cientifico
	INNER JOIN proyecto ON proyecto.codigo = asignadoa.proyecto

SELECT * FROM nombre_proyecto;

--Ejercicio 06 
CREATE VIEW protectos_mascientificos AS
	SELECT TOP(5) proyecto.nombre, COUNT(asignadoa.cientifico) AS total_cientifico
	FROM proyecto
	INNER JOIN asignadoa ON asignadoa.proyecto = proyecto.codigo
	GROUP BY proyecto.nombre 
	ORDER BY total_cientifico DESC

SELECT * FROM protectos_mascientificos;

--Ejercicio 07
CREATE VIEW proyecto_Aerodynamics AS 
	SELECT cientifico.nombre AS nombre_cientifico, proyecto.nombre AS nombre_proyecto
	FROM cientifico	
	INNER JOIN asignadoa ON cientifico.dni = asignadoa.cientifico
	INNER JOIN proyecto ON asignadoa.proyecto = proyecto.codigo
	WHERE proyecto.nombre LIKE 'Aerodynamics%'

SELECT * FROM proyecto_Aerodynamics;

--Ejercicio 08
CREATE VIEW proyecto_horas AS 
	SELECT proyecto.nombre AS nombre_proyecto, proyecto.horas AS promedio_horas
	FROM proyecto

SELECT * FROM proyecto_horas;

--Ejercicio 09
