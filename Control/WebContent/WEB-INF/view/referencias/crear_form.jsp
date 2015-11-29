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
				<h2>Crear Referencia</h2>
				<p>Complete la información solicitada</p>
				<div id="error">
				</div>
				<form action="${pageContext.request.contextPath}/referencias/crear_accion" method="post"
					  id="crearUsuario">
					<table class="table table-hover">
						<tr>
							<td><strong>Código:</strong></td>
							<td><input class="uppercase" id="codigo" name="codigo" type="text" tabindex="1"  required></td>
			       		</tr>
			       		<tr>
			       			<td><strong>Descripción:</strong></td>
			       			<td><textarea class="uppercase" name="descripcion" rows="2" cols="75" tabindex="2"  required></textarea></td>
			       		</tr>
			       		<tr>
			       			<td><strong>Componente:</strong></td>
			       			<td><textarea class="uppercase" name="componente" rows="2" cols="75" tabindex="3"  required></textarea></td>
			       		</tr>
			       		<tr>
			       			<td><strong>Presentación:</strong></td>
			       			<td><textarea class="uppercase" name="presentacion" rows="2" cols="75" tabindex="4"  required></textarea></td>
			       		</tr>
			       		<tr>
			       			<td><strong>Fabricante:</strong></td>
			       			<td>
			       				<select name="fabricante" tabindex="5">
			       					<c:forEach items="${fabricantes}" var="fabricante">
			       						<option value="${fabricante.codigo}">${fabricante.codigo} - ${fabricante.nombre}</option>
			       					</c:forEach>
			       				</select>
							</td>
			       		</tr>

			       		<tr>
			       			<td><strong>Categoría:</strong></td>
			       			<td>
			       				<select name="categoria" tabindex="6">
			       					<c:forEach items="${categorias}" var="categoria">
			       						<option value="${categoria.codigo}">${categoria.codigo} - ${categoria.nombre}</option>
			       					</c:forEach>
			       				</select>
							</td>
			       		</tr>
			       		<tr>
			       			<td><strong>Observación:</strong></td>
			       			<td><textarea class="uppercase" name="observacion" rows="5" cols="75" tabindex="7" required></textarea></td>
			       		</tr>
						<tr>
							<td><strong>Cantidad minima:</strong></td>
							<td><input class="uppercase numeric" name="cant_minima" type="text" tabindex="1" required><p> <span class="label label-info">Representa la cantidad minima <br>que se permitira en almacen</span></p></td>
			       		</tr>
					</table>
					<input type="submit" class="btn btn-primary" value="Crear" tabindex="8">
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