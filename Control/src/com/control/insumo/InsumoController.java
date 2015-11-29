package com.control.insumo;

import java.io.IOException;
import java.nio.charset.Charset;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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
import com.control.referencia.ReferenciaDAO;
import com.control.usuario.UsuarioDAO;
import com.csvreader.CsvReader;


@Controller
public class InsumoController {

	private static final String map = "/insumos";
	private static final String view = "/insumos";
	
	@Autowired
	private InsumoDAO i;	
	@Autowired
	private ReferenciaDAO r;	
	@Autowired
	private UsuarioDAO u;
	
	@RequestMapping(value = map + "/movimientos")
	public ModelAndView movimientos(HttpServletRequest request,
								    HttpServletResponse response) {
		
		ModelMap modelo = new ModelMap();
		
		modelo.put("movimientos", r.consultarMovimientosTodos());
		modelo.addAttribute("refes", i.consultarReferenciasTerminadas());
		modelo.addAttribute("ins", i.consultarInsumosVencidos());
		modelo.addAttribute("UserRol", u.obtenerPermisos(Utils.obtenerUsuario(request)));
		return new ModelAndView(view + "/movimientos", modelo);
	}
	
	@RequestMapping(value = map + "/cargar_insumos")
	public ModelAndView cargar_form(HttpServletRequest request,
								    HttpServletResponse response) {
		
		ModelMap modelo = new ModelMap();
		
		modelo.addAttribute("referencias", i.consultarReferencias());
		modelo.addAttribute("proveedores", i.consultarProveedores());
		modelo.addAttribute("fabricantes", i.consultarFabricantes());
		modelo.addAttribute("bodegas", i.consultarBodegas());
		modelo.addAttribute("refes", i.consultarReferenciasTerminadas());
		modelo.addAttribute("ins", i.consultarInsumosVencidos());
		modelo.addAttribute("UserRol", u.obtenerPermisos(Utils.obtenerUsuario(request)));
		return new ModelAndView(view + "/cargar_insumos", modelo);
	}
	
	@RequestMapping(value = map + "/crear_accion", method = RequestMethod.POST)
	public ModelAndView crear_accion(HttpServletRequest request, 
									 HttpServletResponse response, 
									 @RequestParam(value="codcaja", required=true) String codcaja,
									 @RequestParam(value="referencia", required=true) String referencia,
									 @RequestParam(value="proveedor", required=true) String proveedor,
									 @RequestParam(value="fabricante", required=true) String fabricante,
									 @RequestParam(value="bodega", required=true) String bodega,
									 @RequestParam(value="cantidad", required=true) Integer cantidad,
									 @RequestParam(value="precioComp", required=true) String precioComp,
									 @RequestParam(value="precioVent", required=true) String precioVent,
									 @RequestParam(value="fechaComp", required=true) String fechaComp,
									 @RequestParam(value="fechaVenc", required=true) String fechaVenc) {
	
		SimpleDateFormat fechatxt = new SimpleDateFormat("yyyy-MM-dd");
		
		
		
		Insumo insumo = new Insumo();
		insumo.setCodcaja(codcaja);
		insumo.setCodref(referencia);
		insumo.setProveedor(proveedor);
		insumo.setFabricante(fabricante);
		insumo.setBodega(bodega);
		insumo.setCantInsumos(cantidad);
		insumo.setPrecioComp(precioComp);
		insumo.setPrecioVent(precioVent);
		try {
			insumo.setFechaComp(fechatxt.parse(fechaComp));
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			insumo.setFechaVenc(fechatxt.parse(fechaVenc));
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}	
		
		insumo.setUsuaCrea(Utils.obtenerUsuario(request));
		
		try {
			this.i.insertarInsumo(insumo);
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.EXITO, "El insumo de ha a�adido satisfactoriamente");
		} catch (Exception e) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, e.getMessage());
		}
		
		return new Redireccion(map + "/cargar_insumos");
	}
	
	@RequestMapping(value = map + "/crear_archivo")
	public ModelAndView crear_archivo_form(HttpServletRequest request,
								   HttpServletResponse response) {
		ModelMap modelo = new ModelMap();
		modelo.addAttribute("refes", i.consultarReferenciasTerminadas());
		modelo.addAttribute("ins", i.consultarInsumosVencidos());
		modelo.addAttribute("UserRol", u.obtenerPermisos(Utils.obtenerUsuario(request)));
		return new ModelAndView(view + "/crear_archivo_form", modelo);
	}
	
	@RequestMapping(value = map + "/crear_archivo_accion",
					method = RequestMethod.POST)
	public ModelAndView crear_archivo_accion(HttpServletRequest request,
								   			 HttpServletResponse response,
								   			 @RequestParam(value="arcParte", required=true) CommonsMultipartFile arcParte) {

		List<String> codigosCajas = new ArrayList<String>();
		List<String> codigosReferencias = new ArrayList<String>();
		List<String> insumosProveedor = new ArrayList<String>();
		List<String> fabricantes = new ArrayList<String>();
		List<String> bodegas = new ArrayList<String>();
		List<Integer> cantidad = new ArrayList<Integer>();
		List<String> preciocompra = new ArrayList<String>();
		List<String> precioventa = new ArrayList<String>();
		List<String> fechacompra = new ArrayList<String>();
		List<String> fechavenc = new ArrayList<String>();
		
		try {
			CsvReader lector = new CsvReader(arcParte.getInputStream(), Charset.forName("UTF-8"));
			lector.setDelimiter(';');
			
			lector.readHeaders();
			
			if(lector.getHeaderCount() != 10) {
				ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, "Error leyendo archivo .CSV. El número de columnas especificado es incorrecto");
				return new Redireccion(map + "/crear_archivo");
			}
			
			
			while(lector.readRecord()) {
				codigosCajas.add(lector.get(0));
				codigosReferencias.add(lector.get(1));
				insumosProveedor.add(lector.get(2));
				fabricantes.add(lector.get(3));
				bodegas.add(lector.get(4));
				cantidad.add(Integer.parseInt(lector.get(5)));
				preciocompra.add(lector.get(6));
				precioventa.add(lector.get(7));
				fechacompra.add(lector.get(8));
				fechavenc.add(lector.get(9));
			}
			lector.close();
		}
		catch(IOException e) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, "Error leyendo archivo .CSV");
		}
		
		try {
			i.insertarInsumosBatch(codigosCajas, codigosReferencias, insumosProveedor, fabricantes, bodegas, cantidad, preciocompra, precioventa, fechacompra, fechavenc, Utils.obtenerUsuario(request)); 
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.EXITO, codigosReferencias.size() + " insumos agregados satisfactoriamente");
		} catch (SQLException e) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, e.getMessage());
		}
		
		return new Redireccion(map + "/crear_archivo");
	}
	
	@RequestMapping(value = map + "/consultar")
	public ModelAndView consultar(HttpServletRequest request,
								   HttpServletResponse response) {
		
		ModelMap modelo = new ModelMap();
		
		modelo.addAttribute("referencias", i.consultarReferencias());
		modelo.addAttribute("proveedores", i.consultarProveedores());
		modelo.addAttribute("bodegas", i.consultarBodegas());
		modelo.addAttribute("refes", i.consultarReferenciasTerminadas());
		modelo.addAttribute("ins", i.consultarInsumosVencidos());
		modelo.addAttribute("UserRol", u.obtenerPermisos(Utils.obtenerUsuario(request)));
		
		return new ModelAndView(view + "/consultar", modelo);
	}
	
	@RequestMapping(value = map + "/mostrar")
	public ModelAndView mostrar(HttpServletRequest request,
							   HttpServletResponse response,
							   @RequestParam(value="codcaja", required=false) String codcaja,
							   @RequestParam(value="codref", required=false) String codref,
							   @RequestParam(value="proveedor", required=false) String proveedor,
							   @RequestParam(value="bodega", required=false) String bodega) { 
		
		if(codcaja == null) {
			codcaja = "";
		}
		if(codref == null) {
			codref = "";
		}
		if(proveedor == null) {
			proveedor = "";
		}
		if(bodega.equals("")) {
			bodega = null;
		}
		
		Insumo insumo = new Insumo();
		insumo.setCodcaja(codcaja);
		insumo.setCodref(codref);
		insumo.setProveedor(proveedor);
		insumo.setBodega(bodega);
		
		List<Insumo> l = i.listarInsumos(insumo);
		
		if(l.size() == 0) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ADVERTENCIA, "No se encontraron resultados");
			return new Redireccion(map + "/consultar");
		}
		
		ModelMap modelo = new ModelMap();
		modelo.addAttribute("insumos", l);
		Date fechaActual = new Date();
       Calendar calendar = Calendar.getInstance();

       calendar.setTime(fechaActual); // Configuramos la fecha que se recibe

       calendar.add(Calendar.DAY_OF_YEAR, 30);  // numero de días a añadir, o restar en caso de días<0

       fechaActual = calendar.getTime(); // Devuelve el objeto Date con los nuevos días añadidos
       
       modelo.addAttribute("fechaActual", fechaActual);
		modelo.addAttribute("refes", i.consultarReferenciasTerminadas());
		modelo.addAttribute("ins", i.consultarInsumosVencidos());
		modelo.addAttribute("UserRol", u.obtenerPermisos(Utils.obtenerUsuario(request)));
			
		return new ModelAndView(view + "/listar_reporte", modelo);
	} 
	
	@RequestMapping(value = map + "/ver")
	public ModelAndView ver(HttpServletRequest request,
							HttpServletResponse response,
							@RequestParam(value="codcaja", required=true) String codcaja) {
		
		
		Insumo insumo = new Insumo();
		insumo.setCodcaja(codcaja);
		
		List<Insumo> l = i.consultarInsumo(insumo);
		
		if(l.size() == 0 || l.size() > 1) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ADVERTENCIA, "No se encontro el Insumo");
			return new Redireccion(map + "/consultar");
		}
		
		ModelMap modelo = new ModelMap();
		modelo.put("insumo", l.get(0));
		modelo.addAttribute("refes", i.consultarReferenciasTerminadas());
		modelo.addAttribute("ins", i.consultarInsumosVencidos());
		modelo.addAttribute("UserRol", u.obtenerPermisos(Utils.obtenerUsuario(request)));
		
		return new ModelAndView(view + "/ver", modelo);
	}
	
	@RequestMapping(value = map + "/editar", method = RequestMethod.POST)
	public ModelAndView editar(HttpServletRequest request,
							HttpServletResponse response,
							@RequestParam(value="codcaja", required=true) String codcaja,
							@RequestParam(value="codref", required=true) String codref,
							@RequestParam(value="bodega", required=true) String bodega,
							@RequestParam(value="proveedor", required=true) String proveedor) {
		
		
		Insumo insumo = new Insumo();
		insumo.setCodcaja(codcaja);
		insumo.setCodref(codref);
		insumo.setBodega(bodega);
		insumo.setProveedor(proveedor);
		
		List<Insumo> l = i.listarInsumos(insumo);
		
		if(l.size() == 0 || l.size() > 1) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ADVERTENCIA, "No se encontro el Insumo");
			return new Redireccion(map + "/consultar");
		}
		
		ModelMap modelo = new ModelMap();
		modelo.put("insumo", l.get(0));
		modelo.addAttribute("bodegas", i.consultarBodegas());
		modelo.addAttribute("refes", i.consultarReferenciasTerminadas());
		modelo.addAttribute("ins", i.consultarInsumosVencidos());
		modelo.addAttribute("UserRol", u.obtenerPermisos(Utils.obtenerUsuario(request)));
		
		return new ModelAndView(view + "/editar", modelo);
	}
	 
	@RequestMapping(value = map + "/editar_insumo", method = RequestMethod.POST)
	public ModelAndView editar_insumo(HttpServletRequest request,
							HttpServletResponse response,
							@RequestParam(value="codcaja", required=true) String codcaja,
							@RequestParam(value="codref", required=true) String codref,
							@RequestParam(value="bodega", required=true) String bodega,
							@RequestParam(value="cantInsumos", required=true) Integer cantInsumos,
							@RequestParam(value="precioVent", required=true) String precioVent) {
		
		
		Insumo insumo = new Insumo();
		insumo.setCodcaja(codcaja);
		insumo.setCodref(codref);
		insumo.setBodega(bodega);
		insumo.setCantInsumos(cantInsumos);
		insumo.setPrecioVent(precioVent);
		insumo.setUsuaModi(Utils.obtenerUsuario(request));
		insumo.setFechaModi(new Date());
		
		try {
				this.i.actualizarInsumo(insumo);
				ManejadorMensajes.agregarMensaje(request, TipoMensaje.EXITO, "El insumo ha sido modificado satisfactoriamente");
			} catch (Exception e) {
				ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, e.getMessage());
			}
			
		return new Redireccion(map + "/consultar");
	}
	
	@RequestMapping(value = map + "/eliminar", method = RequestMethod.POST)
	public ModelAndView eliminar(HttpServletRequest request,
							HttpServletResponse response,
							@RequestParam(value="codcaja", required=true) String codcaja,
							@RequestParam(value="codref", required=true) String codref,
							@RequestParam(value="bodega", required=true) String bodega) {
		
		
		Insumo insumo = new Insumo();
		insumo.setCodcaja(codcaja);
		insumo.setCodref(codref);
		insumo.setBodega(bodega);
		List<Insumo> l = i.consultarInsumo(insumo);
		l.get(0).setCantInsumos(0);
		try {
				this.i.actualizarInsumo(l.get(0));
				ManejadorMensajes.agregarMensaje(request, TipoMensaje.EXITO, "El insumo ha sido eliminado satisfactoriamente");
			} catch (Exception e) {
				ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, e.getMessage());
			}
			
		return new Redireccion(map + "/consultar");
	}
}
