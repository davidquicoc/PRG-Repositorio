--
--	PRG - Proyecto Web con Acceso a Datos (BD y FIcheros)
--	Autores: Néstor, Óscar, Ángel y David
--

--	Importar sql en phpMyAdmin

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--	Crear base de datos `cine`

CREATE DATABASE IF NOT EXISTS `cine` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `cine`;

--	Estructura de tabla para la tabla `pelicula`
--	`duracion` en minutos
--	Dependiendo de la `clasificacion` se cambia el color
--		Rojo: R, NC-17
--		Amarillo: PG. PG-13
--		Verde: G

CREATE TABLE IF NOT EXISTS `pelicula` (
  `ID_pelicula` VARCHAR(5) PRIMARY KEY,
  `titulo` VARCHAR(150) NOT NULL,
  `genero` VARCHAR(50) NOT NULL,
  `duracion` INT NOT NULL,
  `clasificacion` ENUM('G', 'PG', 'PG-13', 'R', 'NC-17') NOT NULL
);

INSERT INTO `pelicula` (`ID_pelicula`, `titulo`, `genero`, `duracion`, `clasificacion`) VALUES
('P001', 'Thunderbolts*', 'Acción', 120, 'R'),
('P002', 'Una película de Minecraft', 'Comedia', 90, 'G'),
('P003', 'Until Dawn', 'Terror', 100, 'R'),
('P004', 'El Contable 2', 'Acción', 110, 'PG-13'),
('P005', 'Un funeral de locos', 'Comedia', 95, 'PG'),
('P006', 'Los Pecadores', 'Drama', 105, 'NC-17'),
('P007', 'El casoplón', 'Acción', 110, 'G'),
('P008', 'Amateur', 'Acción', 110, 'PG-13');

-- Estructura de tabla para la tabla `sala`

CREATE TABLE IF NOT EXISTS `sala` (
	`ID_sala` VARCHAR(5) PRIMARY KEY,
	`nombre` VARCHAR(50) NOT NULL,
	`numeroAsientos` INT NOT NULL,
	`plazasMinusvalido` BOOLEAN NOT NULL
);

INSERT INTO `sala` (`ID_sala`, `nombre`, `numeroAsientos`, `plazasMinusvalido`) VALUES
('SA001', 'Sala 1', 200, 1),
('SA002', 'Sala 2', 150, 0),
('SA003', 'Sala 3', 300, 1),
('SA004', 'Sala 4', 100, 0),
('SA005', 'Sala 5', 250, 1);

-- Estructura de tabla para la tabla `sesion`

CREATE TABLE IF NOT EXISTS `sesion` (
	`ID_sesion` VARCHAR(5) PRIMARY KEY,
	`ID_pelicula` VARCHAR(5) NOT NULL,
	`ID_sala` VARCHAR(5) NOT NULL,
	`Fecha_Hora` DATETIME NOT NULL,
	FOREIGN KEY (`ID_pelicula`) REFERENCES `pelicula`(`ID_pelicula`),
	FOREIGN KEY (`ID_sala`) REFERENCES `sala`(`ID_sala`)
);

INSERT INTO `sesion` (`ID_sesion`, `ID_pelicula`, `ID_sala`, `Fecha_Hora`) VALUES
('SE001', 'P001', 'SA001', '2024-05-01 16:00:00'),
('SE002', 'P002', 'SA002', '2024-05-01 19:00:00'),
('SE003', 'P003', 'SA003', '2024-05-01 22:00:00'),
('SE004', 'P004', 'SA004', '2024-05-02 16:00:00'),
('SE005', 'P005', 'SA005', '2024-05-02 19:00:00'),
('SE006', 'P006', 'SA001', '2024-05-03 16:00:00'),
('SE007', 'P007', 'SA002', '2024-05-03 19:00:00');



~/NetBeansProjects/Cine/web
