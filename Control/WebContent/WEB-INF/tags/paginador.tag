<%@ tag description="Paginador" language="java" pageEncoding="UTF-8"%>
<%@ attribute name="paginaActiva" required="true" %>
<%@ attribute name="numeroPaginas" required="true" %>
<%@ attribute name="offset" required="true" %>
<%@ attribute name="link" required="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="pagination pagination-right">
	<ul>
		<c:if test="${atras eq '1'}">
			<li><a href="${pageContext.request.contextPath}${link}&pagina=${offset}">&#171;</a></li>
		</c:if>
		<c:forEach var="i" begin="1" end="${numeroPaginas}">
			<c:choose>
				<c:when test="${pagina eq i+offset}">
					<li class="active"><a href="${pageContext.request.contextPath}${link}&pagina=${i+offset}">${i+offset}</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="${pageContext.request.contextPath}${link}&pagina=${i+offset}">${i+offset}</a></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		<c:if test="${siguiente eq '1'}">
			<li><a href="${pageContext.request.contextPath}${link}&pagina=${numeroPaginas+offset+1}">&#187;</a></li>
		</c:if>
	</ul>
</div>
