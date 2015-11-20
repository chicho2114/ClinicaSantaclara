package com.control.referencia;

import java.io.IOException;
import java.nio.charset.Charset;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.control.general.ManejadorMensajes;
import com.control.general.Redireccion;
import com.control.general.TipoMensaje;
import com.control.general.Utils;
import com.csvreader.CsvReader;

@Controller
public class ReferenciaController {

	private static final String map = "/referencias";
	private static final String view = "/referencias";
	
	@Autowired
	private ReferenciaDAO r;
	
	@RequestMapping(value = map + "/listar")
	public ModelAndView listar_form() {
		
		ModelMap modelo = new ModelMap();
		modelo.addAttribute("fabricantes", r.consultarFabricantes());
		modelo.addAttribute("categorias", r.consultarCategorias());
		
		return new ModelAndView(view + "/listar_form", modelo);
	}
	
	@RequestMapping(value = map + "/listar_reporte")
	public ModelAndView listar(HttpServletRequest request,
							   HttpServletResponse response,
							   @RequestParam(value="codigo", required=false) String codigo,
							   @RequestParam(value="descripcion", required=false) String descripcion,
							   @RequestParam(value="categoria", required=false) String categoria,
							   @RequestParam(value="fabricante", required=false) String fabricante) { 
		
		if(codigo == null) {
			codigo = "";
		}
		if(descripcion == null) {
			descripcion = "";
		}
		if(categoria.equals("")) {
			categoria = null;
		}
		if(fabricante.equals("")) {
			fabricante = null;
		}
		
		if(codigo.length() < 4 && !codigo.equals("")) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ADVERTENCIA, "El campo 'Código de referencia' debe tener, mínimo, 4 caracteres");
			return new Redireccion(map + "/listar");
		}
		
		if(descripcion.length() < 3 && !descripcion.equals("")) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ADVERTENCIA, "El campo 'Descripción' debe tener, mínimo, 3 caracteres");
			return new Redireccion(map + "/listar");	
		}
		
		Referencia referencia = new Referencia();
		referencia.setCodigo(codigo);
		referencia.setDescripcion(descripcion);
		referencia.setFabricante(fabricante);
		referencia.setCategoria(categoria);
		
		List<Referencia> l = r.listarReferencias(referencia);
		
		if(l.size() == 0) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ADVERTENCIA, "No se encontraron resultados");
			return new Redireccion(map + "/listar");
		}
		
		ModelMap modelo = new ModelMap();
		modelo.addAttribute("refs", l);
			
		return new ModelAndView(view + "/listar_reporte", modelo);
	}
	
	@RequestMapping(value = map + "/ver")
	public ModelAndView ver(HttpServletRequest request,
							HttpServletResponse response,
							@RequestParam(value="codigo", required=true) String codigo) {
		
		
		Referencia referencia = new Referencia();
		referencia.setCodigo(codigo);
		referencia.setDescripcion("");
		
		List<Referencia> l = r.listarReferencias(referencia);
		
		if(l.size() == 0 || l.size() > 1) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ADVERTENCIA, "No se encontró referencia");
			return new Redireccion(map + "/listar");
		}
		
		ModelMap modelo = new ModelMap();
		modelo.put("referencia", l.get(0));
		modelo.put("inventarios", r.consultarInventarioReferencia(l.get(0)));
		modelo.put("categorias", r.consultarCategorias());
		modelo.put("fabricantes", r.consultarFabricantes());
		
		return new ModelAndView(view + "/ver", modelo);
	}
	
	@RequestMapping(value = map + "/crear")
	public ModelAndView crear_form(HttpServletRequest request,
								   HttpServletResponse response) {
		
		ModelMap modelo = new ModelMap();
		modelo.addAttribute("fabricantes", r.consultarFabricantes());
		modelo.addAttribute("categorias", r.consultarCategorias());
		
		return new ModelAndView(view + "/crear_form", modelo);
	}
	
	@RequestMapping(value = map + "/crear_accion",
					method = RequestMethod.POST)
	public ModelAndView crear_accion(HttpServletRequest request,
									 HttpServletResponse response,
									 @RequestParam(value="codigo", required=true) String codigo,
									 @RequestParam(value="descripcion", required=true) String descripcion,
									 @RequestParam(value="componente", required=true) String componente,
									 @RequestParam(value="presentacion", required=true) String presentacion,
									 @RequestParam(value="fabricante", required=true) String fabricante,
									 @RequestParam(value="categoria", required=true) String categoria,
									 @RequestParam(value="observacion", required=false) String observacion,
									 @RequestParam(value="cant_minima", required=true) Integer cant_minima) {
		
		Referencia r = new Referencia();
		
		r.setCodigo(codigo);
		r.setDescripcion(descripcion);
		r.setComponente(componente);
		r.setPresentacion(presentacion);
		r.setFabricante(fabricante);
		r.setCategoria(categoria);
		r.setObservacion(observacion);
		r.setCant_mini(cant_minima);
		r.setUsuaCrea(Utils.obtenerUsuario(request));
		
		try {
			this.r.insertarReferencia(r);
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.EXITO, "La referencia ha sido creada satisfactoriamente");
		} catch (Exception e) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, e.getMessage());
		}
		
		return new Redireccion(map + "/crear");
	}
	
	@RequestMapping(value= map + "/crear_fabricante")
	public ModelAndView crear_fabricante(HttpServletRequest request,
										 HttpServletResponse response) {
		
		ModelMap modelo = new ModelMap();
		modelo.put("fabricantes", r.consultarFabricantes());
		
		return new ModelAndView(view + "/crear_fabricante_form", modelo);
	}
	
	@RequestMapping(value = map + "/crear_fabricante_accion",
					method = RequestMethod.POST)
	public ModelAndView crear_fabricante_accion(HttpServletRequest request,
												HttpServletResponse responnse,
												@RequestParam(value="codigo", required=true) String codigo,
												@RequestParam(value="nombre", required=true) String nombre) {
		
		
		if(codigo == "") {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ADVERTENCIA, "El campo 'Código' no puede estar vacío");
			return new Redireccion(map + "/crear_bodega");
		}
		if(nombre == "") {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ADVERTENCIA, "El campo 'Nombre' no puede estar vacío");
			return new Redireccion(map + "/crear_bodega");
		}
		
		try {
			r.insertarFabricante(codigo, nombre, Utils.obtenerUsuario(request), new Date());
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.EXITO, "Fabricante creado correctamente");
		}
		catch(Exception e) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, e.getMessage());
		}
		
		return new Redireccion(map + "/crear_fabricante");
	}
	
	@RequestMapping(value= map + "/crear_categoria")
	public ModelAndView crear_categoria(HttpServletRequest request,
										 HttpServletResponse response) {
		
		ModelMap modelo = new ModelMap();
		modelo.put("categorias", r.consultarCategorias());
		
		return new ModelAndView(view + "/crear_categoria_form", modelo);
	}
	
	@RequestMapping(value = map + "/crear_categoria_accion",
					method = RequestMethod.POST)
	public ModelAndView crear_categoria_accion(HttpServletRequest request,
												HttpServletResponse responnse,
												@RequestParam(value="codigo", required=true) String codigo,
												@RequestParam(value="nombre", required=true) String nombre) {
		
		
		if(codigo == "") {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ADVERTENCIA, "El campo 'Código' no puede estar vacío");
			return new Redireccion(map + "/crear_bodega");
		}
		if(nombre == "") {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ADVERTENCIA, "El campo 'Nombre' no puede estar vacío");
			return new Redireccion(map + "/crear_bodega");
		}
		
		try {
			r.insertarCategoria(codigo, nombre, Utils.obtenerUsuario(request), new Date());
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.EXITO, "Categoria creada correctamente");
		}
		catch(Exception e) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, e.getMessage());
		}
		
		return new Redireccion(map + "/crear_categoria");
	}
	
	@RequestMapping(value = map + "/crear_archivo")
	public ModelAndView crear_archivo_form(HttpServletRequest request,
								   HttpServletResponse response) {
		
		return new ModelAndView(view + "/crear_archivo_form");
	}
	
	@RequestMapping(value = map + "/crear_archivo_accion",
					method = RequestMethod.POST)
	public ModelAndView crear_archivo_accion(HttpServletRequest request,
								   			 HttpServletResponse response,
								   			 @RequestParam(value="arcParte", required=true) CommonsMultipartFile arcParte) {
		
		List<String> codigosReferencias = new ArrayList<String>();
		List<String> descripcionesReferencias = new ArrayList<String>();
		List<String> componentes = new ArrayList<String>();
		List<String> presentaciones = new ArrayList<String>();
		List<String> fabricantes = new ArrayList<String>();
		List<String> categorias = new ArrayList<String>();
		List<String> observaciones = new ArrayList<String>();
		List<Integer> cantminima = new ArrayList<Integer>();
		
		try {
			CsvReader lector = new CsvReader(arcParte.getInputStream(), Charset.forName("UTF-8"));
			lector.setDelimiter(';');
			
			lector.readHeaders();
			
			if(lector.getHeaderCount() != 8) {
				ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, "Error leyendo archivo .CSV. El número de columnas especificado es incorrecto");
				return new Redireccion(map + "/crear_archivo");
			}
			
			
			while(lector.readRecord()) {
				codigosReferencias.add(lector.get(0));
				descripcionesReferencias.add(lector.get(1));
				componentes.add(lector.get(2));
				presentaciones.add(lector.get(3));
				fabricantes.add(lector.get(4));
				categorias.add(lector.get(5));
				observaciones.add(lector.get(6));
				cantminima.add( Integer.parseInt(lector.get(7)));
			}
			lector.close();
		}
		catch(IOException e) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, "Error leyendo archivo .CSV");
		}
		
		try {
			r.insertarReferenciasBatch(codigosReferencias, descripcionesReferencias, componentes, presentaciones, fabricantes, categorias, observaciones, cantminima, Utils.obtenerUsuario(request));
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.EXITO, codigosReferencias.size() + " referencias creadas satisfactoriamente");
		} catch (SQLException e) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, e.getMessage());
		}
		
		return new Redireccion(map + "/crear_archivo");
	}
	
	@RequestMapping(value = map + "/crear_bodega")
	public ModelAndView crear_bodega(HttpServletRequest request,
									 HttpServletResponse response) {
		
		ModelMap modelo = new ModelMap();
		modelo.put("bodegas", r.consultarBodegas());
		
		return new ModelAndView(view + "/crear_bodega_form", modelo);
	}
	
	@RequestMapping(value = map + "/crear_bodega_accion",
					method = RequestMethod.POST)
	public ModelAndView crear_bodega_accion(HttpServletRequest request,
											HttpServletResponse response,
											@RequestParam(value="codigo") String codigo,
											@RequestParam(value="nombre") String nombre) {
		
		if(codigo == "") {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ADVERTENCIA, "El campo 'Código' no puede estar vacío");
			return new Redireccion(map + "/crear_bodega");
		}
		if(nombre == "") {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ADVERTENCIA, "El campo 'Nombre' no puede estar vacío");
			return new Redireccion(map + "/crear_bodega");
		}
		
		try {
			r.insertarBodega(codigo, nombre, Utils.obtenerUsuario(request), new Date());
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.EXITO, "Bodega creada correctamente");
		}
		catch(Exception e) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, e.getMessage());
		}
		
		return new Redireccion(map + "/crear_bodega");
	}
	
	@RequestMapping(value = map + "/consultar_bodega")
	public ModelAndView consultar_bodega(HttpServletRequest request,
										 HttpServletResponse response,
										 @RequestParam(value="codigo") String codigo) {
		
		ModelMap modelo = new ModelMap();
		modelo.put("referencias", r.consultarInventarioBodega(codigo));
		
		return new ModelAndView("/ajax/consultar_bodega", modelo);
	}
	
	@RequestMapping(value = map + "/consultar_json")
	public ModelAndView consultar_json(HttpServletRequest request,
									   HttpServletResponse response,
									   @RequestParam(value="codigo") String codigo) {
		
		Referencia referencia = new Referencia();
		referencia.setCodigo(codigo);
		referencia.setDescripcion("");
		
		List<Referencia> l = r.listarReferencias(referencia);
		
		if(l.size() == 0 || l.size() > 1) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ADVERTENCIA, "No se encontró referencia");
			return new Redireccion(map + "/listar");
		}
		
		ModelMap modelo = new ModelMap();
		modelo.put("referencia", l.get(0));
		
		return new ModelAndView("/ajax/consultar_json", modelo);
	}
	
	@RequestMapping(value = map + "/crear_ajuste")
	public ModelAndView crear_ajuste_form(HttpServletRequest request,
										  HttpServletResponse response) {
		
		ModelMap modelo = new ModelMap();
		modelo.put("ajuste", r.consultarConsecutivo("AJUSTEINVENTARIO"));
		modelo.put("bodegas", r.consultarBodegas());
		
		return new ModelAndView(view + "/crear_ajuste_form", modelo);
	}
	
	@RequestMapping(value = map + "/crear_ajuste_accion",
					method = RequestMethod.POST) 
	public ModelAndView crear_ajuste_accion(HttpServletRequest request,
											HttpServletResponse response,
											@RequestParam(value="referencia") String referencia,
											@RequestParam(value="ref") String refe,
											@RequestParam(value="cantidad") int cantidad,
											@RequestParam(value="bodega") String bodega) {
		
		if(referencia == null) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ADVERTENCIA, "Referencia no debe estar vacío");
			return new Redireccion(map + "/crear_ajuste");
		}
		
		if(cantidad == 0) { 
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ADVERTENCIA, "Cantidad no puede estar vacía");
			return new Redireccion(map + "/crear_ajuste");
		}
		
		if(bodega == null || bodega.equals("")) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ADVERTENCIA, "Bodega no puede estar vacía");
			return new Redireccion(map + "/crear_ajuste");
		}
		
		Referencia ref = new Referencia();
		ref.setCodigo(referencia);
		ref.setDescripcion("");
		
		List<Referencia> l = r.listarReferencias(ref);
		
		if(l.size() == 0 || l.size() > 1 || !l.get(0).getDescripcion().equals(refe)) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ADVERTENCIA, "La referencia no existe");
			return new Redireccion(map + "/crear_ajuste");
		}
		
		try {
			r.insertarAjuste(bodega, referencia, cantidad, Utils.obtenerUsuario(request));
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.EXITO, "Ajuste creado satisfactoriamente");
		}
		catch(SQLException e) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, "Ocurrió un error: " + e.getMessage());
		}
		
		return new Redireccion(map + "/crear_ajuste");
	}
	
	@RequestMapping(value = map + "/crear_ajuste_archivo_accion",
			method = RequestMethod.POST) 
	public ModelAndView crear_ajuste_archivo_accion(HttpServletRequest request,
													HttpServletResponse response,
													@RequestParam(value="arcAjuste", required=true) CommonsMultipartFile arcAjuste) {
		
		List<String> codigosReferencias = new ArrayList<String>();
		List<Integer> cantidades = new ArrayList<Integer>();
		List<String> bodegas = new ArrayList<String>();
		
		try {
			CsvReader lector = new CsvReader(arcAjuste.getInputStream(), Charset.forName("UTF-8"));
			lector.setDelimiter(';');
			
			lector.readHeaders();
			
			if(lector.getHeaderCount() != 3) {
				ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, "Error leyendo archivo .CSV. El número de columnas especificado es incorrecto");
				return new Redireccion(map + "/crear_archivo");
			}
			
			codigosReferencias.add(lector.getHeader(0));
			cantidades.add(Integer.parseInt(lector.getHeader(1)));
			bodegas.add(lector.getHeader(2));
			
			while(lector.readRecord()) {
				codigosReferencias.add(lector.get(0));
				cantidades.add(Integer.parseInt(lector.get(1)));
				bodegas.add(lector.get(2));
			}
			lector.close();
		}
		catch(IOException e) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, "Error leyendo archivo .CSV");
		}
		
		try {
			r.insertarAjustesBatch(codigosReferencias, cantidades, bodegas, Utils.obtenerUsuario(request));
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.EXITO, codigosReferencias.size() + " ajustadas satisfactoriamente");
		} catch (SQLException e) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, e.getMessage());
		}
	
		return new Redireccion(map + "/crear_ajuste");
	}
	
	@RequestMapping(value = map + "/inventario_general_reporte")
	public ModelAndView inventario_general_reporte() {
		
		ModelMap modelo = new ModelMap();
		modelo.addAttribute("inventario", r.inventarioGeneral());
		
		return new ModelAndView(view + "/inventario_general_reporte", modelo);
	}
}
