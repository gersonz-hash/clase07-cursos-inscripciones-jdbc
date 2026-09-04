-- Creamos la base de datos donde almacenaremos toda la información
-- correspondiente a la tarea 5. 
CREATE DATABASE IF NOT EXISTS tarea5_db;

-- Seleccionamos la base de datos para indicar que las siguientes
-- tablas y operaciones se realizarán dentro de ella.
USE tarea5_db;

-- Creamos la tabla estudiantes para almacenar la información 
-- de los estudiantes que forman parte de la base de datos.
-- El id es la clave primaria y el carnet es único para evitar
-- que dos estudiantes tengan el mismo número de identificación.

CREATE TABLE IF NOT EXISTS estudiantes (
id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(100) NOT NULL,
carnet VARCHAR(20) UNIQUE NOT NULL,
edad INT
);

-- Creamos la tabla cursos para almacenar
-- la información de los cursos.
-- El id es la clave primaria y el código identifica de forma única
-- cada curso.

CREATE TABLE IF NOT EXISTS cursos (
id INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR(100) NOT NULL,
codigo VARCHAR(20) UNIQUE NOT NULL,
creditos INT NOT NULL
);

-- Insertamos 5 estudiantes de la tabla estudiantes. 
-- Cada registro contiene nombre, carnet y edad.
-- Correspondiente de cada estudiante.

INSERT IGNORE INTO estudiantes (nombre, carnet, edad) VALUES
('Carlos Pérez', '20905-25-0001', 20),
('Alondra Marroquín', '0905-25-0002', 21),
('German Morales', '0905-25-0003', 19),
('Maria Gimenez', '0905-25-0004', 22),
('Gerson Zeceña', '0905-25-0005', 19);

-- Insertamos 5 cursos de la tabla cursos
-- Cada registro contiene nombre, codigo y creditos.

INSERT IGNORE INTO cursos (nombre, codigo, creditos) VALUES
('Programación I', 'PRO001', 5),
('Microeconomía', 'MIC002', 9),
('Física II', 'FIS013', 4),
('Cálculo II', 'CAL014', 2),
('Estadística', 'EST015', 5);

-- Agregamos los nuevos campos solicitados por el ingeniero.
-- activo: 1 significa activo y 0 significa inactivo.
-- tipo indica si el estudiante es de pregrado o posgrado.

-- Usamos la base de datos que vamos a alterar 
USE tarea5_db;

ALTER TABLE estudiantes
ADD activo TINYINT NOT NULL DEFAULT 1,
ADD TIPO ENUM('pregrado', 'posgrado') NOT NULL DEFAULT 'pregrado';

-- actualizamos los estudiantes existentes 
-- Indicando si están activos y su tipo
UPDATE estudiantes
SET activo =1, TIPO ='pregrado'
WHERE id =1;

UPDATE estudiantes
SET activo=0, TIPO ='posgrado'
WHERE id =2;

UPDATE estudiantes
SET activo=1, TIPO ='posgrado'
WHERE id=3;

UPDATE estudiantes 
SET activo=1, TIPO ='pregrado'
WHERE id=4;

UPDATE estudiantes
SET activo=1, TIPO ='posgrado'
WHERE id=5;

-- Insertamos un nuevo estudiante utilizando todos los campos solicitados.
-- activo = 1 indica que el estudiante está activo.
-- TIPO indica si pertenece a pregrado o posgrado.

INSERT IGNORE INTO estudiantes (nombre, carnet, edad, activo, TIPO)
VALUES('Luis López', '0905-25-0006', 20, 1, 'pregrado');

-- Mostramos los estudiantes que tienen 19 años que están activos.
-- activo =1 significa que el estudiante está activo. 
-- WHERE se utiliza para filtrar los registros que cumplen 
-- con la condición.

SELECT *
FROM estudiantes
WHERE edad =19
AND activo=1;

-- Comprobamos los datos actualizados de los estudiantes.
SELECT id, nombre, edad, activo, TIPO
FROM estudiantes;

-- Mostramos todos los estudiantes ordenados de mayor a menor edad
-- ORDER BY se utiliza para organizar los resultados según
-- la columna edad, usando DESC para mostrar primero las edades mayores.

SELECT *
FROM estudiantes
WHERE activo=1
ORDER BY edad DESC;

SELECT *
FROM estudiantes
WHERE activo=0;

-- Comprobamos que el nuevo estudiante fue almacenado correctamente.
SELECT *
FROM estudiantes;

SELECT COUNT(*) AS total_estudiantes
FROM estudiantes;

DESCRIBE estudiantes;

CREATE DATABASE IF NOT EXISTS tarea5_db;

USE tarea5_db;

CREATE TABLE IF NOT EXISTS libros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) NOT NULL UNIQUE
);

-- Cuidado: fecha_devolucion puede ser NULL. Un prestamo con fecha_devolucion
-- NULL significa "todavia esta prestado" (activo). Cuando el libro se
-- devuelve, se actualiza esa columna con la fecha real.
CREATE TABLE IF NOT EXISTS prestamos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    libro_id INT NOT NULL,
    nombre_estudiante VARCHAR(100) NOT NULL,
    fecha_prestamo DATE NOT NULL,
    fecha_devolucion DATE NULL,
    FOREIGN KEY (libro_id) REFERENCES libros(id)
);

INSERT IGNORE INTO libros (id, titulo, autor, isbn) VALUES
    (1, 'Cien anios de soledad', 'Gabriel Garcia Marquez', '978-0307474728'),
    (2, 'El principito', 'Antoine de Saint-Exupery', '978-0156012195'),
    (3, 'Clean Code', 'Robert C. Martin', '978-0132350884'),
    (4, 'Introduction to Algorithms', 'Cormen, Leiserson, Rivest, Stein', '978-0262033848'),
    (5, '1984', 'George Orwell', '978-0451524935');

-- Prestamos de ejemplo: el libro 3 tiene dos prestamos (uno ya devuelto, uno
-- activo); el libro 5 tiene un prestamo activo; los libros 1, 2 y 4 nunca se
-- han prestado (utiles para el reporte de "libros nunca prestados").
INSERT IGNORE INTO prestamos (id, libro_id, nombre_estudiante, fecha_prestamo, fecha_devolucion) VALUES
    (1, 3, 'Ana Lopez', '2026-08-01', '2026-08-10'),
    (2, 3, 'Carlos Perez', '2026-08-15', NULL),
    (3, 5, 'Maria Gonzalez', '2026-08-20', NULL);
    
SELECT p.id AS IDPrestamo,
       p.nombre_estudiante AS Estudiante,
       l.titulo AS Titulo,
       l.autor AS Autor,
       l.isbn,
       p.fecha_prestamo
FROM prestamos p, libros l
WHERE p.libro_id = l.id;

USE tarea5_db;

CREATE TABLE IF NOT EXISTS libros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS prestamos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    libro_id INT NOT NULL,
    nombre_estudiante VARCHAR(100) NOT NULL,
    fecha_prestamo DATE NOT NULL,
    fecha_devolucion DATE NULL,
    FOREIGN KEY (libro_id) REFERENCES libros(id)
);
INSERT IGNORE INTO libros (id, titulo, autor, isbn) VALUES
    (1, 'Cien anios de soledad', 'Gabriel Garcia Marquez', '978-0307474728'),
    (2, 'El principito', 'Antoine de Saint-Exupery', '978-0156012195'),
    (3, 'Clean Code', 'Robert C. Martin', '978-0132350884'),
    (4, 'Introduction to Algorithms', 'Cormen, Leiserson, Rivest, Stein', '978-0262033848'),
    (5, '1984', 'George Orwell', '978-0451524935');

INSERT IGNORE INTO prestamos (id, libro_id, nombre_estudiante, fecha_prestamo, fecha_devolucion) VALUES
    (1, 3, 'Ana Lopez', '2026-08-01', '2026-08-10'),
    (2, 3, 'Carlos Perez', '2026-08-15', NULL),
    (3, 5, 'Maria Gonzalez', '2026-08-20', NULL);

SELECT * FROM prestamos;
SELECT * FROM libros;

-- creando tabla de inscripciones 
CREATE TABLE IF NOT EXISTS inscripciones(
id INT AUTO_INCREMENT PRIMARY KEY,
estudiante_id INT NOT NULL,
curso_id INT NOT NULL,
nota DECIMAL(4,2)NULL,
 FOREIGN KEY (estudiante_id) REFERENCES estudiantes(id),
    FOREIGN KEY (curso_id) REFERENCES cursos(id),
    UNIQUE (estudiante_id, curso_id)
);

SELECT *FROM inscripciones;

-- Función para promediar en java con una lista 
SELECT AVG(i.nota) AS promedio
	FROM inscripciones i
	JOIN estudiantes e ON i.estudiante_id = e.id
	WHERE e.carnet = '0905-25-0004';
	
	-- Consulta el curso con más estudiantes inscritos
SELECT c.nombre, COUNT(*) AS total
	FROM inscripciones i
	JOIN cursos c ON i.curso_id = c.id
	GROUP BY c.nombre
	ORDER BY total DESC
	LIMIT 1



