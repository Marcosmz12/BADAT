USE NBA ;
--Ejercicio 01
SELECT *
FROM jugador 
WHERE altura >=(
				SELECT AVG(jugador.altura)
				FROM jugador)

--Ejercicio 02
SELECT nombre 
FROM jugador
INNER JOIN estadistica ON estadistica.jugador = jugador.codigo
WHERE estadistica.temporada = '98/99' 
AND (jugador.nombre_equipo IN ( SELECT partido.equipo_local
								FROM partido
								WHERE equipo_visitante = 'Raptors') 
																	OR nombre_equipo IN(SELECT partido.equipo_visitante
																						FROM partido
																						WHERE equipo_local = 'Raptors'))

--Ejercicio 03
SELECT nombre 
FROM jugador
INNER JOIN estadistica ON estadistica.jugador = jugador.codigo
WHERE  temporada = '06/07' 
AND jugador IN (SELECT jugador
				FROM estadistica
				WHERE puntos_por_partido < 15 AND temporada IN ( SELECT temporada
																	FROM estadistica
																	WHERE temporada = '06/07'))

--Ejercicio 04
SELECT jugador.nombre 
FROM jugador
INNER JOIN equipo ON equipo.nombre = jugador.nombre_equipo
WHERE conferencia = 'East'
AND codigo IN (SELECT jugador 
			FROM estadistica
			WHERE puntos_por_partido > 20 AND temporada = '07/08')

--Ejercicio 05
SELECT nombre 
FROM jugador 
WHERE codigo IN (SELECT jugador
				 FROM estadistica
				 WHERE temporada = '05/06' AND tapones_por_partido > 0.8)

--Ejercicio 06 
SELECT nombre 
FROM jugador 
WHERE altura >( SELECT AVG(altura) 
				FROM jugador
				WHERE nombre_equipo = 'Timberwolves')

--Ejercicio 07
SELECT DISTINCT nombre_equipo
FROM jugador
WHERE nombre_equipo IN (SELECT nombre_equipo
						FROM jugador
						WHERE peso > 250 AND nombre_equipo LIKE 'C%')

--Ejercicio 08
SELECT nombre 
FROM jugador
INNER JOIN estadistica ON estadistica.jugador = jugador.codigo
WHERE temporada = '06/07' 
AND puntos_por_partido > (SELECT AVG(puntos_por_partido)
							FROM estadistica
							WHERE temporada = '06/07')

--Ejercicio 09
SELECT nombre 
FROM jugador 
WHERE codigo IN (SELECT jugador 
				FROM estadistica
				WHERE rebotes_por_partido >= 1 AND temporada = '07/08')

--ejercicio 10
SELECT nombre 
FROM jugador
WHERE codigo IN(SELECT jugador
				FROM estadistica
				WHERE puntos_por_partido > 10 AND temporada = '04/05')




