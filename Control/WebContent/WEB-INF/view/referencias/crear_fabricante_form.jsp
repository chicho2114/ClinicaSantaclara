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
			        xmlHttp.open( "GET", "${pageContext.request.contextPath}/referencias/consultar_fabricante?codigo="+selectedValue, false );
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
				<h2>Crear fabricante</h2>
				<p>Por favor, complete la información solicitada</p>
				<div id="error">
				</div>
				<form action="${pageContext.request.contextPath}/referencias/crear_fabricante_accion" method="post"
					  id="crearFabricante">
					<table class="table table-striped">
						<tr>
							<td><strong>Código de fabricante:</strong></td>
							<td><input type="text" class="uppercase" id="codigo" name="codigo" /></td>
			       		</tr>
			       		<tr>
			       			<td><strong>Nombre de fabricante:</strong></td>
			       			<td><input type="text" class="uppercase" id="nombre" name="nombre"></td>
			       		</tr>
					</table>
					<input type="submit" class="btn btn-primary" value="Crear fabricante" />
				</form>
				<h2>Consultar fabricantes</h2>
				<p>Consulte referencias por su fabricante </p>
				<table>
					<tr>
						<td>
							<select id="selectBox">
								<option value=""></option>
								<c:forEach var="fabricante" items="${fabricantes}">
									<option value="${fabricante.codigo}">${fabricante.codigo} - ${fabricante.nombre}</option>
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
				        $('#crearFabricante').validate({
				        	errorClass: "invalid", 
				        	errorLabelContainer : "#error",
				        	wrapper: "li",
				            rules :{
				                codigo : {
				                    required : true
				                },
				                nombre : {
				                    required : true
				                }
				            },
				            messages : {
				            	codigo : {
				            		required : "El campo 'Código de fabricante' es requerido"
				            	},
				            	nombre : {
				            		required : "El campo 'Nombre' es requerido"
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