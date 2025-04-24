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
	@profesor NVARCHAR(50),
	@departamento NVARCHAR(50),
	@sexo_profesor NVARCHAR(1)
	AS
	BEGIN
		DECLARE @profesor_existe BIT,
				@departamento_existe BIT;
		

		SET @departamento_existe = (SELECT COUNT(*)
									FROM departamento
									WHERE nombre = @departamento);

		IF @departamento_existe = 0
		BEGIN 
			THROW 500333, 'El departamento no existe en la base de datos',1;
		END
		
		DECLARE @sexo NVARCHAR(1),
				@nombre_completo NVARCHAR(100),
				@departamento_nombre NVARCHAR(100);
		

		SELECT @nombre_completo = CONCAT(persona.nombre, ' ', persona.apellido1, ' ', persona.apellido2), 
				@sexo = persona.sexo , 
				@departamento_nombre = departamento.nombre
		FROM persona
		INNER JOIN profesor ON profesor.id_profesor = persona.id
		INNER JOIN departamento ON profesor.id_departamento = departamento.id
		WHERE @nombre_completo = @profesor AND departamento.nombre = @departamento AND persona.sexo = @sexo_profesor;

		
		SET @profesor_existe = (SELECT COUNT(profesor.id_profesor)
								FROM profesor
								INNER JOIN persona ON persona.id = profesor.id_profesor
								WHERE @nombre_completo  = @profesor);

		IF @sexo_profesor = 'M'
		BEGIN
			PRINT 'La profesora ha sido asignada al departamento correctamente. ';
		END

		PRINT 'El profesor ha sido asignado al departamento correctamente.';
	END

BEGIN 
	EXEC ejercicio_03 @profesor = 'David Schmidt Fisher', @departamento = 'Matemáticas', @sexo_profesor = 'H';
END

SELECT * 
FROM persona

SELECT CONCAT(persona.nombre, ' ', persona.apellido1, ' ', persona.apellido2), 
		persona.sexo , 
		departamento.nombre
		FROM persona
		INNER JOIN profesor ON profesor.id_profesor = persona.id
		INNER JOIN departamento ON profesor.id_departamento = departamento.id
	
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
			SELECT 			ERROR_NUMBER() AS ErrorNumber,			ERROR_SEVERITY() AS ErrorSeverity,			ERROR_STATE() AS ErrorState,
			ERROR_PROCEDURE() AS ErrorProcedure,
			ERROR_LINE() AS ErrorLine,			ERROR_MESSAGE() AS ErrorMessage;
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
CREATE OR ALTER PROCEDURE ejercicio_06
	@grado NVARCHAR(100)
	AS
	BEGIN 
		DECLARE @total_alumnos INT;
		DECLARE @nombre_completo NVARCHAR(100),
				@sexo_alumnos NVARCHAR(1);

		DECLARE @grado_existe BIT ;

		SET @grado_existe = (SELECT COUNT(*)
								FROM grado 
								WHERE nombre = @grado);

		IF @grado_existe = 0
		BEGIN
			THROW 50006, 'El grado especificado no existe.', 1;
		END
		

		SELECT @total_alumnos = COUNT(DISTINCT persona.id)
		FROM persona
		INNER JOIN alumno_se_matricula_asignatura ON alumno_se_matricula_asignatura.id_alumno = persona.id
		INNER JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id
		INNER JOIN grado ON grado.id = asignatura.id_grado
		WHERE grado.nombre = @grado;

		DECLARE cursor_alumnos1 CURSOR FOR 
		SELECT DISTINCT CONCAT(persona.nombre , ' ', persona.apellido1, ' ', persona.apellido2) AS nombre_completo , persona.sexo
		FROM persona
		INNER JOIN alumno_se_matricula_asignatura ON alumno_se_matricula_asignatura.id_alumno = persona.id
		INNER JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id
		INNER JOIN grado ON grado.id = asignatura.id_grado
		WHERE grado.nombre = @grado;

		OPEN cursor_alumnos1;
		FETCH NEXT FROM cursor_alumnos1 INTO @nombre_completo , @sexo_alumnos;

		PRINT 'El numero de alumnos matriculados en el grado "' + @grado + '" es: '+  CAST(@total_alumnos AS NVARCHAR);
		PRINT 'Lista de alumnos matriculados: ';

		WHILE @@FETCH_STATUS = 0
		BEGIN 
		IF @sexo_alumnos = 'M'
		BEGIN 
			PRINT 'Alumna: '+ @nombre_completo ;
		END
		ELSE 
		BEGIN 
			PRINT 'Alumno: '+ @nombre_completo;
		END
			FETCH NEXT FROM cursor_alumnos1 INTO @nombre_completo , @sexo_alumnos ;
		END

		CLOSE cursor_alumnos1;
		DEALLOCATE cursor_alumnos1;
	END

BEGIN 
	 EXEC ejercicio_06 @grado = 'Grado en Ingeniería Informática (Plan 2015)'
END

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

--Ejercicio04
CREATE OR ALTER PROCEDURE ejercicio_04NBA
	@equipo1 NVARCHAR(50),
	@equipo2 NVARCHAR(50),
	@temporada NVARCHAR(50)
	AS
	BEGIN 
		DECLARE @jugador NVARCHAR(50);
			
		DECLARE @equipo_existe BIT,
				@equipo_existe2 BIT;

		DECLARE @numPartidos INT;

		DECLARE @promedio DECIMAL(10,2),
				@promedio2 DECIMAL(10,2);

		SET @equipo_existe=(SELECT COUNT(*)
							FROM equipo
							WHERE nombre = @equipo1);

		IF @equipo_existe = 0
		BEGIN
			THROW 51001, 'El primer equipo no existe en la base de datos.', 1;
		END

		SET @equipo_existe2 = (SELECT COUNT(*)
								FROM equipo
								WHERE nombre = @equipo2);

		IF @equipo_existe2  = 0
		BEGIN
			THROW 51002, 'El segundo equipo no existe en la base de datos.', 1;
		END

		SELECT @numPartidos = COUNT(*) 
		FROM partido 
		WHERE temporada = @temporada;
    
		IF @numPartidos = 0
		BEGIN
			PRINT 'No hay partidos para la temporada ' + @temporada + '.';
		END

		SELECT @promedio2 = AVG( DISTINCT promedio_triples_temporada)
		FROM jugador
		INNER JOIN jugador_equipo ON jugador_equipo.codigo_jugador = jugador.codigo
		INNER JOIN estadistica_jugador_temporada ON estadistica_jugador_temporada.id_jugador = jugador_equipo.codigo_jugador
		INNER JOIN equipo ON equipo.codigo = jugador_equipo.codigo_equipo
		WHERE estadistica_jugador_temporada.temporada = @temporada AND equipo.nombre = @equipo1

		DECLARE cursor_promedio CURSOR FOR 
		SELECT DISTINCT estadistica_jugador_temporada.promedio_triples_temporada , jugador.nombre
		FROM jugador
		INNER JOIN jugador_equipo ON jugador_equipo.codigo_jugador = jugador.codigo
		INNER JOIN estadistica_jugador_temporada ON estadistica_jugador_temporada.id_jugador = jugador.codigo
		INNER JOIN equipo ON equipo.codigo = jugador_equipo.codigo_equipo
		WHERE estadistica_jugador_temporada.temporada = @temporada AND equipo.nombre = @equipo2
			AND estadistica_jugador_temporada.promedio_triples_temporada > @promedio2;

		OPEN cursor_promedio;
		FETCH NEXT FROM cursor_promedio INTO @promedio , @jugador;

		PRINT 'Media de triples de los jugadores del equipo ' + @equipo1 + ' en la temporada ' + @temporada + ': ' + CAST(@promedio2 AS NVARCHAR);
		PRINT '----------------------------------------------------------------------------------------------------------------';
		PRINT 'Jugadores del equipo ' + @equipo2 + ' en la temporada ' + @temporada + ' con promedio de triples superior a la media del equipo ' + @equipo1;
		WHILE @@FETCH_STATUS = 0
		BEGIN 
			PRINT @jugador + ' con un promedio de triples conseguido en la temporada  ' + @temporada + ': ' +CAST(@promedio AS NVARCHAR) ;
			FETCH NEXT FROM cursor_promedio INTO @promedio , @jugador;
		END

		CLOSE cursor_promedio;
		DEALLOCATE cusor_promedio;
	END

	BEGIN 
		EXEC ejercicio_04NBA @equipo1 = 'Warriors', @equipo2 = 'Lakers' , @temporada = '2023-24'
	END

--Ejercicio 05
CREATE OR ALTER PROCEDURE ejercicio05_NBA 
	@temporada NVARCHAR(50)
	AS
	BEGIN 
		DECLARE @partidosTotal INT;

        SELECT @partidosTotal = COUNT(*) 
		FROM partido 
		WHERE temporada = @temporada;

		IF @partidosTotal = 0
        BEGIN
            PRINT 'No hay partidos en la temporada ' + @temporada + '.';
			RETURN;
        END

		PRINT 'Hay ' + CAST(@partidosTotal AS NVARCHAR) + ' partidos en la temporada ' + @temporada + ':';
		PRINT '----------------------------------------------------------------------------------------';
		
		DECLARE @equipo_local NVARCHAR(50),
				@equipo_visitante NVARCHAR(50),
				@equipo_ganador NVARCHAR(50);

		DECLARE @puntos_local INT,
				@puntos_visitante INT;

		DECLARE @partido_fecha DATE;

		DECLARE  cursor_partidos CURSOR FOR
		SELECT e_local.nombre , e_visitante.nombre , partido.fecha , partido.puntos_local, partido.puntos_visitante 
		FROM partido
		INNER JOIN equipo e_local ON partido.equipo_local = e_local.codigo
		INNER JOIN equipo e_visitante ON partido.equipo_visitante = e_visitante.codigo
		WHERE temporada = @temporada
		ORDER BY partido.fecha ;

		OPEN cursor_partidos;
		FETCH NEXT FROM cursor_partidos INTO @equipo_local, @equipo_visitante, @partido_fecha, @puntos_local, @puntos_visitante;

		WHILE @@FETCH_STATUS = 0
		BEGIN 
			PRINT '(Local) ' + @equipo_local + ' VS ' + '(Visitante) ' + @equipo_visitante + 
				'a fecha ' + CAST(@partido_fecha AS NVARCHAR) + '. Puntos Local: ' + 
				CAST(@puntos_local AS NVARCHAR) + ' / Puntos Visitante: ' +  CAST(@puntos_visitante AS NVARCHAR);
				IF @puntos_local > @puntos_visitante
				BEGIN 
					PRINT 'Ganador: ' + @equipo_local
				END
				ELSE
				BEGIN 
					PRINT 'Ganador: ' + @equipo_visitante
				END
				PRINT '------------------------------------'
				FETCH NEXT FROM cursor_partidos INTO @equipo_local, @equipo_visitante, @partido_fecha,
				@puntos_local, @puntos_visitante;
		END

		CLOSE cursor_partidos;
		DEALLOCATE cursor_partidos;

	END

BEGIN 
	EXEC ejercicio05_NBA @temporada = '2026-27';
END

--Ejercicio 06
CREATE OR ALTER PROCEDURE ejercicio06_NBA 
	@temporada NVARCHAR(50)
	AS
	BEGIN 
		DECLARE @temporada_existe INT;
		SET @temporada_existe =(SELECT temporada
								FROM estadistica_jugador_temporada
								WHERE temporada = @temporada);

		IF @temporada_existe = 0
		BEGIN 
			PRINT 'No hay datos para la temporada especificada.';
            RETURN;
		END

		DECLARE @jugador NVARCHAR(50),
				@equipo NVARCHAR(50);

		DECLARE @triples DECIMAL(10,2);

		DECLARE cursor_triples CURSOR FOR 
		SELECT equipo.nombre , jugador.nombre , 
		MAX(estadistica_jugador_temporada.promedio_triples_temporada)
		FROM estadistica_jugador_temporada
		INNER JOIN jugador_equipo ON estadistica_jugador_temporada.id_jugador = jugador_equipo.codigo_jugador
		INNER JOIN equipo ON equipo.codigo = jugador_equipo.codigo_equipo
		INNER JOIN jugador ON jugador.codigo = jugador_equipo.codigo_jugador
		WHERE estadistica_jugador_temporada.temporada = @temporada
		GROUP BY equipo.nombre , jugador.nombre;

		OPEN cursor_triples;
		FETCH NEXT FROM cursor_triples INTO @equipo, @jugador, @triples;

		PRINT 'Datos para la temporada ' + @temporada + ':';
        PRINT '--------------------------------';

		WHILE @@FETCH_STATUS = 0
		BEGIN 
			PRINT 'Equipo: ' + @equipo;
            PRINT 'Jugador: ' + @jugador;
            PRINT 'Promedio de triples: ' + CAST(@triples AS NVARCHAR);
            PRINT '------------------------------------------';
			FETCH NEXT FROM cursor_triples INTO @equipo, @jugador, @triples;
		END

		CLOSE cursor_triples;
		DEALLOCATE cursor_triples;

	END

	BEGIN 
		EXEC ejercicio06_NBA @temporada = '2022-23'
	END

