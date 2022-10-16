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