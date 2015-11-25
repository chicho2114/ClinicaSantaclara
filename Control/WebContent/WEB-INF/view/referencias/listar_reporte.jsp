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
				<table class="table table-bordered table-striped table-hover" id="consulta">
					<thead>
						<tr>
			         			<th>Código</th>
			         			<th>Descripción</th>
			         			<th>Usuario de creación</th>
			         			<th>Fecha de creación</th>
			         			<th>Cantidad minima</th>
			         			<th>Cantidad disponible</th>
			         			<th>Ver</th>
			       		</tr>
		       		</thead>
					<c:forEach var="referencia" items="${refs}">
						<c:choose>
							<c:when test="${referencia.cantidad >= referencia.cant_mini}">
								<tr >
									<td>${referencia.codigo}</td>
									<td>${referencia.descripcion}</td>
									<td>${referencia.usuaCrea}</td>
									<td><fmt:formatDate value="${referencia.fechaCrea}" pattern="dd/MM/yyyy hh:mm a" /></td>
									<td>${referencia.cant_mini }</td>
									<td>${referencia.cantidad }</td>
									<td><a href="${pageContext.request.contextPath}/referencias/ver?codigo=${referencia.codigo}"><img src="${pageContext.request.contextPath}/images/buscar.png" /></a></td>
								</tr>
	    					</c:when>    
	    					<c:otherwise>
								<tr class="error">
									<td>${referencia.codigo}</td>
									<td>${referencia.descripcion}</td>
									<td>${referencia.usuaCrea}</td>
									<td><fmt:formatDate value="${referencia.fechaCrea}" pattern="dd/MM/yyyy hh:mm a" /></td>
									<td>${referencia.cant_mini }</td>
									<td>${referencia.cantidad }</td>
									<td><a href="${pageContext.request.contextPath}/referencias/ver?codigo=${referencia.codigo}"><img src="${pageContext.request.contextPath}/images/buscar.png" /></a></td>
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