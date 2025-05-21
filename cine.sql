--
--	Proyecto PRG - Proyecto Web con Acceso a Datos (BD y Ficheros)
--	Autores: Néstor, Óscar, Ángel y David
--

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--	Crear base de datos `cine`

CREATE DATABASE IF NOT EXISTS `cine` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `cine`;

--	Estructura de tabla para la tabla `pelicula`
--	`duracion` en minutos
--	Recomendación para el url de imagen que sea de la página de filmaffinity
--	Para tablas pelicula y sala: estado alta(V), baja (F)

CREATE TABLE IF NOT EXISTS `pelicula` (
	`ID_pelicula` VARCHAR(20) PRIMARY KEY,
	`titulo` VARCHAR(150) NOT NULL,
	`genero` VARCHAR(50) NOT NULL,
	`duracion` INT NOT NULL,
	`año` INT NOT NULL, 
	`clasificacion` VARCHAR(20) NOT NULL,
	`url` VARCHAR(255) NOT NULL,
	`estado_pelicula` BOOLEAN NOT NULL
);

INSERT INTO `pelicula` (`ID_pelicula`, `titulo`, `genero`, `duracion`, `año`, `clasificacion`, `url`,`estado_pelicula`) VALUES
('P001', 'Thunderbolts*', 'Acción', 120, 2025, 'R', 'https://pics.filmaffinity.com/thunderbolts-198046674-mmed.jpg', TRUE),
('P002', 'Una película de Minecraft', 'Comedia', 90, 2025, 'G', 'https://pics.filmaffinity.com/a_minecraft_movie-227832687-mmed.jpg', TRUE),
('P003', 'Until Dawn', 'Terror', 100, 2025, 'R', 'https://pics.filmaffinity.com/until_dawn-880447124-mmed.jpg', TRUE),
('P004', 'El Contable 2', 'Acción', 110, 2025, 'PG-13', 'https://pics.filmaffinity.com/the_accountant_2-296563604-mmed.jpg', TRUE),
('P005', 'Un funeral de locos', 'Comedia', 95, 2025, 'PG', 'https://pics.filmaffinity.com/un_funeral_de_locos-332020688-mmed.jpg', TRUE),
('P006', 'Los pecadores', 'Terror', 105, 2025, 'NC-17', 'https://pics.filmaffinity.com/sinners-306242848-mmed.jpg', TRUE),
('P007', 'El casoplón', 'Comedia', 110, 2025, 'G', 'https://pics.filmaffinity.com/el_casoplon-993095418-mmed.jpg',TRUE),
('P008', 'Amateur', 'Thriller', 110, 2025, 'PG-13', 'https://pics.filmaffinity.com/the_amateur-864303328-mmed.jpg', TRUE);

-- Estructura de tabla para la tabla `sala`

CREATE TABLE IF NOT EXISTS `sala` (
	`ID_sala` VARCHAR(20) PRIMARY KEY,
	`nombre` VARCHAR(50) NOT NULL,
	`numeroAsientos` INT NOT NULL,
	`personaConMovilidadReducida` BOOLEAN NOT NULL,
	`estado_sala` BOOLEAN NOT NULL
);

INSERT INTO `sala` (`ID_sala`, `nombre`, `numeroAsientos`, `personaConMovilidadReducida`, `estado_sala`) VALUES
('SA001', 'Sala 1', 200, TRUE, TRUE),
('SA002', 'Sala 2', 150, FALSE, TRUE),
('SA003', 'Sala 3', 300, TRUE, TRUE),
('SA004', 'Sala 4', 100, FALSE, TRUE),
('SA005', 'Sala 5', 250, TRUE, TRUE);

-- Estructura de tabla para la tabla `sesion`

CREATE TABLE IF NOT EXISTS `sesion` (
	`ID_sesion` VARCHAR(20) PRIMARY KEY,
	`ID_pelicula` VARCHAR(20) NOT NULL,
	`ID_sala` VARCHAR(20) NOT NULL,
	`Fecha_Hora` DATETIME NOT NULL,
	FOREIGN KEY (`ID_pelicula`) REFERENCES `pelicula`(`ID_pelicula`) ON DELETE CASCADE,
	FOREIGN KEY (`ID_sala`) REFERENCES `sala`(`ID_sala`) ON DELETE CASCADE
);

INSERT INTO `sesion` (`ID_sesion`, `ID_pelicula`, `ID_sala`, `Fecha_Hora`) VALUES
('SE001', 'P001', 'SA001', '2025-05-01 16:00:00'),
('SE002', 'P002', 'SA002', '2025-05-01 19:00:00'),
('SE003', 'P003', 'SA003', '2025-05-01 22:00:00'),
('SE004', 'P004', 'SA004', '2025-05-02 16:00:00'),
('SE005', 'P005', 'SA005', '2025-05-02 19:00:00'),
('SE006', 'P006', 'SA001', '2025-05-03 16:00:00'),
('SE007', 'P007', 'SA002', '2025-05-03 19:00:00');

-- Estructura de tabla para la tabla `usuarios`
-- Dicha tabla servirá para saber que usuarios pueden logear en la página web

CREATE TABLE IF NOT EXISTS `usuarios` (
	`username` VARCHAR(50) NOT NULL UNIQUE,
	`password` VARCHAR(50) NOT NULL
);

INSERT INTO `usuarios` (`username`, `password`) VALUES

('admin', 'admin123'),
('user', 'user123'),
('david', 'david123'),
('nestor', 'nestor123'),
('angel', 'angel123'),
('oscar', 'oscar123');
