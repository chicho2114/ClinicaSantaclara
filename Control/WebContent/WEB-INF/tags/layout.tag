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
		
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.css" type="text/css" media="screen">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.min.css" type="text/css" media="screen">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.structure.css" type="text/css" media="screen">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.structure.min.css" type="text/css" media="screen">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.theme.css" type="text/css" media="screen">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery-ui.theme.min.css" type="text/css" media="screen">
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery.dataTables.min.css" type="text/css" media="screen">


		<script src="${pageContext.request.contextPath}/js/jquery.min.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/js/jquery-ui.min.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/js/jquery.validate.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/js/bootstrap.min.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/js/funciones.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/js/tableExport.js" type="text/javascript" ></script>
		<script src="${pageContext.request.contextPath}/js/jquery.base64.js" type="text/javascript"></script>
		<script src="${pageContext.request.contextPath}/js/jquery.dataTables.min.js" type="text/javascript"></script>

		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script type="text/javascript">
			var pepe;
			function ini() {
			  pepe = setTimeout('location="${pageContext.request.contextPath}/"',120000); // 5 segundos
			}
			function parar() {
			  clearTimeout(pepe);
			  pepe = setTimeout('location="${pageContext.request.contextPath}/"',120000); // 5 segundos
			}
		</script>
		
		<title>${title}</title>
	</head>
	<body onload="ini()" onkeypress="parar()" onmousemove="parar()" onclick="parar()">
		<!-- Membrete y menú -->
		<div class="container">
			<div class="row">
				<div class="span12">
					<div class="head">
						<div class="row-fluid">
						    <div class="span12">
								<a href="${pageContext.request.contextPath}/#home"><img src="${pageContext.request.contextPath}/images/banner7.png" /></a>
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
 			          					<c:when test="${!empty (sessionScope.usuario)}">
 			          			
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
									          		<c:choose>
									          		  <c:when test="${ins.size() > 0 or refes.size() > 0}">
									          			<li><a id="drop1" data-toggle="popover" data-content="Hay notificaciones (${ins.size()+refes.size() }) pendientes." data-placement="top" title="Aviso!" href="${pageContext.request.contextPath}/"><i class="icon-home"></i></a></li>
										              </c:when>
										              <c:otherwise>
										              	<li><a id="drop1" href="${pageContext.request.contextPath}/"><i class="icon-home"></i></a></li>
										              </c:otherwise>
										            </c:choose>
										            	<li class="dropdown">
										              		<a id="drop2" href="#" class="dropdown-toggle" data-toggle="dropdown">Referencias e Invenarios<b class="caret"></b></a>
										              		<ul class="dropdown-menu">
										              		<c:choose>
											              		<c:when test="${!(UserRol eq ('[ROLE_NOUSUARIO]')) }">
												                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/referencias/crear">Crear Referencia</a></li>
												                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/proveedores/crear">Crear Proveedor</a></li>
												                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/referencias/crear_fabricante">Crear Fabricante</a></li>
												                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/referencias/crear_categoria">Crear Categoría</a></li>
												                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/referencias/crear_archivo">Cargar Referencias mediante Archivo</a></li>
												                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/insumos/cargar_insumos">Cargar Insumos</a></li>
												                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/insumos/crear_archivo">Cargar Insumos mediante Archivo</a></li>
												                
												                	<li class="divider"></li>
												                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/referencias/crear_subbodega">Sub-Bodegas</a></li>
												                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/referencias/crear_bodega">Bodegas de Inventario</a></li>
												                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/referencias/crear_ajuste">Cargar Ajustes en Inventario</a></li>
												              	</c:when>
												              	<c:otherwise>
												              		<li><a tabindex="-1" href="#myModal" data-toggle="modal">Crear Referencia</a></li>
												                	<li><a tabindex="-1" href="#myModal" data-toggle="modal">Crear Proveedor</a></li>
												                	<li><a tabindex="-1" href="#myModal" data-toggle="modal">Crear Fabricante</a></li>
												                	<li><a tabindex="-1" href="#myModal" data-toggle="modal">Crear Categoría</a></li>
												                	<li><a tabindex="-1" href="#myModal" data-toggle="modal">Cargar Referencias mediante Archivo</a></li>
												                	<li><a tabindex="-1" href="#myModal" data-toggle="modal">Cargar Insumos</a></li>
												                	<li><a tabindex="-1" href="#myModal" data-toggle="modal">Cargar Insumos mediante Archivo</a></li>
												                
												                	<li class="divider"></li>
												                	<li><a tabindex="-1" href="#myModal" data-toggle="modal">Sub-bodegas</a></li>
												                	<li><a tabindex="-1" href="#myModal" data-toggle="modal">Bodegas de Inventario</a></li>
												                	<li><a tabindex="-1" href="#myModal" data-toggle="modal">Cargar Ajustes en Inventario</a></li>
												              	
												              	</c:otherwise>
											              	</c:choose>
											              	</ul>
											            </li>
											            <li class="dropdown">
										              		<a href="#" id="drop3" class="dropdown-toggle text-warning" data-toggle="dropdown" >Consultas<b class="caret"></b></a>
										              		<ul class="dropdown-menu">
											                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/referencias/listar">Consultar Referencia</a></li>
											                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/insumos/consultar">Consultar Insumos</a></li>
											                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/proveedores/consultar">Consultar Proveedor</a></li>
											                	<li class="divider"></li>
											                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/insumos/movimientos">Consulta de Movimientos</a></li>
											                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/referencias/inventario_general_reporte">Consulta de Inventario General</a></li>
											              	</ul>
										            	</li>
										            	<li class="dropdown">
										              		<a href="#" id="drop4" class="dropdown-toggle text-warning" data-toggle="dropdown" >Clientes<b class="caret"></b></a>
										              		<ul class="dropdown-menu">
											                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/cliente/crear">Crear Cliente</a></li>
											                </ul>
										            	</li>
										          	</ul>
										          	<ul class="nav pull-right">
										            	<li id="fat-menu" class="dropdown warning text-warning">
									              			<a href="#" id="drop4" class="dropdown-toggle" data-toggle="dropdown"> Más Opciones <b class="caret"></b></a>
									              			<ul class="dropdown-menu">
									              				<c:if test="${!(UserRol eq ('[ROLE_NOUSUARIO]')) }">
											                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/usuarios/crear">Crear Usuario</a></li>
											                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/usuarios/listar">Listar Usuarios</a></li>
											                	<li class="divider"></li></c:if>
											                	<li><a tabindex="-1" href="${pageContext.request.contextPath}/usuarios/ver?codigo=${usuario.codigo}">Mi Perfil</a></li>
											                	<li class="divider"></li>
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
						<a href="#">Soporte: Manuel Cárdenas / 0426-9452127 / 0412-4335969 </a>
					</div>
					<div class="span6">
						<p class="muted pull-right">© 2015 Policlínico Santa Clara. RIF: J-07582262-5. Todos los derechos reservados</p>
					</div>
				</div>
			</div>
		</div>
		<script>
			$('.uppercase').keyup(function(){
			    this.value = this.value.toUpperCase();
			});
			$('.numeric').forceNumeric();
			
			  $(function() {
				    $( ".datepicker" ).datepicker({
				      changeMonth: true,
				      changeYear: true,
				      dateFormat: "yy-mm-dd"
				    });
			   });
			
			  $('#drop1').popover("show");
			 
		</script>
		
		<!-- Modal -->
		<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-header">
		    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		    <h3 id="myModalLabel">Aviso!</h3>
		  </div>
		  <div class="modal-body">
		    <p>Usted no posee los permisos necesarios para realizar
		    esta acción</p>
		  </div>
		  <div class="modal-footer">
		    <button class="btn" data-dismiss="modal" aria-hidden="true">Cerrar</button>
		    <!--  <button class="btn btn-primary">Save changes</button>-->
		  </div>
		</div>

	</body>
</html>
