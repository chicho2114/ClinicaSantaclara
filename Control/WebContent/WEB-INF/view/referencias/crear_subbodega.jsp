<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Sistema de control - Policlínica Santa Clara">
	<jsp:attribute name="body">
		<script>
			function buscar() {
				var selectBox = document.getElementById("selectBox");
			    var selectedValue = selectBox.options[selectBox.selectedIndex].value;
			    
			    if(selectedValue != "") {
			    	var xmlHttp = null;

			        xmlHttp = new XMLHttpRequest();
			        xmlHttp.open( "GET", "${pageContext.request.contextPath}/referencias/consultar_subbodega?codigo="+selectedValue, false );
			        xmlHttp.send( null );
			        document.getElementById("referencias").innerHTML = xmlHttp.responseText;
			    }
			    else {
			    	document.getElementById("referencias").innerHTML = "";
			    }
			}
			
		</script>
		<div class="container">
			<div class="row-fluid">
			<c:choose>
				<c:when test="${!(UserRol eq ('[ROLE_NOUSUARIO]')) }">
				<h2>Crear Sub-bodega</h2>
				<p>Por favor, complete la información solicitada</p>
				<div id="error">
				</div>
				<form action="${pageContext.request.contextPath}/referencias/crear_subbodega_accion" method="post"
					  id="crearBodega">
					<table class="table table-striped">
						<tr>
							<td><strong>Código de Sub-bodega:</strong></td>
							<td><input type="text" class="uppercase" id="codigo" name="codigo" /></td>
			       		</tr>
			       		<tr>
			       			<td><strong>Nombre de la Sub-bodega:</strong></td>
			       			<td><input type="text" class="uppercase" id="nombre" name="nombre"></td>
			       		</tr>
					</table>
					<input type="submit" class="btn btn-primary" value="Crear Sub-bodega" />
				</form>

				<h2>Consultar Sub-bodega</h2>
				<p>Consulte insumos por la sub-bodega en que se encuentran</p>
				<table>
					<tr>
						<td>
							<select id="selectBox">
								<option value=""></option>
								<c:forEach var="subbodega" items="${subbodegas}">
									<option value="${subbodega.codigo}">${subbodega.codigo} - ${subbodega.nombre}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td>
							<button class="btn btn-primary" onclick="buscar();">Buscar</button>
						</td>
					</tr>
				</table>
				<div id="referencias">
				</div>
				<script type="text/javascript">
				    $(function(){
				        $('#crearBodega').validate({
				        	errorClass: "invalid", 
				        	errorLabelContainer : "#error",
				        	wrapper: "li",
				            rules :{
				                codigo : {
				                    minlength : 3
				                },
				                nombre : {
				                    minlength : 1
				                }
				            },
				            messages : {
				            	codigo : {
				            		minlength : "El campo 'Código de bodega' debe tener, mínimo, 3 caracteres"
				            	},
				            	nombre : {
				            		minlength : "El campo 'Nombre' debe tener, mínimo, 1 caracter"
				            	}
				            }
				        });    
				    });
				</script>
				
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
	</jsp:attribute>
</t:layout>