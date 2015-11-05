<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Inventario Virtual de Partes - Vehículos Mazda de Venezuela C.A">
	<jsp:attribute name="body">
		<fmt:formatDate pattern="dd/MM/yyyy hh:mm:ss a" value="${user.ultimoAcceso}" var="fechaUltimoAcceso" />
		<h1>Información del Usuario - ${user.id}</h1>
		<table class="table table-striped">
			<tr>
				<td><strong>Código:</strong></td>
				<td><input type="text" value="${user.id}" disabled></td>
       		</tr>
       		<tr>
       			<td><strong>Nombre:</strong></td>
       			<td><textarea rows="2" cols="75" disabled>${user.nombre}</textarea></td>
       		</tr>
       		<tr>
       			<td><strong>Concesionario:</strong></td>
       			<td><textarea rows="2" cols="75" disabled>${user.concesionario} - ${user.nombreConcesionario}</textarea></td>
       		</tr>
       		<tr>
       			<td><strong>Cargo:</strong></td>
       			<td><textarea rows="5" cols="75" disabled>${user.cargo}</textarea></td>
       		</tr>
       		<tr>
       			<td><strong>Email:</strong></td>
       			<td><a href="mailto:${user.email}">${user.email}</a></td>
       		</tr>
       		<tr>
       			<td><strong>Vigencia:</strong></td>
       			<td>
       				<c:choose>
	       				<c:when test="${user.vigente eq 'V'}">
	       					<input type="text" value="V - Vigente" disabled>
	       				</c:when>
	       				<c:otherwise>
	       					<input type="text" value="N - No Vigente" disabled>
	       				</c:otherwise>
       				</c:choose>
       			</td>
       		</tr>
       		<tr>
       			<td><strong>Cantidad de accesos de usuario:</strong></td>
       			<td><input type="text" value="${user.cantAccesos}" disabled></td>
       		</tr>
       		<tr>
       			<td><strong>Último acceso de usuario:</strong></td>
       			<td><input type="text" value="${fechaUltimoAcceso}" disabled></td>
       		</tr>
       		<tr>
       			<td><strong>IP de acceso:</strong></td>
       			<td><input type="text" value="${user.ipUltimoAcceso}" disabled></td>
       		</tr>
    		<tr>
      			<td><strong>Nivel de permisos:</strong></td>
      			<td>
      				<select id="permisologia" disabled>
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
      				<td><input type="checkbox" id="actualizacion" name="actualizacion" value="S" checked disabled/></td>
      			</c:if>
      			<c:if test="${not actualizar}">
      				<td><input type="checkbox" id="actualizacion" name="actualizacion" value="S" disabled /></td>
      			</c:if>
      		</tr>
		</table>
		<form action="${pageContext.request.contextPath}/usuarios/modificar">
			<input type="hidden" name="codigo" value="${user.id}" />
			<input type="submit" class="btn btn-primary" value="Modificar" />
		</form>
		<script type="text/javascript">
			$(document).ready(function() {
				$('#permisologia option:eq(${permiso})').prop('selected', true);
			});
		</script>
	</jsp:attribute>
</t:layout>