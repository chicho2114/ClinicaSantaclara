<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Sistema de Control - Policlínica Santa Clara">
	<jsp:attribute name="body">
		<div class="container">
			<div class="row-fluid">
<c:choose>
	<c:when test="${!(UserRol eq ('[ROLE_NOUSUARIO]')) }">
				<h2>Editar cantidad de insumos en Sub-Bodega: ${subbodega.subbodega} - ${subbodega.nombre}</h2>
				<form action="${pageContext.request.contextPath}/referencias/editar_sub" method="post"
					  id="editarInsumo">
					<table class="table table-striped">
						<tr>
							<td><strong>Código Sub-Bodega:</strong></td>
							<td><input class="uppercase" name="codsubbodega" type="text" value="${subbodega.subbodega}" readonly></td>
			       			<td><strong>Nombre Sub-Bodega:</strong></td>
			       			<td><input class="uppercase" name="subbodeganombre" type="text" placeholder="${subbodega.nombre}" value="${subbodega.nombre}" readonly></td>
			       		
			       		</tr>
			       		<tr>
			       			<td><strong>Codigo Referencia:</strong></td>
			       			<td><input class="uppercase" name="codref" type="text" placeholder="${subbodega.codref}" value="${subbodega.codref}" readonly></td>
							<td><strong>Codigo Referencia:</strong></td>
			       			<td><input class="uppercase" name="presentacion" type="text" placeholder="${subref.descripcion}" value="${subref.descripcion}" readonly></td>
			       			
			       		
			       		</tr>
			       	
			       		<tr>
			       			<td><strong>Cantidad disponible:</strong></td>
			       			<td><input class="uppercase numeric" name="cantInsumos" placeholder="${subbodega.cantidad}" required type="number" min="0" max="${subbodega.cantidad}" value="${subbodega.cantidad}"></td>
			       			
			       		</tr>
			       			
					</table>
					<input type="submit" class="btn btn-primary" value="Confirmar" tabindex="8">
					
				</form>
				<form action="${pageContext.request.contextPath}/referencias/eliminar_subbod" method="post">
					<input type="hidden" name="codcaja" value="${subbodega.subbodega}">
					<input type="hidden" name="codref" value="${subbodega.codref}">
					<input type="submit" class="btn btn-danger" value="Eliminar" tabindex="8">
				</form>
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
	</jsp:attribute>
</t:layout>