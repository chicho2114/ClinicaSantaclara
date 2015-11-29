<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Sistema de control - Policlínica Santa Clara">
	<jsp:attribute name="body">
	<div class="container">
			<div class="row-fluid">
<c:choose>
	<c:when test="${!(UserRol eq ('[ROLE_NOUSUARIO]')) }">
		<h1>Información del Usuario - ${user.codigo}</h1>
		<div id="error">
		</div>
		<form action="${pageContext.request.contextPath}/usuarios/modificar_accion" method="post"
			  id="modificarUsuario">
			<table class="table table-striped">
				<tr>
					<td><strong>Código:</strong></td>
					<td><input type="text" value="${user.codigo}" name="codigo" readonly required></td>
	       		</tr>
	       		<tr>
	       			<td><strong>Nombre:</strong></td>
	       			<td><textarea name="nombre" rows="2" cols="75" required>${user.nombre}</textarea></td>
	       		</tr>
	       		<tr>
	       			<td><strong>Cedula:</strong></td>
	       			<td><input class="uppercase numeric" name="cedula" type="text" value="${user.cedula}" required></td>
	       		</tr>
	       		<tr>
	       			<td><strong>Cargo:</strong></td>
	       			<td><input class="uppercase" name="cargo" type="text" value="${user.cargo}" required></td>
	       		</tr>
	       		<tr>
	       			<td><strong>Vigencia:</strong></td>
	       			<td>
		       			<select id="vigencia" name="vigencia">
		  					<option value="V">V - VIGENTE</option>
							<option value="N">N - NO VIGENTE</option>
						</select>
					</td>
	       		</tr>
	       		<tr>
	       			<td><strong>Nivel de permisos:</strong></td>
	       			<td>
	       				<select id="permisologia" name="permisologia">
      						<c:choose>
       						<c:when test="${permiso == 'ROLE_USUARIO'}">
       							<option selected value="1">INTERNO</option>
       							<option value="2">EXTERNO</option>
       							<option value="3">ADMINISTRADOR</option>
       						</c:when>
       						<c:when test="${permiso == 'ROLE_NOUSUARIO'}">
       							<option value="1">INTERNO</option>
       							<option selected value="2">EXTERNO</option>
       							<option value="3">ADMINISTRADOR</option>
       						</c:when>
       						<c:otherwise>
       							<option value="1">INTERNO</option>
       							<option value="2">EXTERNO</option>
       							<option selected value="3">ADMINISTRADOR</option>
       						</c:otherwise>
       						</c:choose>
				       	
      				</select>
	       			</td>
	       		</tr>

			</table>
			<input type="hidden" name="id" value="${user.codigo}" required />
			<input type="submit" class="btn btn-primary" value="Modificar" />
		</form>
	</c:when>
	<c:otherwise>
	<h1>Información del Usuario - ${user.codigo}</h1>
		<div id="error">
		</div>
		<form action="${pageContext.request.contextPath}/usuarios/modificar_accion" method="post"
			  id="modificarUsuario">
			<table class="table table-striped">
				<tr>
					<td><strong>Código:</strong></td>
					<td><input type="text" value="${user.codigo}" name="codigo" readonly required></td>
	       		</tr>
	       		<tr>
	       			<td><strong>Nombre:</strong></td>
	       			<td><textarea name="nombre" rows="2" cols="75" readonly required>${user.nombre}</textarea></td>
	       		</tr>
	       		<tr>
	       			<td><strong>Cedula:</strong></td>
	       			<td><input class="uppercase numeric" name="cedula" type="text" readonly value="${user.cedula}" required></td>
	       		</tr>
	       		<tr>
	       			<td><strong>Cargo:</strong></td>
	       			<td><input class="uppercase" name="cargo" type="text" readonly value="${user.cargo}" required></td>
	       		</tr>
	       		<tr>
	       			<td><strong>Vigencia:</strong></td>
	       			<td>
		       			<select id="vigencia" disabled name="vigencia">
		  					<option value="V">V - VIGENTE</option>
							<option value="N">N - NO VIGENTE</option>
						</select>
					</td>
	       		</tr>
	       		<tr>
	       			<td><strong>Nivel de permisos:</strong></td>
	       			<td>
	       				<select id="permisologia" disabled name="permisologia">
      						<c:choose>
       						<c:when test="${permiso == 'ROLE_USUARIO'}">
       							<option selected value="1">INTERNO</option>
       							<option value="2">EXTERNO</option>
       							<option value="3">ADMINISTRADOR</option>
       						</c:when>
       						<c:when test="${permiso == 'ROLE_NOUSUARIO'}">
       							<option value="1">INTERNO</option>
       							<option selected value="2">EXTERNO</option>
       							<option value="3">ADMINISTRADOR</option>
       						</c:when>
       						<c:otherwise>
       							<option value="1">INTERNO</option>
       							<option value="2">EXTERNO</option>
       							<option selected value="3">ADMINISTRADOR</option>
       						</c:otherwise>
       						</c:choose>
				       	
      				</select>
	       			</td>
	       		</tr>

			</table>
			<input type="hidden" name="id" value="${user.codigo}" required />
			<input type="submit" class="btn btn-primary"  disabled value="Modificar" />
		</form>
		
	</c:otherwise>
</c:choose>
	<c:choose>
	<c:when test="${!(UserRol eq ('[ROLE_NOUSUARIO]')) }">
		<h1>Cambiar contraseña - ${user.codigo}</h1>
		<form action="${pageContext.request.contextPath}/usuarios/modificar_contrasena_accion" method="post"
			  id="cambioContrasena">
			<table class="table table-striped">
				<tr>
					<td>Nueva contraseña:</td>
					<td><input id="contrasena" name="contrasena" type="password" required></td>
				</tr>
				<tr>
					<td>Repita nueva contraseña:</td>
					<td><input id="contrasena2" name="contrasena2" type="password" required></td>
				</tr>
			</table>
			<input type="hidden" name="codigo" value="${user.codigo}" />
			<input type="submit" class="btn btn-primary" value="Cambiar contraseña" />
		</form>
		<c:if test="${!(UserRol eq ('[ROLE_NOUSUARIO]')) && !(UserCodigo.codigo eq user.codigo) }">
		<form action="${pageContext.request.contextPath}/usuarios/eliminar" method="post">
			<input type="hidden" name="codigo" value="${user.codigo}" />
			<input type="submit" class="btn btn-danger" value="Eliminar Usuario" />
		</form>
		</c:if>
		</c:when>
		<c:otherwise>
		<c:if test="${(UserCodigo.codigo eq user.codigo) }">
		<h1>Cambiar contraseña - ${user.codigo}</h1>
		<form action="${pageContext.request.contextPath}/usuarios/modificar_contrasena_accion" method="post"
			  id="cambioContrasena">
			<table class="table table-striped">
				<tr>
					<td>Nueva contraseña:</td>
					<td><input id="contrasena" name="contrasena" type="password" required></td>
				</tr>
				<tr>
					<td>Repita nueva contraseña:</td>
					<td><input id="contrasena2" name="contrasena2" type="password" required></td>
				</tr>
			</table>
			<input type="hidden" name="codigo" value="${user.codigo}" />
			<input type="submit" class="btn btn-primary" value="Cambiar contraseña" />
		</form>
		<c:if test="${!(UserRol eq ('[ROLE_NOUSUARIO]')) && !(UserCodigo.codigo eq user.codigo) }">
		<form action="${pageContext.request.contextPath}/usuarios/eliminar" method="post">
			<input type="hidden" name="codigo" value="${user.codigo}" />
			<input type="submit" class="btn btn-danger" value="Eliminar Usuario" />
		</form>
		</c:if>
		</c:if>
		</c:otherwise>
	</c:choose>
		</div>
		</div>
		<script type="text/javascript">
			$('#vigencia').val('${user.vigencia}');
			
			$(function(){
		        $('#modificarUsuario').validate({
		        	focusInvalid : false,
		        	onkeyup : false,
		        	onfocusout : false,
		        	errorClass: "invalid", 
		        	errorLabelContainer : "#error",
		        	wrapper: "li",
		            rules :{
		                nombre : {
		                    required : true
		                },
		               
		                cargo : {
		                	required : true
		                },
		                
		                vigencia : {
		                	required : true
		                }
		            },
		            messages : {
		            	codigo : {
		            		remote : "El código de concesionario ya ha sido tomado",
		            		required : "El campo 'Código' es requerido"
		            	},
		            	nombre : {
		            		required : "El campo 'Nombre' es requerido"
		            	},
		            	cargo : {
		            		required : "El campo 'Cargo' es requerido"
		            	},
		            	vigencia : {
		            		required : "El campo 'Vigencia' es requerido"
		            	}
		            },
		            invalidHandler: function(event, validator) {
		            	window.scrollTo(0, 0);
		        	}
		        });    
		    });
			
			$(function() {
				$('#cambioContrasena').validate({
					focusInvalid : false,
		        	onkeyup : false,
		        	onfocusout : false,
		        	errorClass: "invalid", 
		        	errorLabelContainer : "#error",
		        	wrapper: "li",
					rules : {
						contrasena : {
							required : true,
							minlength : 5
						},
						contrasena2 : {
							required : true,
							equalTo : "#contrasena"
						}
					},
					messages : {
						contrasena : {
							required : "El campo 'Contraseña' es requerido",
							length : "La contraseña debe contener 5 caracteres"
						},
						contrasena2 : {
							required : "Debe repetir la contraseña",
							equalTo : "Las contraseñas deben coincidir"
						}
					}
				});
			});
			
		</script>
	</jsp:attribute>
</t:layout>