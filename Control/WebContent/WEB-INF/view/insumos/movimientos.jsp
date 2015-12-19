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
				<c:choose>
					<c:when test="${ movimientos.size() != 0}">
	          	     <table class="table table-bordered table-hover" id="consulta">
				      <thead>
				        <tr>
				          <th>Nro#</th>
				          <th>Motivo</th>
				          <th>Cantidad</th>
				          <th>Observación</th>
				          <th>Proceso</th>					          
				          <th>Usuario</th>
				          <th>Fecha</th>
				        </tr>
				      </thead>
				      <tbody>
				       <c:forEach var="movimiento" items="${movimientos}">
				       <c:choose>
						<c:when test="${ movimiento.cantidad > 0}">
						<tr class="success">
							<td>${movimiento.id}</td>
							<td>${movimiento.referencia}</td>
							<td>+${movimiento.cantidad}</td>
							<td>${movimiento.motivo }</td>
							<td>${movimiento.observacion }</td>
							<td>${movimiento.usuario }</td>
							<td><fmt:formatDate value="${movimiento.fecha }" pattern="dd/MM/yyyy hh:mm:ss a" /></td>
							
						</tr>
						</c:when>
						<c:otherwise>
							<tr class="error">
								<td>${movimiento.id}</td>
								<td>${movimiento.referencia}</td>
								<td>${movimiento.cantidad}</td>
								<td>${movimiento.motivo }</td>
								<td>${movimiento.observacion }</td>
								<td>${movimiento.usuario }</td>
								<td><fmt:formatDate value="${movimiento.fecha }" pattern="dd/MM/yyyy hh:mm:ss a" /></td>
							</tr>
						</c:otherwise>
						</c:choose>
					</c:forEach> 
				       </tbody>
				    </table> 
				   
				    </c:when>
				    <c:otherwise>
				       	
			           <div class="alert alert-info">
					      <p><strong>Aviso!</strong> No existen movimientos realizados recientemente.</p>
					    </div>
					
				      </c:otherwise>
				  </c:choose>
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