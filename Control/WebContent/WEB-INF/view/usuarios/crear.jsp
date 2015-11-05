<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Inventario Virtual de Partes - Vehículos Mazda de Venezuela C.A">
	<jsp:attribute name="body">
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
	       			<td><textarea class="uppercase" name="nombre" rows="2" cols="75"></textarea></td>
	       		</tr>
	       		<tr>
	       			<td><strong>Concesionario:</strong></td>
	       			<td>
	       				<select name="concesionario">
	       					<option value=""></option>
	       					<c:forEach items="${concs}" var="concesionario">
	       						<option value="${concesionario.codigo}">${concesionario.codigo} - ${concesionario.nombre}</option>
	       					</c:forEach>
	       				</select>
					</td>
	       		</tr>
	       		<tr>
	       			<td><strong>Cargo:</strong></td>
	       			<td><textarea class="uppercase" name="cargo" rows="5" cols="75"></textarea></td>
	       		</tr>
	       		<tr>
	       			<td><strong>Email:</strong></td>
	       			<td><input class="uppercase" type="text" name="email"></td>
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
	       				<select name="permisologia" onchange="activar(this.value);">
	       					<option value=""></option>
	       					<option value="1">EXTERNO</option>
	       					<option value="2">INTERNO</option>
	       					<option value="3">ADMINISTRADOR</option>
	       				</select>
	       			</td>
	       		</tr>
	       		<tr>
	       			<td><strong>¿Permiso de actualización?</strong></td>
	       			<td><input type="checkbox" id="actualizacion" name="actualizacion" value="S" disabled /></td>
	       		</tr>
			</table>
			<input type="submit" class="btn btn-primary" value="Crear" />
		</form>
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
		                codigo : {
		                	remote : {
		                    	url : "buscarUsuario",
		                    	type : "get",
		                    	data : {
		                    		codigo : function() {
		                    			return $('#codigo').val();
		                    		}
		                    	}
		                    },
		                    required : true,
		                    minlength : 4
		                },
		                nombre : {
		                    required : true
		                },
		                concesionario : {
		                	required : true
		                },
		                cargo : {
		                	required : true
		                },
		                contrasena : {
		                	required : true,
		                	minlength : 8
		                },
		                contrasena2: {
		                	required : true,
		                	equalTo : '#contrasena'
		                },
		                email : {
		                	required : true,
		                	email : true
		                },
		                permisologia : {
		                	required : true
		                },
		                actualizacion : {
		                	required : false
		                }
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
		</script>
	</jsp:attribute>
</t:layout>