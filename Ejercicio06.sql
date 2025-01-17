--Marcos Molis Zapata 1º DAM Bases de Datos
--Ejercicio06
USE Empleo;
CREATE TABLE Trabajador(
idTrabajador NVARCHAR (9),
nombreTrabajador NVARCHAR (200) NOT NULL,
apellido1Trabajador NVARCHAR (200) NOT NULL,
apellido2Trabajador NVARCHAR (200) NOT NULL,
fechaNacTrabajador DATE NOT NULL,
CONSTRAINT pk_idTrabajador PRIMARY KEY (idTrabajador));