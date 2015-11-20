<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Sistema de Control - Policlínica Santa Clara">
	<jsp:attribute name="body">
		<div class="container">
			<div class="row-fluid">
				<h1>Búsqueda de Proveedores</h1>
				<p>Debe utilizar un mínimo de <strong>4</strong> caracteres para la búsqueda por código de proveedor.</p>
				<div id="error">
				</div>
				<form action="${pageContext.request.contextPath}/proveedores/mostrar"
					  id="listar">
					<table class="table table-striped">
						<tr>
							<td><strong>Código de proveedor:</strong></td>
							<td><input class="uppercase" name="codigo" size="50" tabindex = "1"/></td>
						</tr>
						<tr>
							<td><strong>Nombre:</strong></td>
							<td><input class="uppercase" name="nombre" size="50" tabindex = "2"/></td>
						</tr>
						<tr>
							<td><strong>Telefono:</strong></td>
							<td><input class="uppercase" name="telefono" size="50" tabindex = "2"/></td>
						</tr>
					</table>
					<input type="submit" class="btn btn-primary" value="Buscar" />
				</form>
				<t:regresar></t:regresar>
				<script type="text/javascript">
				    $(function(){
				        $('#listar').validate({
				        	errorClass: "invalid", 
				        	errorLabelContainer : "#error",
				        	wrapper: "li",
				            rules :{
				                codigo : {
				                    minlength : 4
				                },
				                nombre : {
				                    minlength : 3
				                }
				            },
				            messages : {
				            	codigo : {
				            		minlength : "El campo 'Código de proveedor' debe tener, mínimo, 4 caracteres"
				            	},
				            	nombre : {
				            		minlength : "El campo 'Nombre' debe tener, mínimo, 3 caracteres"
				            	}
				            }
				        });    
				    });
				</script>
			</div>
		</div>
	</jsp:attribute>
</t:layout>