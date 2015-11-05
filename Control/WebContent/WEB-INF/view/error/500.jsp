<%@ page isErrorPage="true" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page import="com.control.general.ManejadorMensajes"%>
<%@ page import="com.control.general.TipoMensaje"%>

<% ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, "Ocurrió un error al ejecutar la solicitud"); %>

<t:layout title="Sistema de control - Policlínica Santa Clara">
	<jsp:attribute name="body">
		<h1 style="text-align: center;">Error 500: Error interno de servidor</h1>
		<div class="container">
			${pageContext.exception}
			<br/><br/>Stacktrace:<br/>
			<c:forEach var="trace" items="${pageContext.exception.stackTrace}">
				- ${trace}<br/>
			</c:forEach>
		</div>
		<t:regresar orientacion="center" />
	</jsp:attribute>
</t:layout>