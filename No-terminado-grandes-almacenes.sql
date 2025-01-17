USE grandes_almacenes;
--Ejercicio 01
ALTER TABLE venta
DROP CONSTRAINT fk_venta_cajero;

ALTER TABLE venta
ADD CONSTRAINT fk_venta_cajero
FOREIGN KEY (cajero) REFERENCES cajero(codigo)
ON DELETE CASCADE;
DELETE FROM venta WHERE cajero = 1;
DELETE FROM cajero WHERE codigo = 1;

SELECT * FROM cajero;
SELECT * FROM venta;

--Ejercicio 02 
ALTER TABLE venta
DROP CONSTRAINT fk_venta_producto;

ALTER TABLE venta
ADD CONSTRAINT fk_venta_producto
FOREIGN KEY (producto) REFERENCES producto(codigo)
ON DELETE CASCADE;

DELETE FROM producto 
WHERE precio > 100;

SELECT * FROM producto;
SELECT * FROM venta;

-- Ejercicio 03
DELETE FROM maquina_registradora
WHERE piso = 2;

SELECT * FROM maquina_registradora;

-- Ejercicio 04
DELETE FROM venta
WHERE cajero = 2;

SELECT * FROM venta;

-- Ejercicio 05
DELETE FROM producto
WHERE nombre LIKE 'C%';
SELECT * FROM producto;

-- Ejercicio 06
DELETE FROM cajero
WHERE nombrecompleto LIKE 'Kumar%';
SELECT * FROM cajero;

-- Ejercicio 07
DELETE FROM producto
WHERE precio BETWEEN 50 AND 150;
SELECT * FROM producto;

-- Ejercicio 08 
DELETE maquina_registradora
WHERE piso BETWEEN 3 AND 4;
SELECT *FROM maquina_registradora;

-- Ejercicio 09
DELETE FROM venta 
WHERE producto = 5
OR maquina = 3;

-- Ejercicio 10
DELETE FROM cajero 
WHERE codigo < 10 
AND nombrecompleto NOT LIKE 'Joe%';

-- Ejercicio 11
DELETE FROM producto 
WHERE precio != 200;

-- Ejercicio 12
DELETE FROM maquina_registradora
WHERE piso < 2;

-- Ejercicio 13 
DELETE FROM producto
WHERE nombre LIKE '%x';

-- Ejercicio 14
UPDATE producto
SET precio = 120
WHERE codigo = 1;

-- Ejercicio 15
UPDATE cajero
SET nombrecompleto = 'María Lopez'
WHERE codigo = 2;

--Ejercicio 16 
UPDATE maquina_registradora
SET piso = 2
WHERE codigo = 3;

--Ejercicio 17
UPDATE producto
SET precio = precio + 10;

--Ejercicio 18
UPDATE producto
SET nombre = 'Oferta'
WHERE nombre LIKE 'Promo%';

--Ejercicio 19 
UPDATE cajero
SET nombrecompleto = 'Pérez'
WHERE nombrecompleto LIKE 'F%';

--Ejercicio 20
UPDATE producto
SET precio = precio * 0.90
WHERE precio BETWEEN 50 AND 100;

--Ejercicio21
UPDATE producto 
SET precio = precio +15
WHERE nombre LIKE 'Premium%';

--Ejercicio 22
UPDATE cajero
SET nombrecompleto = nombrecompleto + 'Senior'
WHERE codigo > 10;

--Ejercicio 23
UPDATE producto
SET precio = precio +20
WHERE (codigo < 10 OR nombre LIKE 'Especial%');

--Ejercicio 24
UPDATE producto
SET precio = 300
WHERE codigo BETWEEN 5 AND 10;

--Ejercicio 25
UPDATE producto
SET nombre = nombre + '- En descuento'
WHERE precio < 30;


-- SELECT GENERICO
SELECT * FROM cajero;
SELECT * FROM maquina_registradora;
SELECT * FROM producto;
SELECT * FROM venta;


