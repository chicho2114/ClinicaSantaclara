<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Sistema de control - Policlínica Santa Clara">
	<jsp:attribute name="body">
		<div class="container">
			<div class="row-fluid">
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
				<t:regresar></t:regresar>
			</div>
		</div>
	</jsp:attribute>
</t:layout>