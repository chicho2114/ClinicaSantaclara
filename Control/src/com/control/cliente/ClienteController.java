package com.control.cliente;

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
import com.control.insumo.InsumoDAO;
import com.control.proveedor.Proveedor;
import com.control.usuario.UsuarioDAO;

@Controller
public class ClienteController {

	private static final String map = "/cliente";
	private static final String view = "/cliente";
	
	@Autowired
	private UsuarioDAO u;
	@Autowired
	private ClienteDAO c;
	@Autowired
	private InsumoDAO i;
	
	@RequestMapping(value = map + "/crear")
	public ModelAndView crear_form(HttpServletRequest request,
								   HttpServletResponse response) {
		
		ModelMap modelo = new ModelMap();
		modelo.addAttribute("refes", i.consultarReferenciasTerminadas());
		modelo.addAttribute("ins", i.consultarInsumosVencidos());
		modelo.addAttribute("UserRol", u.obtenerPermisos(Utils.obtenerUsuario(request)));
		return new ModelAndView(view + "/crear_form", modelo);
	}
	
	@RequestMapping(value = map + "/crear_accion",
			method = RequestMethod.POST)
	public ModelAndView crear_accion(HttpServletRequest request,
								 HttpServletResponse response,
								 @RequestParam(value="cedula", required=true) String cedula,
								 @RequestParam(value="nacionalidad", required=true) String nacionalidad,
								 @RequestParam(value="nombre", required=true) String nombre,
								 @RequestParam(value="telefono", required=true) String telefono,
								 @RequestParam(value="direccion", required=true) String direccion) {
	
			Cliente cliente = new Cliente();
			
			cliente.setCedula(cedula);
			cliente.setNacionalidad(nacionalidad);
			cliente.setNombre(nombre);
			cliente.setTelefono(telefono);
			cliente.setDireccion(direccion);
			cliente.setFechacrea(new Date());
			cliente.setUsuaCrea(Utils.obtenerUsuario(request));
			
			try {
				this.c.insertarCliente(cliente);
				ManejadorMensajes.agregarMensaje(request, TipoMensaje.EXITO, "El cliente ha sido creado satisfactoriamente");
			} catch (Exception e) {
				ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, e.getMessage());
			}
			
		return new Redireccion(map + "/crear");
	}
	
	@RequestMapping(value = map + "/buscar_cliente")
	public ModelAndView buscar_cliente(HttpServletRequest request,
								   HttpServletResponse response) {
		
		ModelMap modelo = new ModelMap();
		modelo.addAttribute("refes", i.consultarReferenciasTerminadas());
		modelo.addAttribute("ins", i.consultarInsumosVencidos());
		modelo.addAttribute("UserRol", u.obtenerPermisos(Utils.obtenerUsuario(request)));
		return new ModelAndView(view + "/buscar_cliente", modelo);
	}
	
	@RequestMapping(value = map + "/listar")
	public ModelAndView listar(HttpServletRequest request,
							   HttpServletResponse response,
							   @RequestParam(value="cedula", required=false) String cedula,
							   @RequestParam(value="nombre", required=false) String nombre) { 
	
		if(nombre == null) {
			nombre = "";
		}
		if(cedula == null){
			cedula = "";
		}

		Cliente cliente = new Cliente();
		cliente.setCedula(cedula);
		cliente.setNombre(nombre);

		List<Cliente> l = c.listarClientes(cliente);
		
		if(l.size() == 0) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ADVERTENCIA, "No se encontraron resultados");
			return new Redireccion(map + "/buscar_cliente");
		}
		
		ModelMap modelo = new ModelMap();
		modelo.addAttribute("clientes", l);
		modelo.addAttribute("refes", i.consultarReferenciasTerminadas());
		modelo.addAttribute("ins", i.consultarInsumosVencidos());
		modelo.addAttribute("UserRol", u.obtenerPermisos(Utils.obtenerUsuario(request)));
			
		return new ModelAndView(view + "/listar_clientes", modelo);
	}
}
