-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 21-08-2025 a las 22:33:10
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `licea_completa`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia`
--

CREATE TABLE `asistencia` (
  `id_asistencia` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_curso` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `id_sesion` int(11) DEFAULT NULL,
  `estado` enum('Presente','Ausente','Justificada') NOT NULL,
  `observaciones` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistenteia`
--

CREATE TABLE `asistenteia` (
  `id_interaccion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `pregunta` text NOT NULL,
  `respuesta` text DEFAULT NULL,
  `feedback_usuario` text DEFAULT NULL,
  `categoria` enum('Academico','Cronograma','Motivacional','Otro') DEFAULT NULL,
  `estado` enum('Pendiente','Respondida') DEFAULT 'Pendiente',
  `fecha` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calificacion`
--

CREATE TABLE `calificacion` (
  `id_calificacion` int(11) NOT NULL,
  `id_entrega` int(11) NOT NULL,
  `nota` decimal(5,2) DEFAULT NULL CHECK (`nota` between 0 and 5),
  `retroalimentacion` text DEFAULT NULL,
  `fecha_calificacion` date DEFAULT NULL,
  `id_evaluador` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoriacurso`
--

CREATE TABLE `categoriacurso` (
  `id_categoria` int(11) NOT NULL,
  `nombre_categoria` varchar(50) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cronograma`
--

CREATE TABLE `cronograma` (
  `id_cronograma` int(11) NOT NULL,
  `id_curso` int(11) NOT NULL,
  `actividad` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `hora_inicio` time DEFAULT NULL,
  `hora_fin` time DEFAULT NULL,
  `tipo` enum('Taller','Clase','Evaluación','Otro') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `curso`
--

CREATE TABLE `curso` (
  `id_curso` int(11) NOT NULL,
  `nombre_curso` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `estado` enum('Activo','Inactivo') DEFAULT 'Activo',
  `id_usuario_docente` int(11) DEFAULT NULL,
  `id_categoria` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entrega`
--

CREATE TABLE `entrega` (
  `id_entrega` int(11) NOT NULL,
  `id_taller` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `archivo_url` varchar(255) NOT NULL,
  `observaciones` text DEFAULT NULL,
  `fecha_entrega` datetime NOT NULL,
  `estado` enum('Enviado','Atrasado','Revisado') DEFAULT 'Enviado',
  `notas_evaluador` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluacion`
--

CREATE TABLE `evaluacion` (
  `id_evaluacion` int(11) NOT NULL,
  `id_curso` int(11) NOT NULL,
  `titulo` varchar(100) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_aplicacion` date DEFAULT NULL,
  `duracion` int(11) DEFAULT NULL,
  `tipo` enum('Parcial','Final','Quiz','Otro') DEFAULT 'Quiz',
  `estado` enum('Pendiente','Publicado','Finalizado') DEFAULT 'Pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial`
--

CREATE TABLE `historial` (
  `id_historial` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `accion` varchar(100) DEFAULT NULL,
  `detalle` text DEFAULT NULL,
  `fecha_hora` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inscripcion`
--

CREATE TABLE `inscripcion` (
  `id_inscripcion` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_curso` int(11) NOT NULL,
  `fecha_inscripcion` date NOT NULL,
  `fecha_baja` date DEFAULT NULL,
  `estado` enum('Inscrito','Cancelado','Finalizado') DEFAULT 'Inscrito'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificacion`
--

CREATE TABLE `notificacion` (
  `id_notif` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `mensaje` text NOT NULL,
  `tipo` enum('Recordatorio','Alerta','Sistema') DEFAULT NULL,
  `prioridad` enum('Baja','Media','Alta') DEFAULT 'Media',
  `referencia_id` int(11) DEFAULT NULL,
  `leido` tinyint(1) DEFAULT 0,
  `fecha_envio` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `opcionrespuesta`
--

CREATE TABLE `opcionrespuesta` (
  `id_opcion` int(11) NOT NULL,
  `id_pregunta` int(11) NOT NULL,
  `texto_opcion` varchar(255) DEFAULT NULL,
  `es_correcta` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pregunta`
--

CREATE TABLE `pregunta` (
  `id_pregunta` int(11) NOT NULL,
  `id_evaluacion` int(11) NOT NULL,
  `enunciado` text NOT NULL,
  `tipo` enum('MultipleChoice','VerdaderoFalso','Abierta') DEFAULT 'Abierta'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `progreso`
--

CREATE TABLE `progreso` (
  `id_progreso` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_curso` int(11) NOT NULL,
  `porcentaje_avance` decimal(5,2) DEFAULT 0.00,
  `ultima_actualizacion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recurso`
--

CREATE TABLE `recurso` (
  `id_recurso` int(11) NOT NULL,
  `id_curso` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `tipo` enum('Documento','Video','Enlace','Otro') DEFAULT 'Documento',
  `url` varchar(255) NOT NULL,
  `fecha_subida` datetime DEFAULT current_timestamp(),
  `id_usuario_subio` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `id_rol` int(11) NOT NULL,
  `nombre_rol` varchar(50) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`id_rol`, `nombre_rol`, `descripcion`, `activo`) VALUES
(1, 'Estudiante', 'Rol por defecto para nuevos usuarios', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `taller`
--

CREATE TABLE `taller` (
  `id_taller` int(11) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha_asignacion` date NOT NULL,
  `fecha_entrega` date NOT NULL,
  `recursos_adicionales` text DEFAULT NULL,
  `tipo` enum('Individual','Grupal') DEFAULT 'Individual',
  `estado` enum('Pendiente','Entregado','Evaluado') DEFAULT 'Pendiente',
  `peso` decimal(5,2) DEFAULT 0.00,
  `id_curso` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(11) NOT NULL,
  `nombre_completo` varchar(100) NOT NULL,
  `correo` varchar(100) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `identificacion` varchar(255) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `genero` enum('Masculino','Femenino','Otro') DEFAULT NULL,
  `direccion` text DEFAULT NULL,
  `contraseña` varchar(255) NOT NULL,
  `avatar_url` varchar(255) DEFAULT NULL,
  `estado` enum('Activo','Inactivo') DEFAULT 'Activo',
  `fecha_creacion` datetime DEFAULT current_timestamp(),
  `ultima_sesion` datetime DEFAULT NULL,
  `id_rol` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `nombre_completo`, `correo`, `telefono`, `identificacion`, `fecha_nacimiento`, `genero`, `direccion`, `contraseña`, `avatar_url`, `estado`, `fecha_creacion`, `ultima_sesion`, `id_rol`) VALUES
(14, 'Andres Felipe', 'andres@example.com', NULL, '', NULL, NULL, NULL, '$2b$12$ttkV4KGaDZLc3MPVZcxwSuj7OBDxMeAn88wUEE4xgnMGKLqmw.SCe', NULL, 'Activo', '2025-08-21 14:45:00', NULL, NULL),
(20, 'pep', 'pepe@asdaw', NULL, NULL, NULL, NULL, NULL, '$2b$12$D12isHqoFFWFWBtYxozpYOLjGn.zUFZq7T7hOS7k4D4YGEEZZ5fES', NULL, 'Activo', '2025-08-21 15:06:42', NULL, NULL),
(32, 'AAAAAA', 'AAAAAAAA@AAAAAA', '333333333333333', '33333333333333', '2025-07-31', 'Masculino', 'DDDDDDDDDDD', '$2b$12$HnNj2NqlZiV6xklqEgtJ1ebVD8qoD2TC9HSZh.Cmr8NGXYbtihhca', 'DDDDDDDDDD', 'Activo', '2025-08-21 15:20:27', NULL, 1),
(33, 'dddddddd', 'ddddddddddddd@dd', 'd33333333', '33333333', '2025-08-01', 'Masculino', 'eeeeeeeee', '$2b$12$Eu.fLnlzxOT2e3bq3Tz5ZeREvRMHh3q4xw8aOqcVgrPRaneUPDn9a', 'eeeeeeeeeeeee', 'Activo', '2025-08-21 15:25:22', NULL, 1),
(34, 'MANOLO', 'MANOLOXD@ASD', '444444444', '44444444444', '2025-08-01', 'Masculino', '44444444444444', '$2b$12$e372lWuDFOUn/nCKAZ1Z/uQ0pItuaBZQMp3vcweB/FUXTqHrzfW7y', '444444444444', 'Activo', '2025-08-21 15:26:35', '2025-08-21 15:26:52', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asistencia`
--
ALTER TABLE `asistencia`
  ADD PRIMARY KEY (`id_asistencia`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_curso` (`id_curso`);

--
-- Indices de la tabla `asistenteia`
--
ALTER TABLE `asistenteia`
  ADD PRIMARY KEY (`id_interaccion`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `calificacion`
--
ALTER TABLE `calificacion`
  ADD PRIMARY KEY (`id_calificacion`),
  ADD KEY `id_entrega` (`id_entrega`),
  ADD KEY `id_evaluador` (`id_evaluador`);

--
-- Indices de la tabla `categoriacurso`
--
ALTER TABLE `categoriacurso`
  ADD PRIMARY KEY (`id_categoria`),
  ADD UNIQUE KEY `nombre_categoria` (`nombre_categoria`);

--
-- Indices de la tabla `cronograma`
--
ALTER TABLE `cronograma`
  ADD PRIMARY KEY (`id_cronograma`),
  ADD KEY `id_curso` (`id_curso`);

--
-- Indices de la tabla `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`id_curso`),
  ADD KEY `id_usuario_docente` (`id_usuario_docente`),
  ADD KEY `id_categoria` (`id_categoria`),
  ADD KEY `idx_curso_nombre` (`nombre_curso`);

--
-- Indices de la tabla `entrega`
--
ALTER TABLE `entrega`
  ADD PRIMARY KEY (`id_entrega`),
  ADD KEY `id_taller` (`id_taller`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `evaluacion`
--
ALTER TABLE `evaluacion`
  ADD PRIMARY KEY (`id_evaluacion`),
  ADD KEY `id_curso` (`id_curso`);

--
-- Indices de la tabla `historial`
--
ALTER TABLE `historial`
  ADD PRIMARY KEY (`id_historial`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `inscripcion`
--
ALTER TABLE `inscripcion`
  ADD PRIMARY KEY (`id_inscripcion`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_curso` (`id_curso`);

--
-- Indices de la tabla `notificacion`
--
ALTER TABLE `notificacion`
  ADD PRIMARY KEY (`id_notif`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `opcionrespuesta`
--
ALTER TABLE `opcionrespuesta`
  ADD PRIMARY KEY (`id_opcion`),
  ADD KEY `id_pregunta` (`id_pregunta`);

--
-- Indices de la tabla `pregunta`
--
ALTER TABLE `pregunta`
  ADD PRIMARY KEY (`id_pregunta`),
  ADD KEY `id_evaluacion` (`id_evaluacion`);

--
-- Indices de la tabla `progreso`
--
ALTER TABLE `progreso`
  ADD PRIMARY KEY (`id_progreso`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_curso` (`id_curso`);

--
-- Indices de la tabla `recurso`
--
ALTER TABLE `recurso`
  ADD PRIMARY KEY (`id_recurso`),
  ADD KEY `id_curso` (`id_curso`),
  ADD KEY `id_usuario_subio` (`id_usuario_subio`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`id_rol`),
  ADD UNIQUE KEY `nombre_rol` (`nombre_rol`);

--
-- Indices de la tabla `taller`
--
ALTER TABLE `taller`
  ADD PRIMARY KEY (`id_taller`),
  ADD KEY `id_curso` (`id_curso`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD UNIQUE KEY `identificacion` (`identificacion`),
  ADD UNIQUE KEY `identificacion_2` (`identificacion`),
  ADD KEY `id_rol` (`id_rol`),
  ADD KEY `idx_usuario_correo` (`correo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asistencia`
--
ALTER TABLE `asistencia`
  MODIFY `id_asistencia` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `asistenteia`
--
ALTER TABLE `asistenteia`
  MODIFY `id_interaccion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `calificacion`
--
ALTER TABLE `calificacion`
  MODIFY `id_calificacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `categoriacurso`
--
ALTER TABLE `categoriacurso`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cronograma`
--
ALTER TABLE `cronograma`
  MODIFY `id_cronograma` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `curso`
--
ALTER TABLE `curso`
  MODIFY `id_curso` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `entrega`
--
ALTER TABLE `entrega`
  MODIFY `id_entrega` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `evaluacion`
--
ALTER TABLE `evaluacion`
  MODIFY `id_evaluacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `historial`
--
ALTER TABLE `historial`
  MODIFY `id_historial` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inscripcion`
--
ALTER TABLE `inscripcion`
  MODIFY `id_inscripcion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notificacion`
--
ALTER TABLE `notificacion`
  MODIFY `id_notif` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `opcionrespuesta`
--
ALTER TABLE `opcionrespuesta`
  MODIFY `id_opcion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pregunta`
--
ALTER TABLE `pregunta`
  MODIFY `id_pregunta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `progreso`
--
ALTER TABLE `progreso`
  MODIFY `id_progreso` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `recurso`
--
ALTER TABLE `recurso`
  MODIFY `id_recurso` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `taller`
--
ALTER TABLE `taller`
  MODIFY `id_taller` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asistencia`
--
ALTER TABLE `asistencia`
  ADD CONSTRAINT `asistencia_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `asistencia_ibfk_2` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `asistenteia`
--
ALTER TABLE `asistenteia`
  ADD CONSTRAINT `asistenteia_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `calificacion`
--
ALTER TABLE `calificacion`
  ADD CONSTRAINT `calificacion_ibfk_1` FOREIGN KEY (`id_entrega`) REFERENCES `entrega` (`id_entrega`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `calificacion_ibfk_2` FOREIGN KEY (`id_evaluador`) REFERENCES `usuario` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `cronograma`
--
ALTER TABLE `cronograma`
  ADD CONSTRAINT `cronograma_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `curso`
--
ALTER TABLE `curso`
  ADD CONSTRAINT `curso_ibfk_1` FOREIGN KEY (`id_usuario_docente`) REFERENCES `usuario` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `curso_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `categoriacurso` (`id_categoria`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `entrega`
--
ALTER TABLE `entrega`
  ADD CONSTRAINT `entrega_ibfk_1` FOREIGN KEY (`id_taller`) REFERENCES `taller` (`id_taller`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `entrega_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `evaluacion`
--
ALTER TABLE `evaluacion`
  ADD CONSTRAINT `evaluacion_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `historial`
--
ALTER TABLE `historial`
  ADD CONSTRAINT `historial_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `inscripcion`
--
ALTER TABLE `inscripcion`
  ADD CONSTRAINT `inscripcion_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `inscripcion_ibfk_2` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `notificacion`
--
ALTER TABLE `notificacion`
  ADD CONSTRAINT `notificacion_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `opcionrespuesta`
--
ALTER TABLE `opcionrespuesta`
  ADD CONSTRAINT `opcionrespuesta_ibfk_1` FOREIGN KEY (`id_pregunta`) REFERENCES `pregunta` (`id_pregunta`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pregunta`
--
ALTER TABLE `pregunta`
  ADD CONSTRAINT `pregunta_ibfk_1` FOREIGN KEY (`id_evaluacion`) REFERENCES `evaluacion` (`id_evaluacion`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `progreso`
--
ALTER TABLE `progreso`
  ADD CONSTRAINT `progreso_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `progreso_ibfk_2` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `recurso`
--
ALTER TABLE `recurso`
  ADD CONSTRAINT `recurso_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `recurso_ibfk_2` FOREIGN KEY (`id_usuario_subio`) REFERENCES `usuario` (`id_usuario`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `taller`
--
ALTER TABLE `taller`
  ADD CONSTRAINT `taller_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id_rol`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
