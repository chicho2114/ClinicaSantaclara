<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<t:layout title="Sistema de control - Policlínica Santa Clara">
	<jsp:attribute name="body">
		<div class="container">
			<div class="row-fluid">
				<h1>Inventario General al mes</h1>
				<a href="#" onClick ="$('#consulta').tableExport({type:'excel',escape:'false'});"><img src="${pageContext.request.contextPath}/images/icon_excel.png" /></a>
				<table class="table table-hover table-bordered table-striped" id="consulta">
					<thead>
						<tr>
			         			<th>Año/Mes</th>
			         			<th>Bodega</th>
			         			<th>Referencia</th>
			         			<th>Descripcion</th>
			         			<th>Cantidad</th>
			         			<th>Cantidad mínima en inventario</th>
			         			<th>Cantidad total en inventarios</th>
			         			<th>Mensajes</th>
			       		</tr>
		       		</thead>
					<c:forEach var="inv" items="${inventario}">
						<tr>
							<td><fmt:formatDate value="${inv.anomes}" pattern="MM/yyyy" /></td>
							<td>${inv.bodega}</td>
							<td>${inv.referencia}</td>
							<td>${inv.descr}</td>
							<td>${inv.cant}</td>
							<td>${inv.cantm}</td>
							<td>${inv.suma}</td>
							<td>
								<c:if test="${inv.suma < inv.cantm}">
									<p style="color:rgb(255,0,0);">Inventario en Mínimo</p>
								</c:if>
							</td>
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