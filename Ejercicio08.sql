--Marcos Molis Zapata 1� DAM Bases de Datos
--ejercicio08
USE Mundo;
ALTER TABLE Pais
ADD CONSTRAINT un_Pais_nombrePais UNIQUE (nombrePais);