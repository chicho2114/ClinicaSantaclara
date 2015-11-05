package com.control.proveedor;



import java.util.Date;

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


@Controller
public class ProveedorController {
	
	private static final String map = "/proveedores";
	private static final String view = "/proveedores";
	
	@Autowired
	private ProveedorDAO p;
	
	/*@RequestMapping(value = map + "/listar")
	public ModelAndView listar_form() {
		
		//ModelMap modelo = new ModelMap();
		//modelo.addAttribute("fabricantes", r.consultarFabricantes());
		//modelo.addAttribute("categorias", r.consultarCategorias());
		
		//return new ModelAndView(view + "/listar_form", modelo);
		return new ModelAndView(view + "/listar_form");
	}*/
	
	@RequestMapping(value = map + "/crear_accion",
			method = RequestMethod.POST)
	public ModelAndView crear_accion(HttpServletRequest request,
								 HttpServletResponse response,
								 @RequestParam(value="id", required=true) String id,
								 @RequestParam(value="nombre", required=true) String nombre,
								 @RequestParam(value="telefono", required=true) String telefono) {
	
			Proveedor p = new Proveedor();
			
			p.setId(id);
			p.setNombre(nombre);
			p.setTelefono(telefono);
			p.setFechacrea(new Date());
			//p.setUsuaCrea(Utils.obtenerUsuario(request));
			
			try {
				this.p.insertarProveedor(p);
				ManejadorMensajes.agregarMensaje(request, TipoMensaje.EXITO, "El proveedor ha sido creado satisfactoriamente");
			} catch (Exception e) {
				ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, e.getMessage());
			}
	
		return new Redireccion(map + "/crear");
	}
	
	@RequestMapping(value = map + "/crear")
	public ModelAndView crear_form(HttpServletRequest request,
								   HttpServletResponse response) {
		
		ModelMap modelo = new ModelMap();
		
		return new ModelAndView(view + "/crear_form", modelo);
	}

}
