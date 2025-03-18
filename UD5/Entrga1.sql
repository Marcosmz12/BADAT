USE ventas;
--Marcos Molis Zapata 1º DAM(T)

--Ejercicio 1
BEGIN
	DECLARE @numero_comercial INT;
	DECLARE @nombre_ciudad NVARCHAR(50) = 'Granada';

	SELECT @numero_comercial = COUNT(DISTINCT comercial.id)
	FROM comercial
	INNER JOIN pedido ON pedido.id_comercial = comercial.id
	INNER JOIN cliente ON cliente.id = pedido.id_cliente
	WHERE cliente.ciudad = @nombre_ciudad;

	PRINT 'El numero de comerciales con clientes en ' + @nombre_ciudad +' es: '+ CAST(@numero_comercial AS NVARCHAR);
END

--Ejercicio 02
BEGIN 
	DECLARE @numero_pedidos INT;

	SELECT @numero_pedidos = COUNT(pedido.id)
	FROM pedido 
	INNER JOIN cliente ON cliente.id = pedido.id_cliente
	INNER JOIN comercial ON comercial.id = pedido.id_comercial
	WHERE cliente.ciudad = 'Almería';

	DECLARE @nombre_comercial INT;

	SELECT @nombre_comercial = COUNT(*)
	FROM pedido 
	INNER JOIN comercial ON comercial.id = pedido.id_comercial
	WHERE comercial.nombre = 'Antonio' AND comercial.apellido1 = 'Carretero' AND comercial.apellido2 = 'Ortega';

	PRINT 'El número de pedidos realizados pr comerciales con clientes en Almería es: '+  CAST(@numero_pedidos AS NVARCHAR);
	PRINT 'El total de los pedidos hechos por el comercial Antonio Carreteo Ortega: ' + CAST(@nombre_comercial AS NVARCHAR);
END

--Ejercicio 03
BEGIN
	DECLARE @comercial_masComision INT;

	SELECT TOP(1) @comercial_masComision = comercial.id
	FROM comercial
	ORDER BY comision DESC

	PRINT 'El codigo de empleado con la comisión más alto es: ' + CAST(@comercial_masComision AS NVARCHAR);
END

--Ejercicio 04
BEGIN
	DECLARE @idCliente INT;
	SET @idCliente = 1;

	DECLARE @numeroPedidos INT;

	SELECT @numeroPedidos = COUNT(cliente.id)
		FROM cliente 
		INNER JOIN pedido ON pedido.id_cliente = cliente.id 
		WHERE cliente.id = @idCliente

	IF(@numeroPedidos) != 0
		BEGIN 
			PRINT 'El cliente con ID: ' + CAST(@idcliente AS NVARCHAR) + ' ha realizado: ' + CAST(@numeroPedidos AS NVARCHAR) + ' pedidos'
		END
	ELSE
		PRINT 'EL cliente con ID ' + CAST(@idcliente AS NVARCHAR) + ' no ha realizado ningun pedido'
END

--Ejercicio 05
BEGIN
	DECLARE @clienteID INT;
	SET @clienteID = 1 ;

	DECLARE @numerosPedidos INT;
	DECLARE @tipoCliente NVARCHAR(50);

	SELECT @numerosPedidos = COUNT(cliente.id)
		FROM cliente 
		INNER JOIN pedido ON pedido.id_cliente = cliente.id 
		WHERE cliente.id = @clienteID

		SET @tipoCliente = CASE
			WHEN @numerosPedidos = 0 THEN  ' nuevo.'
			WHEN @numerosPedidos BETWEEN 1 AND 5 THEN ' ocasional.'
			WHEN @numerosPedidos > 5 THEN ' frecuente.'
			ELSE 'ERROR'
		END;

		PRINT 'El cliente con ID ' + CAST(@clienteID AS NVARCHAR)+ ' es un cliente' + @tipoCliente;
END

--Ejercicio 06
USE universidad;

BEGIN
	DECLARE @numero_alumno INT;
	DECLARE @nombre_grado NVARCHAR (100);
	SET @nombre_grado = 'Grado en Ingeniería Informática (Plan 2015)'; 

	SELECT @numero_alumno = COUNT(DISTINCT alumno_se_matricula_asignatura.id_alumno)
	FROM alumno_se_matricula_asignatura
	INNER JOIN asignatura ON asignatura.id = alumno_se_matricula_asignatura.id_asignatura
	INNER JOIN grado ON grado.id = asignatura.id_grado
	WHERE grado.nombre = @nombre_grado

	PRINT 'Grado: ' + @nombre_grado + ' - Total de estudiantes inscritos: ' + CAST(@numero_alumno AS NVARCHAR) ;
END

--Ejercicio 07
BEGIN 
	DECLARE @numeros_alumnos INT;
	DECLARE @nombre_asignatutra NVARCHAR(100);
	SET @nombre_asignatutra = 'Introducción a la programación'
	
	SELECT @numeros_alumnos = COUNT(DISTINCT id_alumno)
	FROM alumno_se_matricula_asignatura
	INNER JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id
	WHERE asignatura.nombre = @nombre_asignatutra;

	PRINT 'Asignatura: ' + @nombre_asignatutra + ' - Total de estudiantes inscritos: ' + CAST(@numeros_alumnos AS NVARCHAR) ;
END 

--Ejercicio 08
BEGIN 
	DECLARE @num_alumnos INT;
	DECLARE @nombreAsignatura NVARCHAR(100);
	SET @nombreAsignatura = 'Física para informática'
	
	SELECT @num_alumnos = COUNT(DISTINCT id_alumno)
	FROM alumno_se_matricula_asignatura
	INNER JOIN asignatura ON alumno_se_matricula_asignatura.id_asignatura = asignatura.id
	WHERE asignatura.nombre = @nombreAsignatura;

	DECLARE @alumno INT;
	SELECT @alumno = COUNT(DISTINCT id_alumno)
	FROM alumno_se_matricula_asignatura
	INNER JOIN persona ON persona.id = alumno_se_matricula_asignatura.id_alumno
	INNER JOIN asignatura ON asignatura.id = alumno_se_matricula_asignatura.id_asignatura
	WHERE persona.sexo = 'H' AND asignatura.nombre = @nombreAsignatura;

	DECLARE @alumna INT;
	SELECT @alumna = COUNT(DISTINCT id_alumno)
	FROM alumno_se_matricula_asignatura
	INNER JOIN persona ON persona.id = alumno_se_matricula_asignatura.id_alumno
	INNER JOIN asignatura ON asignatura.id = alumno_se_matricula_asignatura.id_asignatura
	WHERE persona.sexo = 'M' AND asignatura.nombre = @nombreAsignatura;

	PRINT 'Total de alumnos matriculado en ' + @nombreAsignatura +' '+ CAST(@num_alumnos AS NVARCHAR) ;
	IF (@num_alumnos != 0)
	BEGIN
		PRINT 'Total de alumnos matriculados : ' + CAST(@alumno AS NVARCHAR);
		PRINT 'Total de alumnas matriculadas : ' + CAST(@alumna AS NVARCHAR);
	END
END

--Ejercicio 09
BEGIN 
	DECLARE @nombre_profesor NVARCHAR(100)
	DECLARE @asignatura NVARCHAR(100);
	SET @asignatura = 'Bioinformática'

	SELECT @asignatura = asignatura.nombre, @nombre_profesor = CONCAT(persona.nombre ,' ', persona.apellido1, ' ', persona.apellido2) 
	FROM asignatura
	INNER JOIN profesor ON profesor.id_profesor = asignatura.id_profesor
	INNER JOIN persona ON persona.id = profesor.id_profesor
	WHERE asignatura.nombre = @asignatura

	DECLARE @id_profesor INT;
	SET @id_profesor = (SELECT id_profesor
					   FROM asignatura
					   WHERE nombre = @asignatura);

	IF(@id_profesor IS NULL)
	BEGIN
		PRINT 'Profesor que imparte la asignatura "' + @asignatura +'": Sin profesor';
	END
	ELSE
	BEGIN
		PRINT 'Profesor que imparte la asignatura "' + @asignatura +'": ' + @nombre_profesor
	END
END

--Ejercicio 10
BEGIN 
	DECLARE @asignaturas NVARCHAR(100);
	DECLARE @estudiantes NVARCHAR(100);
	DECLARE @estudiantes_matriculados BIT ;
	DECLARE @nombre_estrudiantes NVARCHAR(100);

	SET @nombre_estrudiantes = 'Salvador Sanchez';
	SET @asignaturas = 'Álgegra lineal y matemática discreta';
	SET @estudiantes_matriculados = (SELECT COUNT(persona.id)
									 FROM persona
									 INNER JOIN alumno_se_matricula_asignatura ON alumno_se_matricula_asignatura.id_alumno = persona.id
									 INNER JOIN asignatura ON asignatura.id = alumno_se_matricula_asignatura.id_asignatura
									 WHERE CONCAT(persona.nombre , ' ', persona.apellido1) = @estudiantes 
									 AND @asignaturas = asignatura.nombre);

	IF(@estudiantes_matriculados = 0)
	BEGIN
		PRINT 'El estudiante ' + @estudiantes + 'NO esta matriculado en ' + @asignaturas;
	END
	ELSE 
	BEGIN
		PRINT 'El estudiante ' + @estudiantes + 'SI esta matriculado en ' + @asignaturas;
	END
END


			


