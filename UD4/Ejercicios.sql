USE NBA;
--Marcos Molis Zapata 1º DAM (T)
--Ejercicio 01
CREATE VIEW Equipo_victorias AS 
	SELECT partido.equipo_local AS equipo, COUNT(*) AS victorias_local
	FROM partido
	WHERE puntos_local > puntos_visitante
	GROUP BY equipo_local

SELECT * FROM Equipo_victorias;

--Ejercicio 02
CREATE VIEW equipo_alturapromedio AS 
	SELECT jugador.nombre_equipo AS nombre_equipo, CAST(AVG(jugador.altura) AS DECIMAL (10,2)) AS altura_promedio
	FROM jugador
	GROUP BY nombre_equipo

SELECT * FROM equipo_alturapromedio;

--Ejercicio 03
CREATE VIEW Puntos_equipos AS 
	SELECT partido.equipo_local AS equipo, partido.temporada, SUM(puntos_local + puntos_visitante) AS total_puntos_temporada
	FROM partido
	GROUP BY equipo_local, temporada

SELECT * FROM Puntos_equipos;

--Ejercicio 04
CREATE VIEW Cantidadjugadores_equipo AS 
	SELECT nombre_equipo, COUNT(*) AS cantidad_jugadores
	FROM jugador
	GROUP BY nombre_equipo
	HAVING COUNT(*) > 10

SELECT * FROM Cantidadjugadores_equipo;

--Ejercicio 05
CREATE VIEW partidosequipos_puntospromedios AS 
	SELECT equipo_local AS equipo , 
	COUNT(*) AS partidos_local, COUNT(*) AS partidos_visitantes, 
	SUM(puntos_local + puntos_visitante) AS total_puntos
	FROM partido
	GROUP BY equipo_local

SELECT * FROM partidosequipos_puntospromedios;

--Ejercicio 06
CREATE VIEW asistencias_jugador AS 
	SELECT nombre AS nombre_jugador, nombre_equipo, 
	CAST(AVG(estadistica.asistencias_por_partido)AS DECIMAL (10,2))AS promedio_asistencias
	FROM jugador
	INNER JOIN estadistica ON jugador.codigo = estadistica.jugador
	GROUP BY nombre, nombre_equipo
	HAVING AVG(estadistica.asistencias_por_partido) > 5

SELECT * FROM asistencias_jugador;
