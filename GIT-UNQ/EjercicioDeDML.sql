--1 

SELECT usuario.nyap, usuario.usuario, repositorio.tipo_repositorio
FROM usuario
JOIN repositorio
ON repositorio.usuario = usuario.usuario
JOIN contribucion
ON contribucion.usuario = usuario.usuario
WHERE usuario.ciudad = 'Quilmes' AND contribucion.cantidad_cambios > 6
ORDER BY repositorio.cantidad_pull_request
 
 -- 2

 SELECT * 
 FROM commite 
 WHERE fecha_cambio > '1/10/2021'
 ORDER BY hashe DESC, id_archivo ASC, fecha_cambio DESC;

 -- 3  
-- Obtener los repositorios que solo poseen contribuciones de usuarios de Solano y con edad entre 18 y 21
-- (deben cumplirse ambas condiciones).

SELECT * 
FROM repositorio
JOIN usuario
ON usuario.usuario = repositorio.usuario
JOIN contribucion
ON contribucion.usuario = usuario.usuario
WHERE usuario.ciudad = 'Solano' AND 
((2022 - (EXTRACT(year from (DATE(fecha_nacimiento))))) >= 18 OR 
(2022 - (EXTRACT(year from (DATE(fecha_nacimiento))))) <= 21)

-- 4. Obtener un listado que muestre de cada repositorio, el promedio de contribuciones de usuarios de Quilmes
-- y de Varela.

SELECT repositorio.nombre, ROUND(AVG(cantidad_cambios),2) AS promedio_contribuciones
FROM repositorio
JOIN usuario
ON usuario.usuario = repositorio.usuario
JOIN contribucion
ON contribucion.usuario = usuario.usuario
WHERE usuario.ciudad = 'Quilmes'
GROUP BY repositorio.nombre

UNION

SELECT repositorio.nombre, ROUND(AVG(cantidad_cambios),2) AS promedio_contribuciones
FROM repositorio
JOIN usuario
ON usuario.usuario = repositorio.usuario
JOIN contribucion
ON contribucion.usuario = usuario.usuario
WHERE usuario.ciudad = 'Varela'
GROUP BY repositorio.nombre;

-- 5. Obtener un listado que muestre de cada archivo, el usuario que más commiteó en el mismo junto con la
-- ciudad cantidad de commits. -- ¿Consulta Como muestro al usuario que mas comiteo de cada archivo? Ya lo hace la consulta?

SELECT archivo.*, usuario.ciudad, MAX(cantidad_cambios) AS maximos_cambios
FROM archivo 
JOIN commite 
ON commite.id_archivo = archivo.id 
NATURAL JOIN contribucion
NATURAL JOIN usuario
GROUP BY archivo.id, usuario.ciudad

-- 6. Obtener un listado de las últimas actividades. Que son, por usuario, la suma de contribuciones que hizo y
--el promedio de la cantidad de cambios, ordenados descendentemente por estas últimas dos.

SELECT usuario, sum(cantidad_cambios + cantidad_pull_request) AS contribucionesTotales, ROUND(AVG(cantidad_cambios),2)
FROM usuario 
NATURAL JOIN contribucion
GROUP BY usuario