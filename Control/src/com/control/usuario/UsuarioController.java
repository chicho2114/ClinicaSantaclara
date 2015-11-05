package com.control.usuario;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

//import com.control.general.ExcepcionSQL;
//import com.control.general.GeneralController;
import com.control.general.ManejadorMensajes;
import com.control.general.Redireccion;
import com.control.general.ServicioDetallesUsuario;
import com.control.general.TipoMensaje;
import com.control.general.Utils;

@Controller
public class UsuarioController {
	
	private static final String map = "/usuarios";
	private static final String view = "/usuarios";
	
	@Autowired
	private UsuarioDAO u;
	
	@Autowired
	private ServicioDetallesUsuario sdu;
	
	//private static final Logger logger = Logger.getLogger(GeneralController.class);
	
	@RequestMapping(value = map)
	public ModelAndView usuario(HttpServletRequest request,
								HttpServletResponse response) {
		
		ModelMap modelo = new ModelMap();
		modelo.addAttribute("usuarios", u.obtenerUsuario(null));
		return new ModelAndView(view + "/listado", modelo);
	}
	
	@RequestMapping(value = map + "/ver")
	public ModelAndView usuario(HttpServletRequest request,
								HttpServletResponse response,
								@RequestParam(value="codigo", required=true) String id) {
		
		return new ModelAndView(view + "/ver", null);
	}
	
	@RequestMapping(value = map + "/crear")
	public ModelAndView crear(HttpServletRequest request,
							  HttpServletResponse response) {
		
		return new ModelAndView(view + "/crear");
	}
	
	@RequestMapping(value = map + "/buscarUsuario")
	public ModelAndView buscarUsuario(HttpServletRequest request,
									  HttpServletResponse response,
									  @RequestParam(value="codigo", required=true) String codigo) {
		
		ModelMap modelo = new ModelMap();
		modelo.addAttribute("respuesta", !(u.verificarUsuario(codigo) > 0));
		
		return new ModelAndView("ajax/usuario", modelo);
	}
	
	@RequestMapping(value = map + "/crear_accion", method=RequestMethod.POST)
	public ModelAndView crear_accion(HttpServletRequest request,
									 HttpServletResponse response) {
		
		return new Redireccion(map + "/crear");
	}
	
	@RequestMapping(value = map + "/modificar")
	public ModelAndView modificar(HttpServletRequest request,
								  HttpServletResponse response,
								  @RequestParam(value="codigo", required=true) String id) {
		
		Utils.borrarAtributo(request, "usuarioMod");
		
		List<Usuario> l = u.obtenerUsuario(id);
		
		if(l.size() == 0) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, "No existe usuario");
			return new Redireccion(map + "/");
		}
		
		UserDetails usuario = sdu.loadUserByUsername(id);
		
		List<String> permisos = Utils.obtenerPermisosUsuario(usuario);
		
		ModelMap modelo = new ModelMap();
		modelo.put("user", l.get(0));
		modelo.put("actualizar", permisos.contains("ROLE_ACTUALIZAR"));
		
		permisos.remove("ROLE_ACTUALIZAR");
		
		if(permisos.contains("ROLE_EXTERNO")) {
			modelo.put("permiso", 1);
		}
		
		if(permisos.contains("ROLE_VMV")) {
			modelo.put("permiso", 2);
		}
		
		if(permisos.contains("ROLE_ADMINISTRADOR")) {
			modelo.put("permiso", 3);
		}
		
		Utils.registrarAtributo(request, "usuarioMod", id);
		
		return new ModelAndView(view + "/modificar", modelo);
	}
	
	@RequestMapping(value = map + "/modificar_accion", method=RequestMethod.POST)
	public ModelAndView modificar_accion(HttpServletRequest request,
										 HttpServletResponse response) {
		
		return new Redireccion(map + "/ver");
	}
	
	@RequestMapping(value = map + "/modificar_contrasena_accion", method=RequestMethod.POST) 
	public ModelAndView modificar_contrasena_accion(HttpServletRequest request,
													HttpServletResponse response) {
		
		return new Redireccion(map + "/ver");
	}
	
	@RequestMapping(value = map + "/cambiar_contrasena")
	public ModelAndView cambiar_contrasena(HttpServletRequest request,
										   HttpServletResponse response) {
		
		return new ModelAndView(view + "/cambiar_contrasena");
	}
	
	@RequestMapping(value = map + "/cambiar_contrasena_accion", method=RequestMethod.POST)
	public ModelAndView cambiar_contrasena_accion(HttpServletRequest request,
												  HttpServletResponse response) {
		
		return new Redireccion("/");
	}
}
