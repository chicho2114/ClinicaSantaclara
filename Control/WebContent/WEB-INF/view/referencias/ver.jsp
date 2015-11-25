<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Sistema de Control - Policlínica Santa Clara">
	<jsp:attribute name="body">
		<div class="container">
			<div class="row-fluid">
				<h2>Ver Referencia: ${referencia.codigo} - ${referencia.descripcion}</h2>
				<form action="${pageContext.request.contextPath}/referencias/editar" method="post"
					  id="editarInsumo">
				<table class="table table-striped">
					<tr>
						<td><strong>Código:</strong></td>
						<td><input class="uppercase" id="codigo" name="codigo" type="text" value="${referencia.codigo}" readonly></td>
		       		</tr>
		       		<tr>
		       			<td><strong>Descripción:</strong></td>
		       			<td><textarea class="uppercase" name="descripcion" rows="2" cols="75" readonly>${referencia.descripcion}</textarea></td>
		       		</tr>
		       		<tr>
		       			<td><strong>Componente:</strong></td>
		       			<td><textarea class="uppercase" name="componente" rows="2" cols="75" readonly>${referencia.componente}</textarea></td>
		       		</tr>
		       		<tr>
		       			<td><strong>Presentación:</strong></td>
		       			<td><textarea class="uppercase" name="presentacion" rows="2" cols="75" readonly>${referencia.presentacion}</textarea></td>
		       		</tr>
		       		<tr>
		       			<td><strong>Fabricante:</strong></td>
		       			<td>
		       				<select id="fabricante" name="fabricante" disabled>
		       					<c:forEach items="${fabricantes}" var="fabricante">
		       						<option value="${fabricante.codigo}">${fabricante.codigo} - ${fabricante.nombre}</option>
		       					</c:forEach>
		       				</select>
						</td>
		       		</tr>
		       		<tr>
		       			<td><strong>Categoría:</strong></td>
		       			<td>
		       				<select id="categoria" name="categoria" disabled>
		       					<c:forEach items="${categorias}" var="categoria">
		       						<option value="${categoria.codigo}">${categoria.codigo} - ${categoria.nombre}</option>
		       					</c:forEach>
		       				</select>
						</td>
		       		</tr>
		       		<tr>
		       			<td><strong>Observación:</strong></td>
		       			<td><textarea class="uppercase" name="observacion" rows="5" cols="75" readonly>${referencia.observacion}</textarea></td>
		       		</tr>
		       		<tr>
		       			<td><strong>Cantidad minima:</strong></td>
		       			<td><input class="uppercase"  name="cant_mini" type="text" value="${referencia.cant_mini}" readonly></td>
		       		</tr>
		       		<tr>
		       			<td><strong>Cantidad disponible:</strong></td>
		       			<td><input class="uppercase"  name="cantidad" type="text" value="${referencia.cantidad}" readonly></td>
		       		</tr>
				</table>
					<input type="submit" class="btn btn-primary" value="Editar" tabindex="8">
				</form>
				
				<h2>Cantidades en Bodegas</h2>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>
								Bodega
							</th>
							<th>
								Referencia
							</th>
							<th>
								Cantidad
							</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="inven" items="${inventarios}">
							<tr>
								<td>${inven.bodega}</td>
								<td>${inven.refe}</td>
								<td>${inven.cantidad}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<t:regresar></t:regresar>
				<script src="${pageContext.request.contextPath}/js/jquery.filtertable.min.js" type="text/javascript"></script>
				<script type="text/javascript">
					$(document).ready(function() {
				        $('table').filterTable();
				    });
					
					$("#categoria").val('${referencia.categoria}');
					$("#fabricante").val('${referencia.fabricante}');
				</script>
			</div>
		</div>
	</jsp:attribute>
</t:layout>