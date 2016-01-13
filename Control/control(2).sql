-- phpMyAdmin SQL Dump
-- version 4.4.12
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-01-2016 a las 19:58:02
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
('AJUSTEINVENTARIO', 0),
('AJUSTEPROVEEDOR', 0);

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_inventario_subbodega`
--

CREATE TABLE IF NOT EXISTS `t_inventario_subbodega` (
  `id` int(11) NOT NULL COMMENT 'Codigo de la tabla',
  `t_subbodega_codigo` varchar(10) NOT NULL COMMENT 'Codigo de subbodega',
  `t_referencia_codigo` varchar(10) CHARACTER SET utf8 COLLATE utf8_spanish2_ci NOT NULL COMMENT 'Codigo de referencia',
  `t_cantidad` int(11) NOT NULL DEFAULT '0',
  `t_invensubbod_usuacrea` varchar(15) NOT NULL COMMENT 'Usuario que lo crea',
  `t_invensubbod_fechacrea` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha en que es creado',
  `t_invensubbod_usuamodi` varchar(15) NOT NULL COMMENT 'Usuario que modifica el proveedor',
  `t_invensubbod_fechamodi` datetime NOT NULL COMMENT 'Fecha en que es modificado'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_movimiento`
--

CREATE TABLE IF NOT EXISTS `t_movimiento` (
  `tpi_movimiento_id` int(11) NOT NULL COMMENT 'Id de movimiento',
  `tpd_movimiento_fecha` datetime NOT NULL COMMENT 'Fecha de movimiento',
  `tpfs_movimiento_referencia` varchar(10) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Referencia de movimiento',
  `ti_movimiento_cantidad` int(11) NOT NULL COMMENT 'Cantidad',
  `t_movimiento_motivo` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  `ts_movimiento_observacion` varchar(30) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Tipo de movmiento',
  `ts_movimiento_proceso` varchar(50) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Proceso que ejecuto el movimiento',
  `tfs_movimiento_usuacrea` varchar(22) COLLATE latin1_spanish_ci NOT NULL COMMENT 'Usuario de creacion',
  `td_movimiento_fechacrea` datetime NOT NULL COMMENT 'Fecha de creacion'
) ENGINE=InnoDB AUTO_INCREMENT=135 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci COMMENT='Movimientos de referencias';

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
(1, 'codigo8'),
(1, 'prueba'),
(3, 'user1'),
(2, 'venc');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `t_subbodega`
--

CREATE TABLE IF NOT EXISTS `t_subbodega` (
  `t_subbodega_codigo` varchar(10) NOT NULL COMMENT 'Codigo Subbodega',
  `t_subbodega_nombre` varchar(100) NOT NULL COMMENT 'Nombre Subbodega',
  `t_subbodega_usuacrea` varchar(15) NOT NULL COMMENT 'Usuario que crea la subbodega',
  `t_subbodega_fechacrea` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha en que es creada la subbodega'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
('codigo8', '4bba2cd311c195ac30cd0c64fd81cd2e20122b04c73e7e0b10cd1d91af29fc52', 'N', '2015-12-03 12:28:21', 'V', '15014015', 'Juan Perez', 'Administracion', 'SECRETARIO', 'prueba', '2015-12-03 12:28:21', NULL, NULL),
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
-- Indices de la tabla `t_inventario_subbodega`
--
ALTER TABLE `t_inventario_subbodega`
  ADD PRIMARY KEY (`id`),
  ADD KEY `t_subbodega_codigo` (`t_subbodega_codigo`),
  ADD KEY `t_referencia_codigo` (`t_referencia_codigo`);

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
-- Indices de la tabla `t_subbodega`
--
ALTER TABLE `t_subbodega`
  ADD PRIMARY KEY (`t_subbodega_codigo`);

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
-- AUTO_INCREMENT de la tabla `t_inventario_subbodega`
--
ALTER TABLE `t_inventario_subbodega`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Codigo de la tabla';
--
-- AUTO_INCREMENT de la tabla `t_movimiento`
--
ALTER TABLE `t_movimiento`
  MODIFY `tpi_movimiento_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Id de movimiento',AUTO_INCREMENT=135;
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
-- Filtros para la tabla `t_inventario_subbodega`
--
ALTER TABLE `t_inventario_subbodega`
  ADD CONSTRAINT `t_subbodega_codigo` FOREIGN KEY (`t_subbodega_codigo`) REFERENCES `t_subbodega` (`t_subbodega_codigo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `t_subbodega_referencia` FOREIGN KEY (`t_referencia_codigo`) REFERENCES `t_referencia` (`tps_referencia_codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

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
