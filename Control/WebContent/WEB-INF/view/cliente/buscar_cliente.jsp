<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Sistema de Control - Policlínica Santa Clara">
	<jsp:attribute name="body">
		<div class="container">
			<div class="row-fluid">
			

				<h1>Búsqueda de Cliente</h1>
				<p>Puede buscar clientes por cedula o nombre.</p>
				<p class="text-warning"><strong>NOTA:</strong> En caso de no especificar algun parametro, se listaran todos los clientes. (Esto puede ralentizar la carga desde el servidor).</p>
				<div id="error">
				</div>
				<form action="${pageContext.request.contextPath}/cliente/listar"
					  id="listar">
					<table class="table table-striped">
						<tr>
							<td><strong>Cedula:</strong></td>
							<td><input class="uppercase numeric" name="codigo" type="text" size="50" tabindex = "1"/></td>
						</tr>
						<tr>
							<td><strong>Nombre:</strong></td>
							<td><input name="descripcion" type="text" size="50" tabindex = "2"/></td>
						</tr>
					</table>
					<input type="submit" class="btn btn-primary" value="Buscar" />
				</form>
				<form action="${pageContext.request.contextPath}/cliente/crear">
					<input type="submit" class="btn btn-info" value="Crear cliente" />
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
				                descripcion : {
				                    minlength : 3
				                }
				            },
				            messages : {
				            	codigo : {
				            		minlength : "El campo 'Código de referencia' debe tener, mínimo, 4 caracteres"
				            	},
				            	descripcion : {
				            		minlength : "El campo 'Descripción' debe tener, mínimo, 3 caracteres"
				            	}
				            }
				        });    
				    });
				</script>
			</div>
		</div>
	</jsp:attribute>
</t:layout></html>