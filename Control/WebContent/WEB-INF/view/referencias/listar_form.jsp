<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Sistema de Control - Policlínica Santa Clara">
	<jsp:attribute name="body">
		<div class="container">
			<div class="row-fluid">
			

				<h1>Búsqueda de Referencias</h1>
				<p>Debe utilizar un mínimo de 4 caracteres para la búsqueda por código de referencia.</p>
				<p>Debe utilizar un mínimo de 3 caracteres para la búsqueda por descripción.</p>
				<div id="error">
				</div>
				<form action="${pageContext.request.contextPath}/referencias/listar_reporte"
					  id="listar">
					<table class="table table-striped">
						<tr>
							<td><strong>Código de Referencia</strong></td>
							<td><input class="uppercase" name="codigo" size="50" tabindex = "1"/></td>
						</tr>
						<tr>
							<td><strong>Descripción</strong></td>
							<td><input class="uppercase" name="descripcion" size="50" tabindex = "2"/></td>
						</tr>
						<tr>
			       			<td><strong>Fabricante:</strong></td>
			       			<td>
			       				<select name="fabricante" tabindex="3">
			       					<option value=""></option>
			       					<c:forEach items="${fabricantes}" var="fabricante">
			       						<option value="${fabricante.codigo}">${fabricante.codigo} - ${fabricante.nombre}</option>
			       					</c:forEach>
			       				</select>
							</td>
			       		</tr>
			       		<tr>
			       			<td><strong>Categoría:</strong></td>
			       			<td>
			       				<select name="categoria" tabindex="4">
			       					<option value=""></option>
			       					<c:forEach items="${categorias}" var="categoria">
			       						<option value="${categoria.codigo}">${categoria.codigo} - ${categoria.nombre}</option>
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
</t:layout>