package com.control.insumo;

import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.control.general.ManejadorMensajes;
import com.control.general.Redireccion;
import com.control.general.TipoMensaje;
import com.control.general.Utils;


@Controller
public class InsumoController {

	private static final String map = "/insumos";
	private static final String view = "/insumos";
	
	@Autowired
	private InsumoDAO i;
	
	
	@RequestMapping(value = map + "/cargar_insumos")
	public ModelAndView cargar_form(HttpServletRequest request,
								    HttpServletResponse response) {
		
		ModelMap modelo = new ModelMap();
		
		modelo.addAttribute("referencias", i.consultarReferencias());
		modelo.addAttribute("proveedores", i.consultarProveedores());
		modelo.addAttribute("fabricantes", i.consultarFabricantes());
		modelo.addAttribute("bodegas", i.consultarBodegas());
		return new ModelAndView(view + "/cargar_insumos", modelo);
	}
	
	@RequestMapping(value = map + "/crear_accion", method = RequestMethod.POST)
	public ModelAndView crear_accion(HttpServletRequest request, 
									 HttpServletResponse response, 
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
		insumo.setCodigoRef(referencia);
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
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.EXITO, "El insumo de ha añadido satisfactoriamente");
		} catch (Exception e) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, e.getMessage());
		}
		
		return new Redireccion(map + "/cargar_insumos");
	}
}
