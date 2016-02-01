<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="p" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<t:layout title="Sistema de control - Policlínica Santa Clara">
	<jsp:attribute name="body">
		<div class="container">
			<div class="row-fluid">
				<h1>Resultados de consulta</h1>
				<a href="#" onClick ="$('#consulta').tableExport({type:'excel',escape:'false',});"><img src="${pageContext.request.contextPath}/images/icon_excel.png" /></a>
				<table class="table table-striped table-hover" id="consulta">
					<thead>
						<tr>
			         			<th>Nombre</th>
			         			<th>Cedula</th>
			         			<th>Telefono</th>
			         			<th>Fecha de creación</th>
			         			<th>Usuario de creación</th>
			         			<th>Ver</th>
			       		</tr>
		       		</thead>
					<c:forEach var="cliente" items="${clientes}">
						<tr>
							<td>${cliente.nombre}</td>
							<td>${cliente.nacionalidad} - ${cliente.cedula}</td>
							<td>${cliente.telefono}</td>
							<td><fmt:formatDate value="${cliente.fechacrea}" pattern="dd/MM/yyyy hh:mm a" /></td>
							<td>${cliente.usuacrea}</td>
							<td><a href="${pageContext.request.contextPath}/cliente/ver?codigo=${cliente.codigo}"><img src="${pageContext.request.contextPath}/images/buscar.png" /></a></td>
						</tr>
					</c:forEach>
				</table>
				<t:regresar></t:regresar>
				<script src="${pageContext.request.contextPath}/js/jquery.filtertable.min.js" type="text/javascript"></script>
				<script type="text/javascript">
					$(document).ready(function() {
				        $('table').filterTable();
				    });
					$(document).ready(function() {
					    $('#consulta').DataTable( {
					        "pagingType": "full_numbers",
					        "language": {
					        "search": "Buscar:",
					        "infoEmpty": "Mostrando 0 a 0 de 0 entradas",
					        "lengthMenu": "Mostrar _MENU_ entradas",
					        "zeroRecords": "No se encuentran resultados que coincidan con la busqueda",
					        "info": "Mostrando _START_ a _END_ de _TOTAL_ entradas",
					        "infoFiltered":   "(filtrado de _MAX_ entradas totales)",
				        	"paginate": {
				        	      "first": "Primera",
				        	      "previous": "Anterior",
				        	      "next": "Siguiente",
				        	      "last": "Ultima",
				        	     
				        	    }
					    	}
					    } );
					} );
				</script>
			</div>
		</div>
	</jsp:attribute>
</t:layout>