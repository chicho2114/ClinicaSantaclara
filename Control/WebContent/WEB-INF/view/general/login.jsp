<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Sistema de control - Policlínica Santa Clara">
	<jsp:attribute name="body">
		
		<!-- Información -->
		
		<div class="container">
			<div class="row-fluid">
				<div class="span6">
					<img src="http://dummyimage.com/570x400/000/fff" />
				</div>
				<div class="span6">
					<form action="${pageContext.request.contextPath}/j_spring_security_check" method="post" autocomplete="off">
						<h1>Ingreso</h1>
		   				<fieldset class="scheduler-border">
		   					<legend class="scheduler-border"></legend>
		   					<div class="control-group" style="text-align: center;">
		        				<label class="control-label input-label" for="j_username"><i class="icon-user"></i>&nbsp;&nbsp;Nombre de usuario:</label>
		        				<div class="controls">
		            				<input type="text" id="j_username" name="j_username" placeholder="Nombre de usuario" />
		        				</div>
		        				<label class="control-label input-label" for="j_password"><i class="icon-lock"></i>&nbsp;&nbsp;Contraseña:</label>
		        				<div class="controls">
		            				<input type="password" id="j_password" name="j_password" placeholder="Contraseña" />
		        				</div>
		        				<div class="controls">
		        					<input type="submit" class="btn btn-primary" value="Ingresar" />
		        				</div>
		   					</div>
						</fieldset>
		   			</form>
	   			</div>
   			</div>
		</div>
		
	</jsp:attribute>
</t:layout>