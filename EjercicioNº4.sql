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