--Marcos Molis Zapata 1º DAM Bases de Datos
--ejercicio07
USE Empleo;
CREATE TABLE historial_trabajo(
idTrabajador NVARCHAR (9),
idTrabajo NVARCHAR (10),
fecha_comienzo DATE NOT NULL, 
fecha_finalizacion DATE NOT NULL,
CONSTRAINT pk_historial_trabajo PRIMARY KEY (idTrabajador, idTrabajo),
CONSTRAINT fk_historial_trabajador FOREIGN KEY (idTrabajador) REFERENCES Trabajador (idTrabajador) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT fk_historial_trabajo FOREIGN KEY (idTrabajo) REFERENCES Trabajo (idTrabajo) ON DELETE CASCADE ON UPDATE CASCADE);