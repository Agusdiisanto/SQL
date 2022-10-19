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
-- ciudad cantidad de commits.

SELECT archivo.*, usuario.ciudad, MAX(cantidad_cambios) AS maximos_cambios
FROM archivo 
JOIN commite 
ON commite.id_archivo = archivo.id 
NATURAL JOIN contribucion
NATURAL JOIN usuario
GROUP BY archivo.id, usuario.ciudad

-- 6. Obtener un listado de las últimas actividades. Que son, por usuario, la suma de contribuciones que hizo y
--el promedio de la cantidad de cambios, ordenados descendentemente por estas últimas dos.

SELECT usuario, sum(cantidad_cambios + cantidad_pull_request) AS contribuciones_Totales, ROUND(AVG(cantidad_cambios),2) AS promedio_cambios
FROM usuario 
NATURAL JOIN contribucion
GROUP BY usuario
ORDER BY contribuciones_Totales DESC, promedio_cambios DESC

-- 7. Obtener el nombre de usuario y el repositorio en donde el usuario sea el creador del repositorio pero no
-- haya hecho contribuciones, o haya hecho al menos tres.

SELECT DISTINCT usuario.nyap, repositorio.nombre 
FROM usuario 
JOIN repositorio 
ON repositorio.usuario = usuario.usuario
JOIN archivo 
ON archivo.nombre_repositorio = repositorio.nombre
JOIN commite 
ON commite.id_archivo != archivo.id

UNION 

SELECT DISTINCT usuario.nyap, repositorio.nombre 
FROM usuario 
JOIN repositorio 
ON repositorio.usuario = usuario.usuario
JOIN archivo 
ON archivo.nombre_repositorio = repositorio.nombre
JOIN commite 
ON commite.id_archivo = archivo.id
JOIN contribucion
ON contribucion.hashe = commite.hashe
WHERE cantidad_cambios >= 3


--8. Obtener la cantidad de repositorios superseguros por ciudad. Que son los que pertenecen a usuarios con
--contraseña que poseen al menos un ‘#’ numeral, más de 32 caracteres y el usuario hizo más de diez
--contribuciones, ordenados descendentemente por cantidad de favoritos.

SELECT t.usuario, t.ciudad, t.cantidad_de_repositorio, repositorio.cantidad_favoritos
FROM repositorio
JOIN (
        SELECT usuario.ciudad, usuario.usuario ,count(DISTINCT repositorio.nombre) AS cantidad_de_repositorio
        FROM usuario 
        NATURAL JOIN contribucion
        JOIN repositorio 
        ON repositorio.usuario = usuario.usuario
        WHERE ((LENGTH(contrasenia) >= 32) AND (contrasenia LIKE '%#%') AND (contribucion.cantidad_cambios > 10))
        GROUP BY usuario.ciudad, usuario.usuario
     ) AS t
ON repositorio.usuario = t.usuario
ORDER BY repositorio.cantidad_favoritos DESC 
    
    

--9. Obtener los tres archivos más modificados del 2021 por usuarios que hayan hecho más de 6 pull requests
--o que posean menos de tres repositorios (puede cumplirse una o ambas condiciones).


SELECT archivo.*
FROM archivo 
JOIN commite 
ON commite.id_archivo = archivo.id 
JOIN repositorio 
ON repositorio.nombre = archivo.nombre_repositorio
WHERE (fecha_cambio BETWEEN '2021/1/1' AND '2022/12/31') AND repositorio.cantidad_pull_request > 6;

UNION 

SELECT archivo.*
FROM archivo 
JOIN repositorio 
ON repositorio.nombre = archivo.nombre_repositorio AND archivo.usuario_repositorio = repositorio.usuario
GROUP BY archivo.id 
HAVING (count(nombre_repositorio) + count(usuario)) > 3;

-- 10. Obtener de los repositorios ‘family friendly’, el repositorio y la cantidad de contribuidores por edad. Son
-- los repositorios en los que la edad de todos los usuarios que contribuyeron en el mismo es menor a 21.

SELECT repositorio.nombre,usuario.usuario, count(contribucion.hashe) AS cantidad_de_contribuciones
FROM usuario
NATURAL JOIN contribucion
JOIN repositorio
ON repositorio.usuario = usuario.usuario
WHERE (2022 - (EXTRACT(year FROM (DATE(usuario.fecha_nacimiento))))) <= 21
GROUP BY repositorio.nombre,usuario.usuario
HAVING (count(usuario.usuario) = count(contribucion.hashe))


-- 11. Obtener los más activos. Que son los usuarios que realizaron más commits que el promedio, ordenados
-- ascendentemente por nyap y ciudad, y descendentemente por la cantidad de commits

SELECT usuario.nyap , usuario.ciudad , commits_promedio.cantidad_cambios
FROM usuario 
JOIN (
       SELECT contribucion.*, x.promedio_commits
       FROM contribucion,(
                     SELECT ROUND(avg(t.total_commits),2) AS promedio_commits 
                     FROM (
                            SELECT count(contribucion.usuario) AS total_commits
                            FROM contribucion 
                            ) AS t
                     ) x
       ) commits_promedio
ON usuario.usuario = commits_promedio.usuario 
WHERE commits_promedio.cantidad_cambios > commits_promedio.promedio_commits
ORDER BY usuario.nyap , usuario.ciudad , commits_promedio.cantidad_cambios DESC 


