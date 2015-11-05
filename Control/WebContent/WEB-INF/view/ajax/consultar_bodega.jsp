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
				Ver
			</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="referencia" items="${referencias}">
			<tr>
				<td>${referencia.referencia} - ${referencia.descripcion}</td>
				<td>${referencia.cantidad}</td>
				<td><a href="${pageContext.request.contextPath}/referencias/ver?codigo=${referencia.referencia}"><img src="${pageContext.request.contextPath}/images/buscar.png" /></a></td>
			<tr>
		</c:forEach>
	</tbody>
</table>
<script src="${pageContext.request.contextPath}/js/jquery.filtertable.min.js" type="text/javascript"></script>
<script type="text/javascript">
	$(document).ready(function() {
	       $('table').filterTable();
	   });
</script>