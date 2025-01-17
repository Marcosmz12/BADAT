-- Marcos Molis Zapata 1º DAM Bases de Datos
--Ejercicio01
CREATE DATABASE TallerMecanico;
--Ejercicio02
CREATE DATABASE TallerMecanico_SucursalA;
--EJercicio03
DROP DATABASE TallerMecanico_SucursalA;
--Ejercicio04
CREATE DATABASE TallerMecanico_Respaldo;
--Ejercicio05
ALTER DATABASE TallerMecanico_Respaldo MODIFY NAME = TallerMecanico_Backup;
--Ejercicio06
CREATE DATABASE TallerMaecanico_SucursalB;
--Ejercicio07
DROP DATABASE TallerMecanico_BACKUP;
--Ejercicio08
CREATE DATABASE TallerMecanico_Almacen;
--Ejercicio09
ALTER DATABASE TallerMecanico_Almacen MODIFY NAME = TallerMecanico_Inventario
--Ejercicio10
DROP DATABASE TallerMaecanico_SucursalB;
--Ejercicio11
SELECT name FROM sys.databases WHERE name = 'TallerMecanico';
SELECT name FROM sys.databases WHERE name = 'TallerMecanico_Inventario';
