<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Sistema de control - Policlínica Santa Clara">
	<jsp:attribute name="body">
		<div class="container">
			<div class="row-fluid">
<c:choose>
	<c:when test="${!(UserRol eq ('[ROLE_NOUSUARIO]')) }">
				<h2>Cargar insumos a partir de un archivo</h2>
				<p>Por favor seleccione un archivo .CSV guardado en su computador para subirlo al sistema.</p>
				<div id="error">
				</div>
				<form action="${pageContext.request.contextPath}/insumos/crear_archivo_accion" method="post"
					  id="crearArchivo" enctype="multipart/form-data" accept-charset="UTF-8">
					<table class="table table-striped">
						<tr>
							<td><strong>Archivo de insumos:</strong></td>
							<td><input type="file" id="arcParte" name="arcParte" accept=".csv" required /></td>
			       		</tr>
					</table>
					<input type="submit" class="btn btn-primary" value="Subir archivo" />
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