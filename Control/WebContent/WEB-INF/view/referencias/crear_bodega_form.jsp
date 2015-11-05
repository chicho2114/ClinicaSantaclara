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
			        xmlHttp.open( "GET", "${pageContext.request.contextPath}/referencias/consultar_bodega?codigo="+selectedValue, false );
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
				<h2>Crear bodega</h2>
				<p>Por favor, complete la información solicitada</p>
				<div id="error">
				</div>
				<form action="${pageContext.request.contextPath}/referencias/crear_bodega_accion" method="post"
					  id="crearBodega">
					<table class="table table-striped">
						<tr>
							<td><strong>Código de bodega:</strong></td>
							<td><input type="text" class="uppercase" id="codigo" name="codigo" /></td>
			       		</tr>
			       		<tr>
			       			<td><strong>Nombre de bodega:</strong></td>
			       			<td><input type="text" class="uppercase" id="nombre" name="nombre"></td>
			       		</tr>
					</table>
					<input type="submit" class="btn btn-primary" value="Crear bodega" />
				</form>
				<h2>Consultar bodega</h2>
				<p>Consulte referencias por la bodega en que se encuentran</p>
				<table>
					<tr>
						<td>
							<select id="selectBox">
								<option value=""></option>
								<c:forEach var="bodega" items="${bodegas}">
									<option value="${bodega.codigo}">${bodega.codigo} - ${bodega.nombre}</option>
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
				<t:regresar></t:regresar>
			</div>
		</div>
	</jsp:attribute>
</t:layout>