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
				    <div class="row">
					
			          <div class="span4">
			          
			            <ul class="nav nav-pills nav-tabs nav-stacked" id="myTab">
					      <li><a href="${pageContext.request.contextPath}/#home" data-toggle="tab"><i class="icon-home"></i> Inicio</a></li>
					      <c:choose>
					      	<c:when test="${ insumos.size() != 0}">
					      		<li><a href="#vencidos" data-toggle="tab"><i class="icon-calendar"></i> Insumos proximos a vencer <span class="label label-warning text-right">Warning</span></a> </li>
					      	</c:when>
					      	<c:otherwise>
					      		<li ><a href="#vencidos" data-toggle="tab"><i class="icon-calendar"></i> Insumos proximos a vencer</a></li>
					      	</c:otherwise>
					      </c:choose>
					      <c:choose>
					      	<c:when test="${ refes.size() > 0}">
					      		<li><a href="#agotarse" data-toggle="tab"><i class="icon-eye-open"></i> Insumos por acabar su existencia <span class="label label-warning ">Warning</span></a></li>
					      		</c:when>
					      	<c:otherwise>
							      <li><a href="#agotarse" data-toggle="tab"><i class="icon-eye-open"></i> Insumos por acabar su existencia</a></li> 
					      	</c:otherwise>
					      </c:choose>
					      <li class="divider"></li>
					      <li><a href="#agregados" data-toggle="tab"><i class="icon-plus"></i> Ultimos insumos agregados</a></li>
					      <li><a href="#retirados" data-toggle="tab"><i class="icon-list"></i> Ultimos movimientos realizados</a></li>
					    </ul>
			          </div>
				          <div class="span8 ">
				          <div class="tab-content">
				          	 <div class="tab-pane" id="home"><img src="${pageContext.request.contextPath}/images/hospital.jpg" /></div>
				          	 <div class="tab-pane" id="vencidos">
				          	 <c:choose>
				          	 <c:when test="${ insumos.size() != 0}">
				          	     <table class="table table-bordered table-hover">
							      <thead>
							        <tr>
							          <th>Codigo Caja</th>
							          <th>Codigo Referencia</th>
							          <th>Codigo Bodega</th>
							          <th>Cantidad Disponible</th>
							          <th>Fecha Vencimiento</th>
							          <th>Ver</th>
							        </tr>
							      </thead>
							      <tbody>
							      <c:forEach var="insumo" items="${insumos}">
							        <tr class="error">
							          <td>${insumo.codcaja}</td>
							          <td>${insumo.codigo}</td>
							          <td>${insumo.bodega}</td>
							          <td>${insumo.cantidad}</td>
							          <td><fmt:formatDate value="${insumo.fecha}" pattern="dd/MM/yyyy" /></td>
							         <td><a href="${pageContext.request.contextPath}/insumos/ver?codcaja=${insumo.codcaja}"><img src="${pageContext.request.contextPath}/images/buscar.png" /></a></td>
									</tr>
							       </c:forEach>
							       </tbody>
							    </table> 
							    </c:when>
							     <c:otherwise>
							       	
						           <div class="alert alert-info">
								      <p><strong>Aviso!</strong> No existen insumos proximos a vencer.</p>
								    </div>
								
							      </c:otherwise>
							  </c:choose>
							 </div>
				          	 <div class="tab-pane" id="agotarse">
				          	 <c:choose>
				          	 <c:when test="${ refes.size() > 0}">
				          	     <table class="table table-bordered table-hover">
							      <thead>
							        <tr>
							          <th>Codigo Referencia</th>
							          <th>Presentacion</th>
							          <th>Cantidad minima permitida</th>
							          <th>Cantidad Disponible</th>
							          <th>Ver</th>
							        </tr>
							      </thead>
							      <tbody>
							       <c:forEach var="referencia" items="${refes}">
								
									<tr class="error">
										<td>${referencia.codigo}</td>
										<td>${referencia.presentacion}</td>
										<td>${referencia.cantmini}</td>
										<td>${referencia.cantidad }</td>
										<td><a href="${pageContext.request.contextPath}/referencias/ver?codigo=${referencia.codigo}"><img src="${pageContext.request.contextPath}/images/buscar.png" /></a></td>
									</tr>
								</c:forEach> 
							       </tbody>
							    </table> 
							   
							    </c:when>
							     <c:otherwise>
							       	
						           <div class="alert alert-info">
								      <p><strong>Aviso!</strong> No existen insumos proximos a terminarse.</p>
								    </div>
								
							      </c:otherwise>
							  </c:choose>
					          	
							 </div>
				          	 <div class="tab-pane" id="agregados">
				          	 <c:choose>
				          	 <c:when test="${ agregados.size() != 0}">
				          	     <table class="table table-bordered table-hover">
							      <thead>
							        <tr>
							          <th>Codigo Caja</th>
							          <th>Referencia</th>
							          <th>Bodega</th>
							          <th>Cantidad</th>						          
							          <th>Usuario</th>
							          <th>Fecha</th>
							          <th>Ver</th>
							        </tr>
							      </thead>
							      <tbody>
							       <c:forEach var="agregado" items="${agregados}">
								
									<tr class="success">
										<td>${agregado.codcaja}</td>
										<td>${agregado.codref}</td>
										<td>${agregado.bodega}</td>
										<td>${agregado.cantidad }</td>
										<td>${agregado.usuario }</td>
										<td><fmt:formatDate value="${agregado.fecha }" pattern="dd/MM/yyyy hh:mm:ss a" /></td>
										
										<td><a href="${pageContext.request.contextPath}/insumos/ver?codcaja=${agregado.codcaja}"><img src="${pageContext.request.contextPath}/images/buscar.png" /></a></td>
									</tr>
								</c:forEach> 
							       </tbody>
							    </table> 
							   
							    </c:when>
							    <c:otherwise>
							       	
						           <div class="alert alert-info">
								      <p><strong>Aviso!</strong> No existen insumos agregados recientemente.</p>
								    </div>
								
							      </c:otherwise>
							  </c:choose>
				          	 
				          	 </div>
				          	 <div class="tab-pane" id="retirados">
					          	 <c:choose>
					          	 <c:when test="${ movimientos.size() != 0}">
					          	     <table class="table table-bordered table-hover">
								      <thead>
								        <tr>
								          <th>Nro#</th>
								          <th>Motivo</th>
								          <th>Cantidad</th>
								          <th>Observación</th>						          
								          <th>Usuario</th>
								          <th>Fecha</th>
								        </tr>
								      </thead>
								      <tbody>
								       <c:forEach var="movimiento" items="${movimientos}">
								       <c:choose>
										<c:when test="${ movimiento.cantidad > 0}">
										<tr class="success">
											<td>${movimiento.id}</td>
											<td>${movimiento.referencia}</td>
											<td>${movimiento.cantidad}</td>
											<td>${movimiento.observacion }</td>
											<td>${movimiento.usuario }</td>
											<td><fmt:formatDate value="${movimiento.fecha }" pattern="dd/MM/yyyy hh:mm:ss a" /></td>
											
										</tr>
										</c:when>
										<c:otherwise>
											<tr class="error">
												<td>${movimiento.id}</td>
												<td>${movimiento.referencia}</td>
												<td>${movimiento.cantidad}</td>
												<td>${movimiento.observacion }</td>
												<td>${movimiento.usuario }</td>
												<td><fmt:formatDate value="${movimiento.fecha }" pattern="dd/MM/yyyy hh:mm:ss a" /></td>
											</tr>
										</c:otherwise>
										</c:choose>
									</c:forEach> 
								       </tbody>
								    </table> 
								   
								    </c:when>
								    <c:otherwise>
								       	
							           <div class="alert alert-info">
									      <p><strong>Aviso!</strong> No existen movimientos realizados recientemente.</p>
									    </div>
									
								      </c:otherwise>
								  </c:choose>
				          	 
				          	 </div>
				          	 
				          	
				          	
				          </div>
				          </div>
				   </div>
			</div>
		 </div>
				<!-- <img src="${pageContext.request.contextPath}/images/hospital.jpg" /> -->
		   	<script type="text/javascript">
			  /*$(function () {
			    $('#myTab a:last').tab('show');
			  })*/
			    $('#myTab a').click(function (e) {
			        e.preventDefault();
			        $(this).tab('show');
			      })
			    $('a[data-toggle="tab"]').on('shown', function (e) {
			      e.target // activated tab
			      e.relatedTarget // previous tab
			    })
			</script>
		
	</jsp:attribute>
</t:layout>