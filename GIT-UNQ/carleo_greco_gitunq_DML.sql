DML 

-Creación de las Querys 

--Ejercicio 1 

SELECT repositorio.nombre, repositorio.usuario, repositorio.tipo_repositorio
FROM usuario
NATURAL JOIN repositorio
NATURAL JOIN commit
NATURAL JOIN contribucion
WHERE usuario.ciudad = 'Quilmes'
GROUP BY repositorio.nombre, repositorio.usuario, repositorio.tipo_repositorio
HAVING count(commit.id_archivo) >= 6
ORDER BY repositorio.cantidad_pull_request ASC;

--Ejercicio 2 

SELECT hash, id_archivo, titulo, descripcion, fecha_cambio
FROM commit 
WHERE fecha_cambio > '2021-10-01'
ORDER BY hash DESC, id_archivo ASC, fecha_cambio DESC;

--Ejercicio 3 

SELECT *
FROM repositorio
NATURAL JOIN usuario
NATURAL JOIN contribucion 
WHERE usuario.ciudad = 'Solano' AND usuario.fecha_nacimiento  BETWEEN '2001-01-01' AND '2004-12-31'

EXCEPT

SELECT *
FROM repositorio
NATURAL JOIN usuario
NATURAL JOIN contribucion 
WHERE usuario.ciudad != 'Solano' AND usuario.fecha_nacimiento  < '2001-01-01' AND usuario.fecha_nacimiento > '2004-12-31';

--Ejercicio 4 

SELECT nombre, repositorio.usuario, avg(cantidad_de_contribuciones) AS promedio_contribuciones
FROM repositorio
JOIN archivo
NATURAL JOIN (SELECT id, usuario, count(usuario) AS cantidad_de_contribuciones
              FROM archivo
              JOIN (SELECT *
                    FROM commit
                    NATURAL JOIN usuario
                    NATURAL JOIN contribucion
                    WHERE usuario.ciudad IN ('Quilmes', 'Varela')) AS contribuciones_de_usuarios
              ON id = id_archivo
              GROUP BY id, usuario) AS joins
ON repositorio.usuario = usuario_repositorio AND nombre = nombre_repositorio
GROUP BY nombre, repositorio.usuario;

--Ejercicio 5 

SELECT id, usuario_repositorio, count(commit) AS usuarios_commiteados
FROM archivo
JOIN commit
ON commit.id_archivo = archivo.id
GROUP BY id, usuario_repositorio
ORDER BY id, usuario_repositorio;

--Ejercicio 6 

SELECT usuario.usuario, sum(cantidad_de_contribuciones) AS suma_contribuciones, avg(cantidad_cambios) AS promedio_cantidad_cambios 
FROM usuario
NATURAL JOIN contribucion
NATURAL JOIN (SELECT id, usuario, count(usuario) AS cantidad_de_contribuciones
              FROM archivo
              JOIN (SELECT *
                    FROM commit
                    NATURAL JOIN usuario
                    NATURAL JOIN contribucion) AS contribuciones_de_usuarios
              ON id = id_archivo
              GROUP BY id, usuario) AS joins
GROUP BY usuario.usuario
ORDER BY usuario DESC;

--Ejercicio 7

SELECT id, nombre_repositorio, usuario_repositorio
FROM archivo
NATURAL JOIN (SELECT usuario, count(usuario) AS cantidad_contribuciones
              FROM repositorio
              NATURAL JOIN usuario
		  GROUP BY usuario) AS cantidad_total_contribuciones
JOIN usuario ON usuario.usuario = usuario_repositorio
GROUP BY id, nombre_repositorio, usuario_repositorio
HAVING count(cantidad_contribuciones) = 0 OR count(cantidad_contribuciones) >= 3

--Ejercicio 8 

SELECT usuario.ciudad, count(repositorio) AS cant_repositorio
FROM repositorio
JOIN (SELECT usuario, count(usuario) AS cantidad_contribuciones
              FROM repositorio
              NATURAL JOIN usuario
		  GROUP BY usuario) AS cantidad_total_contribuciones
ON repositorio.usuario = cantidad_total_contribuciones.usuario
JOIN usuario
ON usuario.usuario = repositorio.usuario
WHERE contrasenia LIKE '%#%'
GROUP BY usuario.ciudad, usuario.contrasenia
HAVING length(contrasenia) > 32 AND count(cantidad_contribuciones) > 10;

--Ejercicio 9

SELECT DISTINCT id, usuario_repositorio
FROM usuario
NATURAL JOIN commit
JOIN archivo
ON id = id_archivo
JOIN repositorio
ON archivo.usuario_repositorio = repositorio.usuario AND archivo.nombre_repositorio = repositorio.nombre
JOIN (SELECT repositorio.nombre, repositorio.usuario, count(repositorio) AS cantidad_repositorio_usuario
      FROM repositorio
      JOIN usuario
      ON usuario.usuario = repositorio.usuario
      GROUP BY repositorio.nombre, repositorio.usuario) AS repositorios_usuario
ON usuario.usuario = repositorio.usuario
WHERE ((usuario.cantidad_pull_request) > 6 OR (cantidad_repositorio_usuario) < 3) AND (fecha_cambio BETWEEN '2021-01-01' AND '2021-12-31')
LIMIT 3;

--Ejercicio 10

SELECT repositorio.nombre, EXTRACT(YEAR FROM age(usuario.fecha_nacimiento)) AS edad, count(usuario.fecha_nacimiento) AS cantidad_edades
FROM repositorio
JOIN(
  SELECT repositorio.nombre
  FROM usuario
  JOIN contribucion
  ON contribucion.usuario = usuario.usuario
  JOIN commit
  ON commit.hash = contribucion.hash
  JOIN archivo
  ON archivo.id = commit.id_archivo
  JOIN repositorio
  ON repositorio.nombre = archivo.nombre_repositorio
  WHERE EXTRACT(YEAR FROM age(usuario.fecha_nacimiento)) < 21
  GROUP BY repositorio.nombre, EXTRACT(YEAR FROM age(usuario.fecha_nacimiento))

  EXCEPT

  SELECT repositorio.nombre
  FROM usuario
  JOIN contribucion
  ON contribucion.usuario = usuario.usuario
  JOIN commit
  ON commit.hash = contribucion.hash
  JOIN archivo
  ON archivo.id = commit.id_archivo
  JOIN repositorio
  ON repositorio.nombre = archivo.nombre_repositorio
  WHERE EXTRACT(YEAR FROM age(usuario.fecha_nacimiento)) >= 21
  GROUP BY repositorio.nombre, EXTRACT(YEAR FROM age(usuario.fecha_nacimiento))) AS family_friendlies_repos
ON repositorio.nombre = family_friendlies_repos.nombre
JOIN archivo
ON archivo.nombre_repositorio = family_friendlies_repos.nombre
JOIN commit
ON commit.id_archivo = archivo.id
JOIN contribucion
ON contribucion.hash = commit.hash
JOIN usuario
ON usuario.usuario = contribucion.usuario
GROUP BY repositorio.nombre, EXTRACT(YEAR FROM age(usuario.fecha_nacimiento));

--Ejercicio 11

SELECT *
FROM usuario
NATURAL JOIN (SELECT contribucion.usuario, count(contribucion.usuario) AS commits_totales
            FROM contribucion
            GROUP BY contribucion.usuario) AS commits_usuarios
JOIN (SELECT avg(commits_totales) AS commits_promedios
      FROM (SELECT contribucion.usuario, count(contribucion.usuario) AS commits_totales
            FROM contribucion
            GROUP BY contribucion.usuario) AS commits_totales_usuario
     		) AS commits_promedios_usuario
ON commits_totales > commits_promedios
ORDER BY usuario.nyap, usuario.ciudad asc, commits_totales desc;

--Ejercicio 12

SELECT repositorio.nombre, repositorio.usuario, MAX(contribucion.cantidad_cambios) AS cantidad
FROM repositorio
NATURAL JOIN contribucion
GROUP BY repositorio.nombre, repositorio.usuario;

--Ejercicio 13 

CREATE INDEX idx_commit
ON commit(id_archivo, fecha_cambio);

--Ejercicio 15

ALTER TABLE usuario
ADD CONSTRAINT uc_usuario UNIQUE (correo, ciudad);
