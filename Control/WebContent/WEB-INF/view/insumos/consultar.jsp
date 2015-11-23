<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Sistema de Control - Policlínica Santa Clara">
	<jsp:attribute name="body">
		<div class="container">
			<div class="row-fluid">
				<h1>Consultar insumos</h1>
				<!-- <p>Debe utilizar un mínimo de <strong>4</strong> caracteres para la búsqueda por código de proveedor.</p> -->
				<div id="error">
				</div>
				<form action="${pageContext.request.contextPath}/insumos/mostrar" 
					  id="listar">
					<table class="table table-striped">
						<tr>
							<td><strong>Código de caja:</strong></td>
							<td>
			       				<input class="uppercase" name="codcaja" size="50" tabindex = "2"/>
							</td>
						</tr>
						<tr>
							<td><strong>Codigo de referencia:</strong></td>
							<td><input class="uppercase" name="codref" size="50" tabindex = "2"/></td>
						</tr>
						<tr>
							<td><strong>Codigo de proveedor:</strong></td>
							<td><input class="uppercase" name="proveedor" size="50" tabindex = "2"/></td>
						</tr>
						<tr>
							<td><strong>Codigo de bodega:</strong></td>
							<td><select id="bodega" name="bodega" tabindex="5">
									<option value=""></option>
			       					<c:forEach items="${bodegas}" var="bodega">
			       						<option value="${bodega.codigo}">${bodega.codigo} - ${bodega.nombre }</option>
			       					</c:forEach>
			       				</select>
			       			</td>
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