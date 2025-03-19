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
	@numeros INT 
	AS 
	BEGIN 
		IF(@numeros < 5)
		BEGIN
			PRINT 'La nota obtenida es ' + CAST(@numeros AS NVARCHAR) + ' es Insuficiente.'
		END 
		IF(@numeros <= 6 AND @numeros > 5) 
		BEGIN 
			PRINT 'La nota obtenida es ' + CAST(@numeros AS NVARCHAR) + ' es Aprobado.'
		END
		IF(@numeros <= 7 AND @numeros > 6) 
		BEGIN 
			PRINT 'La nota obtenida es ' + CAST(@numeros AS NVARCHAR) + ' es Bien.'
		END
		IF(@numeros <= 9 AND @numeros > 7) 
		BEGIN 
			PRINT 'La nota obtenida es ' + CAST(@numeros AS NVARCHAR) + ' es Notable.'
		END
		IF(@numeros <= 10 AND @numeros >9) 
		BEGIN 
			PRINT 'La nota obtenida es ' + CAST(@numeros AS NVARCHAR) + ' es Sobresaliente.'
		END
		ELSE
		BEGIN
			PRINT 'Esta nota ' + CAST(@numeros AS NVARCHAR) + ' no es compatible.'
		END
	END;

BEGIN
	EXEC notas @numeros = 10;
END

--Ejercicio 05










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

