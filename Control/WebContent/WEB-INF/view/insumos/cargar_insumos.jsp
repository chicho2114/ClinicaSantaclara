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
				<h2>Cargar insumos</h2>
				<p>Complete la información solicitada</p>
				<div id="error">
				</div>
				<form action="${pageContext.request.contextPath}/insumos/crear_accion" method="post"
					  id="cargarInsumo">
					<table class="table table-hover">
						<tr>	
							<td><strong>Codigo de caja:</strong></td>
							<td><input class="uppercase" name="codcaja" type="text" tabindex="2" required></td>
			       		</tr>
						<tr>
							<td><strong>Codigo Referencia:</strong></td>
							<td>	
			       				<select id="referencia" name="referencia" tabindex="5">
			       					<c:forEach items="${referencias}" var="referencia">
			       						<option value="${referencia.codigo}">${referencia.codigo}</option>
			       					</c:forEach>
			       				</select>
			       				<input type="text" id="entrada">
			       			</td>
			       		</tr>
			       		<tr>
			       			<td><strong>Codigo Proveedor:</strong></td>
			       			<td>
			       				<select name="proveedor" tabindex="5">
			       					<c:forEach items="${proveedores}" var="proveedor">
			       						<option value="${proveedor.codigo}">${proveedor.codigo} - ${proveedor.nombre}</option>
			       					</c:forEach>
			       				</select>
							</td>
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
				       		<td><strong>Bodega:</strong></td>
				       			<td>
				       				<select name="bodega" tabindex="2">
				       					<c:forEach items="${bodegas}" var="bodega">
				       						<option value="${bodega.codigo}">${bodega.codigo} - ${bodega.nombre}</option>
				       					</c:forEach>
				       				</select>
				       			</td>
				       			
				       	</tr>
				       	<tr>
			       			<td><strong>Cantidad:</strong></td>
			       			<td><input class="uppercase numeric" name="cantidad" type="text" tabindex="2" required></td>
			       		</tr>
			       		<tr>
			       			<td><strong>Precio de compra:</strong></td>
			       			<td>
			       			<span class="add-on">Bs:</span>
			       			<input class="uppercase numeric" name="precioComp" type="text" tabindex="1" required>
			       			</td>
			       		</tr>
			       		<tr>
			       			<td><strong>Precio de venta al publico:</strong></td>
			       			<td>
			       			<span class="add-on">Bs:</span>
			       			<input class="uppercase numeric" name="precioVent" type="text" tabindex="2" required></td>
			       		</tr>
			       		<tr>
			       			<td><strong>Fecha de compra:</strong></td>
			       			<td><input class="uppercase datepicker" name="fechaComp" type="text" tabindex="2"></td>
			       		</tr>
			       		<tr>
			       			<td><strong>Fecha de vencimiento:</strong></td>
			       			<td><input class="uppercase datepicker" name="fechaVenc" type="text" tabindex="2"></td>
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
		<script>			
			jQuery.fn.filterByText = function(textbox, selectSingleMatch) {
		        return this.each(function() {
		            var select = this;
		            var options = [];
		            $(select).find('option').each(function() {
		                options.push({value: $(this).val(), text: $(this).text()});
		            });
		            $(select).data('options', options);
		            $(textbox).bind('change keyup', function() {
		                var options = $(select).empty().data('options');
		                var search = $(this).val().trim();
		                var regex = new RegExp(search,"gi");
		              
		                $.each(options, function(i) {
		                    var option = options[i];
		                    if(option.text.match(regex) !== null) {
		                        $(select).append(
		                           $('<option>').text(option.text).val(option.value)
		                        );
		                    }
		                });
		                if (selectSingleMatch === true && $(select).children().length === 1) {
		                    $(select).children().get(0).selected = true;
		                }
		            });            
		        });
		    };

		    $(function() {
		        $('#referencia').filterByText($('#entrada'), true);
		      
		    });
		    

		</script>

	</jsp:attribute>
</t:layout>