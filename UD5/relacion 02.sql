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

