<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Sistema de control - Policlínica Santa Clara">
	<jsp:attribute name="body">
	<div class="container">
			<div class="row-fluid">
			
		<h1>Información del Usuario - ${user.codigo}</h1>
		<table class="table table-striped">
			<tr>
				<td><strong>Código:</strong></td>
				<td><input type="text" value="${user.codigo}" disabled></td>
       		</tr>
       		<tr>
       			<td><strong>Nombre:</strong></td>
       			<td><textarea rows="2" cols="75" disabled>${user.nombre}</textarea></td>
       		</tr>
      		<tr>
       			<td><strong>Cedula:</strong></td>
       			<td><input type="text" value="${user.cedula}" disabled></td>
			 </tr>
       		<tr>
       			<td><strong>Cargo:</strong></td>
       			<td><input type="text" value="${user.cargo}" disabled></td>
       		</tr>
       		<tr>
       			<td><strong>Vigencia:</strong></td>
       			<td>
       				<c:choose>
	       				<c:when test="${user.vigencia eq 'V'}">
	       					<input type="text" value="V - Vigente" disabled>
	       				</c:when>
	       				<c:otherwise>
	       					<input type="text" value="N - No Vigente" disabled>
	       				</c:otherwise>
       				</c:choose>
       			</td>
       		</tr>
    		<tr>
      			<td><strong>Nivel de permisos:</strong></td>
      			<td>
      				<select id="permisologia" disabled>
      					
       						<c:choose>
       						<c:when test="${permiso == 'ROLE_USUARIO'}">
       							<option selected value="1">INTERNO</option>
       							<option value="2">EXTERNO</option>
       							<option value="3">ADMINISTRADOR</option>
       						</c:when>
       						<c:when test="${permiso == 'ROLE_NOUSUARIO'}">
       							<option value="1">INTERNO</option>
       							<option selected value="2">EXTERNO</option>
       							<option value="3">ADMINISTRADOR</option>
       						</c:when>
       						<c:otherwise>
       							<option value="1">INTERNO</option>
       							<option value="2">EXTERNO</option>
       							<option selected value="3">ADMINISTRADOR</option>
       						</c:otherwise>
       						</c:choose>
				       	
      				</select>
      			</td>
      		</tr>
       		<tr>
       			<td><strong>Cambio contraseña:</strong></td>
       			<td><input type="text" value="${user.cambcontra}" disabled></td>
			 </tr>
			 <tr>
				 <td><strong>Ultimo Cambio:</strong></td>
			   	<td><input type="text"  readonly  value="<fmt:formatDate value="${user.ultcambcontra}" pattern="dd/MM/yyyy hh:mm a"/>"></td>
			 </tr>
	   		<tr>
       			<td><strong>Usuario creador:</strong></td>
       			<td><input type="text" value="${user.usuacrea}" disabled></td>
			 </tr>
	  		<tr>
       			<td><strong>Fecha de creacion:</strong></td>
       			<td><input type="text" readonly value="<fmt:formatDate value="${user.fechacrea}" pattern="dd/MM/yyyy hh:mm a"/>"></td>
			
			 </tr>
		</table>
		<form action="${pageContext.request.contextPath}/usuarios/modificar">
			<input type="hidden" name="codigo" value="${user.codigo}" />
			<input type="submit" class="btn btn-primary" value="Modificar" />
		</form>
		<t:regresar></t:regresar>
					</div>
		</div>
		<script type="text/javascript">
		</script>
	</jsp:attribute>
</t:layout>