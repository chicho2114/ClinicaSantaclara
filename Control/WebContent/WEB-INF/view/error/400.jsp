<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page import="com.control.general.ManejadorMensajes" %>
<%@ page import="com.control.general.TipoMensaje" %>

<% ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, "Ocurrió un error al ejecutar la solicitud"); %>

<t:layout title="Sistema de control - Policlínica Santa Clara">
	<jsp:attribute name="body">
		<h1 style="text-align: center;">Error 400</h1>
		<p style="text-align: center;"><strong>Error:</strong> Solicitud incorrecta.</p>
		<p style="text-align: center;">La solicitud que envió era sintácticamente incorrecta.</p>
		<p style="text-align: center;"><img src="${pageContext.request.contextPath}/images/warning.png" /></p>
		<t:regresar orientacion="center" />
	</jsp:attribute>
</t:layout>