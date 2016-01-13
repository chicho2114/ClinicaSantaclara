<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<table class="table table-striped" id="inventarios">
	<thead>
		<tr>
			<th>
				Referencia
			</th>
			<th>
				Cantidad
			</th>
			<th>
			    Operar
			</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="referencia" items="${referencias}">
			<tr>
				<td>${referencia.referencia} - ${referencia.presentacion} - ${referencia.descripcion}</td>
				<td>${referencia.cantidad}</td>
				<td><form action="${pageContext.request.contextPath}/referencias/vaciar_subbodega">
						<input type=hidden name="codref" value="${referencia.referencia}" >
						<input type=hidden name="codsbb" value="${subbodega}" >
						<button class="btn btn-small btn-danger" type="submit">Eliminar</button>
					</form></td>
			<tr>
		</c:forEach>
		<c:if test="${referencias.isEmpty() }">
			<tr>
				<td><p class="text-error">SUB-BODEGA SIN INSUMOS</p></td>
				<td><p class="text-error">0</p></td>
				<td class="text-center">
					<form action="${pageContext.request.contextPath}/referencias/eliminar_subbodega">
						<input type=hidden name="codigo" value="${subbodega}" >
						<button class="btn btn-small btn-danger" type="submit">Eliminar</button>
					</form>
				</td>
			<tr>
		</c:if>
	</tbody>

</table>
<c:if test="${(UserRol eq ('[ROLE_ADMINISTRADOR]')) }">
		
			<form action="${pageContext.request.contextPath}/referencias/eliminar_subbodega">
				<input type=hidden name="codigo" value="${subbodega}" >
				<button class="btn btn-danger" type="submit">Eliminar Sub-Bodega</button>
			</form>
		
</c:if>
<script src="${pageContext.request.contextPath}/js/jquery.filtertable.min.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
	       $('table').filterTable();
	   });
	} );	
</script>