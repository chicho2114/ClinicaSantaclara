<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Sistema de Control - Policlínica Santa Clara">
	<jsp:attribute name="body">
		<div class="container">
			<div class="row-fluid">
				<h2>Ver Proveedor: ${proveedor.codigo} - ${proveedor.nombre}</h2>
				<form action="${pageContext.request.contextPath}/proveedores/editar" method="post"
					  id="editarProveedor">
					<table class="table table-striped">
						<tr>
							<td><strong>Código Proveedor:</strong></td>
							<td><input class="uppercase" id="codigo" name="codigo" type="text" value="${proveedor.codigo}" readonly></td>
			       		</tr>
			       		<tr>
			       			<td><strong>Nombre:</strong></td>
			       			<td><input class="uppercase" name="nombre" type="text" value="${proveedor.nombre}" readonly></td>
			       		</tr>
			       		<tr>
			       			<td><strong>Telefono:</strong></td>
			       			<td><textarea class="uppercase" name="telefono" rows="2" cols="75" readonly>${proveedor.telefono}</textarea></td>
			       		</tr>
			       		<tr>
			       			<td><strong>Fecha de creación:</strong></td>
			       			<td><input class="uppercase" name="fechacrea" type="text" value="${proveedor.fechacrea}" readonly></td>
			       		</tr>
			       		<tr>
			       			<td><strong>Creado por el usuario:</strong></td>
			       			<td><input class="uppercase" name="usuacrea" type="text" value="${proveedor.usuaCrea}" readonly></td>
			       		</tr>
	
	
					</table>
					
				<c:if test="${!(UserRol eq ('[ROLE_NOUSUARIO]')) }">
					<input type="submit" class="btn btn-primary" value="Editar" tabindex="8">
				</c:if>
				</form>
				
				<t:regresar></t:regresar>
			</div>
		</div>
	</jsp:attribute>
</t:layout>