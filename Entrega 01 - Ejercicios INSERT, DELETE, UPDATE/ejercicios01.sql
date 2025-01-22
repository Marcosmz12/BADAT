--Marcos Molis Zapata 1º DAM (T)
USE jardineria;

--Ejercicio 01
INSERT INTO oficina(codigo_oficina, ciudad, pais, region, codigo_postal, telefono, linea_direccion1,linea_direccion2)
VALUES ('AM-ES', 'Almería', 'España', 'Almería', '04007', '+34 04 12 20003', 'C. Médico Francisco Pérez Company', '44, 04009 Almería');
SELECT * FROM oficina;

--Ejercicio 02
INSERT INTO empleado(codigo_empleado, nombre, apellido1, apellido2, extension, email, codigo_oficina, codigo_jefe, puesto)
VALUES (32, 'Pepe', 'Rodriguez', 'Perez', '1297', 'pepe@jardineria.es', 'AM-ES', 3, 'Representante Ventas' );
UPDATE empleado
SET codigo_jefe = 3
WHERE codigo_empleado = 32;

--Ejercicio 03
INSERT INTO cliente(codigo_cliente, nombre_cliente, nombre_contacto, apellido_contacto, telefono, fax, linea_direccion1, linea_direccion2, ciudad, region, pais, codigo_postal, codigo_empleado_rep_ventas, limite_credito) 
VALUES (39,'Paco Cobo','Paco','Cobo','666000444','950635240','C. Costa del Sol, 26',NULL,'Almeria','Almeria','España','04007',32, 500.00);

--Ejercicio 04
INSERT INTO pedido(codigo_pedido, fecha_pedido, fecha_esperada, fecha_entrega, estado, comentarios, codigo_cliente) 
VALUES (129,'2025-01-21','2025-01-24','2006-01-27','Entregado','Pagado con tarjeta',39);

INSERT INTO linea_pedido(codigo_pedido, codigo_producto, cantidad, precio_unidad, numero_linea) 
VALUES (129,'21636',5,14.00,1),
(129,'FR-11',2,100.00,2);

--Ejercicio 05
-- No, no es posible hacerlo porque entra en conflicto con la restricción REFERENCE 'fk_pedido_cliente'.
-- Tendriamos que borrar la fk que tiene por defecto y modificar la tabla con una nueva que permita actualizar en las demas.
UPDATE cliente
SET codigo_cliente = 40
WHERE codigo_cliente = 39;

ALTER TABLE pedido
DROP CONSTRAINT fk_pedido_cliente;
ALTER TABLE pedido
ADD CONSTRAINT fk_pedido_cliente
FOREIGN KEY (codigo_cliente)
REFERENCES cliente( codigo_cliente)
ON UPDATE CASCADE;

--Ejercicio 06
-- No, no es posible hacerlo porque entra en conflicto con la restricción REFERENCE 'fk_pedido_cliente'.
-- Tendriamos que borrar la fk que tiene por defecto y modificar la tabla con una nueva que permita borrar los demas.
ALTER TABLE pedido
DROP CONSTRAINT fk_pedido_cliente;

ALTER TABLE pedido
ADD CONSTRAINT fk_pedido_cliente
FOREIGN KEY (codigo_cliente)
REFERENCES cliente( codigo_cliente)
ON DELETE CASCADE;

ALTER TABLE linea_pedido
DROP CONSTRAINT fk_linea_pedido_pedido;

ALTER TABLE linea_pedido
ADD CONSTRAINT fk_linea_pedido_pedido
FOREIGN KEY (codigo_pedido)
REFERENCES pedido( codigo_pedido)
ON DELETE CASCADE;

DELETE cliente
WHERE codigo_cliente = 40;

--Ejercicio 07




--SELECT
SELECT * FROM pago;
SELECT * FROM pedido;
SELECT * FROM linea_pedido;
SELECT * FROM producto;
SELECT * FROM gama_producto;
SELECT * FROM cliente;
SELECT * FROM oficina;
SELECT * FROM empleado;