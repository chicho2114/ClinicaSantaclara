<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Sistema de control - Policlínica Santa Clara">
	<jsp:attribute name="body">
		<div class="container">
			<div class="row-fluid">
				<script type="text/javascript">
				function buscarRef() {
					var ref = document.getElementById("referencia").value;
				    
				    if(ref != "") {
				    	var xmlHttp = null;

				        xmlHttp = new XMLHttpRequest();
				        xmlHttp.open( "GET", "${pageContext.request.contextPath}/referencias/consultar_json?codigo="+ref, false );
				        xmlHttp.send( null );
				        //document.getElementById("ref").innerHTML = xmlHttp.responseText;
				        var rta= JSON.parse(xmlHttp.responseText);

				        if(rta.codigo) {
				        	document.getElementById("ref").value = rta.descripcion;
				        }
				    }
				    else {
				    	document.getElementById("ref").value = "";
				    }
				}
				</script>
				<c:choose>
					<c:when test="${!(UserRol eq ('[ROLE_NOUSUARIO]')) }">
				<h2>Crear ajuste puntual</h2>
				<p>Complete la información solicitada</p>
				<div id="error">
				</div>
				<form action="${pageContext.request.contextPath}/referencias/crear_ajuste_accion" method="post"
					  id="crearAjuste">
					<table class="table table-striped">
						<tr>
							<td><strong>Código de ajuste:</strong></td>
							<td><input class="uppercase" id="codigo" name="codigo" type="text" value="${ajuste}" readonly /></td>
			       		</tr>
			       		<tr>
			       			<td><strong>Referencia:</strong></td>
			       			<td><input class="uppercase" name="referencia" id="referencia"/>&nbsp;<input id="ref" name="ref" readonly />&nbsp;<input type="button" value= "Buscar Referencia" onclick="buscarRef();"></td>
			       		</tr>
			       		<tr>
			       			<td><strong>Cantidad:</strong></td>
			       			<td><input id="cantidad" name="cantidad" type="number"/></td>
			       		</tr>
			       		<tr>
			       			<td><strong>Bodega:</strong></td>
			       			<td>
			       				<select id="bodega" name="bodega">
								<option value=""></option>
								<c:forEach var="bodega" items="${bodegas}">
									<option value="${bodega.codigo}">${bodega.codigo} - ${bodega.nombre}</option>
								</c:forEach>
								</select>
							</td>
			       		</tr>
					</table>
					<input type="submit" class="btn btn-primary" value="Crear ajuste" />
				</form>
				<h2>Crear ajustes a partir de un archivo</h2>
				<p>Por favor seleccione un archivo .CSV guardado en su computador para subirlo al sistema.</p>
				<div id="error">
				</div>
				<form action="${pageContext.request.contextPath}/referencias/crear_ajuste_archivo_accion" method="post"
					  id="crearArchivo" enctype="multipart/form-data" accept-charset="UTF-8">
					<table class="table table-striped">
						<tr>
							<td><strong>Archivo de referencias:</strong></td>
							<td><input type="file" id="arcAjuste" name="arcAjuste" accept=".csv" required /></td>
			       		</tr>
					</table>
					<input type="submit" class="btn btn-primary" value="Subir archivo" />
				</form>
				<!-- --------------------------------------------------------Si no tiene permisos---------------- -->
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
				<script type="text/javascript">
				    $(function(){
				        $('#crearAjuste').validate({
				        	errorClass: "invalid", 
				        	errorLabelContainer : "#error",
				        	wrapper: "li",
				            rules :{
				                codigo : {
				                    required : true
				                },
				                referencia : {
				                    required : true
				                },
				                ref : { 
				                	required : true
				                },
				                cantidad : { 
				                	required : true
				                },
				                bodega : {
				                	required : true
				                }
				            },
				            messages : {
				            	codigo : {
				                    required : "Código de ajuste es requerido"
				                },
				                referencia : {
				                    required : "Referencia es requerido"
				                },
				                ref : { 
				                	required : "Referencia es requerido"
				                },
				                cantidad : { 
				                	required : "Cantidad es requerido"
				                },
				                bodega : {
				                	required : "Bodega es requerido"
				                }
				            }
				        });    
				    });
				</script>
			</div>
		</div>
	</jsp:attribute>
</t:layout>