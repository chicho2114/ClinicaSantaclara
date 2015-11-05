<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Inventario Virtual de Partes - Vehículos Mazda de Venezuela C.A">
	<jsp:attribute name="body">
		<h1>Horarios</h1>
		<p>Agregar, modificar horarios para el acceso a la aplicación</p>
		
		<table class="table table-striped">
			<thead>
				<tr>
					<th>Descripción de horario</th>
					<th>Hora Inicial</th>
					<th>Hora Final</th>
					<th>Ver Usuarios</th>
					<th>Borrar</th>
				</tr>
			</thead>
			<c:forEach var="horario" items="${horarios}">
				<tr>
					<td>${horario.descripcion}</td>
					<td>${horario.horaini}</td>
					<td>${horario.horafin}</td>
					<td><a href="${pageContext.request.contextPath}/horarios/usuarios_horario?id=${horario.id}"><img src="${pageContext.request.contextPath}/images/buscar.png" /></a></td>
					<td>
						<form action="${pageContext.request.contextPath}/horarios/borrar_horario_accion" method="post">
							<input name="id" type="hidden" value="${horario.id}" />
							<input type="submit" class="btn" onclick="return confirm('¿Está seguro de borrar este horario?')" value="Borrar"/>
						</form>
					</td>
				</tr>
			</c:forEach>
		</table>
		
		<h1>Crear Horario</h1>
		<form action="${pageContext.request.contextPath}/horarios/crear_horario_accion" method="post">
			<table>
				<tr>
					<td><b>Descripción: </b></td>
					<td><input name="descripcion" type="text" class="uppercase" required /></td>
				</tr>
				<tr>
					<td><b>Hora inicial: </b></td>
					<td><input name="inicio" type="time" required /></td>
				</tr>
				<tr>
					<td><b>Hora inicial: </b></td>
					<td><input name="fin" type="time" required /></td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="Crear"></td>
				</tr>
			</table>
		</form>
	</jsp:attribute>
</t:layout>