USE jardineria;
--Marcos Molis Zapata 1º DAM (T)
--Ejercicio 01
SELECT ciudad , telefono
FROM oficina
WHERE pais LIKE 'España';

--Ejercicio 02
SELECT nombre , apellido1 , apellido2 , puesto
FROM empleado
WHERE puesto NOT LIKE 'Representante Ventas';

--Ejercicio 03
SELECT codigo_pedido , codigo_cliente , fecha_esperada , fecha_entrega
FROM pedido
WHERE DATEDIFF (DAY,fecha_entrega,fecha_esperada) >= 2;

--Ejercicio 04
SELECT codigo_pedido, codigo_cliente, fecha_pedido, estado
FROM pedido
WHERE estado LIKE 'Rechazado' AND YEAR(fecha_pedido) = 2009;

--Ejercicio 05
SELECT codigo_producto, nombre, gama, cantidad_en_stock, precio_venta
FROM producto
WHERE gama LIKE 'Ornamentales' AND cantidad_en_stock > 100
ORDER BY precio_venta DESC;

--Ejercicio 06
SELECT codigo_cliente, nombre_cliente, ciudad, codigo_empleado_rep_ventas
FROM cliente
WHERE ciudad LIKE 'Madrid' AND codigo_empleado_rep_ventas = 11 OR codigo_empleado_rep_ventas = 30;

--Ejercicio 07
SELECT cliente.nombre_cliente, CONCAT(empleado.nombre, ' ' , empleado.apellido1,' ' , empleado.apellido2) AS  nombre_completo_empleado , oficina.ciudad
FROM oficina
INNER JOIN empleado ON empleado.codigo_oficina = oficina.codigo_oficina
INNER JOIN cliente ON cliente.codigo_empleado_rep_ventas = empleado.codigo_empleado;

--Ejercicio 08
SELECT cliente.nombre_cliente, pedido.fecha_entrega, pedido.fecha_esperada
FROM pedido
INNER JOIN cliente ON cliente.codigo_cliente = pedido.codigo_cliente
WHERE fecha_entrega > fecha_esperada;

--Ejercicio 09
SELECT oficina.linea_direccion1, oficina.linea_direccion2 , cliente.ciudad
FROM

