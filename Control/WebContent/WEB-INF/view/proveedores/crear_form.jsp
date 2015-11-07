<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Sistema de control - Policlínica Santa Clara">
	<jsp:attribute name="body">
		<div class="container">
			<div class="row-fluid">
				<h2>Crear Proveedor</h2>
				<p>Complete la información solicitada</p>
				<div id="error">
				</div>
				<form action="${pageContext.request.contextPath}/proveedores/crear_accion" method="post"
					  id="crearUsuario">
					<table class="table table-hover">
						<tr>
							<td><strong>Codigo Proveedor:</strong></td>
							<td><input class="uppercase" id="codigo" name="codigo" type="text" tabindex="1"></td>
			       		</tr>
			       		<tr>
			       			<td><strong>Nombre:</strong></td>
			       			<td><input class="uppercase" name="nombre" type="text" tabindex="2"></td>
			       		</tr>
			       		<tr>
			       			<td><strong>Telefono:</strong></td>
			       			<td><textarea class="uppercase" name="telefono" rows="2" cols="75" tabindex="3"></textarea></td>
			       		</tr>
					</table>
					<input type="submit" class="btn btn-primary" value="Crear" tabindex="8">
				</form>
				<t:regresar></t:regresar>
			</div>
		</div>
	</jsp:attribute>
</t:layout>