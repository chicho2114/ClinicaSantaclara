<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Inventario Virtual de Partes - Vehículos Mazda de Venezuela C.A">
	<jsp:attribute name="body">
		<h1>Horario: ${horario.descripcion}</h1>
		<p><b>Hora Inicial: </b> ${horario.horaini}</p>
		<p><b>Hora Final: </b> ${horario.horafin}</p>
		
		<table class="table table-striped">
			<thead>
				<tr>
					<th>Usuario</th>
					<th>Nombre de Usuario</th>
				</tr>
			</thead>
			<c:forEach var="usuario" items="${usuarios}">
				<tr>
					<td>${usuario.id}</td>
					<td>${usuario.nombre}</td>
				</tr>
			</c:forEach>
		</table>
		
		<h1>Agregar usuarios a este horario</h1>
		<form action="${pageContext.request.contextPath}/horarios/usuarios_horario_accion" method="post">
			<input type="hidden" name="id" value="${horario.id}" />
			<table>
				<tr>
					<td>
						<select name="usuario">
							<c:forEach var="usuarioAgregar" items="${usuariosAgregar}">
							<option value="${usuarioAgregar.id_usuario }">${usuarioAgregar.id_usuario} - ${usuarioAgregar.nombre_usuario}</option>					
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td><input type="submit" class="btn" onclick="return confirm('¿Está seguro de agergar este usuario al horario?')" value="Agregar"/></td>
				</tr>
			</table>
		</form>
		
		<t:regresar />
	</jsp:attribute>
</t:layout>