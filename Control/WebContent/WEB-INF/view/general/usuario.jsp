<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Sistema de control - Policlínica Santa Clara">
	<jsp:attribute name="body">
		<div class="container">
			<div class="row-fluid">
				<p>Bienvenido, <strong>${usuario.nombre}</strong></p>
				<p><strong>POR FAVOR, SELECCIONE UNA OPCION</strong></p>
				<img src="${pageContext.request.contextPath}/images/hospital.jpg" />
		   	</div>
		</div>
	</jsp:attribute>
</t:layout>