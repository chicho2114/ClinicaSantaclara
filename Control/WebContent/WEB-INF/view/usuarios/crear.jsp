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
		<h1>Crear Usuario</h1>
		<p>Complete la información solicitada</p>
		<div id="error">
		</div>
		<form action="${pageContext.request.contextPath}/usuarios/crear_accion" method="post"
			  id="crearUsuario">
			<table class="table table-striped">
				<tr>
					<td><strong>Código:</strong></td>
					<td><input id="codigo" name="codigo" type="text" ></td>
	       		</tr>
	       		<tr>
	       			<td><strong>Nombre:</strong></td>
	       			<td><textarea name="nombre" rows="2" cols="75" ></textarea></td>
	       		</tr>
	       		<tr>
	       			<td><strong>Cedula:</strong></td>
	       			<td><input class="uppercase numeric" name="cedula" type="text" required></td>
	       		</tr>
	       		<tr>
	       			<td><strong>Cargo:</strong></td>
	       			<td><input class="uppercase" name="cargo" type="text" required></td>
	       		</tr>
	       		<tr>
	       			<td><strong>Contraseña temporal:</strong></td>
	       			<td><input id="contrasena" name="contrasena" type="password" ></td>
	       		</tr>
	       		<tr>
	       			<td><strong>Repita contraseña temporal:</strong></td>
	       			<td><input id="contrasena2" name="contrasena2" type="password" ></td>
	       		</tr>
	       		<tr>
	       			<td><strong>Nivel de permisos</strong></td>
	       			<td>
	       				<select name="permisologia">
	       					<option value=""></option>
	       					<option value="1">INTERNO</option>
	       					<option value="2">EXTERNO</option>
	       					<option value="3">ADMINISTRADOR</option>
	       				</select>
	       			</td>
	       		</tr>
			</table>
			<input type="submit" class="btn btn-primary" value="Crear" />
		</form>
			</c:when>
	<c:otherwise>
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
			<button class="btn btn-primary" data-dismiss="modal" aria-hidden="true" onClick="">Cerrar</button>
			<!--  <button class="btn btn-primary">Save changes</button>-->
		  </div>
		</div>
		<script type="text/javascript">
				$('#myModal').modal({
					keyboard: false
				  })
				$('#myModal').on('hide', function () {
					location.href="${pageContext.request.contextPath}/";// do something…
					})
		</script>
	</c:otherwise>
</c:choose>
		<t:regresar></t:regresar>
		</div>
	</div>
		<script type="text/javascript">
		    $(function(){
		        $('#crearUsuario').validate({
		        	focusInvalid : false,
		        	onkeyup : false,
		        	onfocusout : false,
		        	errorClass: "invalid", 
		        	errorLabelContainer : "#error",
		        	wrapper: "li",
		            rules :{
		                codigo:{
		                    required : true,
		                    minlength : 4
		                },
		                nombre : {
		                    required : true
		                },
		                cargo : {
		                	required : true
		                },
		                contrasena : {
		                	required : true,
		                	minlength : 5
		                },
		                contrasena2: {
		                	required : true,
		                	equalTo : '#contrasena'
		                },   
		                permisologia : {
		                	required : true
		                },
		            },
		            messages : {
		            	codigo : {
		            		remote : "El código de concesionario ya ha sido tomado",
		            		required : "El campo 'Código' es requerido",
		            		minlength : "El código de usuario debe tener, mínimo, 4 caracteres"
		            	},
		            	nombre : {
		            		required : "El campo 'Nombre' es requerido"
		            	},
		            	cargo : {
		            		required : "El campo 'Cargo' es requerido"
		            	},
		            	contrasena : {
		            		required : "El campo 'Contraseña' es requerido",
		            		minlength : "La contraseña debe contener, mínimo, 8 caracteres"
		            	},
		            	contrasena2 : {
		            		required : "Debe repetir la contraseña",
		            		equalTo: "Las contrasenas deben coincidir"
		            	},
		            	permisologia : {
		                	required : "Debe seleccionar el tipo de permisología"
		                }
		            },
		            invalidHandler: function(event, validator) {
		            	window.scrollTo(0, 0);
		        	}
		        });    
		    });
		    
		</script>
	</jsp:attribute>
</t:layout>