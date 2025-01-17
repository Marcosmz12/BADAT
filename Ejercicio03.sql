--Marcos Molis Zapata 1º DAM Bases de Datos
--Ejercicio03
USE Mundo;
ALTER TABLE Pais
ADD idRegion INT;

ALTER TABLE Pais 
ADD CONSTRAINT fk_region_pais FOREIGN KEY (idRegion) REFERENCES Region(idRegion);