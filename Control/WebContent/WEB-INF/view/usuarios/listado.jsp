<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Inventario Virtual de Partes - Vehículos Mazda de Venezuela C.A">
	<jsp:attribute name="body">
		<h1>Listado de Usuarios</h1>
		<table class="table table-striped">
			<thead>
				<tr>
	         			<th>Código</th>
	         			<th>Nombre</th>
	         			<th>Concesionario</th>
	         			<th>Cargo</th>
	         			<th>Email</th>
	         			<th>Ver</th>
	       		</tr>
       		</thead>
			<c:forEach var="usuario" items="${usuarios}">
				<tr>
					<td>${usuario.id}</td>
					<td>${usuario.nombre}</td>
					<td>${usuario.concesionario} - ${usuario.nombreConcesionario}</td>
					<td>${usuario.cargo}</td>
					<td><a href="mailto:${usuario.email}">${usuario.email}</a></td>
					<td><a href="${pageContext.request.contextPath}/usuarios/ver?codigo=${usuario.id}"><img src="${pageContext.request.contextPath}/images/buscar.png" /></a></td>
				</tr>
			</c:forEach>
		</table>
		<a class="btn" href="${pageContext.request.contextPath}/usuarios/crear">Crear Usuario</a>
		<script src="${pageContext.request.contextPath}/js/jquery.filtertable.min.js" type="text/javascript"></script>
		<script type="text/javascript">
			$(document).ready(function() {
		        $('table').filterTable();
		    });
		</script>
	</jsp:attribute>
</t:layout>