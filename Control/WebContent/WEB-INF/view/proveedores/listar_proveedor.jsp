<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<t:layout title="Sistema de control - Policlínica Santa Clara">
	<jsp:attribute name="body">
		<div class="container">
			<div class="row-fluid">
				<h1>Resultados de consulta</h1>
				<a href="#" onClick ="$('#consulta').tableExport({type:'excel',escape:'false',});"><img src="${pageContext.request.contextPath}/images/icon_excel.png" /></a>
				<table class="table table-striped" id="consulta">
					<thead>
						<tr>
			         			<th>Código</th>
			         			<th>Nombre</th>
			         			<th>Telefono</th>
			         			<th>Fecha de creación</th>
			         			<th>Usuario de creación</th>
			         			<th>Ver</th>
			       		</tr>
		       		</thead>
					<c:forEach var="proveedor" items="${prov}">
						<tr>
							<td>${proveedor.codigo}</td>
							<td>${proveedor.nombre}</td>
							<td>${proveedor.telefono}</td>
							<td><fmt:formatDate value="${proveedor.fechacrea}" pattern="dd/MM/yyyy hh:mm a" /></td>
							<td>${proveedor.usuaCrea}</td>
							<td><a href="${pageContext.request.contextPath}/proveedores/ver?codigo=${proveedor.codigo}"><img src="${pageContext.request.contextPath}/images/buscar.png" /></a></td>
						</tr>
					</c:forEach>
				</table>
				<t:regresar></t:regresar>
				<script src="${pageContext.request.contextPath}/js/jquery.filtertable.min.js" type="text/javascript"></script>
				<script type="text/javascript">
					$(document).ready(function() {
				        $('table').filterTable();
				    });
				</script>
			</div>
		</div>
	</jsp:attribute>
</t:layout>