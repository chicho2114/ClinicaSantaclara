<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Sistema de control - Policlínica Santa Clara">
	<jsp:attribute name="body">
	<div class="container">
	 <div class="row-fluid">
		<!-- Información -->
		<div class="container">
			<div class="row">
				<div class="span12">
					<div class="head">
						<div class="row-fluid">
						    <div class="span12">
								<!-- <img src="${pageContext.request.contextPath}/images/hero-unit.png" /> -->
						    </div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="container">
		
			<br>
			<form action="${pageContext.request.contextPath}/usuarios/cambiar_contrasena_accion" method="post" autocomplete="off"
				  id="cambioContrasena">
   				<fieldset class="scheduler-border">
   					<h1>Cambio de contrasena</h1>
   					<div id="error">
   					</div>
   					<div>
   						<h4>Políticas de contraseñas</h4>
   						<ul>
   							<li>Contener 8 caracteres</li>
   							<li>Deberá ser alfa / numérico, y sólo los caracteres especiales $, #, @ están permitidos</li>
   							<li>Tener al menos dos letras al principio</li>
   							<li>La primera letra mayúscula</li>
   							<li>Por lo menos un dígito numérico al final</li>
   							<li>Que no sea el nombre de usuario ni al derecho ni al revés</li>
   							<li>No ser igual a las cuatro contraseñas anteriores</li>
   							<li><b>LA CONTRASEÑA TENDRÁ UNA VIGENCIA DE 45 DÍAS</b></li>
   						</ul>
   					</div>
   					<div class="control-group" style="text-align: center;">
        				<label class="control-label input-label" for="j_username"><i class="icon-user"></i>&nbsp;&nbsp;Contraseña anterior:</label>
        				<div class="controls">
            				<input type="password" id="contAnterior" name="contAnterior" placeholder="Contraseña anterior" required />
        				</div>
        				<label class="control-label input-label" for="contrasena"><i class="icon-lock"></i>&nbsp;&nbsp;Nueva contraseña:</label>
        				<div class="controls">
            				<input type="password" id="contrasena" name="contrasena" placeholder="Nueva contraseña" required />
        				</div>
        				<label class="control-label input-label" for="contrasena2"><i class="icon-lock"></i>&nbsp;&nbsp;Repita nueva contraseña:</label>
        				<div class="controls">
            				<input type="password" id="contrasena2" name="contrasena2" placeholder="Repita nueva contraseña" required />
        				</div>
        				<div class="controls">
        					<input type="submit" class="btn btn-primary" value="Cambiar contraseña" />
        				</div>
   					</div>
				</fieldset>
   			</form>
		</div>
	</div>
</div>
		<script type="text/javascript">
			$(function() {
				$('#cambioContrasena').validate({
					focusInvalid : false,
		        	onkeyup : false,
		        	onfocusout : false,
		        	errorClass: "invalid", 
		        	errorLabelContainer : "#error",
		        	wrapper: "li",
					rules : {
						contrasena : {
							required : true,
							length : 8
						},
						contrasena2 : {
							required : true,
							equalTo : "#contrasena"
						}
					},
					messages : {
						contrasena : {
							required : "El campo 'Contraseña' es requerido",
							length : "La contraseña debe contener 8 caracteres"
						},
						contrasena2 : {
							required : "Debe repetir la contraseña",
							equalTo : "Las contraseñas deben coincidir"
						}
					}
				});
			});
		</script>
	</jsp:attribute>
</t:layout>