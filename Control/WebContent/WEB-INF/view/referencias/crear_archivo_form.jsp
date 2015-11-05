<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<t:layout title="Sistema de control - Policlínica Santa Clara">
	<jsp:attribute name="body">
		<div class="container">
			<div class="row-fluid">
				<h2>Crear referencias a partir de un archivo</h2>
				<p>Por favor seleccione un archivo .CSV guardado en su computador para subirlo al sistema.</p>
				<div id="error">
				</div>
				<form action="${pageContext.request.contextPath}/referencias/crear_archivo_accion" method="post"
					  id="crearArchivo" enctype="multipart/form-data" accept-charset="UTF-8">
					<table class="table table-striped">
						<tr>
							<td><strong>Archivo de referencias:</strong></td>
							<td><input type="file" id="arcParte" name="arcParte" accept=".csv" required /></td>
			       		</tr>
					</table>
					<input type="submit" class="btn btn-primary" value="Subir archivo" />
				</form>
				<t:regresar></t:regresar>
			</div>
		</div>
	</jsp:attribute>
</t:layout>