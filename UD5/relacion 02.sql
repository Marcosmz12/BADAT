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

