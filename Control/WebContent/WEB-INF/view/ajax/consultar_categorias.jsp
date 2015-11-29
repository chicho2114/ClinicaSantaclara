<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<table class="table table-striped" id="consulta">
	<thead>
		<tr>
			<th>
				Categoria
			</th>
			<th>
				Cant. Referencias
			</th>
			<th>
				Operar
			</th>
			<th>
				Ver
			</th>
		</tr>
	</thead>
	<tbody>
		
			<tr>
				<td class="text-center">${categoria}</td>
				<td class="text-center">${cantRefes}</td>
				<c:choose>
				<c:when test="${cantRefes == 0}">
				<td class="text-center">
					<form action="${pageContext.request.contextPath}/referencias/eliminar_categoria">
						<input type=hidden name="codigo" value="${categoria}" >
						<button class="btn btn-small btn-danger" type="submit">Eliminar</button>
					</form>
				</td>
				</c:when>
				<c:otherwise>
				<td class="text-center">
						<button class="btn btn-small btn-danger disabled" type="submit">Eliminar</button>
				</td>
				</c:otherwise>
				</c:choose>
				<td class="text-center"><a href="${pageContext.request.contextPath}/referencias/listar_reporte?codigo=&descripcion=&fabricante=&categoria=${categoria}"><img src="${pageContext.request.contextPath}/images/buscar.png" /></a></td>
				
			<tr>
		
	</tbody>
</table>
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