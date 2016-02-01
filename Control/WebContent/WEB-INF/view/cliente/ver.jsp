<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<t:layout title="Sistema de Control - Policlínica Santa Clara">
	<jsp:attribute name="body">
		<div class="container">
			<div class="row-fluid">
				<h2>Ver Cliente: ${cliente.nombre} - ${cliente.nacionalidad} ${cliente.cedula}</h2>
				<form action="${pageContext.request.contextPath}/cliente/editar" method="post"
					  id="editarInsumo">
					<table class="table table-striped">
						<tr>
							<td><strong>Nombre:</strong></td>
							<td><input  name="nombre" type="text" value="${cliente.nombre}" readonly></td>
			       			<td><strong>Cedula:</strong></td>
			       			<td><input class="uppercase" name="cedulacompleta" type="text" value="${cliente.nacionalidad} - ${cliente.cedula}" readonly></td>
			       				<input type="hidden" name="cedula" value="${cliente.cedula}">
			       				<input type="hidden" name="nacionalidad" value="${cliente.nacionalidad}">
			       		</tr>
			       		<tr>
			       			<td><strong>Telefono:</strong></td>
			       			<td><input class="uppercase" name="telefono" type="text" value="${cliente.telefono}" readonly></td>
			       			<td><strong>Dirección:</strong></td>
			       			<td><textarea rows="2" cols="120" class="uppercase" name="direccion" readonly> ${cliente.direccion}</textarea></td>
			       		
			       		</tr>
			       	
			       		<tr>
			       			<td><strong>Fecha de creación:</strong></td>
			       			<td><input class="uppercase" name="fechacrea" type="text" value="<fmt:formatDate value="${cliente.fechacrea}" pattern="yyyy-MM-dd hh:mm a" />" readonly></td>
			       			<td><strong>Usuario que lo creo:</strong></td>
			       			<td><input name="usuaCrea" type="text" value="${cliente.usuaCrea}" readonly></td>
			       		
			       		</tr>
			       		
			       		<tr>
			       			<td><strong>Fecha de modificación:</strong></td>
			       			<td><input class="uppercase" name="fechamodi" type="text" value="<fmt:formatDate value="${cliente.fechamodi}" pattern="yyyy-MM-dd hh:mm a" />" readonly></td>
			       			<td><strong>Usuario que lo modifico:</strong></td>
			       			<td><input name="usuaModi" type="text" value="${cliente.usuaModi}" readonly></td>
			       		
			       		</tr>
					</table>
					<c:if test="${!(UserRol eq ('[ROLE_NOUSUARIO]')) }">
						<button class="btn btn-primary" type="submit">Editar <i class="icon-edit"></i></button>
					</c:if>
				</form>
				<form action="${pageContext.request.contextPath}/cliente/listar" method="post">
					<button class="btn btn-info" type="submit">Regresar <i class="icon-arrow-left"></i></button>
				</form>
				<t:regresar></t:regresar>
			</div>
		</div>
	</jsp:attribute>
</t:layout>