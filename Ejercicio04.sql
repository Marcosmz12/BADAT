--Marcos Molis Zapata 1�DAM Bases de Datos 
--Ejercicio04
USE Mundo;

ALTER TABLE Pais
ADD CONSTRAINT ck_Pais_nombrePais CHECK (nombrePais IN ('Italia', 'China', 'India'));