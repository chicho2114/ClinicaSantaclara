-- phpMyAdmin SQL Dump
-- version 4.4.12
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-11-2015 a las 20:10:48
-- Versión del servidor: 5.6.25
-- Versión de PHP: 5.6.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `control`
--
CREATE DATABASE IF NOT EXISTS `control` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `control`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_bodega`
--

CREATE TABLE IF NOT EXISTS `t_bodega` (
  `tps_bodega_codigo` varchar(3) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Código de bodega',
  `ts_bodega_nombre` varchar(20) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Nombre de bodega',
  `ts_bodega_usuacrea` varchar(22) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Usuario de creación',
  `td_bodega_fechcrea` datetime NOT NULL COMMENT 'Fecha de creación'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci COMMENT='Bodegas de inventarios';

--
-- Volcado de datos para la tabla `t_bodega`
--

INSERT INTO `t_bodega` (`tps_bodega_codigo`, `ts_bodega_nombre`, `ts_bodega_usuacrea`, `td_bodega_fechcrea`) VALUES
('BO1', 'BODEGA PRINCIPAL', 'prueba', '2015-04-26 19:01:05'),
('BO2', 'BODEGA RECEPCION', 'prueba', '2015-04-26 20:33:28'),
('BO3', 'DEPOSITO AUXILIAR', 'prueba', '2015-05-16 10:58:36');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_categoria`
--

CREATE TABLE IF NOT EXISTS `t_categoria` (
  `tps_categoria_codigo` varchar(10) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Codigo de categoria',
  `ts_categoria_nombre` varchar(10) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Nombre de categoria',
  `ts_categoria_usuacrea` varchar(22) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Usuario de creación',
  `td_categoria_fechacrea` datetime NOT NULL COMMENT 'Fecha de creación'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `t_categoria`
--

INSERT INTO `t_categoria` (`tps_categoria_codigo`, `ts_categoria_nombre`, `ts_categoria_usuacrea`, `td_categoria_fechacrea`) VALUES
('PRO', 'PRO', 'prueba', '2015-11-29 12:37:29');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_consecutivo`
--

CREATE TABLE IF NOT EXISTS `t_consecutivo` (
  `tps_consecutivo_tabla` varchar(20) COLLATE utf8_spanish2_ci NOT NULL,
  `ti_consecutivo_siguiente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `t_consecutivo`
--

INSERT INTO `t_consecutivo` (`tps_consecutivo_tabla`, `ti_consecutivo_siguiente`) VALUES
('AJUSTEINVENTARIO', 28),
('AJUSTEPROVEEDOR', 23);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_costo_referencia`
--

CREATE TABLE IF NOT EXISTS `t_costo_referencia` (
  `tpfs_costrefe_referencia` varchar(10) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Referencia',
  `tpd_costrefe_fecha` date NOT NULL COMMENT 'Fecha de costo',
  `tdb_costrefe_costo` decimal(14,2) NOT NULL COMMENT 'Costo de referencia',
  `ts_costrefe_usuacrea` varchar(22) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Usuario de creación'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci COMMENT='Costo por referencia';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_fabricante`
--

CREATE TABLE IF NOT EXISTS `t_fabricante` (
  `tps_fabricante_codigo` varchar(10) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Codigo de fabricante',
  `ts_fabricante_nombre` varchar(10) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Nombre de fabricante',
  `ts_fabricante_usuacrea` varchar(22) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Usuario de creacion',
  `td_fabricante_fechacrea` datetime NOT NULL COMMENT 'Fecha de creacion'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `t_fabricante`
--

INSERT INTO `t_fabricante` (`tps_fabricante_codigo`, `ts_fabricante_nombre`, `ts_fabricante_usuacrea`, `td_fabricante_fechacrea`) VALUES
('BAY', 'BAYER', 'prueba', '2015-05-16 14:33:27'),
('GEN', 'GENVEN', 'prueba', '2015-05-16 14:39:09'),
('PRO', 'PRO', 'prueba', '2015-05-19 18:03:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_impuesto`
--

CREATE TABLE IF NOT EXISTS `t_impuesto` (
  `tdp_impuesto_fecha` datetime NOT NULL COMMENT 'Fecha de creación de impuesto',
  `tdb_impuesto_valor` decimal(14,2) NOT NULL COMMENT 'Valor del impuesto',
  `ts_impuesto_vigencia` char(1) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Vigencia del impuesto',
  `ts_impuesto_usuacrea` varchar(22) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Usuario de creación'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci COMMENT='Impuestos a la fecha';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_insumo`
--

CREATE TABLE IF NOT EXISTS `t_insumo` (
  `ts_insumo_codcaja` varchar(30) NOT NULL COMMENT 'Codigo de la caja',
  `ts_insumo_codref` varchar(10) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Codigo de referencia del insumo',
  `ts_insumo_proveedor` varchar(20) NOT NULL COMMENT 'Proveedor del insumo',
  `ts_insumo_fabricante` varchar(10) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Codigo del fabricante del insumo',
  `ts_insumo_bodega` varchar(3) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Bodega donde se guarda',
  `ti_insumo_cantinsumo` int(11) NOT NULL COMMENT 'Cantidad del insumo',
  `ts_insumo_preciocomp` varchar(255) NOT NULL COMMENT 'Precio de compra del insumo',
  `ts_insumo_preciovent` varchar(255) NOT NULL COMMENT 'Precio venta del insumo',
  `td_insumo_fechacomp` date NOT NULL COMMENT 'Fecha de compra del insumo',
  `td_insumo_fechavenc` date NOT NULL COMMENT 'Fecha de venta del insumo',
  `ts_insumo_usuacrea` varchar(255) NOT NULL COMMENT 'Usuario que crea el insumo',
  `td_insumo_fechacrea` datetime NOT NULL COMMENT 'Fecha de creacion del insumo',
  `ts_insumo_usuamodi` varchar(255) DEFAULT NULL COMMENT 'Usuario que modifica el insumo',
  `td_insumo_fechamodi` datetime DEFAULT NULL COMMENT 'Fecha en que se modifica el insumo'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `t_insumo`
--

INSERT INTO `t_insumo` (`ts_insumo_codcaja`, `ts_insumo_codref`, `ts_insumo_proveedor`, `ts_insumo_fabricante`, `ts_insumo_bodega`, `ti_insumo_cantinsumo`, `ts_insumo_preciocomp`, `ts_insumo_preciovent`, `td_insumo_fechacomp`, `td_insumo_fechavenc`, `ts_insumo_usuacrea`, `td_insumo_fechacrea`, `ts_insumo_usuamodi`, `td_insumo_fechamodi`) VALUES
('CAJA2', 'REFE1', 'PROV1', 'BAY', 'BO2', 200, '2000', '2500', '2015-11-29', '2016-11-16', 'prueba', '2015-11-29 12:40:55', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_inventario_bodega`
--

CREATE TABLE IF NOT EXISTS `t_inventario_bodega` (
  `tpfs_invebode_anomes` date NOT NULL COMMENT 'Año/mes de inventario',
  `tpfs_invebode_bodega` varchar(3) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Bodega',
  `tpfs_invebode_referencia` varchar(10) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Referencia',
  `ti_invebode_cantidad` int(11) NOT NULL COMMENT 'Cantidad actual en inventario',
  `tfs_invebode_usuacrea` varchar(22) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Usuario de creacion',
  `td_invebode_fechacrea` datetime NOT NULL COMMENT 'Fecha de creacion',
  `tfs_invebode_usuamodi` varchar(22) COLLATE utf8_spanish2_ci DEFAULT NULL COMMENT 'Usuario de modificacion',
  `td_invebode_fecha` datetime DEFAULT NULL COMMENT 'Fecha de modificacion'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci COMMENT='Inventarios';

--
-- Volcado de datos para la tabla `t_inventario_bodega`
--

INSERT INTO `t_inventario_bodega` (`tpfs_invebode_anomes`, `tpfs_invebode_bodega`, `tpfs_invebode_referencia`, `ti_invebode_cantidad`, `tfs_invebode_usuacrea`, `td_invebode_fechacrea`, `tfs_invebode_usuamodi`, `td_invebode_fecha`) VALUES
('2015-11-01', 'BO1', 'REF2', 0, 'prueba', '2015-11-29 12:59:39', NULL, NULL),
('2015-11-01', 'BO1', 'REFE1', 0, 'prueba', '2015-11-29 12:37:52', 'prueba', '2015-11-29 12:48:10'),
('2015-11-01', 'BO2', 'REF2', 0, 'prueba', '2015-11-29 12:59:39', NULL, NULL),
('2015-11-01', 'BO2', 'REFE1', 200, 'prueba', '2015-11-29 12:37:52', NULL, NULL),
('2015-11-01', 'BO3', 'REF2', 0, 'prueba', '2015-11-29 12:59:39', NULL, NULL),
('2015-11-01', 'BO3', 'REFE1', 0, 'prueba', '2015-11-29 12:37:52', NULL, NULL),
('2015-11-01', 'BO4', 'REF2', 0, 'prueba', '2015-11-29 12:59:39', NULL, NULL),
('2015-11-01', 'BO4', 'REFE1', 0, 'prueba', '2015-11-29 12:37:52', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_movimiento`
--

CREATE TABLE IF NOT EXISTS `t_movimiento` (
  `tpi_movimiento_id` int(11) NOT NULL COMMENT 'Id de movimiento',
  `tpd_movimiento_fecha` datetime NOT NULL COMMENT 'Fecha de movimiento',
  `tpfs_movimiento_referencia` varchar(10) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Referencia de movimiento',
  `ti_movimiento_cantidad` int(11) NOT NULL COMMENT 'Cantidad',
  `ts_movimiento_observacion` varchar(30) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Tipo de movmiento',
  `ts_movimiento_proceso` varchar(50) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Proceso que ejecuto el movimiento',
  `tfs_movimiento_usuacrea` varchar(22) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Usuario de creacion',
  `td_movimiento_fechacrea` datetime NOT NULL COMMENT 'Fecha de creacion'
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci COMMENT='Movimientos de referencias';

--
-- Volcado de datos para la tabla `t_movimiento`
--

INSERT INTO `t_movimiento` (`tpi_movimiento_id`, `tpd_movimiento_fecha`, `tpfs_movimiento_referencia`, `ti_movimiento_cantidad`, `ts_movimiento_observacion`, `ts_movimiento_proceso`, `tfs_movimiento_usuacrea`, `td_movimiento_fechacrea`) VALUES
(1, '2015-11-04 22:03:09', 'COODIGO', 5, 'AJUSTEINVENTARIO1', 'AJUSTEINVENTARIO', 'prueba', '2015-11-04 22:03:09'),
(2, '2015-11-18 21:37:02', 'PRUEBA', 14, 'AJUSTEINVENTARIO2', 'AJUSTEINVENTARIO', 'prueba', '2015-11-18 21:37:02'),
(3, '2015-11-18 21:40:54', 'PRUEBA', 10, 'AJUSTEINVENTARIO3', 'AJUSTEINVENTARIO', 'prueba', '2015-11-18 21:40:54'),
(4, '2015-11-18 21:41:19', 'PRUEBA', -20, 'AJUSTEINVENTARIO4', 'AJUSTEINVENTARIO', 'prueba', '2015-11-18 21:41:19'),
(5, '2015-11-18 21:41:55', 'PRUEBA', -90, 'AJUSTEINVENTARIO5', 'AJUSTEINVENTARIO', 'prueba', '2015-11-18 21:41:55'),
(6, '2015-11-20 14:17:39', 'REFE3', 101, 'AJUSTEINVENTARIO6', 'AJUSTEINVENTARIO', 'prueba', '2015-11-20 14:17:39'),
(7, '2015-11-20 23:39:13', 'REFE2', -9, 'AJUSTEINVENTARIO7', 'AJUSTEINVENTARIO', 'prueba', '2015-11-20 23:39:13'),
(8, '2015-11-20 23:46:22', 'REFE2', -2, 'AJUSTEINVENTARIO8', 'AJUSTEINVENTARIO', 'prueba', '2015-11-20 23:46:22'),
(9, '2015-11-24 02:05:22', 'PE', -300, 'AJUSTEINVENTARIO9', 'AJUSTEINVENTARIO', 'prueba', '2015-11-24 02:05:22'),
(10, '2015-11-24 02:09:08', 'PE', -300, 'AJUSTEINVENTARIO10', 'AJUSTEINVENTARIO', 'prueba', '2015-11-24 02:09:08'),
(11, '2015-11-24 02:21:34', 'PE', -300, 'AJUSTEINVENTARIO11', 'AJUSTEINVENTARIO', 'prueba', '2015-11-24 02:21:34'),
(12, '2015-11-24 02:33:40', 'PE', -300, 'AJUSTEINVENTARIO12', 'AJUSTEINVENTARIO', 'prueba', '2015-11-24 02:33:40'),
(13, '2015-11-24 02:39:22', 'PE', -300, 'AJUSTEINVENTARIO13', 'AJUSTEINVENTARIO', 'prueba', '2015-11-24 02:39:22'),
(16, '2015-11-24 14:31:07', 'refexcel2', -703988, 'AJUSTEINVENTARIO14', 'AJUSTEINVENTARIO', 'prueba', '2015-11-24 14:31:07'),
(17, '2015-11-24 16:01:23', 'PENEPENE', -1, 'AJUSTEPROVEEDOR0', 'AJUSTEPROVEEDOR', 'prueba', '2015-11-24 16:01:23'),
(18, '2015-11-24 16:03:42', 'PENEERECTO', -1, 'AJUSTEPROVEEDOR1', 'AJUSTEPROVEEDOR', 'prueba', '2015-11-24 16:03:42'),
(19, '2015-11-24 16:03:53', 'ENOERECTO', -1, 'AJUSTEPROVEEDOR2', 'AJUSTEPROVEEDOR', 'prueba', '2015-11-24 16:03:53'),
(20, '2015-11-24 17:22:14', 'REFE1', -5, 'AJUSTEINVENTARIO15', 'AJUSTEINVENTARIO', 'prueba', '2015-11-24 17:22:14'),
(21, '2015-11-24 17:24:19', 'REFE1', -5, 'AJUSTEINVENTARIO16', 'AJUSTEINVENTARIO', 'prueba', '2015-11-24 17:24:19'),
(22, '2015-11-24 18:14:34', 'REFE1', -5, 'AJUSTEINVENTARIO17', 'AJUSTEINVENTARIO', 'prueba', '2015-11-24 18:14:34'),
(24, '2015-11-24 18:47:56', 'REFE1', -10, 'AJUSTEINVENTARIO18', 'AJUSTEINVENTARIO', 'prueba', '2015-11-24 18:47:56'),
(25, '2015-11-24 18:58:11', 'REFE1', -10, 'AJUSTEINVENTARIO19', 'AJUSTEINVENTARIO', 'prueba', '2015-11-24 18:58:11'),
(26, '2015-11-24 18:59:06', 'REFE1', 10, 'AJUSTEINVENTARIO20', 'AJUSTEINVENTARIO', 'prueba', '2015-11-24 18:59:06'),
(27, '2015-11-24 21:56:21', 'FASFASF', 1, 'AJUSTEPROVEEDOR3', 'AJUSTEPROVEEDOR', 'prueba', '2015-11-24 21:56:21'),
(28, '2015-11-25 11:49:20', 'REFE1', 1000, 'AJUSTEINVENTARIO21', 'AJUSTEINVENTARIO', 'prueba', '2015-11-25 11:49:20'),
(29, '2015-11-25 12:04:39', 'REFE1', -100, 'AJUSTEINVENTARIO21', 'AJUSTEINVENTARIO', 'prueba', '2015-11-25 12:04:39'),
(30, '2015-11-25 12:06:12', 'REFE1', -90, 'AJUSTEINVENTARIO21', 'AJUSTEINVENTARIO', 'prueba', '2015-11-25 12:06:12'),
(31, '2015-11-25 12:13:24', 'PROV2', 1, 'AJUSTEPROVEEDOR3', 'AJUSTEPROVEEDOR', 'prueba', '2015-11-25 12:13:24'),
(32, '2015-11-25 12:13:38', 'PROV3', 1, 'AJUSTEPROVEEDOR3', 'AJUSTEPROVEEDOR', 'prueba', '2015-11-25 12:13:38'),
(33, '2015-11-25 12:13:48', 'PROV4', 1, 'AJUSTEPROVEEDOR3', 'AJUSTEPROVEEDOR', 'prueba', '2015-11-25 12:13:48'),
(34, '2015-11-25 12:13:56', 'PROV5', 1, 'AJUSTEPROVEEDOR3', 'AJUSTEPROVEEDOR', 'prueba', '2015-11-25 12:13:56'),
(35, '2015-11-25 12:14:04', 'PROV6', 1, 'AJUSTEPROVEEDOR3', 'AJUSTEPROVEEDOR', 'prueba', '2015-11-25 12:14:04'),
(36, '2015-11-25 12:14:13', 'PROV7', 1, 'AJUSTEPROVEEDOR3', 'AJUSTEPROVEEDOR', 'prueba', '2015-11-25 12:14:13'),
(37, '2015-11-25 12:14:22', 'PROV8', 1, 'AJUSTEPROVEEDOR3', 'AJUSTEPROVEEDOR', 'prueba', '2015-11-25 12:14:22'),
(38, '2015-11-25 12:14:29', 'PROV9', 1, 'AJUSTEPROVEEDOR3', 'AJUSTEPROVEEDOR', 'prueba', '2015-11-25 12:14:29'),
(39, '2015-11-25 12:15:04', 'PRO10', 1, 'AJUSTEPROVEEDOR3', 'AJUSTEPROVEEDOR', 'prueba', '2015-11-25 12:15:04'),
(40, '2015-11-25 14:32:24', 'REFE3', 30, 'AJUSTEINVENTARIO21', 'AJUSTEINVENTARIO', 'prueba', '2015-11-25 14:32:24'),
(41, '2015-11-25 14:35:57', 'REFE2', 600, 'AJUSTEINVENTARIO21', 'AJUSTEINVENTARIO', 'prueba', '2015-11-25 14:35:57'),
(42, '2015-11-25 14:36:40', 'BRAVOS', -1, 'AJUSTEPROVEEDOR3', 'AJUSTEPROVEEDOR', 'prueba', '2015-11-25 14:36:40'),
(43, '2015-11-25 14:53:42', 'REFE1', 5000, 'AJUSTEINVENTARIO21', 'AJUSTEINVENTARIO', 'prueba', '2015-11-25 14:53:42'),
(44, '2015-11-25 14:54:36', 'REFE1', -1000, 'AJUSTEINVENTARIO21', 'AJUSTEINVENTARIO', 'prueba', '2015-11-25 14:54:36'),
(45, '2015-11-27 13:29:08', 'REFE1', 200, 'AJUSTEINVENTARIO21', 'AJUSTEINVENTARIO', 'codigo3', '2015-11-27 13:29:08'),
(46, '2015-11-28 22:38:53', 'REFE1', -4000, 'AJUSTEINVENTARIO21', 'AJUSTEINVENTARIO', 'prueba', '2015-11-28 22:38:53'),
(47, '2015-11-28 22:39:49', 'REFE1', 6546545, 'AJUSTEINVENTARIO21', 'AJUSTEINVENTARIO', 'prueba', '2015-11-28 22:39:49'),
(48, '2015-11-28 23:00:55', 'LEONES', -1, 'AJUSTEPROVEEDOR4', 'AJUSTEPROVEEDOR', 'agarcia21', '2015-11-28 23:00:55'),
(49, '2015-11-28 23:01:11', 'CARIBES', -1, 'AJUSTEPROVEEDOR5', 'AJUSTEPROVEEDOR', 'agarcia21', '2015-11-28 23:01:11'),
(50, '2015-11-28 23:01:18', 'CJUHFH', -1, 'AJUSTEPROVEEDOR6', 'AJUSTEPROVEEDOR', 'agarcia21', '2015-11-28 23:01:18'),
(51, '2015-11-28 23:01:38', 'CODPROV1', -1, 'AJUSTEPROVEEDOR7', 'AJUSTEPROVEEDOR', 'agarcia21', '2015-11-28 23:01:38'),
(52, '2015-11-28 23:01:48', 'FASFASF', -1, 'AJUSTEPROVEEDOR8', 'AJUSTEPROVEEDOR', 'agarcia21', '2015-11-28 23:01:48'),
(53, '2015-11-28 23:01:55', 'MAGALLANES', -1, 'AJUSTEPROVEEDOR9', 'AJUSTEPROVEEDOR', 'agarcia21', '2015-11-28 23:01:55'),
(54, '2015-11-28 23:02:19', 'PENECASIER', -1, 'AJUSTEPROVEEDOR10', 'AJUSTEPROVEEDOR', 'agarcia21', '2015-11-28 23:02:19'),
(55, '2015-11-28 23:02:27', 'PRO10', -1, 'AJUSTEPROVEEDOR11', 'AJUSTEPROVEEDOR', 'agarcia21', '2015-11-28 23:02:27'),
(56, '2015-11-28 23:02:34', 'PROV2', -1, 'AJUSTEPROVEEDOR12', 'AJUSTEPROVEEDOR', 'agarcia21', '2015-11-28 23:02:34'),
(57, '2015-11-28 23:02:40', 'PROV3', -1, 'AJUSTEPROVEEDOR13', 'AJUSTEPROVEEDOR', 'agarcia21', '2015-11-28 23:02:40'),
(58, '2015-11-28 23:03:37', 'ZULIA', -1, 'AJUSTEPROVEEDOR14', 'AJUSTEPROVEEDOR', 'agarcia21', '2015-11-28 23:03:37'),
(59, '2015-11-28 23:03:44', 'TIBURONES', -1, 'AJUSTEPROVEEDOR15', 'AJUSTEPROVEEDOR', 'agarcia21', '2015-11-28 23:03:44'),
(60, '2015-11-28 23:04:10', 'PROVCOD', -1, 'AJUSTEPROVEEDOR16', 'AJUSTEPROVEEDOR', 'agarcia21', '2015-11-28 23:04:10'),
(61, '2015-11-28 23:04:18', 'PROV9', -1, 'AJUSTEPROVEEDOR17', 'AJUSTEPROVEEDOR', 'agarcia21', '2015-11-28 23:04:18'),
(62, '2015-11-28 23:04:25', 'PROV8', -1, 'AJUSTEPROVEEDOR18', 'AJUSTEPROVEEDOR', 'agarcia21', '2015-11-28 23:04:25'),
(63, '2015-11-28 23:04:31', 'PROV7', -1, 'AJUSTEPROVEEDOR19', 'AJUSTEPROVEEDOR', 'agarcia21', '2015-11-28 23:04:31'),
(64, '2015-11-28 23:04:39', 'PROV6', -1, 'AJUSTEPROVEEDOR20', 'AJUSTEPROVEEDOR', 'agarcia21', '2015-11-28 23:04:39'),
(65, '2015-11-28 23:04:45', 'PROV5', -1, 'AJUSTEPROVEEDOR21', 'AJUSTEPROVEEDOR', 'agarcia21', '2015-11-28 23:04:45'),
(66, '2015-11-28 23:05:13', 'PROV4', -1, 'AJUSTEPROVEEDOR22', 'AJUSTEPROVEEDOR', 'agarcia21', '2015-11-28 23:05:13'),
(67, '2015-11-28 23:27:41', 'REFE1', -1195, 'AJUSTEINVENTARIO21', 'AJUSTEINVENTARIO', 'prueba', '2015-11-28 23:27:41'),
(68, '2015-11-28 23:33:06', 'REFE1', 0, 'AJUSTEINVENTARIO22', 'AJUSTEINVENTARIO', 'agarcia21', '2015-11-28 23:33:06'),
(69, '2015-11-28 23:42:22', 'COD1', 0, 'AJUSTEINVENTARIO23', 'AJUSTEINVENTARIO', 'agarcia21', '2015-11-28 23:42:22'),
(70, '2015-11-28 23:54:38', 'COID1', 0, 'AJUSTEINVENTARIO24', 'AJUSTEINVENTARIO', 'agarcia21', '2015-11-28 23:54:38'),
(71, '2015-11-29 10:22:00', 'REFE2', 0, 'AJUSTEINVENTARIO25', 'AJUSTEINVENTARIO', 'prueba', '2015-11-29 10:22:00'),
(72, '2015-11-29 10:30:12', 'ASFASF', 0, 'AJUSTEINVENTARIO26', 'AJUSTEINVENTARIO', 'prueba', '2015-11-29 10:30:12'),
(73, '2015-11-29 10:37:14', 'REFE2', 0, 'AJUSTEINVENTARIO27', 'AJUSTEINVENTARIO', 'prueba', '2015-11-29 10:37:14'),
(74, '2015-11-29 12:39:53', 'PROV1', 1, 'AJUSTEPROVEEDOR23', 'AJUSTEPROVEEDOR', 'prueba', '2015-11-29 12:39:53'),
(75, '2015-11-29 12:40:15', 'REFE1', 100, 'AJUSTEINVENTARIO28', 'AJUSTEINVENTARIO', 'prueba', '2015-11-29 12:40:15'),
(76, '2015-11-29 12:40:54', 'REFE1', 200, 'AJUSTEINVENTARIO28', 'AJUSTEINVENTARIO', 'prueba', '2015-11-29 12:40:54'),
(77, '2015-11-29 12:48:09', 'REFE1', -50, 'AJUSTEINVENTARIO28', 'AJUSTEINVENTARIO', 'prueba', '2015-11-29 12:48:09'),
(78, '2015-11-29 12:48:38', 'REFE1', -50, 'AJUSTEINVENTARIO28', 'AJUSTEINVENTARIO', 'prueba', '2015-11-29 12:48:38');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_proveedor`
--

CREATE TABLE IF NOT EXISTS `t_proveedor` (
  `ts_proveedor_codigo` varchar(20) NOT NULL COMMENT 'Codigo del proveedor',
  `ts_proveedor_nombre` varchar(255) NOT NULL COMMENT 'Nombre del proveedor',
  `ts_proveedor_telefono` varchar(255) NOT NULL COMMENT 'Telefono del proveedor',
  `td_proveedor_fechacrea` datetime NOT NULL COMMENT 'Fecha de creacion',
  `ts_proveedor_usuacrea` varchar(50) NOT NULL COMMENT 'Usuario que crea el proveedor',
  `ts_proveedor_usuamodi` varchar(50) DEFAULT NULL COMMENT 'Usuario que modifica el proveedor',
  `td_proveedor_fechamodi` datetime DEFAULT NULL COMMENT 'Fecha en que fue modificado'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `t_proveedor`
--

INSERT INTO `t_proveedor` (`ts_proveedor_codigo`, `ts_proveedor_nombre`, `ts_proveedor_telefono`, `td_proveedor_fechacrea`, `ts_proveedor_usuacrea`, `ts_proveedor_usuamodi`, `td_proveedor_fechamodi`) VALUES
('PROV1', 'ARGENIS GARCIA', '04127849712', '2015-11-29 12:39:54', 'prueba', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_referencia`
--

CREATE TABLE IF NOT EXISTS `t_referencia` (
  `tps_referencia_codigo` varchar(10) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Código de referencia',
  `ts_referencia_descripcion` varchar(150) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Descripción de referencia',
  `ts_referencia_componente` varchar(30) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Componente activo de la referencia',
  `ts_referencia_presentacion` varchar(30) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Unidad de medida de la referencia',
  `tfi_referencia_fabricante` varchar(10) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Fabricante de la referencia',
  `tfi_referencia_categoria` varchar(10) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Categoría asociada a la referencia',
  `ts_referencia_observacion` varchar(200) COLLATE utf8_spanish2_ci DEFAULT NULL,
  `ti_referencia_cantmini` int(11) NOT NULL DEFAULT '0' COMMENT 'Cantidad minima permitida',
  `t_referencia_cantidad` int(11) NOT NULL DEFAULT '0' COMMENT 'Cantidad disponible del producto',
  `ts_referencia_usuacrea` varchar(22) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Usuario de creación',
  `td_referencia_fechacrea` datetime NOT NULL COMMENT 'Fecha de creación de referencia',
  `ts_referencia_usuamodi` varchar(22) COLLATE utf8_spanish2_ci DEFAULT NULL COMMENT 'Usuario de modificación',
  `td_referencia_fechamodi` datetime DEFAULT NULL COMMENT 'Fecha de modificación'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci COMMENT='Referencias en inventario';

--
-- Volcado de datos para la tabla `t_referencia`
--

INSERT INTO `t_referencia` (`tps_referencia_codigo`, `ts_referencia_descripcion`, `ts_referencia_componente`, `ts_referencia_presentacion`, `tfi_referencia_fabricante`, `tfi_referencia_categoria`, `ts_referencia_observacion`, `ti_referencia_cantmini`, `t_referencia_cantidad`, `ts_referencia_usuacrea`, `td_referencia_fechacrea`, `ts_referencia_usuamodi`, `td_referencia_fechamodi`) VALUES
('REF2', 'ASFSA', 'ASFASF', 'ASFAF', 'BAY', 'PRO', 'ASFASF', 2, 0, 'prueba', '2015-11-29 12:59:39', NULL, NULL),
('REFE1', 'ASASFA', 'ASFAFSa', 'SFASF', 'BAY', 'PRO', 'ASFAASF', 100, 200, 'prueba', '2015-11-29 12:37:52', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_rol`
--

CREATE TABLE IF NOT EXISTS `t_rol` (
  `tpi_rol_codigo` int(11) NOT NULL COMMENT 'Código de rol',
  `ts_rol_descripcion` varchar(20) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Descripción de rol'
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `t_rol`
--

INSERT INTO `t_rol` (`tpi_rol_codigo`, `ts_rol_descripcion`) VALUES
(1, 'ROLE_USUARIO'),
(2, 'ROLE_NOUSUARIO'),
(3, 'ROLE_ADMINISTRADOR');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_rol_usuario`
--

CREATE TABLE IF NOT EXISTS `t_rol_usuario` (
  `tpfi_rolusuario_codigo` int(11) NOT NULL COMMENT 'Código de rol',
  `tfs_rolusuario_usuario` varchar(22) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Usuario de rol'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `t_rol_usuario`
--

INSERT INTO `t_rol_usuario` (`tpfi_rolusuario_codigo`, `tfs_rolusuario_usuario`) VALUES
(3, 'agarcia21'),
(2, 'codigo2'),
(1, 'prueba'),
(3, 'user1'),
(2, 'venc');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_usuario`
--

CREATE TABLE IF NOT EXISTS `t_usuario` (
  `tps_usuario_codigo` varchar(22) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Código de usuario',
  `ts_usuario_contrasena` varchar(64) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Contraseña de usuario',
  `ts_usuario_cambcontra` varchar(1) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Cambio de contraseña',
  `td_usuario_ultcamcon` datetime DEFAULT NULL COMMENT 'Último cambio de contraseña',
  `ts_usuario_vigencia` varchar(1) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Vigencia de usuario',
  `ts_usuario_cedula` varchar(10) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Cédula de usuario',
  `ts_usuario_nombre` varchar(100) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Nombre de usuario',
  `ts_usuario_area` varchar(20) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Área de negocio ',
  `ts_usuario_cargo` varchar(20) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Cargo de usuario',
  `ts_usuario_usuacrea` varchar(22) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Usuario de creación',
  `td_usuario_fechacrea` datetime NOT NULL COMMENT 'Fecha de creación',
  `ts_usuario_usuamodi` varchar(22) COLLATE utf8_spanish2_ci DEFAULT NULL COMMENT 'Usuario de modificación',
  `td_usuario_fechamodi` datetime DEFAULT NULL COMMENT 'Fecha de modificación'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci COMMENT='Usuarios de la aplicación';

--
-- Volcado de datos para la tabla `t_usuario`
--

INSERT INTO `t_usuario` (`tps_usuario_codigo`, `ts_usuario_contrasena`, `ts_usuario_cambcontra`, `td_usuario_ultcamcon`, `ts_usuario_vigencia`, `ts_usuario_cedula`, `ts_usuario_nombre`, `ts_usuario_area`, `ts_usuario_cargo`, `ts_usuario_usuacrea`, `td_usuario_fechacrea`, `ts_usuario_usuamodi`, `td_usuario_fechamodi`) VALUES
('agarcia21', 'fdee8133235dcff7371c8ed76c8ebe581e80a23005e8e752cd9a9efced03cb7a', 'N', '2015-11-28 17:35:27', 'V', '21443181', 'ARGENIS GARCIA', 'Administracion', 'EMPRESARIO', 'prueba', '2015-11-27 12:34:19', 'prueba', '2015-11-28 18:46:34'),
('codigo2', 'f0b8a6fd052a1f30ae90404c2f689a71d4ed6d7186b5ad347773943f4e5328ae', 'N', '2015-11-28 18:51:31', 'V', '100000', 'Manuel Cardenas', 'Administracion', 'EMPRESARIO', 'prueba', '2015-11-28 18:51:31', 'codigo2', '2015-11-28 22:07:11'),
('prueba', 'cb6f42cbfc8a0ba32f32caded612f35edd0a09eb0b540495f34ceef52fa0eae4', 'N', '2015-10-17 20:13:00', 'V', '19772932', 'Luis Calatayud', 'Prueba', 'Prueba', 'Sistemas', '2014-11-01 00:00:00', NULL, NULL),
('user1', 'd2006b92732ec3ee76ef5d9c4880e2170ec15cf62358ebe4f2ac27ed0a016f58', 'N', '2015-11-29 13:58:13', 'V', '19000000', 'Genesis Garcia', 'Administracion', 'SECRETARIA', 'agarcia21', '2015-11-29 13:58:13', NULL, NULL),
('venc', 'aa3c5a0e6669117bdc376c9586c32cbb7ac00e158c5162ae3fb905fcc310b279', 'N', '2015-08-19 14:15:35', 'V', '123456789', 'Usuario Vencido', 'Administracion', 'EMPRESARIO', 'prueba', '2015-11-29 14:15:35', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_valor_referencia`
--

CREATE TABLE IF NOT EXISTS `t_valor_referencia` (
  `tpfs_valorefe_referencia` varchar(10) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Referencia',
  `tpd_valorefe_fecha` date NOT NULL COMMENT 'Fecha',
  `tdb_valorefe_valor` decimal(14,2) NOT NULL COMMENT 'Valor de la referencia',
  `ts_valorefe_usuacrea` varchar(22) COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Usuario de creación',
  `td_valorefe_fechcreacion` datetime NOT NULL COMMENT 'Fecha de creación'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci COMMENT='Valores de referencias';

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `t_bodega`
--
ALTER TABLE `t_bodega`
  ADD PRIMARY KEY (`tps_bodega_codigo`);

--
-- Indices de la tabla `t_categoria`
--
ALTER TABLE `t_categoria`
  ADD PRIMARY KEY (`tps_categoria_codigo`);

--
-- Indices de la tabla `t_consecutivo`
--
ALTER TABLE `t_consecutivo`
  ADD PRIMARY KEY (`tps_consecutivo_tabla`);

--
-- Indices de la tabla `t_costo_referencia`
--
ALTER TABLE `t_costo_referencia`
  ADD PRIMARY KEY (`tpfs_costrefe_referencia`,`tpd_costrefe_fecha`);

--
-- Indices de la tabla `t_fabricante`
--
ALTER TABLE `t_fabricante`
  ADD PRIMARY KEY (`tps_fabricante_codigo`);

--
-- Indices de la tabla `t_impuesto`
--
ALTER TABLE `t_impuesto`
  ADD PRIMARY KEY (`tdp_impuesto_fecha`);

--
-- Indices de la tabla `t_insumo`
--
ALTER TABLE `t_insumo`
  ADD PRIMARY KEY (`ts_insumo_codcaja`),
  ADD KEY `ts_insumo_codref` (`ts_insumo_codref`),
  ADD KEY `ts_insumo_proveedor` (`ts_insumo_proveedor`),
  ADD KEY `codigo_fabricante` (`ts_insumo_fabricante`),
  ADD KEY `t_insumo_bodega` (`ts_insumo_bodega`);

--
-- Indices de la tabla `t_inventario_bodega`
--
ALTER TABLE `t_inventario_bodega`
  ADD PRIMARY KEY (`tpfs_invebode_bodega`,`tpfs_invebode_referencia`),
  ADD KEY `tpfs_invebode_referencia` (`tpfs_invebode_referencia`);

--
-- Indices de la tabla `t_movimiento`
--
ALTER TABLE `t_movimiento`
  ADD PRIMARY KEY (`tpi_movimiento_id`,`tpd_movimiento_fecha`,`tpfs_movimiento_referencia`);

--
-- Indices de la tabla `t_proveedor`
--
ALTER TABLE `t_proveedor`
  ADD PRIMARY KEY (`ts_proveedor_codigo`);

--
-- Indices de la tabla `t_referencia`
--
ALTER TABLE `t_referencia`
  ADD PRIMARY KEY (`tps_referencia_codigo`),
  ADD KEY `tfi_referencia_categoria` (`tfi_referencia_categoria`),
  ADD KEY `tfi_referencia_fabricante` (`tfi_referencia_fabricante`),
  ADD KEY `tfi_referencia_categoria_2` (`tfi_referencia_categoria`);

--
-- Indices de la tabla `t_rol`
--
ALTER TABLE `t_rol`
  ADD PRIMARY KEY (`tpi_rol_codigo`);

--
-- Indices de la tabla `t_rol_usuario`
--
ALTER TABLE `t_rol_usuario`
  ADD PRIMARY KEY (`tpfi_rolusuario_codigo`,`tfs_rolusuario_usuario`),
  ADD KEY `tfs_rolusuario_usuario` (`tfs_rolusuario_usuario`);

--
-- Indices de la tabla `t_usuario`
--
ALTER TABLE `t_usuario`
  ADD PRIMARY KEY (`tps_usuario_codigo`);

--
-- Indices de la tabla `t_valor_referencia`
--
ALTER TABLE `t_valor_referencia`
  ADD PRIMARY KEY (`tpfs_valorefe_referencia`,`tpd_valorefe_fecha`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `t_movimiento`
--
ALTER TABLE `t_movimiento`
  MODIFY `tpi_movimiento_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id de movimiento',AUTO_INCREMENT=79;
--
-- AUTO_INCREMENT de la tabla `t_rol`
--
ALTER TABLE `t_rol`
  MODIFY `tpi_rol_codigo` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Código de rol',AUTO_INCREMENT=4;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `t_insumo`
--
ALTER TABLE `t_insumo`
  ADD CONSTRAINT `codigo_bodega` FOREIGN KEY (`ts_insumo_bodega`) REFERENCES `t_bodega` (`tps_bodega_codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `codigo_fabricante` FOREIGN KEY (`ts_insumo_fabricante`) REFERENCES `t_fabricante` (`tps_fabricante_codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `codigo_proveedor` FOREIGN KEY (`ts_insumo_proveedor`) REFERENCES `t_proveedor` (`ts_proveedor_codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `indice_referencia` FOREIGN KEY (`ts_insumo_codref`) REFERENCES `t_referencia` (`tps_referencia_codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `t_inventario_bodega`
--
ALTER TABLE `t_inventario_bodega`
  ADD CONSTRAINT `t_referencia` FOREIGN KEY (`tpfs_invebode_referencia`) REFERENCES `t_referencia` (`tps_referencia_codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `t_referencia`
--
ALTER TABLE `t_referencia`
  ADD CONSTRAINT `t_referencia_ibfk_2` FOREIGN KEY (`tfi_referencia_categoria`) REFERENCES `t_categoria` (`tps_categoria_codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `t_referencia_ibfk_3` FOREIGN KEY (`tfi_referencia_fabricante`) REFERENCES `t_fabricante` (`tps_fabricante_codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `t_rol_usuario`
--
ALTER TABLE `t_rol_usuario`
  ADD CONSTRAINT `t_rol_usuario_ibfk_1` FOREIGN KEY (`tpfi_rolusuario_codigo`) REFERENCES `t_rol` (`tpi_rol_codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `t_rol_usuario_ibfk_2` FOREIGN KEY (`tfs_rolusuario_usuario`) REFERENCES `t_usuario` (`tps_usuario_codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
