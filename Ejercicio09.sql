--Marcos Molis Zapata 1� DAM Bases de Datos
--ejercicio09
USE Empleo;
ALTER TABLE Trabajo
ADD CONSTRAINT df_Trabajo_salarioMin DEFAULT (1500) FOR salarioMin ;