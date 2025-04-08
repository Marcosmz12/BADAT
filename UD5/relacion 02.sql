--Ejercicio 01 Basicos
CREATE PROCEDURE hola_mundo AS
BEGIN 
	PRINT 'Hola Mundo !!!'
END

EXEC hola_mundo;

--Ejercicio 02
CREATE PROCEDURE numeros_positivos 
	 @numeros INT 
AS
BEGIN 
	DECLARE @salida NVARCHAR(50)
	SET @salida = CASE
		WHEN @numeros < 0 THEN 'Negativo'
		WHEN @numeros = 0 THEN 'Cero'
		WHEN @numeros > 0 THEN 'Positivo'
	ELSE 'ERROR 404'
	END;

	PRINT 'EL número ' + CAST(@numeros AS NVARCHAR)+ ' es '+ @salida;
END

EXEC numeros_positivos @numeros = 6;

--Ejercicio 03
 CREATE PROCEDURE numeros_positivos2
	@numeros INT,
	@salida NVARCHAR(100) OUT
	AS
	BEGIN
		SET @salida = CASE 
			WHEN @numeros < 0 THEN 'El número es negativo'
			WHEN @numeros = 0 THEN 'El número es cero'
			WHEN @numeros > 0 THEN 'El número es positivo'
			ELSE 'ERROR 404'
			END;
	END

BEGIN
	DECLARE @mensaje NVARCHAR(100)
	EXECUTE numeros_positivos2 @numeros = -12 , @salida = @mensaje OUT;
	PRINT @mensaje
END
		
--Ejercicio 04
ALTER PROCEDURE notas 
	@numeros FLOAT 
	AS 
	BEGIN 
	DECLARE @mensaje NVARCHAR(100);
		SET @mensaje = CASE 
			WHEN @numeros < 5 THEN CAST(@numeros AS NVARCHAR) + ' Tu nota es Insuficiente.'
			WHEN @numeros < 6 THEN CAST(@numeros AS NVARCHAR) + ' Tu nota esta Aprobada.'
			WHEN @numeros < 7 THEN CAST(@numeros AS NVARCHAR) + ' Tu nota esta Bien.'
			WHEN @numeros < 8 THEN CAST(@numeros AS NVARCHAR) + ' Tu nota es Notable'
			WHEN @numeros <= 10 THEN CAST(@numeros AS NVARCHAR) + ' Tu nota es Sobresaliente'
			ELSE 'ERROR 404'
			END;
			PRINT @mensaje;
	END;

BEGIN
	EXEC notas @numeros = 7;
END

--Ejercicio 05
ALTER PROCEDURE notas2 
	@numero FLOAT,
	@salida NVARCHAR(100) OUT
	AS
	BEGIN
		IF(@numero >= 0 )
		BEGIN
			SET @salida = CASE 
				WHEN @numero < 5 THEN ' es Insuficiente.'
				WHEN @numero < 6 THEN ' esta Aprobado. '
				WHEN @numero < 7 THEN ' esta Bien.'
				WHEN @numero < 8 THEN ' es Notable.'
				WHEN @numero <= 10 THEN ' es Sobresaliente.'
				ELSE 'ERROR 404'
				END;
		END;
	END

BEGIN 
	DECLARE @mensaje NVARCHAR(100);
	EXEC notas2 @numero = 7.9 , @salida = @mensaje OUT;
	PRINT 'Tu nota' + @mensaje;
END

--Ejercicio 06 
ALTER PROCEDURE notas3
	@numero FLOAT,
	@salida NVARCHAR(100) OUT
	AS
	BEGIN
		IF(@numero >= 0 )
		BEGIN
			SET @salida = CASE 
				WHEN @numero < 5 THEN ' es Insuficiente.'
				WHEN @numero < 6 THEN ' esta Aprobado. '
				WHEN @numero < 7 THEN ' esta Bien.'
				WHEN @numero < 8 THEN ' es Notable.'
				WHEN @numero <= 10 THEN ' es Sobresaliente.'
				ELSE ' ERROR 404'
				END;
		END;
		ELSE PRINT 'Te has equivocado socio'
	END;

BEGIN 
	DECLARE @mensaje NVARCHAR(100);
	EXEC notas3 @numero = 5.3 , @salida = @mensaje OUT;
	PRINT 'Tu nota' + @mensaje;
END;

--Ejercicio 07
CREATE PROCEDURE dias_semanas 
	@dias INT,
	@mensaje NVARCHAR(100) OUT
	AS 
	BEGIN
		IF(@dias >= 0)
		BEGIN 
			SET @mensaje = CASE 
				WHEN @dias = 1 THEN 'Lunes'
				WHEN @dias = 2 THEN 'Martes'
				WHEN @dias = 3 THEN 'Miercoles'
				WHEN @dias = 4 THEN 'Jueves'
				WHEN @dias = 5 THEN 'Viernes'
				WHEN @dias = 6 THEN 'Sabado'
				WHEN @dias = 7 THEN 'Domingo'
				ELSE 'Paco Feminista'
			END;
		END;
		ELSE PRINT 'Paco No Es feminista'
	END

BEGIN 
	DECLARE @semana NVARCHAR(100);
	EXEC dias_semanas @dias = 8, @mensaje = @semana OUT;
	PRINT @semana;
END;

--Ejercicio 08
ALTER PROCEDURE esPar 
	@numero INT,
	@espar BIT OUT
	AS
	BEGIN
		IF (@numero % 2 = 0)
		BEGIN 
			SET @espar = 1;
		END
		ELSE
		BEGIN
			SET @espar = 0;
		END;
	END;

BEGIN 
	DECLARE @esPar BIT;
	EXEC esPar @numero = 1 , @espar = @esPar OUT;
	IF @esPar = 1
	BEGIN 
		PRINT 'TRUE';
	END
	ELSE 
	BEGIN 
		PRINT 'FALSE';
	END;
END

--Ejercicio 09
ALTER PROCEDURE numerosMayoraMenor
	@numero1 INT,
	@numero2 INT,
	@numero3 INT,
	@mayor INT OUT
	AS
	BEGIN 
		IF(@numero1 > @numero2 AND @numero1 > @numero3)
		BEGIN 
			SET @mayor = @numero1;
		END
		IF(@numero2 > @numero1 AND @numero2 > @numero3)
		BEGIN 
			SET @mayor = @numero2;
		END
		IF(@numero3 > @numero2 AND @numero3 > @numero1)
		BEGIN 
			SET @mayor = @numero3;
		END
	END;

BEGIN 
	DECLARE @numeroSalida INT;
	EXEC numerosMayoraMenor @numero1 = 4, @numero2 = 6, @numero3 = 9, @mayor = @numeroSalida OUT;
	PRINT @numeroSalida;
END;





USE tienda_informatica;
--Ejercicio 01
CREATE PROCEDURE total_productos AS
BEGIN 
	DECLARE @productos INT;

	SELECT @productos = COUNT(*)
	FROM producto

	PRINT 'En la base de datos hay ' + CAST(@productos AS NVARCHAR) + ' productos';
END
GO

EXEC total_productos;

--Ejercicio 02
CREATE PROCEDURE valor_medio AS
	@id_fabricante INT;



--Ejercicios Jardineria 
USE jardineriav2;
--Ejercicio 01
ALTER PROCEDURE pais_clientes 
	@nombre_pais NVARCHAR(50)
	AS
BEGIN 
	DECLARE @id_cliente INT,
			@nombre_cliente NVARCHAR(100),
			@telefono NVARCHAR(100),
			@nombre_ciudad NVARCHAR(100),
			

	DECLARE cursor_clientes CURSOR FOR 
		SELECT 
			oficina.pais,
			cliente.codigo_cliente,
			cliente.nombre_cliente,
			cliente.telefono,
			cliente.ciudad
			FROM oficina
			INNER JOIN empleado ON empleado.codigo_oficina = oficina.codigo_oficina
			INNER JOIN cliente ON empleado.codigo_empleado = cliente.codigo_empleado_rep_ventas
			WHERE oficina.pais = @nombre_pais
			ORDER BY codigo_cliente;

		OPEN cursor_clientes;

		FETCH NEXT FROM cursor_clientes INTO @nombre_pais, @id_cliente, @nombre_cliente, @telefono, @nombre_ciudad;


		PRINT 'Clientes en: ' + @nombre_pais;
		WHILE @@FETCH_STATUS = 0
		BEGIN
			PRINT 'Codigo: ' + CAST(@id_cliente AS NVARCHAR) 
				+ ', Nombre: ' + @nombre_cliente 
				+ ', Telefono: ' + @telefono 
				+ ', Ciudad: ' + @nombre_ciudad;
				FETCH NEXT FROM cursor_clientes INTO @nombre_pais, @id_cliente, @nombre_cliente, @telefono, @nombre_ciudad;
		END;

		CLOSE cursor_clientes;
		DEALLOCATE cursor_clientes;
END
GO

EXEC pais_clientes @nombre_pais= 'Spain';

--Ejercicio02
CREATE OR ALTER PROCEDURE pago_maximo 
	@formadePago NVARCHAR(100)
	AS
	BEGIN 
		DECLARE @existe_metadoPago BIT

		SET @existe_metadoPago = (SELECT COUNT(*)
									FROM pago
									WHERE pago.forma_pago = @formadePago);

		DECLARE @mensaje NVARCHAR(100)
		SET @mensaje = 'No se encuntran pagos realizados mediante ' + @formadePago;

		IF @existe_metadoPago = 0
			BEGIN
				THROW 50001, @mensaje , 1;
				RETURN;
			END

			DECLARE @maximo_pago MONEY,
					@nombre_cliente NVARCHAR(100),
					@fechaDePago DATE,
					@id_transicion NVARCHAR(100)
		
			DECLARE cursor_pagoMaximo CURSOR FOR
				SELECT TOP 1 
					SUM(cantidad * precio_unidad) AS pago,
					cliente.nombre_cliente,
					pago_pedido.fecha_pago,
					pago_pedido.id_transaccion
				FROM pago
				INNER JOIN pago_pedido ON pago_pedido.codigo_pago = pago.codigo_pago
				INNER JOIN pedido ON pedido.codigo_pedido = pago_pedido.codigo_pedido
				INNER JOIN cliente ON cliente.codigo_cliente = pedido.codigo_cliente
				INNER JOIN linea_pedido ON linea_pedido.codigo_pedido = pedido.codigo_pedido
				GROUP BY forma_pago , nombre_cliente , fecha_pago, id_transaccion
				HAVING forma_pago = @formadePago
				ORDER BY pago DESC;

				OPEN cursor_pagoMaximo;
				FETCH NEXT FROM cursor_pagoMaximo INTO @maximo_pago, @nombre_cliente, @fechaDePago, @id_transicion ;

				DECLARE @metodoPago2 INT
				SET @metodoPago2 = ( SELECT COUNT (*)
									FROM pago 
									INNER JOIN pago_pedido ON pago.codigo_pago = pago_pedido.codigo_pago
									WHERE forma_pago = @formadePago AND pago.codigo_pago = pago_pedido.codigo_pago);

				IF @metodoPago2 <= 0
				BEGIN 
					PRINT 'No se encontraron pagos realizados mediante ' + @formadePago;
				END
					WHILE @@FETCH_STATUS = 0
					BEGIN 
						PRINT 'El pago de máximo valor realizado con la forma de pago ' + @formadePago + ' es de: ' + CAST(@maximo_pago AS NVARCHAR(100)) + ' Euros.';
						PRINT 'Cliente: ' + @nombre_cliente;
						PRINT 'Fecha de Pago: ' + CAST(@fechaDePago AS NVARCHAR(10));
						PRINT 'ID de trasacción: ' + CAST(@id_transicion AS NVARCHAR(10));
						FETCH NEXT FROM cursor_pagoMaximo INTO @maximo_pago, @nombre_cliente, @fechaDePago, @id_transicion ;
					END


					CLOSE cursor_pagoMaximo;
					DEALLOCATE cursor_pagoMaximo;
			
END
GO

BEGIN
	EXEC pago_maximo @formadePago = 'Tarjeta de crédito'
END

--Ejercicio 03
CREATE OR ALTER PROCEDURE pagos_metodo
	@metodoPago NVARCHAR(100)
	AS
	BEGIN 
		DECLARE @metodo_pago_existe BIT
		SET @metodo_pago_existe = (SELECT COUNT(*)
									FROM pago
									WHERE pago.forma_pago = @metodoPago);

		DECLARE @mensaje_error NVARCHAR(100)
		SET @mensaje_error = 'No se encuntran pagos realizados mediante ' + @metodoPago
		IF @metodo_pago_existe = 0 
		BEGIN 
			THROW 50002 , @mensaje_error , 1; 
		END

		DECLARE @pago_maximo MONEY,
				@pago_minimo MONEY,
				@pago_medio MONEY,
				@pago_total MONEY,
				@numeros_pago INT

		SELECT @pago_maximo = MAX(pago), @pago_minimo = MIN(pago), @pago_medio = AVG(pago), @pago_total = SUM(pago), @numeros_pago = COUNT(pago) FROM (
			SELECT  
					SUM(cantidad * precio_unidad) AS pago,
					cliente.nombre_cliente,
					pago_pedido.fecha_pago,
					pago_pedido.id_transaccion
				FROM pago
				INNER JOIN pago_pedido ON pago_pedido.codigo_pago = pago.codigo_pago
				INNER JOIN pedido ON pedido.codigo_pedido = pago_pedido.codigo_pedido
				INNER JOIN cliente ON cliente.codigo_cliente = pedido.codigo_cliente
				INNER JOIN linea_pedido ON linea_pedido.codigo_pedido = pedido.codigo_pedido
				GROUP BY forma_pago , nombre_cliente , fecha_pago, id_transaccion
				HAVING forma_pago = @metodoPago
				) AS pago_maximo;

				DECLARE @metodoPago2 INT
				SET @metodoPago2 = ( SELECT COUNT (*)
									FROM pago 
									INNER JOIN pago_pedido ON pago.codigo_pago = pago_pedido.codigo_pago
									WHERE forma_pago = @metodoPago AND pago.codigo_pago = pago_pedido.codigo_pago);

				IF @metodoPago2 <= 0
				BEGIN 
					PRINT 'No se encontraron pagos realizados mediante ' + @metodoPago;
				END
				ELSE
				BEGIN
					PRINT 'Estadisticas  para la forma de pago: ' + @metodoPago;
					PRINT '----------------------------------------------------';
					PRINT 'Pago máximo valor: ' + CAST(@pago_maximo AS NVARCHAR);
					PRINT 'Pago minimo valor: ' + CAST(@pago_minimo AS NVARCHAR);
					PRINT 'Valor medio de los pagos: ' + CAST(@pago_medio AS NVARCHAR);
					PRINT 'Suma total de los pagos: ' + CAST(@pago_total AS NVARCHAR);
					PRINT 'Números de pagos realizados: ' + CAST(@numeros_pago AS NVARCHAR);
				END

	END
	GO

BEGIN 
	EXEC pagos_metodo @metodoPago = 'Transferencia Bancaria';
END

-- Ejercicio 04
CREATE OR ALTER PROCEDURE pedidos_codigos 
	@codigo INT
	AS
	BEGIN 
		DECLARE @codigo_existe BIT 
		SET @codigo_existe = (SELECT COUNT(*)
								FROM pedido
								WHERE pedido.codigo_pedido = @codigo)
		
		
		DECLARE @mensaje_error NVARCHAR(100)
		SET @mensaje_error = 'El pedido especificado no existe ' + CAST(@codigo AS NVARCHAR)
		IF @codigo_existe = 0 
		BEGIN 
			THROW 50003 , @mensaje_error , 1; 
		END

		DECLARE @codigo_pedido INT;

		DECLARE @fecha_pedido DATE,
				@fecha_esperada DATE,
				@fecha_entrega DATE;

		DECLARE @estado_pedido NVARCHAR(100),
				@nombre_cliente NVARCHAR(100),
				@comentarios NVARCHAR(100),
				@forma_pago NVARCHAR(100);

		DECLARE cursor_pedidos CURSOR FOR 
			SELECT pedido.codigo_pedido,
					pedido.fecha_pedido,
					pedido.fecha_esperada,
					pedido.fecha_entrega,
					pedido.estado,
					pedido.comentarios,
					cliente.nombre_cliente,
					pago.forma_pago
					FROM pedido
					INNER JOIN cliente ON cliente.codigo_cliente = pedido.codigo_cliente
					LEFT JOIN pago_pedido ON pago_pedido.codigo_pedido = pedido.codigo_pedido
					LEFT JOIN pago ON pago.codigo_pago = pago_pedido.codigo_pago
					WHERE pedido.codigo_pedido = @codigo


		OPEN cursor_pedidos;
		FETCH NEXT FROM cursor_pedidos INTO @codigo_pedido, 
											@fecha_pedido, 
											@fecha_esperada, 
											@fecha_entrega, 
											@estado_pedido , 
											@comentarios,
											@nombre_cliente ,
											@forma_pago;
		WHILE @@FETCH_STATUS = 0
		BEGIN 
			PRINT 'Datos del pedido:'
			PRINT '-----------------'
			PRINT 'Codigo del pedido: ' + CAST(@codigo_pedido AS NVARCHAR)
			PRINT 'Fecha de pedido: ' + CAST(@fecha_pedido AS NVARCHAR)
			PRINT 'Fecha esperada: ' + CAST(@fecha_esperada AS NVARCHAR)
			IF @fecha_entrega is NULL
			BEGIN 
				PRINT 'Fecha de entrega: No ha llegado'
			END
			ELSE
			BEGIN
				PRINT 'Fecha de entrega: ' + CAST(@fecha_entrega AS NVARCHAR)
			END
			PRINT 'Estado: ' + @estado_pedido
			IF @comentarios IS NULL
			BEGIN 
				PRINT 'Comentario: Ninguno'
			END
			ELSE
			BEGIN
				PRINT 'Comentario: ' + @comentarios
			END
			PRINT 'Cliente: ' + @nombre_cliente
			IF @forma_pago IS NULL
			BEGIN 
				PRINT 'Forma de pago: Ninguno'
			END
			PRINT 'Forma de pago: ' + @forma_pago
			FETCH NEXT FROM cursor_pedidos INTO @codigo_pedido, 
											@fecha_pedido, 
											@fecha_esperada, 
											@fecha_entrega, 
											@estado_pedido ,
											@comentarios,
											@nombre_cliente ,
											@forma_pago;
		END

		CLOSE cursor_pedidos;
		DEALLOCATE cursor_pedidos;

		DECLARE @numero_linea INT,
				@cantidad_producto INT,
				@codigo_pedido2 INT;

		DECLARE @nombre_producto NVARCHAR(100);

		DECLARE @precio_producto MONEY,
				@precio_total MONEY;

		DECLARE cursor_lineaPedido CURSOR FOR
			SELECT linea_pedido.numero_linea,
					producto.nombre,
					linea_pedido.cantidad,
					linea_pedido.precio_unidad,
					SUM(cantidad * precio_unidad) AS total,
					linea_pedido.codigo_pedido
					FROM linea_pedido
					INNER JOIN producto ON producto.codigo_producto = linea_pedido.codigo_producto
					GROUP BY linea_pedido.numero_linea, producto.nombre, linea_pedido.cantidad, linea_pedido.precio_unidad, codigo_pedido
					HAVING linea_pedido.codigo_pedido = @codigo

		OPEN cursor_lineaPedido;
		FETCH NEXT FROM cursor_lineaPedido INTO @numero_linea,@nombre_producto, 
												@cantidad_producto, 
												@precio_producto ,
												@precio_total, 
												@codigo_pedido2;

		PRINT 'Lineas del pedido:'
		PRINT '-------------------'
		PRINT 'Número de línea | Nombre del producto | Cantidad | Precio por unidad | Total de la línea'
		PRINT '----------------------------------------------------------------------------------------'
		WHILE @@FETCH_STATUS = 0
		BEGIN 
			PRINT CAST(@numero_linea AS NVARCHAR) + ' | ' 
			+ @nombre_producto + ' | ' 
			+ CAST(@cantidad_producto AS NVARCHAR) + ' | ' 
			+ CAST(@precio_producto AS NVARCHAR) + ' | '
			+ CAST(@precio_total AS NVARCHAR)

			FETCH NEXT FROM cursor_lineaPedido INTO @numero_linea,@nombre_producto, 
												@cantidad_producto, 
												@precio_producto ,
												@precio_total, 
												@codigo_pedido2;
		END

		CLOSE cursor_lineaPedido;
		DEALLOCATE cursor_lineaPedido;
	END;
	GO

	

BEGIN
	EXEC pedidos_codigos @codigo = '12'
END;



SELECT pedido.codigo_pedido,
					pedido.fecha_pedido,
					pedido.fecha_esperada,
					pedido.fecha_entrega,
					pedido.estado,
					cliente.nombre_cliente,
					pago.forma_pago
					FROM pedido
					INNER JOIN cliente ON cliente.codigo_cliente = pedido.codigo_cliente
					LEFT JOIN pago_pedido ON pago_pedido.codigo_pedido = pedido.codigo_pedido
					LEFT JOIN pago ON pago.codigo_pago = pago_pedido.codigo_pago
					WHERE pedido.codigo_pedido = 12

					SELECT * 
					FROM pedido 
					INNER JOIN cliente ON cliente.codigo_cliente = pedido.codigo_cliente
					LEFT JOIN pago_pedido ON pago_pedido.codigo_pedido = pedido.codigo_pedido
					LEFT JOIN pago ON pago.codigo_pago = pago_pedido.codigo_pago
					WHERE pedido.codigo_pedido = 12
				