
-- creates

CREATE TABLE alumno(
	legajo int PRIMARY KEY,
	apellido varchar(30),
	nombre varchar(30),
	aniodeingreso int,
	trabaja boolean
);

CREATE TABLE profesor(
	legajo_prof int PRIMARY KEY,
	cuil varchar(30),
	apellido varchar(30),
	nombre varchar(30),
	marca varchar(20),
	aniodeIngreso int,
	polizaart varchar(30),
	salario int
);

CREATE TABLE curso(
	cod_curso varchar(6) PRIMARY KEY,
	legajo_prof int,
	cod_materia varchar(30),
	dia varchar(3),
	turno int
);

CREATE TABLE inscripto(
	cod_curso varchar(6) PRIMARY KEY,
	legajo int,
	FOREIGN KEY (legajo) REFERENCES alumno(legajo),
	FOREIGN KEY (cod_curso) REFERENCES curso(cod_curso)
);


CREATE TABLE materia(
	cod_materia varchar(15) PRIMARY KEY,
	materia varchar(150),
	semestre int
);

CREATE TABLE puede_dar(
	cod_materia varchar(15),
	legajo_prof int,
	PRIMARY KEY(cod_materia, legajo_prof)
);

CREATE TABLE profesor_trabaja_industria(
	legajo_prof int PRIMARY KEY,
	sueldo int
);

-- insert ----

#PARA ESTE EJERCICIO NO SE PROVEEN LOS DATOS DE PRUEBA.
