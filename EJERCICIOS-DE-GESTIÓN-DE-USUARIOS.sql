--Marcos Molis Zapata 1ºDAM Bases de Datos
CREATE DATABASE Biblioteca;
USE Biblioteca;
CREATE TABLE Libro(
Titulo_libro NVARCHAR(50),
CONSTRAINT pk_Libro_Titulo PRIMARY KEY (Titulo_libro));
CREATE TABLE Prestamo(
Fecha_prestamo DATE,
CONSTRAINT pk_Prestamo_Fecha PRIMARY KEY (Fecha_prestamo));
CREATE TABLE Usuario(
Nombre_usuario NVARCHAR(50),
CONSTRAINT pk_Usuario_Nombre PRIMARY KEY (Nombre_usuario));
CREATE TABLE Autor(
Nombre_autor NVARCHAR(50),
CONSTRAINT pk_Autor_Nombre PRIMARY KEY (Nombre_autor));
--Ejercicio01
CREATE LOGIN Bibliotecario1 
WITH PASSWORD = 'biblioteca1';

CREATE USER Bibliotecario1
FOR LOGIN Bibliotecario1;
--Ejercicio02
CREATE USER Lector1 WITHOUT LOGIN;
--Ejercicio03
ALTER USER Bibliotecario1 WITH NAME = gestorBiblioteca;
--Ejercicio04
GRANT SELECT , UPDATE
ON Libro 
TO gestorBiblioteca;
--Ejercicio05
DENY DELETE 
ON Libro 
TO gestorBiblioteca;
--Ejercicio06
GRANT SELECT 
ON Prestamo 
To Lector1;
--Ejercicio07
CREATE LOGIN Bibliotecario2 
WITH PASSWORD = 'biblioteca2';

CREATE USER Bibliotecario2
FOR LOGIN Bibliotecario2;

DENY UPDATE  
ON Libro 
TO Bibliotecario2;
--Ejercio08
GRANT INSERT , UPDATE , DELETE 
ON Prestamo 
TO gestorBiblioteca
WITH GRANT OPTION;
--Ejercicio09
GRANT ALL ON Usuario TO gestorBiblioteca;
--Ejercicio10
DENY SELECT ON Prestamo TO Lector1;
--Ejercicio11
ALTER USER Bibliotecario2 WITH NAME = asistenteBiblioteca;
ALTER LOGIN Bibliotecario2 WITH NAME = asistenteBiblioteca;
--Ejercicio12
CREATE USER revisorLibros WITHOUT LOGIN;
GRANT SELECT , UPDATE 
ON Libro 
TO revisorLIbros;
--Ejercicio13
DROP USER Lector1;
--Ejercicio14
DENY ALL ON Libro TO asistenteBiblioteca;