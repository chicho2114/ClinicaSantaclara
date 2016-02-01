<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<t:layout title="Sistema de Control - Policlínica Santa Clara">
	<jsp:attribute name="body">
		<div class="container">
			<div class="row-fluid">
				<h2>Editar Cliente: ${cliente.nombre} - ${cliente.nacionalidad} ${cliente.cedula}</h2>
				<form action="${pageContext.request.contextPath}/cliente/editar_cliente" method="post"
					  id="editarCliente">
					<table class="table table-striped">
						<tr>
							<td><strong>Nombre:</strong></td>
							<td><input  name="nombre" type="text" placeholder="${cliente.nombre}" value="${cliente.nombre}" required></td>
			       			<td><strong>Cedula:</strong></td>
			       			<td>
			       			<select id="nacionalidad" name="nacionalidad" class="span2">
	      						<c:choose>
		       						<c:when test="${cliente.nacionalidad == 'V'}">
		       							<option selected value="V">V</option>
		       							<option value="E">E</option>
		       						</c:when>
		       						<c:otherwise>    			
				       					<option selected value="E">E</option>
		       							<option value="V">V</option>
		       						</c:otherwise>
	       						</c:choose>
	      					</select>
			       			<input class="uppercase" name="cedula" type="text" placeholder="${cliente.cedula}" value="${cliente.cedula}" required></td>
			       			<input type="hidden" value="${cliente.cedula}" name="cedulaOriginal">
			       			<input type="hidden" value="${cliente.nacionalidad}" name="nacionalOriginal">
			       		</tr>
			       		<tr>
			       			<td><strong>Telefono:</strong></td>
			       			<td><input class="uppercase" name="telefono" type="text" placeholder="${cliente.telefono}" value="${cliente.telefono}" required></td>
			       			<td><strong>Dirección:</strong></td>
			       			<td><textarea rows="2" cols="120" class="uppercase" name="direccion" placeholder="${cliente.direccion}" required> ${cliente.direccion}</textarea></td>
			       		
			       		</tr>
			       			<input type="hidden" name="fechacrea" value="<fmt:formatDate value="${cliente.fechacrea}" pattern="yyyy-MM-dd hh:mm a" />">
			       			<input type="hidden" name="usuaCrea" value="${cliente.usuaCrea}">
			       		<!--<tr>
			       			
			       			<td><strong>Fecha de creación:</strong></td>
			       			<td><input class="uppercase" name="fechacrea" type="text" value="<fmt:formatDate value="${cliente.fechacrea}" pattern="yyyy-MM-dd hh:mm a" />" readonly></td>
			       			<td><strong>Usuario que lo creo:</strong></td>
			       			<td><input name="usuaCrea" type="text" value="${cliente.usuaCrea}" readonly></td>
			       		
			       		</tr>-->
					</table>
					<c:if test="${!(UserRol eq ('[ROLE_NOUSUARIO]')) }">
						<button class="btn btn-primary" type="submit">Editar <i class="icon-edit"></i></button>
					</c:if>
				</form>
				<form action="${pageContext.request.contextPath}/cliente/ver?C=${cliente.cedula}&N=${cliente.nacionalidad}" method="post">
					<button class="btn btn-info" type="submit">Cancelar <i class="icon-minus-sign"></i></button>
				</form>
				
				<t:regresar></t:regresar>
			</div>
		</div>
	</jsp:attribute>
</t:layout>