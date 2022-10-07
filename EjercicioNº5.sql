-- 1 

SELECT cod_curso, legajo, apellido, nombre 
FROM alumno
NATURAL JOIN inscripto
NATURAL JOIN curso
NATURAL JOIN materia
WHERE materia = 'BaseDeDatos' AND cod_curso = '2'

-- 2 

SELECT nombre,apellido,legajo_prof, avg(sueldo)
FROM profesor
NATURAL JOIN puede_dar
NATURAL JOIN materia
NATURAL JOIN profesor_trabaja_industria
WHERE materia = 'BaseDeDatos'
GROUP BY nombre,apellido,legajo_prof

-- 3 

SELECT legajo_prof, apellido, nombre, aniodeIngreso
FROM profesor
NATURAL JOIN puede_dar

EXCEPT

SELECT legajo_prof, apellido, nombre, aniodeIngreso
FROM profesor
NATURAL JOIN puede_dar
NATURAL JOIN materia
WHERE semestre = 1;

--4 

SELECT legajo_prof
FROM profesor

EXCEPT

SELECT legajo_prof
FROM profesor
NATURAL JOIN profesor_trabaja_industria

-- 5 

SELECT legajo_prof ,cod_materia, avg(salario) AS salario_promedio
FROM profesor
NATURAL JOIN puede_dar
GROUP BY cod_materia, legajo_prof