package com.control.proveedor;



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
import org.springframework.web.servlet.ModelAndView;

import com.control.general.ManejadorMensajes;
import com.control.general.Redireccion;
import com.control.general.TipoMensaje;
import com.control.general.Utils;


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
								 @RequestParam(value="codigo", required=true) String codigo,
								 @RequestParam(value="nombre", required=true) String nombre,
								 @RequestParam(value="telefono", required=true) String telefono) {
	
			Proveedor p = new Proveedor();
			
			p.setCodigo(codigo);
			p.setNombre(nombre);
			p.setTelefono(telefono);
			p.setFechacrea(new Date());
			p.setUsuaCrea(Utils.obtenerUsuario(request));
			
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
	
	@RequestMapping(value = map + "/consultar")
	public ModelAndView consultar_prov(HttpServletRequest request,
								   HttpServletResponse response) {
		
		ModelMap modelo = new ModelMap();
		//modelo.addAttribute("fabricantes", p.consultarFabricantes());
		//modelo.addAttribute("categorias", p.consultarCategorias());
		
		return new ModelAndView(view + "/consultar_prov", modelo);
	}
	
	@RequestMapping(value = map + "/mostrar")
	public ModelAndView listar(HttpServletRequest request,
							   HttpServletResponse response,
							   @RequestParam(value="codigo", required=false) String codigo,
							   @RequestParam(value="nombre", required=false) String nombre,
							   @RequestParam(value="telefono", required=false) String telefono) { 
		
		if(codigo == null) {
			codigo = "";
		}
		if(nombre == null) {
			nombre = "";
		}
		if(telefono == null) {
			telefono = "";
		}
		
		if(codigo.length() < 4 && !codigo.equals("")) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ADVERTENCIA, "El campo 'Codigo de proveedor' debe tener, minimo, 4 caracteres");
			return new Redireccion(map + "/consultar");
		}
		
		if(nombre.length() < 3 && !nombre.equals("")) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ADVERTENCIA, "El campo 'Nombre' debe tener, minimo, 3 caracteres");
			return new Redireccion(map + "/consultar");	
		}
		
		Proveedor proveedor = new Proveedor();
		proveedor.setCodigo(codigo);
		proveedor.setNombre(nombre);
		proveedor.setTelefono(telefono);

		List<Proveedor> l = p.listarProveedores(proveedor);
		
		if(l.size() == 0) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ADVERTENCIA, "No se encontraron resultados");
			return new Redireccion(map + "/listar");
		}
		
		ModelMap modelo = new ModelMap();
		modelo.addAttribute("prov", l);
			
		return new ModelAndView(view + "/listar_proveedor", modelo);
	}
	
	@RequestMapping(value = map + "/ver")
	public ModelAndView ver(HttpServletRequest request,
							HttpServletResponse response,
							@RequestParam(value="codigo", required=true) String codigo) {
		
		
		Proveedor proveedor = new Proveedor();
		proveedor.setCodigo(codigo);
		proveedor.setNombre("");
		proveedor.setTelefono("");
		
		List<Proveedor> l = p.listarProveedores(proveedor);
		
		if(l.size() == 0 || l.size() > 1) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ADVERTENCIA, "No se encontro Proveedor");
			return new Redireccion(map + "/consultar");
		}
		
		ModelMap modelo = new ModelMap();
		modelo.put("proveedor", l.get(0));
		/*modelo.put("inventarios", r.consultarInventarioReferencia(l.get(0)));
		modelo.put("categorias", r.consultarCategorias());
		modelo.put("fabricantes", r.consultarFabricantes());*/
		
		return new ModelAndView(view + "/ver", modelo);
	}
	
	@RequestMapping(value = map + "/editar", method = RequestMethod.POST)
	public ModelAndView editar(HttpServletRequest request,
							HttpServletResponse response,
							@RequestParam(value="codigo", required=true) String codigo,
							@RequestParam(value="nombre", required=true) String nombre,
							@RequestParam(value="telefono", required=true) String telefono) {
		
		
		Proveedor proveedor = new Proveedor();
		proveedor.setCodigo(codigo);
		proveedor.setNombre(nombre);
		proveedor.setTelefono(telefono);
		
		List<Proveedor> l = p.listarProveedores(proveedor);
		
		if(l.size() == 0 || l.size() > 1) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ADVERTENCIA, "No se encontro Proveedor");
			return new Redireccion(map + "/consultar");
		}
		
		ModelMap modelo = new ModelMap();
		modelo.put("proveedor", l.get(0));
		
		return new ModelAndView(view + "/editar", modelo);
	}
	
	@RequestMapping(value = map + "/editar_prov", method = RequestMethod.POST)
	public ModelAndView editar_prov(HttpServletRequest request,
							HttpServletResponse response,
							@RequestParam(value="codigo", required=true) String codigo,
							@RequestParam(value="nombre", required=true) String nombre,
							@RequestParam(value="telefono", required=true) String telefono) {
		
		
		Proveedor proveedor = new Proveedor();
		proveedor.setCodigo(codigo);
		proveedor.setNombre(nombre);
		proveedor.setTelefono(telefono);
		proveedor.setUsuaModi(Utils.obtenerUsuario(request));
		proveedor.setFechamodi(new Date());
		
		try {
				this.p.actualizarProveedor(proveedor);
				ManejadorMensajes.agregarMensaje(request, TipoMensaje.EXITO, "El proveedor ha sido modificado satisfactoriamente");
			} catch (Exception e) {
				ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, e.getMessage());
			}
			
		return new Redireccion(map + "/consultar");
	}
	
	@RequestMapping(value = map + "/eliminar", method = RequestMethod.GET)
	public ModelAndView eliminar_proveedor(HttpServletRequest request,
							HttpServletResponse response,
							@RequestParam(value="codigo", required=true) String codigo) {
		
		
		Proveedor proveedor = new Proveedor();
		proveedor.setCodigo(codigo);
		List<Proveedor> l = p.encontrarProveedor(proveedor);
		l.get(0).setUsuaModi(Utils.obtenerUsuario(request));
		try {
				this.p.eliminarProveedor(l.get(0));
				ManejadorMensajes.agregarMensaje(request, TipoMensaje.EXITO, "El proveedor ha sido eliminado satisfactoriamente");
			} catch (Exception e) {
				ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, e.getMessage());
			}
			
		return new Redireccion(map + "/consultar");
	}
}
