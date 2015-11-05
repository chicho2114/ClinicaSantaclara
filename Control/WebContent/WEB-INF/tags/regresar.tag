<%@ tag description="Paginador" language="java" pageEncoding="UTF-8"%>
<%@ attribute name="orientacion" required="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:if test="${empty orientacion}">
	<c:set var="orientacion" value="right" />
</c:if>

<div style="text-align: ${orientacion};">
	<button class="btn-primary" onclick="javascript:history.back(1);">Regresar</button>
</div>