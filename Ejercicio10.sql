--Marcos Molis Zapata 1º DAM Bases de Datos
--ejercicio10
CREATE DATABASE Pubs;
USE Pubs;

CREATE TABLE Pub (
Codigo NVARCHAR(50),
Nombre NVARCHAR(50) NOT NULL,
Licencia_fiscal NVARCHAR (50) NOT NULL,
Domicilio NVARCHAR (50),
Fecha_apertura DATE NOT NULL,
Horario NVARCHAR (50) NOT NULL,
Codigo_localidad INT NOT NULL,
CONSTRAINT pk_codigopub PRIMARY KEY (Codigo),
CONSTRAINT ck_HorarioPub CHECK (Horario IN ('HORARIO1', 'HORARIO2','HORARIO3')));

CREATE TABLE Titular (
DNI_Titular NVARCHAR (50),
Nombre NVARCHAR(50) NOT NULL,
Domicilio NVARCHAR (50),
Codigo_Pub NVARCHAR (50) NOT NULL,
CONSTRAINT pk_DNI_Titular PRIMARY KEY (DNI_Titular),
CONSTRAINT fk_Titular_CodgPub FOREIGN KEY (Codigo_Pub) REFERENCES Pub (Codigo));

CREATE TABLE Empleado (
DNI_Empleado NVARCHAR (50),
Nombre NVARCHAR (50) NOT NULL,
Domicilio NVARCHAR (50),
CONSTRAINT pk_DNI_Empleado PRIMARY KEY (DNI_Empleado));

CREATE TABLE Articulo (
Codigo_articulo NVARCHAR (50),
Nombre NVARCHAR (50) NOT NULL,
Cantidad INT NOT NULL,
Precio_articulo INT NOT NULL,
Codigo_Pub NVARCHAR (50) NOT NULL,
CONSTRAINT pk_Codigo_articulo PRIMARY KEY (Codigo_articulo),
CONSTRAINT fk_Articulo_CodgPub FOREIGN KEY (Codigo_Pub) REFERENCES Pub (Codigo));

CREATE TABLE Localidad (
Codigo_localidad NVARCHAR (50),
Nombre NVARCHAR (50) NOT NULL,
CONSTRAINT pk_Codigo_localidad PRIMARY KEY (Codigo_localidad));

CREATE TABLE Pub_Empleado(
Codigo_Pub NVARCHAR (50),
DNI_Empleado NVARCHAR (50),
Funcion NVARCHAR (50) NOT NULL,
CONSTRAINT pk_Pubempleado_codigopub_DNIempleado PRIMARY KEY (Codigo_Pub,DNI_Empleado),
CONSTRAINT ck_Pubempleado_funcion CHECK (Funcion IN ('CAMARERO', 'SEGURIDAD','LIMPIEZA')));

