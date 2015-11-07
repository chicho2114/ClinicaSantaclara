<%@ tag description="Layout Control Santa Clara" language="java" pageEncoding="UTF-8"%>
<%@ attribute name="title" %>
<%@ attribute name="body" fragment="true" %>
<%@ attribute name="active0" fragment="true" %>
<%@ attribute name="active1" fragment="true" %>
<%@ attribute name="active2" fragment="true" %>
<%@ attribute name="active3" fragment="true" %>
<%@ attribute name="active4" fragment="true" %>
<%@ attribute name="active5" fragment="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="es">
	<head>
		<!-- Compatibilidad con IE9 -->
		<!--[if lt IE 9]>
			<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
		<![endif]-->
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" type="text/css" media="screen">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap-responsive.min.css" type="text/css" media="screen">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilogeneral.css" type="text/css" media="screen">
		<script src="${pageContext.request.contextPath}/js/jquery.min.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/js/jquery.validate.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/js/funciones.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/js/tableExport.js" type="text/javascript" ></script>
		<script src="${pageContext.request.contextPath}/js/jquery.base64.js" type="text/javascript"></script>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>${title}</title>
	</head>
	<body>
		<!-- Membrete y menú -->
		<div class="container">
			<div class="row">
				<div class="span12">
					<div class="head">
						<div class="row-fluid">
						    <div class="span12">
								<a href="${pageContext.request.contextPath}/"><img src="http://dummyimage.com/1170x125/000/fff" /></a>
						    </div>
						</div>
						<div class="navbar">
						    <div class="navbar-inner">
						    	<div class="container">
						        	<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
		 				            	<span class="icon-bar"></span> 
 				            			<span class="icon-bar"></span> 
 			            				<span class="icon-bar"></span> 
 			          				</a>
 			          				<c:choose>
 			          					<c:when test="${!empty sessionScope.usuario}">
								      		<div class="container" style="width: auto;">
											
										        <!-- .btn-navbar is used as the toggle for collapsed navbar content -->
										        <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
									          		<span class="icon-bar"></span>
									          		<span class="icon-bar"></span>
									          		<span class="icon-bar"></span>
									        	</a>
											        
									        	<!-- Everything you want hidden at 940px or less, place within here -->
										        <div class="nav-collapse collapse">
									          		<ul class="nav">
										            	<li class="dropdown">
										              		<a id="drop1" href="#" class="dropdown-toggle" data-toggle="dropdown">Referencias e Invenarios<b class="caret"></b></a>
										              		<ul class="dropdown-menu">
											                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/referencias/crear">Crear Referencia</a></li>
											                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/proveedores/crear">Crear Proveedor</a></li>
											                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/referencias/crear_fabricante">Crear Fabricante</a></li>
											                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/referencias/crear_categoria">Crear Categoría</a></li>
											                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/referencias/crear_archivo">Cargar Referencias mediante Archivo</a></li>
											                	<li class="divider"></li>
											                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/referencias/listar">Consultar Referencia</a></li>
											                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/proveedores/consultar">Consultar Proveedor</a></li>
											                	<li class="divider"></li>
											                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/referencias/crear_bodega">Bodegas de Inventario</a></li>
											                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/referencias/crear_ajuste">Cargar Ajustes en Inventario</a>
											                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/referencias/inventario_general_reporte">Consulta de Inventario General</a></li>
											              	</ul>
											            </li>
											            <li class="dropdown">
										              		<a href="#" id="drop2" class="dropdown-toggle" data-toggle="dropdown">Impuestos<b class="caret"></b></a>
										              		<ul class="dropdown-menu">
											                	<li><a tabindex="-1" href="#">Cargar Impuesto</a></li>
											                	<li><a tabindex="-1" href="#">Cargar Referencias mediante archivo</a></li>
											                	<li><a tabindex="-1" href="#">Consultar referencia</a></li>
											                	<li class="divider"></li>
											                	<li><a tabindex="-1" href="#">Separated link</a></li>
											              	</ul>
										            	</li>
										          	</ul>
										          	<ul class="nav pull-right">
										            	<li id="fat-menu" class="dropdown warning text-warning">
									              			<a href="#" id="drop3" class="dropdown-toggle" data-toggle="dropdown"> <i class="icon-warning-sign"></i> Más Opciones <b class="caret"></b></a>
									              			<ul class="dropdown-menu">
											                	<li><a tabindex="-1" href="http://yahoo.com" target="_blank">Yahoo!</a></li>
											                	<li><a tabindex="-1" href="http://bing.com" target="_blank">Bing</a></li>
											                	<li><a tabindex="-1" href="#">Something else here</a></li>
											                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/logout">Cerrar sesión</a></li>
											              	</ul>
										            	</li>
								          			</ul>
								          			<ul class="nav pull-right">
									            		<li><div style="padding: 10px 10px 11px; font-size: 14px; color: #fcfcfc; text-shadow: black 1px 1px 1px;">Bienvenido, ${usuario.codigo} - ${usuario.nombre}</div></li>
									            		
									            	</ul>
										        </div>
								      		</div>
							            </c:when>
							            <c:otherwise>
							            	<div class="nav-collapse collapse">
									            <ul class="nav">
									                <li><div style="padding: 10px 10px 11px; font-size: 14px; color: #fcfcfc; text-shadow: black 1px 1px 1px;">${title}</div></li>
													<li class="divider-vertical"></li>
									            </ul>
								            </div>
							            </c:otherwise>
						          	</c:choose>
						        </div>
						    </div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!-- Mensajes -->
		<c:if test="${not empty sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message}">
			<div class="container">
				<div class="alert alert-error">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					<p><strong>¡Error!</strong> ${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'].message}</p>
				</div>
			</div>
			<c:remove var="SPRING_SECURITY_LAST_EXCEPTION" scope="session" />
		</c:if>
		<c:if test="${not empty sessionScope.mensaje}">
			<div class="container">
				<c:choose>
					<c:when test="${sessionScope.tipo eq 'EXITO'}">
						<div class="alert alert-success">
							<button type="button" class="close" data-dismiss="alert">&times;</button>
							<p><strong>¡Éxito!</strong> ${sessionScope.mensaje}.</p>
						</div>
					</c:when>
					<c:when test="${sessionScope.tipo eq 'ERROR'}">
						<div class="alert alert-error">
							<button type="button" class="close" data-dismiss="alert">&times;</button>
							<p><strong>¡Error!</strong> ${sessionScope.mensaje}.</p>
						</div>
					</c:when>
					<c:when test="${sessionScope.tipo eq 'ADVERTENCIA'}">
						<div class="alert">
  							<button type="button" class="close" data-dismiss="alert">&times;</button>
							<p><strong>¡Advertencia!</strong> ${sessionScope.mensaje}.</p>
						</div>
					</c:when>
				</c:choose>
			</div>
			<c:remove var="mensaje" scope="session" />
			<c:remove var="tipo" scope="session" />
		</c:if>
		
		<!-- Cuerpo -->
		<jsp:invoke fragment="body" />
		
		<!-- Pie de página -->
		<div class="container">  
			<div class="row-fluid">
				<div class="span12">
					<p style="font-size: 12px; text-align: center; color: red;">
						"Aviso: Usted está ingresando a una aplicación interna de Policlínica Santa Clara, C.A. Su utilización o acceso
						no autorizado puede incurrir en delitos establecidos según el marco legal vigente. "
					</p>					
				</div>
			</div>
			<hr>
			<div class="row-fluid">
				<div class="span12">
					<div class="span6">
						<a href="#">Desarrollado por ISCON, C.A.</a>
						<br>
						<a href="#">Soporte: Manuel Cárdenas / 0426-9452127</a>
					</div>
					<div class="span6">
						<p class="muted pull-right">© 2014 Policlínico Santa Clara. RIF: J-30040457-9. Todos los derechos reservados</p>
					</div>
				</div>
			</div>
		</div>
		<script>
			$('.uppercase').keyup(function(){
			    this.value = this.value.toUpperCase();
			});
			$('.numeric').forceNumeric();
		</script>
	</body>
</html>
