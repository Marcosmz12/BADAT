--Marcos Molis Zapata 1º DAM Bases de Datos 
--Ejercicio02 
USE Mundo;
CREATE TABLE Region(
idRegion INT IDENTITY(1,1),
nombreRegion NVARCHAR(300) NOT NULL,
hemisferioRegion NVARCHAR(50) NOT NULL ,
CONSTRAINT pk_region PRIMARY KEY (idRegion),
CONSTRAINT ch_hemisferio_region CHECK (hemisferioRegion IN ('NORTE', 'SUR')));
