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
				<table class="table table-striped table-bordered table-hover" id="consulta">
					<thead>
						<tr>
			         			<th>Código Caja</th>
			         			<th>Código Referencia</th>
			         			<th>Bodega</th>
			         			<th>Código Proveedor</th>
			         			<th>Cantidad Disponible</th>
			         			<th>Fecha Vencimiento</th>
			         			<th>Usuario de creación</th>
			         			<th>Fecha de creación</th>
			         			<th>Ver</th>
			       		</tr>
		       		</thead>
					<c:forEach var="insumo" items="${insumos}">
						<c:choose>
						<c:when test="${insumo.fechaVenc <= fechaActual}">
						<tr class="error">
							<td>${insumo.codcaja}</td>
							<td>${insumo.codref}</td>
							<td>${insumo.bodega}</td>
							<td>${insumo.proveedor}</td>
							<td>${insumo.cantInsumos}</td>
							<td>${insumo.fechaVenc}</td>
							<td>${insumo.usuaCrea}</td>
							<td><fmt:formatDate value="${insumo.fechaCrea}" pattern="dd/MM/yyyy hh:mm a" /></td>
							<td><a href="${pageContext.request.contextPath}/insumos/ver?codcaja=${insumo.codcaja}"><img src="${pageContext.request.contextPath}/images/buscar.png" /></a></td>
						</tr>
						</c:when>
						<c:otherwise>
							<tr>
								<td>${insumo.codcaja}</td>
								<td>${insumo.codref}</td>
								<td>${insumo.bodega}</td>
								<td>${insumo.proveedor}</td>
								<td>${insumo.cantInsumos}</td>
								<td>${insumo.fechaVenc}</td>
								<td>${insumo.usuaCrea}</td>
								<td><fmt:formatDate value="${insumo.fechaCrea}" pattern="dd/MM/yyyy hh:mm a" /></td>
								<td><a href="${pageContext.request.contextPath}/insumos/ver?codcaja=${insumo.codcaja}"><img src="${pageContext.request.contextPath}/images/buscar.png" /></a></td>
							</tr>
						</c:otherwise>
						</c:choose>
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