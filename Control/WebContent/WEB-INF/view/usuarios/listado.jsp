<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<t:layout title="Sistema de control - Policlínica Santa Clara">
	<jsp:attribute name="body">
	<div class="container">
	 <div class="row-fluid">
<c:choose>
	<c:when test="${!(UserRol eq ('[ROLE_NOUSUARIO]')) }">
		<h1>Listado de Usuarios</h1>
		<table class="table table-striped table-bordered table-hover" id="consulta">
			<thead>
				<tr>
	         			<th>Código</th>
	         			<th>Nombre</th>
	         			<th>Cedula</th>
	         			<th>Vigencia</th>
	         			<th>Cambio contraseña</th>
	         			<th>Fecha de cambio</th>
	         			<th>Fecha de creación</th>
	         			<th>Ver</th>
	       		</tr>
       		</thead>
			<c:forEach var="usuario" items="${usuarios}">
				<tr>
					<td>${usuario.codigo}</td>
					<td>${usuario.nombre}</td>
					<td>${usuario.cedula}</td>
					<td>${usuario.vigencia}</td>
					<td>${usuario.cambcontra}</td>
					<td><fmt:formatDate value="${usuario.ultcambcontra}" pattern="dd/MM/yyyy hh:mm a" /></td>
					<td><fmt:formatDate value="${usuario.fechacrea}" pattern="dd/MM/yyyy hh:mm a" /></td>
					<td><a href="${pageContext.request.contextPath}/usuarios/ver?codigo=${usuario.codigo}"><img src="${pageContext.request.contextPath}/images/buscar.png" /></a></td>
				</tr><!-- -->
			</c:forEach>
		</table>
		<a class="btn btn-primary" href="${pageContext.request.contextPath}/usuarios/crear">Crear Usuario</a>
		</c:when>
	<c:otherwise>
		<!-- Modal -->
		<div id="myModal" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3 id="myModalLabel">Aviso!</h3>
		  </div>
		  <div class="modal-body">
			<p>Usted no posee los permisos necesarios para realizar
			esta acción</p>
		  </div>
		  <div class="modal-footer">
			<button class="btn btn-primary" data-dismiss="modal" aria-hidden="true" onClick="">Cerrar</button>
			<!--  <button class="btn btn-primary">Save changes</button>-->
		  </div>
		</div>
		<script type="text/javascript">
				$('#myModal').modal({
					keyboard: false
				  })
				$('#myModal').on('hide', function () {
					location.href="${pageContext.request.contextPath}/";// do something…
					})
		</script>
	</c:otherwise>
</c:choose>
		<t:regresar></t:regresar>
		</div>
	</div>
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
		
	</jsp:attribute>
</t:layout>