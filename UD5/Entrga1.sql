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


			


