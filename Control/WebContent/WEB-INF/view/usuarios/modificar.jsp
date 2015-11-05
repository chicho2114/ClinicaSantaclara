<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Inventario Virtual de Partes - Vehículos Mazda de Venezuela C.A">
	<jsp:attribute name="body">
		<h1>Información del Usuario - ${user.id}</h1>
		<div id="error">
		</div>
		<form action="${pageContext.request.contextPath}/usuarios/modificar_accion" method="post"
			  id="modificarUsuario">
			<table class="table table-striped">
				<tr>
					<td><strong>Código:</strong></td>
					<td><input class="uppercase" type="text" value="${user.id}" disabled required></td>
	       		</tr>
	       		<tr>
	       			<td><strong>Nombre:</strong></td>
	       			<td><textarea class="uppercase" name="nombre" rows="2" cols="75" required>${user.nombre}</textarea></td>
	       		</tr>
	       		<tr>
	       			<td><strong>Concesionario:</strong></td>
	       			<td>
	       				<select id="concesionario" name="concesionario">
	       					<option value="-"></option>
	       					<c:forEach items="${concs}" var="concesionario">
	       						<option value="${concesionario.codigo}">${concesionario.codigo} - ${concesionario.nombre}</option>
	       					</c:forEach>
	       				</select>
					</td>
	       		</tr>
	       		<tr>
	       			<td><strong>Cargo:</strong></td>
	       			<td><textarea class="uppercase" name="cargo" rows="5" cols="75" required>${user.cargo}</textarea></td>
	       		</tr>
	       		<tr>
	       			<td><strong>Email:</strong></td>
	       			<td><input class="uppercase" name="email" type="text" value="${user.email}" required></td>
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
	       				<select id="permisologia" name="permisologia" onchange="activar(this.value);">
	       					<option value=""></option>
	       					<option value="1">EXTERNO</option>
	       					<option value="2">INTERNO</option>
	       					<option value="3">ADMINISTRADOR</option>
	       				</select>
	       			</td>
	       		</tr>
	       		<tr>
	       			<td><strong>¿Permiso de actualización?</strong></td>
	       			<c:if test="${actualizar}">
	       				<td><input type="checkbox" id="actualizacion" name="actualizacion" value="S" checked/></td>
	       			</c:if>
	       			<c:if test="${not actualizar}">
	       				<td><input type="checkbox" id="actualizacion" name="actualizacion" value="S" disabled /></td>
	       			</c:if>
	       		</tr>
			</table>
			<input type="hidden" name="id" value="${user.id}" required />
			<input type="submit" class="btn btn-primary" value="Modificar" />
		</form>
		<h1>Cambiar contraseña - ${user.id}</h1>
		<form action="${pageContext.request.contextPath}/usuarios/modificar_contrasena_accion" method="post"
			  id="cambioContrasena">
			<table class="table table-striped">
				<tr>
					<td>Nueva contraseña:</td>
					<td><input id="contrasena" name="contrasena" type="password"></td>
				</tr>
				<tr>
					<td>Repita nueva contraseña:</td>
					<td><input name="contrasena2" type="password"></td>
				</tr>
			</table>
			<input type="hidden" name="id" value="${user.id}" />
			<input type="submit" class="btn btn-primary" value="Cambiar contraseña" />
		</form>
		<script type="text/javascript">
			$('#vigencia').val('${user.vigente}');
			$('#concesionario').val('${user.concesionario}');
			
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
		                concesionario : {
		                	required : true
		                },
		                cargo : {
		                	required : true
		                },
		                email : {
		                	required : true,
		                	email : true
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
		            	concesionario : {
		            		required : "El campo 'Concesionario' es requerido"
		            	},
		            	cargo : {
		            		required : "El campo 'Cargo' es requerido"
		            	},
		            	email : {
		            		required : "El campo 'Email' es requerido",
		            		email : "Por favor, introduzca un email válido"
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
							length : 8
						},
						contrasena2 : {
							required : true,
							equalTo : "#contrasena"
						}
					},
					messages : {
						contrasena : {
							required : "El campo 'Contraseña' es requerido",
							length : "La contraseña debe contener 8 caracteres"
						},
						contrasena2 : {
							required : "Debe repetir la contraseña",
							equalTo : "Las contraseñas deben coincidir"
						}
					}
				});
			});
			
			function activar(valor) {
		    	if(valor === '1') {
		    		$('#actualizacion').prop('disabled', false);
		    	}
		    	else {
		    		$('#actualizacion').prop('disabled', true);
		    		if($('#actualizacion').prop("checked")) {
		    			$('#actualizacion').prop("checked", false);
		    		}
		    	}
		    }
			
			$(document).ready(function() {
				$('#permisologia option:eq(${permiso})').prop('selected', true);
			});
		</script>
	</jsp:attribute>
</t:layout>