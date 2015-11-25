<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Sistema de Control - Policlínica Santa Clara">
	<jsp:attribute name="body">
		<div class="container">
			<div class="row-fluid">
				<h2>Editar referencia: ${referencia.codigo} - ${referencia.descripcion}</h2>
				<p><strong>NOTA:</strong> Los campos dejados en blanco o sin modificar no seran afectados.</p>
				<form action="${pageContext.request.contextPath}/referencias/editar_ref" method="post"
					  id="editarReferencia">
					<table class="table table-hover">
						<tr>
							<td><strong>Código:</strong></td>
							<td><input class="uppercase" name="codigo" type="text" value="${referencia.codigo}" readonly></td>
			       		</tr>
			       		<tr>
			       			<td><strong>Descripción:</strong></td>
			       			<td><textarea class="uppercase" name="descripcion" rows="2"  cols="75" placeholder="${referencia.descripcion }" tabindex="2"  required>${referencia.descripcion}</textarea></td>
			       		</tr>
			       		<tr>
			       			<td><strong>Componente:</strong></td>
			       			<td><textarea class="uppercase" name="componente" rows="2" cols="75" placeholder="${referencia.componente }" tabindex="3"  required>${referencia.componente}</textarea></td>
			       		</tr>
			       		<tr>
			       			<td><strong>Presentación:</strong></td>
			       			<td><textarea class="uppercase" name="presentacion" placeholder="${referencia.presentacion }" rows="2" cols="75" tabindex="4"  required>${referencia.presentacion}</textarea></td>
			       		</tr>
			       		<tr>
			       			<td><strong>Fabricante:</strong></td>
			       			<td>
			       				<select name="fabricante" tabindex="5">
			       					<c:forEach items="${fabricantes}" var="fabricante">
			       						<c:choose>
				       						<c:when test="${fabricante.codigo == referencia.fabricante}">
				       							<option selected value="${fabricante.codigo}">${fabricante.codigo} - ${fabricante.nombre}</option>
				       						</c:when>
				       						<c:otherwise>
				       							<option value="${fabricante.codigo}">${fabricante.codigo} - ${fabricante.nombre}</option>
				       						</c:otherwise>
				       					</c:choose>
			       					</c:forEach>
			       				</select>
							</td>
			       		</tr>

			       		<tr>
			       			<td><strong>Categoría:</strong></td>
			       			<td>
			       				<select name="categoria" tabindex="6">
			       					<c:forEach items="${categorias}" var="categoria">
			       						<c:choose>
				       						<c:when test="${categoria.codigo == referencia.categoria}">
				       							<option selected value="${categoria.codigo}">${categoria.codigo} - ${categoria.nombre}</option>
				       						</c:when>
				       						<c:otherwise>
				       							<option value="${categoria.codigo}">${categoria.codigo} - ${categoria.nombre}</option>
				       						</c:otherwise>
				       					</c:choose>
			       					</c:forEach>
			       				</select>
							</td>
			       		</tr>
			       		<tr>
			       			<td><strong>Observación:</strong></td>
			       			<td><textarea class="uppercase" name="observacion" rows="5" placeholder="${referencia.observacion }" cols="75" tabindex="7" required>${referencia.observacion }</textarea></td>
			       		</tr>
						<tr>
							<td><strong>Cantidad minima:</strong></td>
							<td><input class="uppercase numeric" name="cant_minima" type="text" value="${referencia.cant_mini }" placeholder="${referencia.cant_mini }" tabindex="1" required><p> <span class="label label-info">Representa la cantidad minima <br>que se permitira en almacen</span></p></td>
			       		</tr>
			       		<tr>
							<td><strong>Cantidad disponible:</strong></td>
							<td><input class="uppercase numeric" name="cantidad" type="text" value="${referencia.cantidad }" placeholder="${referencia.cantidad }" tabindex="1" required readonly></td>
			       		</tr>
					</table>
					<input type="submit" class="btn btn-primary" value="Confirmar" tabindex="8">
				</form>
				
					<a href="${pageContext.request.contextPath}/referencias/eliminar?codigo=${referencia.codigo}"><button class="btn btn-danger">Eliminar</button></a>
				<t:regresar></t:regresar>
			</div>
		</div>
	</jsp:attribute>
</t:layout>