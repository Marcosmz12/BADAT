--Marcos Molis Zapata 1º DAM Bases de Datos
--Ejercicio05
CREATE TABLE Trabajo(
idTrabajo NVARCHAR (10),
nombreTrabajo NVARCHAR (35) NOT NULL,
salarioMax DECIMAL (10,2) NOT NULL,
salarioMin DECIMAL (10,2) NOT NULL,
CONSTRAINT pk_idTrabajo PRIMARY KEY (idTrabajo),
CONSTRAINT ck_salarioMax CHECK ( salarioMax <= 25000));