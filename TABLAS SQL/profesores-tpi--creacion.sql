
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

INSERT INTO alumno
(legajo,apellido,nombre,aniodeingreso,trabaja)
VALUES
(20,'Di Santo','Agustin',2002,true),
(10,'Greco','Guido',2000,true),
(30,'Perez','Gasston',1980,false),
(40,'Messi','Lionel',1990,true),
(50,'Fernandez','Enzo',2002,false),
(60,'Guzman','Valentino',1998,true),
(80,'Di Salvo','Martin',1995,false),
(100,'Hernesto','Alex',1995,false),
(70,'Walter','Santiago',1995,false)
;

INSERT INTO profesor
(legajo_prof,cuil,apellido,nombre,marca,aniodeIngreso, polizaart,salario )
VALUES
(120, '20015123', 'Guillaume', 'Juan', 'Pepsi', 2000, 'D',1000 ),
(150, '20123524', 'Moyano', 'Tomas', 'Coca', 1980, 'A',2500 ),
(130, '20458760', 'Mosconi', 'Pablo', 'LG', 2002, 'B',1500 ),
(170, '25428060', 'Lopez', 'Bruno', 'Samsung', 1980, 'C',2700 ),
(160, '20543587', 'Gonzalez', 'Santiago', 'Coca', 2002, 'E',3000 )
;

INSERT INTO curso
(cod_curso,legajo_prof,cod_materia,dia,turno)
VALUES
('550555',120,'4510','Mar',1),
('550123',180,'4522','Lun',2),
('550182',150,'4578','Juv',4),
('550127',170,'6905','Vie',5),
('550327',130,'7825','Mar',0),
('550780',190,'3680','Lun',9),
('551203',120,'8204','Mar',10),
('550980',180,'9809','Mar',10)
;

INSERT INTO materia
(cod_materia,materia,semestre)
VALUES
('4510','BaseDeDatos',1),
('4578','Objetos1',1),
('8204','Funcional',1),
('4522','Intro',1),
('7825','Objetos3',1),
('9809','Orga',1),
('6905','BaseDeDatos',1)
;

INSERT INTO inscripto
(cod_curso,legajo)
VALUES
('550780',20),
('550123',50),
('550980',40),
('550327',30),
('550127',60),
('550182',70),
('550555',10),
('551203',100)
;

INSERT INTO puede_dar
(cod_materia,legajo_prof)
VALUES
('4510',150),
('4578',130),
('8204',170),
('4522',160),
('7825',190),
('1978',200),
('6905',120)
;

INSERT INTO profesor_trabaja_industria
(legajo_prof,sueldo)
VALUES
(150,15500),
(130,64000),
(170,85078),
(160,69825),
(190,36524),
(200,87592),
(120,14781)
;












