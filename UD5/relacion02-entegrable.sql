--Marcos Molis Zapata 1º DAM(T)
USE universidad;
--Ejercicio 01
CREATE OR ALTER PROCEDURE ejercicio_01
	@nombre NVARCHAR(100)
	AS
	BEGIN
		INSERT INTO departamento (nombre) VALUES(@nombre);
	END
	GO;

BEGIN 
	EXEC ejercicio_01 @nombre = 'Lenguaje';
	SELECT * FROM departamento
END

--Ejercicio 02
CREATE OR ALTER PROCEDURE ejercicio_02
	@nif NVARCHAR(9),
	@nombre NVARCHAR(50),
	@apellido1 NVARCHAR(50),
	@apellido2 NVARCHAR(50),
	@ciudad NVARCHAR(50),
	@direccion NVARCHAR(50),
	@telefono NVARCHAR(9),
	@fecha_nacimiento DATE,
	@sexo NVARCHAR(1),
	@tipo NVARCHAR(10)
	AS
	BEGIN 
		INSERT INTO persona(nif, nombre, apellido1, apellido2, ciudad, direccion, telefono, fecha_nacimiento, sexo, tipo)
		VALUES(@nif, @nombre, @apellido1, @apellido2, @ciudad, @direccion, @telefono, @fecha_nacimiento, @sexo, @tipo);
	END

BEGIN
	EXEC ejercicio_02 @nif ='54533994M', @nombre = 'Marcos', @apellido1 = 'Molis', @apellido2 = 'Zapata', @ciudad = 'Vélez-Málaga', @direccion = 'C/ Juan Vazquez Reginfo', @telefono = '6585645406' , @fecha_nacimiento = '04/12/2003', @sexo = 'H', @tipo = 'alumno';
	SELECT * FROM persona
END

--Ejercicio 03
CREATE OR ALTER PROCEDURE ejercicio_03
	@id_profesor INT,
	@id_departamento INT,
	@salida NVARCHAR(20) OUT
	AS
	BEGIN
		DECLARE @hombre NVARCHAR(1),
				@mujer NVARCHAR(1);
		SET @hombre = 'H';
		SET @mujer = 'M';

		SELECT COUNT(*) 
		FROM profesor
		INNER JOIN persona ON persona.id = profesor.id_profesor
		WHERE sexo = @hombre OR sexo = @mujer

		IF @hombre = 'H' OR @mujer = 'M'
		BEGIN 
			SET @salida = 'El profesor ha sido asignado al departamento correctamente.';
			SET @salida = 'La profesora ha sido asignada al departamento correctamente.';
		END
		ELSE 
	END
	

	

	SELECT COUNT(*) 
	FROM departamento
	INNER JOIN profesor ON profesor.id_departamento = departamento.id
	WHERE profesor.id_profesor = 3


	SELECT * FROM profesor
