-- 1

SELECT * FROM comercio;

UPDATE comercio
SET direccion = 'Balcarce 50'
WHERE comercio = 42;

SELECT * FROM comercio;

-- 2
-- A

SELECT pid
FROM producto
WHERE (contenido = 'Choclo' AND tipo = 'Enlatado') OR (contenido = 'Pochoclo' AND tipo = 'Bolsa');

-- B

SELECT DISTINCT precio
FROM precio NATURAL JOIN producto NATURAL JOIN comercio
WHERE contenido = 'Tomate' AND zona = 'Bernal';


-- (c) Comercios Gourmet: Listar los comercios que venden Avellanas a más de $50 y también venden Frutas Secas a menos de $40.
-- 

SELECT comercio.*
FROM comercio 
JOIN precio 
ON comercio.comercio = precio.comercio
WHERE comercio.barrio = 'Avellaneda' and precio.precio >= 50

INTERSECT

SELECT comercio.*
FROM comercio 
JOIN precio 
ON comercio.comercio = precio.comercio
JOIN producto 
ON producto.pid = precio.pid
WHERE producto.descripcion = 'Frutas Secas' and precio.precio <= 40

-- (d) Productos Exclusivos: Listar los <pid, descripcion> de los productos que son vendidos
-- en el barrio de Palermo, pero que no son vendidos en el barrio de San Telmo.


SELECT p.pid, p.descripcion 
FROM producto AS p
JOIN precio 
ON p.pid = precio.pid 
JOIN comercio
ON precio.comercio = comercio.comercio
WHERE comercio.barrio = 'Palermo' 

EXCEPT 

SELECT p.pid, p.descripcion 
FROM producto AS p
JOIN precio 
ON p.pid = precio.pid 
JOIN comercio
ON precio.comercio = comercio.comercio
WHERE comercio.barrio = 'San Telmo' 

--(e) Barrios: Listar el <precio-promedio, barrio> del precio promedio de los productos
--ofrecidos en cada barrio.

SELECT barrio, avg(precio) AS precio_promedio
FROM comercio
JOIN precio
ON comercio.comercio = precio.comercio
GROUP BY barrio

-- (f) Los precios de ahorita: Obtener la lista de los productos con sus precios actuales.

SELECT precio.*
FROM     (
         SELECT pid,comercio, max(fecharegistro) AS ultimo_precio
         FROM precio
         GROUP BY pid,comercio
         ORDER BY pid )  AS ultimo_producto
JOIN precio  
ON precio.pid = ultimo_producto.pid AND ultimo_producto.comercio = precio.comercio
WHERE precio.fecharegistro = ultimo_producto.ultimo_precio;

-- (g) Sobreprecios: Obtener la lista de los productos que sufrieron aumentos en las entre dos fechas diferentes (no necesariamente consecutivas).


SELECT precio1.pid, precio1.comercio
FROM precio AS precio1
JOIN precio AS precio2
ON precio1.pid = precio2.pid AND precio2.comercio = precio1.comercio
WHERE precio1.precio > precio2.precio;