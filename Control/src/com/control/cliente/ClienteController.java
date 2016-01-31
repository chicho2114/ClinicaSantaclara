package com.control.cliente;

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
import com.control.general.Utils;
import com.control.insumo.InsumoDAO;
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
								 @RequestParam(value="cedula", required=true) Integer cedula,
								 @RequestParam(value="nacionalidad", required=true) String nacionalidad,
								 @RequestParam(value="nombre", required=true) String nombre,
								 @RequestParam(value="telefono", required=true) String telefono,
								 @RequestParam(value="direccion", required=true) String direccion) {
	
			Cliente c = new Cliente();
			
			c.setCedula(cedula);
			c.setNacionalidad(nacionalidad);
			c.setNombre(nombre);
			c.setTelefono(telefono);
			c.setDireccion(direccion);
			c.setFechacrea(new Date());
			c.setUsuaCrea(Utils.obtenerUsuario(request));
			
			try {
				this.c.insertarCliente(c);
				ManejadorMensajes.agregarMensaje(request, TipoMensaje.EXITO, "El cliente ha sido creado satisfactoriamente");
			} catch (Exception e) {
				ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, e.getMessage());
			}
			
		return new Redireccion(map + "/crear");
	}
}
