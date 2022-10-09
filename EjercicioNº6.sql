-- (b) Modifique la relación componentes agregando como atributo la provincia de la ciudad
-- de los Componentes.

ALTER TABLE componentes ADD COLUMN provincia varchar(15) DEFAULT 'Buenos Aires';

-- (c) Modifique la relación artículos agregando un atributo que permita guardar el número
-- de serie de cada artículo.

ALTER TABLE articulos ADD COLUMN número_serie SERIAL;

-- (d) Actualice la componentes cambiando los colores rojos por violeta y los azules por
-- marron

UPDATE public.componentes set color = 'Violeta' WHERE color = 'Rojo' 
UPDATE public.componentes set color = 'Marron' WHERE color = 'Azul'

--(e) Actualice la definición de componentes para que los colores posibles sean solamente
--{rojo, verde, azul, violeta o marrón}


CREATE TABLE coloracion (
	nombre_color varchar(10) PRIMARY KEY
);

INSERT INTO colarcion (nombre_color)
VALUES 
('Rojo'),
('Verde'),
('Azul'),
('Violeta'),
('Marron')	
;

-- (f) Actualice la ciudad de los proveedores cuyos nombres son Carlos o Eva, y cambie su
-- ciudad por Bahía Blanca.

UPDATE public.proveedores set ciudad = 'Bahía Blanca' 
WHERE provnombre = 'Carlos' OR provnombre = 'Eva';

-- (g) Elimine todos los envios cuya cantidad esté entre 200 y 300

DELETE FROM public.envios WHERE cantidad >= 200 AND cantidad <= 300;

-- (h) Elimine los artículos de La Plata.

DELETE FROM public.articulos WHERE ciudad = 'La Plata';


-- DML 

-- (a) Obtener todos los detalles de todos los artículos de Bernal

SELECT * 
FROM articulos
WHERE ciudad = 'Bernal'

-- (b) Obtener todos los valores de id_prov para los proveedores que abastecen el artículo
-- T1.

SELECT idprov 
FROM proveedores
NATURAL JOIN envios
WHERE idart = 'T1'


-- (c) Obtener de la tabla de artículos los valores de id_art y ciudad donde el nombre de la
-- ciudad acaba en D o contiene al menos una E.

SELECT idart,ciudad 
FROM articulos
WHERE ciudad LIKE '%e%' OR ciudad LIKE 'd%';

-- (d) Obtener los valores de id_prov para los proveedores que suministran para el artículo
-- T1 el componente C1.

SELECT idprov
FROM envios
WHERE idcomp = 'C1' AND idart = 'T1'

--(e) Obtener los valores de art_nombre en orden alfabético para los artículos abastecidos
--por el proveedor P1.

SELECT artnombre
FROM articulos
NATURAL JOIN envios
WHERE idprov = 'P1'
GROUP BY artnombre

--(f) Obtener los valores de id_comp para los componentes suministrados para cualquier
--artículo de Capital Federal.

SELECT idcomp
FROM envios
NATURAL JOIN articulos
WHERE ciudad = 'Cap. Fed.';

-- (g) Obtener el id_comp del (o los) componente(s) que tienen el menor peso.

SELECT *
FROM componentes, (
                   SELECT min(peso) AS menor_peso
                   FROM componentes
                  ) AS componentes2
WHERE componentes2.menor_peso = componentes.peso

-- (h) Obtener los valores de idprov para los proveedores que suministran para un artículo
--de La Plata o Capital Federal un componente Rojo.
 
SELECT proveedores.idprov
FROM proveedores
JOIN envios
ON envios.idprov = proveedores.idprov
JOIN componentes
ON componentes.idcomp = envios.idcomp
JOIN articulos
ON articulos.idart = envios.idart
WHERE componentes.color = 'Rojo' AND (articulos.ciudad = 'La Plata' OR articulos.ciudad = 'Cap. Fed.')

--(i) Seleccionar el id_prov de los proveedores que nunca suministraron un componente verde.

SELECT proveedores.idprov
FROM proveedores
JOIN envios
ON envios.idprov = proveedores.idprov
JOIN componentes
ON componentes.idcomp = envios.idcomp
WHERE componentes.color = 'Verde'

-- (j) Obtener, para los envíos del proveedor P2, el número de suministros realizados, el de
-- artículos distintos suministrados y la cantidad total.

SELECT componentes.ciudad,cantidad,idart,sum(cantidad) AS cantidad_Total
FROM envios
JOIN componentes
ON componentes.idcomp = envios.idcomp
WHERE envios.idprov = 'P2'
GROUP BY componentes.ciudad,cantidad,idart

-- O 

SELECT *
FROM envios
WHERE envios.idprov = 'P2'

-- (k) Obtener la cantidad máxima suministrada en un mismo envío, para cada proveedor

SELECT idprov AS proveedor, max(cantidad) AS maxima_suministrada
FROM envios
GROUP BY idprov

-- (l) Para cada artículo y componente suministrado obtener los valores de id_comp, id_art
-- y la cantidad total correspondiente. DUDA 

SELECT DISTINCT idcomp, idart, cantidad
FROM envios 

-- (m) Seleccionar los nombres de los componentes que son suministrados en una cantidad
-- total superior a 500.

SELECT compnombre AS nombre_componente
FROM componentes
JOIN envios
ON componentes.idcomp = envios.idcomp
WHERE envios.cantidad > 500


--(n) Obtener los identificadores de artículos, id_art, para los que se ha suministrado algún
-- componente del que se haya suministrado una media superior a 420 artículos.

SELECT idart
FROM envios,(
              SELECT avg(cantidad) AS promedio
              FROM envios
             ) AS envio2
 WHERE envios.cantidad > envio2.promedio AND envios.cantidad > 420






















