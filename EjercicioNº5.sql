-- 1 

SELECT cod_curso, legajo, apellido, nombre 
FROM alumno
NATURAL JOIN inscripto
NATURAL JOIN curso
NATURAL JOIN materia
WHERE materia = 'BaseDeDatos' AND cod_curso = '2'

UNION

SELECT cod_curso, legajo_prof AS legajo, apellido, nombre
FROM profesor
NATURAL JOIN curso
NATURAL JOIN materia
WHERE cod_curso = '2' AND materia = 'Bases de Datos';

-- 2 

SELECT legajo_prof, avg(sueldo + salario)
FROM profesor
NATURAL JOIN profesor_trabaja_industria
NATURAL JOIN puede_dar
NATURAL JOIN materia
JOIN curso 
ON profesor.legajo_prof = curso.legajo_prof
WHERE materia = 'Bases de datos'
GROUP BY legajo_prof


-- Otra forma 

SELECT AVG (sueldo + salario) as sueldo_prom
FROM profesor AS prof
JOIN curso AS cur ON prof.legajo_prof = cur.legajo_prof
JOIN profesor_trabaja_industria AS trab ON prof.legajo_prof=trab.legajo_prof
WHERE cur.cod_materia= 'Bases de Datos'


-- 3  Correcto

SELECT legajo_prof, apellido, nombre, aniodeIngreso
FROM profesor
NATURAL JOIN puede_dar

EXCEPT

SELECT legajo_prof, apellido, nombre, aniodeIngreso
FROM profesor
NATURAL JOIN puede_dar
NATURAL JOIN materia
WHERE semestre = 1;


--4  Correcto

SELECT legajo_prof
FROM profesor

EXCEPT

SELECT legajo_prof
FROM profesor
NATURAL JOIN profesor_trabaja_industria

-- 5 

SELECT cod_materia, avg(salario) AS salario_promedio
FROM profesor
NATURAL JOIN puede_dar
GROUP BY cod_materia


-- 
SELECT cod_materia, ROUND(AVG(salario),2) AS salario_prom
FROM profesor 
NATURAL JOIN curso 
NATURAL JOIN materia
GROUP BY cod_materia
ORDER BY cod_materia;