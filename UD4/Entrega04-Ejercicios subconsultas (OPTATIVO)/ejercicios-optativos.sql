USE NBA;
--Marcos Molis Zapata

--Ejercicio 01
SELECT * FROM jugador
WHERE altura >(
SELECT AVG(altura)
FROM jugador);

--Ejercicio 02
SELECT nombre
FROM jugador
INNER JOIN estadistica ON estadistica.jugador = jugador.codigo
WHERE estadistica.temporada = '98/99' AND (nombre_equipo IN (
		SELECT equipo_local
			FROM partido
			WHERE equipo_visitante = 'Raptors')
	OR nombre_equipo IN (
		SELECT equipo_visitante
		FROM partido
		WHERE equipo_local = 'Raptors'));

--Ejercicio 03
SELECT nombre 
FROM jugador
INNER JOIN estadistica ON estadistica.jugador = jugador.codigo
WHERE estadistica.temporada = '06/07' AND jugador IN (
	SELECT jugador
	FROM estadistica
	WHERE puntos_por_partido < 15
	AND temporada IN (
	SELECT temporada 
	FROM estadistica
	WHERE temporada = '06/07'));

--Ejercicio 04
SELECT jugador.nombre
FROM jugador
INNER JOIN equipo ON equipo.nombre = jugador.nombre_equipo
WHERE equipo.conferencia = 'East' AND codigo IN (
	SELECT jugador
	FROM estadistica
	WHERE puntos_por_partido > 20 AND temporada IN (
	SELECT temporada 
	FROM estadistica
	WHERE estadistica.temporada = '07/08'));

--Ejercicio 05
SELECT nombre
FROM jugador
INNER JOIN estadistica ON estadistica.jugador = jugador.codigo
WHERE estadistica.temporada = '05/06' AND codigo IN (
	SELECT jugador
	FROM estadistica
	WHERE tapones_por_partido > 0.8
	AND temporada IN (
	SELECT temporada
	FROM estadistica
	WHERE temporada = '05/06'));

--Ejercicio 06
SELECT nombre
FROM jugador
WHERE altura >(
	SELECT AVG(altura)
	FROM jugador
	WHERE nombre_equipo = 'Timberwolves');

--Ejercicio 07
SELECT DISTINCT nombre_equipo
FROM jugador
WHERE nombre_equipo LIKE 'C%' AND codigo IN (
		SELECT codigo
		FROM jugador
		WHERE peso > 250);

--Ejercicio 08
SELECT nombre
FROM estadistica
INNER JOIN jugador ON jugador.codigo = estadistica.jugador
WHERE temporada = '06/07' AND puntos_por_partido > (
	SELECT AVG(puntos_por_partido)
	FROM estadistica
	WHERE temporada = '06/07');

--Ejercicio 09
SELECT nombre
FROM jugador
WHERE codigo IN(
	SELECT jugador
	FROM estadistica
	WHERE rebotes_por_partido >= 1 AND temporada = '07/08');

--Ejercicio 10
SELECT nombre
FROM jugador
WHERE codigo IN(
	SELECT jugador
	FROM estadistica
	WHERE puntos_por_partido > 10 AND temporada = '04/05');

--Ejercicio 11
SELECT nombre
FROM jugador
WHERE codigo IN (
	SELECT jugador
	FROM estadistica
	WHERE asistencias_por_partido < 3 AND temporada = '03/04');

--Ejercicio 12
SELECT nombre
FROM jugador
INNER JOIN estadistica ON jugador.codigo = estadistica.jugador
WHERE temporada = '07/08' AND puntos_por_partido >(
	SELECT AVG(puntos_por_partido)
	FROM estadistica
	WHERE temporada = '07/08');

--Ejercico 13
SELECT jugador.nombre
FROM jugador
WHERE jugador.codigo IN(
	SELECT jugador
	FROM estadistica
	WHERE puntos_por_partido <= (
		SELECT AVG(puntos_por_partido)
		FROM estadistica
		WHERE puntos_por_partido <= 10));