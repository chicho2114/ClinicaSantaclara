<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Sistema de Control - Policlínica Santa Clara">
	<jsp:attribute name="body">
		<div class="container">
			<div class="row-fluid">
				<h2>Editar Insumo: ${insumo.codcaja} - ${insumo.codref}</h2>
				<p><strong>NOTA:</strong> Los campos dejados en blanco o sin modificar no seran afectados.</p>
				<form action="${pageContext.request.contextPath}/insumos/editar_insumo" method="post"
					  id="editarInsumo">
					<table class="table table-striped">
						<tr>
							<td><strong>Código Caja:</strong></td>
							<td><input class="uppercase" name="codcaja" type="text" value="${insumo.codcaja}" readonly></td>
			       			<td><strong>Codigo Referencia:</strong></td>
			       			<td><input class="uppercase" name="codref" type="text" placeholder="${insumo.codref}" value="${insumo.codref}" readonly></td>
			       		
			       		</tr>
			       		<tr>
			       			<td><strong>Codigo Proveedor:</strong></td>
			       			<td><input class="uppercase" name="proveedor" type="text" placeholder="${insumo.proveedor}" value="${insumo.proveedor}" readonly></td>
			       			<td><strong>Codigo Bodega:</strong></td>
			       			<td><select name="bodega" tabindex="2">
				       					<c:forEach items="${bodegas}" var="bodega">
				       						<c:choose>
				       						<c:when test="${insumo.bodega == bodega.codigo}">
				       							<option selected value="${bodega.codigo}">${bodega.codigo} - ${bodega.nombre}</option>
				       						</c:when>
				       						<c:otherwise>
				       							<option value="${bodega.codigo}">${bodega.codigo} - ${bodega.nombre}</option>
				       						</c:otherwise>
				       						</c:choose>
				       					</c:forEach>
				       				</select></td>
			       		
			       		</tr>
			       	
			       		<tr>
			       			<td><strong>Cantidad disponible:</strong></td>
			       			<td><input class="uppercase numeric" name="cantInsumos" placeholder="${insumo.cantInsumos}" required type="number" value="${insumo.cantInsumos}"></td>
			       			<td></td>
			       			<td></td>
			       		</tr>
			       		
			       		<tr>
			       			<td><strong>Precio de compra:</strong></td>
			       			<td><input class="uppercase" name="precioComp" type="text" placeholder="${insumo.precioComp}" value="${insumo.precioComp}" readonly></td>
			       			<td><strong>Precio de venta general:</strong></td>
			       			<td><input class="uppercase" name="precioVent" type="text" placeholder="${insumo.precioVent}" required value="${insumo.precioVent}"></td>
			       		
			       		</tr>
			       		
			       		<tr>
			       			<td><strong>Fecha de compra:</strong></td>
			       			<td><input class="uppercase" name="fechaComp" type="text" placeholder="${insumo.fechaComp}" value="${insumo.fechaComp}" readonly></td>
			       			<td><strong>Fecha de vencimiento:</strong></td>
			       			<td><input class="uppercase" name="fechaVenc" type="text" placeholder="${insumo.fechaVenc}" value="${insumo.fechaVenc}" readonly></td>
			       		
			       		</tr>
			       			
					</table>
					<input type="submit" class="btn btn-primary" value="Confirmar" tabindex="8">
					
				</form>
				<a href="${pageContext.request.contextPath}/insumos/eliminar?codcaja=${insumo.codcaja}&codref=${insumo.codref}&bodega=${insumo.bodega}"><button class="btn btn-danger">Eliminar</button></a>
				<t:regresar></t:regresar>
			</div>
		</div>
	</jsp:attribute>
</t:layout>