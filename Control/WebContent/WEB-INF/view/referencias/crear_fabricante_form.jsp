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
				<t:regresar></t:regresar>
			</div>
		</div>
	</jsp:attribute>
</t:layout>