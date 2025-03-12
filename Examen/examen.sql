--Marcos Molis Zapata 1º DAM (T)
USE pokedex;
--Ejercicio 01
SELECT nombre, ps , ataque, defensa, at_especial, df_especial, velocidad
FROM pokemon
WHERE at_especial >= df_especial

--Ejercicio 02
SELECT categoria, COUNT(*) AS cantidad
FROM pokemon
GROUP BY categoria
ORDER BY cantidad DESC;

--Ejercicio 03
SELECT nombre , ataque
FROM pokemon
WHERE ataque >(
	SELECT AVG(ataque)
	FROM pokemon)ORDER BY ataque DESC;

--Ejercicio 04
SELECT pokemon.nombre, COUNT(id_habilidad) AS cantidad_habilidades
FROM pokemon
INNER JOIN pokemon_habilidad ON pokemon.numeropokedex = id_pokemon
GROUP BY nombre
HAVING COUNT(id_habilidad) > 1
ORDER BY cantidad_habilidades DESC;

--Ejercicio 05 
SELECT pokemon.nombre, evolucion.metodo
FROM pokemon
INNER JOIN evolucion ON pokemon.numeropokedex = evolucion.id_pokemon_evoluciona
WHERE metodo LIKE '%piedra%';

--Ejercicio 06
SELECT pokemon.nombre AS nombrepokemon, pokemon_evolucionado.nombre AS nombreevolucion, evolucion.metodo AS metodoevolucion
FROM pokemon
LEFT JOIN pokemon pokemon_evolucionado ON pokemon.numeropokedex = pokemon_evolucionado.numeropokedex
LEFT JOIN evolucion ON pokemon.numeropokedex = evolucion.id_pokemon_base

--Ejercicio 07
SELECT pokemon.nombre , tipo.nombre, tipo2.nombre, descripcion, categoria
FROM pokemon
INNER JOIN tipo ON pokemon.tipo1 = tipo.id 
INNER JOIN tipo tipo2 ON pokemon.tipo2 = tipo2.id
--Ejercicio 08


--Ejercicio 09

--Ejercicio 10

--Ejercicio 11
SELECT nombre, velocidad, categoria
FROM pokemon
WHERE velocidad IN(
	SELECT AVG(velocidad)
	FROM pokemon
	INNER JOIN tipo ON pokemon.tipo1 = tipo.id
	WHERE tipo.nombre = 'Pokémon Dragón'
	OR pokemon.tipo2 IN (
		SELECT AVG(velocidad)
		FROM pokemon
		INNER JOIN tipo ON pokemon.tipo2 = tipo.id
		WHERE tipo.nombre = 'Pokémon Dragón'));
--Ejercicio 12
SELECT nombre 
--Ejercicio 13









