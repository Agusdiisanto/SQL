-- (c) Comercios Gourmet: Listar los comercios que venden Avellanas a más de $50 y también venden Frutas Secas a menos de $40.
-- 

SELECT comercio.comercio, comercio.nombre, comercio.direccion, comercio.barrio, comercio.zona
FROM comercio 
JOIN precio 
ON comercio.comercio = precio.comercio
WHERE comercio.barrio = 'Avellaneda' and precio.precio > 50

INTERSECT

SELECT comercio.comercio, comercio.nombre, comercio.direccion, comercio.barrio, comercio.zona
FROM comercio 
JOIN precio 
ON comercio.comercio = precio.comercio
JOIN producto 
ON producto.pid = precio.pid
WHERE producto.descripcion = 'Frutas Secas' and precio.precio < 40

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
