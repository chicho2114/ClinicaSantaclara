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
				<h2>Editar Proveedor: ${proveedor.codigo} - ${proveedor.nombre}</h2>
				<form action="${pageContext.request.contextPath}/proveedores/editar_prov" method="post"
					  id="crearUsuario">
					  <p><strong>NOTA:</strong> Los campos dejados en blanco o sin modificar no seran afectados.</p>
					<table class="table table-striped">
						<tr>
							<td><strong>Código Proveedor:</strong></td>
							<td><input class="uppercase" id="codigo" name="codigo" type="text" value="${proveedor.codigo}" readonly></td>
			       		</tr>
			       		<tr>
			       			<td><strong>Nombre:</strong></td>
			       			<td><input class="uppercase" name="nombre" type="text" required placeholder="${proveedor.nombre}" value="${proveedor.nombre}" ></td>
			       		</tr>
			       		<tr>
			       			<td><strong>Telefono:</strong></td>
			       			<td><textarea class="uppercase" name="telefono" required placeholder="${proveedor.telefono}" rows="2" cols="75" >${proveedor.telefono}</textarea></td>
			       		</tr>	
	
					</table>
					<input type="submit" class="btn btn-primary" value="Modificar" tabindex="8">
				</form>
				<form action="${pageContext.request.contextPath}/proveedores/eliminar" method="post">
					<input type="hidden" name="codigo" value="${proveedor.codigo}">
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