-- Eliminar la base de datos cientificos si existe
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'cientificos')
BEGIN
    DROP DATABASE cientificos;
END;
GO

-- Crear y usar la base de datos cientificos
CREATE DATABASE cientificos;
GO

USE cientificos;
GO

-- Creación de la tabla cientifico
CREATE TABLE cientifico (
   dni INT NOT NULL,
   nombre NVARCHAR(30) NOT NULL,
   CONSTRAINT pk_cientifico PRIMARY KEY (dni)
);
GO

-- Creación de la tabla proyecto
CREATE TABLE proyecto (
   codigo NVARCHAR(4) NOT NULL,
   nombre NVARCHAR(50) NOT NULL,
   horas INT,
   CONSTRAINT pk_proyecto PRIMARY KEY (codigo)
);
GO

-- Creación de la tabla asignadoa
CREATE TABLE asignadoa (
   cientifico INT NOT NULL,
   proyecto NVARCHAR(4) NOT NULL,
   CONSTRAINT pk_asignadoa PRIMARY KEY (cientifico, proyecto),
   CONSTRAINT fk_asignadoa_cientifico FOREIGN KEY (cientifico) REFERENCES cientifico(dni),
   CONSTRAINT fk_asignadoa_proyecto FOREIGN KEY (proyecto) REFERENCES proyecto(codigo)
);
GO

-- Insertar datos en la tabla cientifico
INSERT INTO cientifico(dni, nombre) 
VALUES (123234877, 'Michael Rogers'),
       (152934485, 'Anand Manikutty'),
       (222364883, 'Carol Smith'),
       (326587417, 'Joe Stevens'),
       (332154719, 'Mary-Anne Foster'),	
       (332569843, 'George ODonnell'),
       (546523478, 'John Doe'),
       (631231482, 'David Smith'),
       (654873219, 'Zacary Efron'),
       (745685214, 'Eric Goldsmith'),
       (845657245, 'Elizabeth Doe'),
       (845657246, 'Kumar Swamy'),
       (635716875, 'John Smith');
GO

-- Insertar datos en la tabla proyecto
INSERT INTO proyecto(codigo, nombre, horas)
VALUES ('AeH1', 'Winds: Studying Bernoullis Principle', 156),
       ('AeH2', 'Aerodynamics and Bridge Design', 189),
       ('AeH3', 'Aerodynamics and Gas Mileage', 256),
       ('AeH4', 'Aerodynamics and Ice Hockey', 789),
       ('AeH5', 'Aerodynamics of a Football', 98),
       ('AeH6', 'Aerodynamics of Air Hockey', 89),
       ('Ast1', 'A Matter of Time', 112),
       ('Ast2', 'A Puzzling Parallax', 299),
       ('Ast3', 'Build Your Own Telescope', 6546),
       ('Bte1', 'Juicy: Extracting Apple Juice with Pectinase', 321),
       ('Bte2', 'A Magnetic Primer Designer', 9684),
       ('Bte3', 'Bacterial Transformation Efficiency', 321),
       ('Che1', 'A Silver-Cleaning Battery', 545),
       ('Che2', 'A Soluble Separation Solution', 778);
GO

-- Insertar datos en la tabla asignadoa
INSERT INTO asignadoa(cientifico, proyecto)
VALUES (123234877, 'AeH1'),
       (152934485, 'AeH3'),
       (222364883, 'Ast3'),	   
       (326587417, 'Ast3'),
       (332154719, 'Bte1'),
       (546523478, 'Che1'),
       (631231482, 'Ast3'),
       (654873219, 'Che1'),
       (745685214, 'AeH3'),
       (845657245, 'Ast1'),
       (845657246, 'Ast2'),
       (332569843, 'AeH4');
GO