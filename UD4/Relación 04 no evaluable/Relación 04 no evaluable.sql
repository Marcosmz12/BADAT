USE tienda_informatica;

--Ejercicio01
SELECT producto.codigo, producto.nombre, producto.precio, producto.cod_fabricante
FROM producto
WHERE producto.cod_fabricante IN(
SELECT fabricante.codigo
FROM fabricante
WHERE fabricante.nombre LIKE 'Sony');

--Ejercicio 02
SELECT producto.codigo, producto.nombre, producto.precio, producto.cod_fabricante
FROM producto
WHERE producto.precio = (
SELECT MAX(producto.precio)
FROM producto
INNER JOIN fabricante ON fabricante.codigo = producto.cod_fabricante
WHERE fabricante.nombre LIKE 'Samsung');

--Ejercico 03
SELECT producto.nombre
FROM producto
WHERE producto.precio = (
SELECT MAX(producto.precio)
FROM producto
INNER JOIN fabricante ON fabricante.codigo = producto.cod_fabricante
WHERE fabricante.nombre LIKE 'Hewlett-Packard');

--Ejercicio 04
SELECT producto.nombre
FROM producto
WHERE producto.precio = (
SELECT MIN(producto.precio)
FROM producto
INNER JOIN fabricante ON fabricante.codigo = producto.cod_fabricante
WHERE fabricante.nombre LIKE 'LG');

--Ejercicio 05
SELECT producto.nombre
FROM producto
WHERE producto.precio >= ALL (
SELECT producto.precio
FROM producto
INNER JOIN fabricante ON fabricante.codigo = producto.cod_fabricante
WHERE fabricante.nombre LIKE 'Asus');

--Ejercicio 06
SELECT * FROM producto
WHERE precio > (
SELECT AVG(producto.precio)
FROM producto
INNER JOIN fabricante ON fabricante.codigo = producto.cod_fabricante
WHERE fabricante.nombre = 'Asus') AND fabricante.nombre = 'Asus';