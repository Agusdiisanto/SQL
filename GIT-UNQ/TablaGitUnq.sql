CREATE TABLE usuario(
    usuario VARCHAR(16) PRIMARY KEY,
    correo VARCHAR(50) DEFAULT 'ejemplopepe@gmail.com',
    fecha_nacimiento DATE CHECK (fecha_nacimiento <= '2015/12/12'), 
    ciudad VARCHAR(40) DEFAULT 'Quilmes',
    nyap VARCHAR(30),
    contrasenia VARCHAR(200),
    cantidad_pull_request INT DEFAULT 0
);

CREATE TABLE repositorio(
    nombre VARCHAR(20) PRIMARY KEY,
    usuario VARCHAR(16),
    tipo_repositorio VARCHAR(12) CHECK (tipo_repositorio = 'informativo' 
                                        OR tipo_repositorio = 'empresarial' 
                                        OR tipo_repositorio = 'educacional' 
                                        OR tipo_repositorio = 'comercial'),
    cantidad_favoritos INT DEFAULT 0, 
    cantidad_pull_request INT DEFAULT 0,
    FOREIGN KEY (usuario) REFERENCES usuario(usuario)
);

CREATE TABLE archivo(
    id SERIAL PRIMARY KEY, 
    nombre_repositorio VARCHAR(20),
    usuario_repositorio VARCHAR(16),
    contenido VARCHAR(255),
    FOREIGN KEY (usuario_repositorio) REFERENCES usuario(usuario),
    FOREIGN KEY (nombre_repositorio) REFERENCES repositorio(nombre)
);

CREATE TABLE commite(
    hashe VARCHAR(40) PRIMARY KEY,
    id_archivo INT DEFAULT 0,
    titulo VARCHAR(30),
    descripcion VARCHAR(200),
    fecha_cambio DATE DEFAULT '2022/10/15',
    FOREIGN KEY (id_archivo) REFERENCES archivo(id) 
);

CREATE TABLE contribucion(
    hashe VARCHAR(40),
    usuario VARCHAR(16),
    cantidad_cambios INT,
    PRIMARY KEY (hashe,usuario),
    FOREIGN KEY (hashe) REFERENCES commite(hashe),
    FOREIGN KEY (usuario) REFERENCES usuario(usuario)
);

INSERT INTO usuario
(usuario,correo,fecha_nacimiento,ciudad,nyap,contrasenia,cantidad_pull_request)
VALUES
('agusdiisanto','Agusdisanto99@gmail.com','2002/11/3','Bernal','Agustin Di Santo', 'Mancedo2022',34),
('magicTowers','magiToweers99@hotmail.com','1989/08/30','Espeleta','Diego Torres', '1234567',5),
('juanManuel34','juanManuelSanchez10@gmail.com','2001/10/23','Wilde','Juan Manuel Sanchez', 'Dolar',20),
('tomasCenturion2','feTomasCenturion2@hotmail.com','1999/09/12','Varela','Tomas Centurion', 'A34',10),
('abreguSantiago','santiagoAbregu@gmail.com','2000/07/15','Varela','Santiago Abregu', '21345',12),
('ezequielGonzales','ezequielGonzales@gmail.com','1999/12/23','Espeleta','Ezequiel Gonzales', 'MercadoLibrew234',4),
('ValeN212','valentin@gmail.com','1998/09/28','Quilmes','Valentin Ferreyra', 'unq12Po2',25),
('gabi','gabi20@gmail.com','1980/11/28','Quilmes','Gabi', 'Base',65),
('pepim','pepim203@gmail.com','1997/1/25','Solano','pepim','pepim123',21),
('solan','solan123@gmail.com','2012/03/12','Quilmes','Solan','solan213',32);

INSERT INTO repositorio
(nombre,usuario,tipo_repositorio,cantidad_favoritos,cantidad_pull_request)
VALUES
    ('TP-OBJ2', 'agusdiisanto', 'educacional', 123, 25),
    ('TP-SQL', 'agusdiisanto', 'informativo', 1, 4),
    ('TP-INTERFACES', 'juanManuel34', 'educacional', 40, 23),
    ('TP-PERSISTENCIA', 'juanManuel34', 'educacional', 2, 25),
    ('Estructuras', 'tomasCenturion2', 'educacional', 12, 23),
    ('MercadoLibre', 'ezequielGonzales', 'empresarial', 1, 22),
    ('AnalisisMatematico', 'abreguSantiago', 'informativo', 4, 8),
    ('OBJ2', 'magicTowers', 'educacional', 534, 54),
    ('Matematica2', 'ValeN212', 'educacional', 24, 12),
    ('Concurrente', 'pepim', 'educacional',30,5),
    ('BaseDeDatos', 'gabi', 'educacional', 782, 17);

INSERT INTO archivo
(id,nombre_repositorio,usuario_repositorio,contenido)
VALUES
    (58259, 'TP-OBJ2', 'agusdiisanto', 'Ejercicios'),
    (54608, 'Matematica2', 'ValeN212', 'Material teorico'),
    (78250, 'OBJ2', 'magicTowers', 'Trabajo practico'),
    (36587, 'TP-SQL', 'agusdiisanto', 'Material teorico'),
    (75480, 'BaseDeDatos', 'gabi', 'Ejercicios'),
    (98257, 'TP-PERSISTENCIA', 'juanManuel34', 'Practica'),
    (62581, 'Estructuras', 'tomasCenturion2', 'Ejercicios'),
    (62450, 'AnalisisMatematico', 'abreguSantiago', 'Ejercicios'),
    (54857, 'TP-INTERFACES', 'juanManuel34', 'Enunciados'),
    (21381, 'BaseDeDatos', 'gabi', 'Material teorico');

INSERT INTO archivo
(id,nombre_repositorio,usuario_repositorio,contenido)
VALUES
    (21314, 'TP-OBJ2', 'tomasCenturion2', 'Ejercicios'),
    (85180, 'TP-PERSISTENCIA', 'ValeN212', 'Practica'),
    (89054, 'Estructuras', 'agusdiisanto', 'Ejercicios');

INSERT INTO archivo
(id,nombre_repositorio,usuario_repositorio,contenido)
VALUES
    (68048, 'TP-OBJ2', 'abreguSantiago', 'Ejercicios'),
    (97051, 'Estructuras', 'abreguSantiago', 'Ejercicios');


INSERT INTO commite
(hashe,id_archivo,titulo,descripcion,fecha_cambio)
VALUES
    ('bsad2135291', 58259, 'Persistencia', 'ejercicios de java', '2022/10/15'),
    ('asdasn21349', 36587, 'SQL', 'ejercicios de java', '2022/9/23'),
    ('gdsa2138402', 68048, 'JAVA', 'ejercicios de java', '2022/10/14'),
    ('keiwq210485', 21314, 'TP-FINAL', 'TrabajoPractico de java', '2022/10/12'),
    ('toreqwjr124', 98257, 'Persistencia', 'ejercicios', '2022/10/2'),
    ('hwo393sywm9', 21381, 'SQL', 'ejercicios de sql', '2022/10/9'),
    ('jh29sa20456', 62581, 'Estructuras', 'ejercicios estructuras ', '2015/10/19'),
    ('sa29vmap28m', 89054, 'Estructuras', 'ejercicios estructuras ', '2015/02/28'),
    ('yqwn2mwo914', 97051, 'Estructuras', 'ejercicios estructuras', '2022/10/29'),
    ('oqitnaspo32', 54608, 'Mate', 'ejercicios estructuras', '2012/4/12'),
    ('asj294qwpv3', 62450, 'AnalisisMatematico', 'ejercicios Analisis', '2022/10/12');

INSERT INTO contribucion
(hashe,usuario,cantidad_cambios)
VALUES
    ('bsad2135291', 'juanManuel34', 12),
    ('asdasn21349', 'gabi',12),
    ('gdsa2138402', 'abreguSantiago', 2),
    ('keiwq210485', 'agusdiisanto', 25),
    ('toreqwjr124', 'tomasCenturion2', 8),
    ('hwo393sywm9', 'agusdiisanto', 5),
    ('jh29sa20456', 'pepim', 3),
    ('sa29vmap28m', 'pepim', 3),
    ('yqwn2mwo914', 'pepim', 3),
    ('oqitnaspo32', 'ValeN212', 34),
    ('asj294qwpv3','agusdiisanto',23);