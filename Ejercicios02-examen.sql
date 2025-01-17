--Marcos Molis Zapata 
--Ejercicio02 examen 
CREATE DATABASE Pokedex;
USE Pokedex;

CREATE TABLE Categoria (
idCategoria INT IDENTITY (1,1),
Nombre NVARCHAR(100) NOT NULL,
CONSTRAINT pk_Categoria_id PRIMARY KEY (idCategoria));

CREATE TABLE Pokemon ( 
Numeropokedex INT IDENTITY (1,1) ,
Nombre NVARCHAR(100) NOT NULL,
Descripcion NVARCHAR(100) DEFAULT ('Es un pokemon tranquilo'),
Foto NVARCHAR(100) NOT NULL,
idCategoria INT NOT NULL, 
CONSTRAINT pk_Pokemon_id PRIMARY KEY (Numeropokedex),
CONSTRAINT fk_Pokemon_idcategoria FOREIGN KEY (idCategoria) REFERENCES Categoria );

CREATE TABLE Tipo (
idTipo INT IDENTITY (1,1) ,
Nombre NVARCHAR(100) NOT NULL,
CONSTRAINT pk_Tipo_id PRIMARY KEY (idTipo));

CREATE TABLE Habilidad (
idHabilidad INT IDENTITY (1,1) , 
Nombre NVARCHAR(100) NOT NULL,
CONSTRAINT pk_Habilidad_id PRIMARY KEY (idHabilidad));

CREATE TABLE Debilidad (
idDebilidad INT IDENTITY (1,1) ,
Nombre NVARCHAR(100) NOT NULL,
CONSTRAINT pk_Debilidad_id PRIMARY KEY (idDebilidad));

CREATE TABLE Estadistica (
Numeropokedex INT  IDENTITY (1,1),
Ataque INT NOT NULL,
Defensa INT NOT NULL,
Ata_es INT NOT NULL,
Def_es INT NOT NULL,
Velocidad INT NOT NULL,
Vida INT NOT NULL,
Altura DECIMAL(10,2) NOT NULL,
Peso DECIMAL(10,2) NOT NULL,
CONSTRAINT pk_Estadistica_Npokedex PRIMARY KEY (Numeropokedex),
CONSTRAINT fk_Estadistica_Npokedex FOREIGN KEY (Numeropokedex) REFERENCES Pokemon,
CONSTRAINT ck_Estadistica_Ataque CHECK (Ataque >= 0),
CONSTRAINT ck_Estadistica_Defensa CHECK (Defensa >= 0),
CONSTRAINT ck_Estadistica_Ata_es CHECK (Ata_es >= 0),
CONSTRAINT ck_Estadistica_Def_es CHECK (Def_es >= 0),
CONSTRAINT ck_Estadistica_Velocidad CHECK (Velocidad >= 0),
CONSTRAINT ck_Estadistica_Vida CHECK (Vida >= 0),
CONSTRAINT ck_Estadistica_Altura CHECK (Altura >= 0),
CONSTRAINT ck_Estadistica_Peso CHECK (Peso >= 0),
CONSTRAINT ck_Estadistica_Ataquemax CHECK (Ataque <= 255),
CONSTRAINT ck_Estadistica_Defensamax CHECK (Defensa <= 255),
CONSTRAINT ck_Estadistica_Ata_esmax CHECK (Ata_es <= 255),
CONSTRAINT ck_Estadistica_Def_es CHECK (Def_es <= 255),
CONSTRAINT ck_Estadistica_Velocidadmax CHECK (Velocidad <= 255),
CONSTRAINT ck_Estadistica_Vidamax CHECK (Vida <= 255),
);

CREATE TABLE Tipo_Pokemon (
idTipo INT IDENTITY (1,1),
Numeropokedex INT ,
CONSTRAINT pk_Tipo_Pokemon_idTipo_Npokedex PRIMARY KEY (idTipo , Numeropokedex),
CONSTRAINT fk_Tipo_pokemon_Npokedex FOREIGN KEY (Numeropokedex) REFERENCES Pokemon,
CONSTRAINT fk_Tipo_pokemon_id FOREIGN KEY (idTipo) REFERENCES Tipo);

CREATE TABLE Pokemon_debilidad (
Numeropokedex INT ,
idDebilidad INT ,
CONSTRAINT pk_Pokemon_debilidad_Npokedex_id PRIMARY KEY (Numeropokedex , idDebilidad),
CONSTRAINT fk_Pokemon_debilidad_Npokedex FOREIGN KEY (Numeropokedex) REFERENCES Pokemon,
CONSTRAINT fk_Pokemon_Debilidad_id FOREIGN KEY (idDebilidad) REFERENCES Debilidad);

CREATE TABLE Pokemon_Habilidad (
Numeropokedex INT ,
idHabilidad INT , 
CONSTRAINT pk_Pokemon_habilidad_Npokedex_id PRIMARY KEY (Numeropokedex , idHabilidad),
CONSTRAINT fk_Pokemon_habilidad_Npokedex FOREIGN KEY (Numeropokedex) REFERENCES Pokemon,
CONSTRAINT fk_Pokemon_habilidad_id FOREIGN KEY (idHabilidad) REFERENCES Habilidad);

ALTER TABLE Pokemon 
ADD Tipo_evolucion NVARCHAR(100),
ADD CONSTRAINT ck_Pokemon_tipo_evolucion CHECK (Tipo_evolucion IN ('Nivel' , 'Piedra Agua' , 'Piedra Fuego' , 'Piedra Trueno' , 'Piedra Hoja' , 'Piedra Hoja' , 'Piedra Lunar' , 'Intercambio' , 'No evoluciona');

ALTER TABLE Pokemon 
ADD Fecha_descrubimiento DATE NOT NULL;

ALTER TABLE Debilidad
ADD Multiplicador DECIMAL (10,2) NOT NULL,