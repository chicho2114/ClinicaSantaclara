<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<t:layout title="Sistema de Control - Policlínica Santa Clara">
	<jsp:attribute name="body">
		<div class="container">
			<div class="row-fluid">
				<h2>Ver Insumo: ${insumo.codcaja} - ${insumo.codref}</h2>
				<form action="${pageContext.request.contextPath}/insumos/editar" method="post"
					  id="editarInsumo">
					<table class="table table-striped">
						<tr>
							<td><strong>Código Caja:</strong></td>
							<td><input class="uppercase" id="codigo" name="codcaja" type="text" value="${insumo.codcaja}" readonly></td>
			       			<td><strong>Codigo Referencia:</strong></td>
			       			<td><input class="uppercase" name="codref" type="text" value="${insumo.codref}" readonly></td>
			       		
			       		</tr>
			       		<tr>
			       			<td><strong>Codigo Proveedor:</strong></td>
			       			<td><input class="uppercase" name="proveedor" type="text" value="${insumo.proveedor}" readonly></td>
			       			<td><strong>Codigo Bodega:</strong></td>
			       			<td><input class="uppercase" name="bodega" type="text" value="${insumo.bodega}" readonly></td>
			       		
			       		</tr>
			       	
			       		<tr>
			       			<td><strong>Fabricante:</strong></td>
			       			<td><input class="uppercase" name="fabricante" type="text" value="${insumo.fabricante}" readonly></td>
			       			<td><strong>Cantidad disponible:</strong></td>
			       			<td><input class="uppercase" name="cantInsumos" type="text" value="${insumo.cantInsumos}" readonly></td>
			       		
			       		</tr>
			       		
			       		<tr>
			       			<td><strong>Precio de compra:</strong></td>
			       			<td><input class="uppercase" name="precioComp" type="text" value="${insumo.precioComp}" readonly></td>
			       			<td><strong>Precio de venta general:</strong></td>
			       			<td><input class="uppercase" name="precioVent" type="text" value="${insumo.precioVent}" readonly></td>
			       		
			       		</tr>
			       		
			       		<tr>
			       			<td><strong>Fecha de compra:</strong></td>
			       			<td><input class="uppercase" name="fechaComp" type="text" value="${insumo.fechaComp}" readonly></td>
			       			<td><strong>Fecha de vencimiento:</strong></td>
			       			<td><input class="uppercase" name="fechaVenc" type="text" value="${insumo.fechaVenc}" readonly></td>
			       		
			       		</tr>
			       		
			       		<tr>
			       			<td><strong>Creado por el usuario:</strong></td>
			       			<td><input class="uppercase" name="usuaCrea" type="text" value="${insumo.usuaCrea}" readonly></td>
			       			<td><strong>Fecha de creación:</strong></td>
			       			<td><input class="uppercase" name="fechaCrea" type="text" value="<fmt:formatDate value="${insumo.fechaCrea}" pattern="yyyy-MM-dd hh:mm a" />" readonly></td>
			       		
			       		</tr>
			       		
	
	
					</table>
					<c:if test="${!(UserRol eq ('[ROLE_NOUSUARIO]')) }">
						<button class="btn btn-primary" type="submit">Editar Cliente</button>
					</c:if>
				</form>
				
				<t:regresar></t:regresar>
			</div>
		</div>
	</jsp:attribute>
</t:layout>