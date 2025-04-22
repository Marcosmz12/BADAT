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
		END
		ELSE
		BEGIN
			SET @salida = 'La profesora ha sido asignada al departamento correctamente.';
		END

	END


	
--Ejercicio 04
CREATE OR ALTER PROCEDURE ejercicio04
	@nombre_grado NVARCHAR(100)
	AS
	BEGIN
		DECLARE @grado_existe BIT;

		SET @grado_existe = (SELECT COUNT(*) 
							FROM grado 
							WHERE id = 11);

		IF @grado_existe = 1
		BEGIN 
			THROW 50004, 'ERROR: El grado con ese ID ya existe.', 1;
		END
		ELSE 
		BEGIN
			INSERT INTO grado(nombre) VALUES(@nombre_grado);
		END
	END

	BEGIN 
		BEGIN TRY 
			EXEC ejercicio04 @nombre_grado = 'Grado en Carpinteria(Plan 2025)';
		END TRY
		BEGIN CATCH
			SELECT 			ERROR_NUMBER() AS ErrorNumber,			ERROR_SEVERITY() AS ErrorSeverity,			ERROR_STATE() AS ErrorState,
			ERROR_PROCEDURE() AS ErrorProcedure,
			ERROR_LINE() AS ErrorLine,			ERROR_MESSAGE() AS ErrorMessage;
		END CATCH
	END
	GO

--Ejercicio 05
CREATE OR ALTER PROCEDURE ejercicio_05
	@nombre_asignatura NVARCHAR(50)
	AS
	BEGIN
		DECLARE @nombre_completo NVARCHAR(50),
				@sexo_alumno NVARCHAR(1),
				@ciudad_alumno NVARCHAR(50);

		DECLARE @asignatura_existe BIT;

		SET @asignatura_existe = (SELECT COUNT(*) 
									FROM asignatura
									WHERE nombre = @nombre_asignatura);

		IF @asignatura_existe = 0
		BEGIN 
			THROW 50005, 'La asignatura especificada no existe.', 1;
		END


		DECLARE cursor_alumnos CURSOR FOR
			SELECT CONCAT(persona.nombre, ' ', apellido1, ' ', apellido2) , 
					ciudad,
					sexo
			FROM persona
			INNER JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno
			INNER JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id
			WHERE asignatura.nombre = @nombre_asignatura;

		OPEN cursor_alumnos;
		FETCH NEXT FROM cursor_alumnos INTO @nombre_completo , @ciudad_alumno, @sexo_alumno;

		WHILE @@FETCH_STATUS = 0
		BEGIN 
		IF @sexo_alumno = 'M'
		BEGIN 
			PRINT 'Alumna: '+ @nombre_completo + ', Ciudad: ' + @ciudad_alumno;
		END
		ELSE 
		BEGIN 
			PRINT 'Alumno: '+ @nombre_completo + ', Ciudad: ' + @ciudad_alumno;
		END
			FETCH NEXT FROM cursor_alumnos INTO @nombre_completo , @ciudad_alumno , @sexo_alumno;
		END

		CLOSE cursor_alumnos;
		DEALLOCATE cursor_alumnos;
	END

	BEGIN
		EXEC ejercicio_05 @nombre_asignatura = 'Introducción a la programación';
	END

--Ejercicio 06

--Ejercicio 07
CREATE OR ALTER PROCEDURE ejercicio_07
	@nombre_profesor NVARCHAR(50)
	AS
	BEGIN 
		DECLARE @profesor NVARCHAR(100),
				@sexo NVARCHAR(1),
				@asignatura NVARCHAR(100),
				@grado NVARCHAR(100);

		DECLARE @existe_profesor BIT;
		SET @existe_profesor = (SELECT COUNT(*)
								FROM persona
								INNER JOIN profesor ON profesor.id_profesor = persona.id
								WHERE persona.nombre = @nombre_profesor);

		IF @existe_profesor = 0
		BEGIN 
			THROW 50007, 'El profesor o profesora especificado/a no existe.', 1;
		END
		
		DECLARE cursor_profesor CURSOR FOR
		SELECT CONCAT(persona.nombre, ' ', apellido1, ' ', apellido2) AS nombreCompleto, 
				persona.sexo,
				asignatura.nombre,
				grado.nombre
		FROM persona
		INNER JOIN profesor ON profesor.id_profesor = persona.id
		INNER JOIN asignatura ON asignatura.id_profesor = profesor.id_profesor
		INNER JOIN grado ON asignatura.id_grado = grado.id
		WHERE persona.nombre = @nombre_profesor;

		OPEN cursor_profesor;
		FETCH NEXT FROM cursor_profesor INTO @profesor , @sexo, @asignatura, @grado;

		IF @sexo = 'M'
				BEGIN 
					PRINT 'Profesora: ' + @profesor;
				END
			ELSE 
				BEGIN 
					PRINT 'Profesor: ' + @profesor;
				END

			PRINT 'Lista de asignaturas impartidas: ';
		WHILE @@FETCH_STATUS = 0
		BEGIN 
			PRINT 'Asignatura : ' + @asignatura + ' (Grado: ' + @grado + ' )';
			FETCH NEXT FROM cursor_profesor INTO @profesor , @sexo, @asignatura, @grado;
		END

		CLOSE cursor_profesor;
		DEALLOCATE cursor_profesor;

	END
	GO;
	

	BEGIN 
		EXEC ejercicio_07 @nombre_profesor = 'Zoe';
	END

USE NBAv2;
--Ejercicio 01
CREATE OR ALTER PROCEDURE ejercicio01
	@nombre_equipo NVARCHAR(50)
	AS
	BEGIN 
		DECLARE @equipo_existe BIT;
		SET @equipo_existe = (SELECT COUNT(*)
								FROM equipo
								WHERE nombre = @nombre_equipo );
		IF @equipo_existe = 0
		BEGIN 
			THROW 50011, 'El equipo no existe en la base de datos', 1;
		END
		DECLARE @ciudad NVARCHAR(50),
				@equipo NVARCHAR(50);

		SELECT @equipo = nombre , @ciudad= equipo.ciudad
		FROM equipo
		WHERE equipo.nombre = @nombre_equipo;

		PRINT 'La ciudad del equipo ' + @equipo + ' es : ' + @ciudad;
	END

	BEGIN 
		EXEC ejercicio01 @nombre_equipo = 'Raptors'
	END;

--Ejercicio 02 
CREATE OR ALTER PROCEDURE ejercicio02_NBA
	@equipo NVARCHAR(50),
	@temporada NVARCHAR(20)
	AS
	BEGIN 
		DECLARE @equipo_existe BIT,
				@tempora_existe BIT;

		SET @tempora_existe = ( SELECT COUNT(*)
								FROM jugador_equipo
								WHERE temporada = @temporada);
		IF @tempora_existe = 0
		BEGIN 
			PRINT 'No hay partidos para el equipo ' + @equipo + ' en la temporada ' + @temporada;

		END

		SET @equipo_existe = ( SELECT COUNT(*)
								FROM equipo
								WHERE nombre = @equipo);
		IF @equipo_existe = 0
		BEGIN 
			THROW 50012, 'El equipo no existe en la base de datos.', 1;
		END

		DECLARE @jugador NVARCHAR(50),
				@temporada1 NVARCHAR(20),
				@nombre_equipo NVARCHAR(50);

		DECLARE cursor_equipos CURSOR FOR
		SELECT jugador.nombre , jugador_equipo.temporada , equipo.nombre
		FROM jugador
		INNER JOIN jugador_equipo ON jugador.codigo = jugador_equipo.codigo_jugador
		INNER JOIN equipo ON equipo.codigo = jugador_equipo.codigo_equipo
		WHERE equipo.nombre = @equipo AND temporada = @temporada;

		OPEN cursor_equipos;
		FETCH NEXT FROM cursor_equipos INTO @jugador, @temporada1, @nombre_equipo;

		PRINT 'Jugadores del equipo ' + @nombre_equipo + ' en la temporada: ' + @temporada1;
		PRINT '----------------------------------------------------------------------------';
		WHILE @@FETCH_STATUS = 0
		BEGIN 
			PRINT 'Nombre: '+ @jugador;
			FETCH NEXT FROM cursor_equipos INTO @jugador, @temporada1, @nombre_equipo;
		END

		CLOSE cursor_equipos;
		DEALLOCATE cursor_equipos;
	END


	BEGIN 
		EXEC ejercicio02_NBA @equipo = 'Lakers', @temporada = '2029-30';
	END
	
--Ejercicio 03
CREATE OR ALTER PROCEDURE ejercicio03_NBA
	@equipo NVARCHAR(50),
	@temporada NVARCHAR(50),
	@posicion NVARCHAR(50)
	AS
	BEGIN 
		DECLARE @equipo_existe BIT,
				@tempora_existe BIT,
				@posicion_existe BIT;

		SET @posicion_existe = (SELECT COUNT(*)
								FROM jugador_equipo
								WHERE posicion = @posicion);

		IF @posicion_existe = 0
		BEGIN 
			PRINT 'No hay jugadores para el equipo ' + @equipo + ' en la temporada '+ @temporada + ' con la posicion ' + @posicion;
		END

		SET @tempora_existe = ( SELECT COUNT(*)
								FROM jugador_equipo
								WHERE temporada = @temporada);
		IF @tempora_existe = 0
		BEGIN 
			PRINT 'No hay partidos para el equipo ' + @equipo + ' en la temporada ' + @temporada;
		END

		SET @equipo_existe = ( SELECT COUNT(*)
								FROM equipo
								WHERE nombre = @equipo);
		IF @equipo_existe = 0
		BEGIN 
			THROW 50012, 'El equipo no existe en la base de datos.', 1;
		END
		DECLARE @jugador NVARCHAR(50),
				@temporada1 NVARCHAR(20),
				@nombre_equipo NVARCHAR(50),
				@posicion1 NVARCHAR(50);

		DECLARE cursor_posicion CURSOR FOR
			SELECT jugador.nombre, jugador_equipo.temporada, jugador_equipo.posicion, equipo.nombre
			FROM jugador
			INNER JOIN jugador_equipo ON jugador.codigo = jugador_equipo.codigo_jugador
			INNER JOIN equipo ON jugador_equipo.codigo_equipo = equipo.codigo
			WHERE equipo.nombre = @equipo AND temporada = @temporada AND posicion = @posicion;

		OPEN cursor_posicion ;
		FETCH NEXT FROM cursor_posicion INTO @jugador, @temporada1, @posicion1, @nombre_equipo;

		PRINT 'Jugadores del equipo ' + @nombre_equipo + ' en la temporada ' + @temporada1 + ' con la posicion de ' + @posicion1;
		PRINT '---------------------------------------------------------------';
		WHILE @@FETCH_STATUS = 0
		BEGIN 
			PRINT @jugador;
			FETCH NEXT FROM cursor_posicion INTO @jugador, @temporada1, @nombre_equipo, @posicion1;
		END

		CLOSE cursor_posicion;
		DEALLOCATE cursor_posicion;
	END

BEGIN 
	EXEC ejercicio03_NBA @equipo = 'Lakers', @temporada = '2022-23', @posicion = 'PIVOT_ALERo'
END


