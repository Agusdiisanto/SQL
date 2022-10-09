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
