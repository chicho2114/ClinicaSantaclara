<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Sistema de Control - Policlínica Santa Clara">
	<jsp:attribute name="body">
		<div class="container">
			<div class="row-fluid">
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
				
					<a href="${pageContext.request.contextPath}/proveedores/eliminar?codigo=${proveedor.codigo}"><button class="btn btn-danger">Eliminar</button></a>
				<t:regresar></t:regresar>
			</div>
		</div>
	</jsp:attribute>
</t:layout>