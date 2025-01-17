--Marcos Molis Zapata 1ºDAM Bases de Datos
--Ejercicio01
CREATE DATABASE Mundo;
USE Mundo; 
CREATE TABLE Pais(
idPais INT IDENTITY(1,1),
nombrePais NVARCHAR(50) NOT NULL,
CONSTRAINT pk_pais PRIMARY KEY (idPais));