package com.ivpm.horario;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.control.general.ExcepcionSQL;
import com.control.general.ManejadorMensajes;
import com.control.general.Redireccion;
import com.control.general.TipoMensaje;

@Controller
public class HorarioController {
	
	private static final String map = "/horarios";
	private static final String view = "/horarios";
	
	@Autowired
	private HorarioDAO h;
	
	@RequestMapping(value = map)
	public ModelAndView horario(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		ModelMap modelo = new ModelMap();
		
		modelo.addAttribute("horarios", h.obtenerHorario(-1));
		
		return new ModelAndView(view + "/listar", modelo);
	}
	
	@RequestMapping(value = map + "/crear_horario_accion", method=RequestMethod.POST)
	public ModelAndView crear_horario_accion(HttpServletRequest request, 
											 HttpServletResponse response,
											 @RequestParam(value="descripcion", required=true) String descripcion,
											 @RequestParam(value="inicio", required=true) String horainicio,
											 @RequestParam(value="fin", required=true) String horafin) throws Exception {
		
		String[] inicio = horainicio.split(":");
		String[] fin = horafin.split(":");
		
		try {
			int i,j,k,l;
			
			i = Integer.parseInt(inicio[0]);
			j = Integer.parseInt(fin[0]);
			k = Integer.parseInt(inicio[1]);
			l = Integer.parseInt(fin[1]);
			
			if(i < 0 && i > 24 && j < 0 && j > 60) {
				ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, "Hora inválida");
				return new Redireccion(map + "/");
			}
			
			if(i > j) {
				ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, "Hora de inicio debe ser menor que hora final");
				return new Redireccion(map + "/");
			}
			else {
				if(i == j) {
					if(k > l) {
						ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, "Hora de inicio debe ser menor que hora final");
						return new Redireccion(map + "/");
					}
				}
			}
		}
		catch(Exception e) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, "Las horas deben ser en formato hh:mm");
			return new Redireccion(map + "/");
		}
		
		try {
			h.insertarHorario(descripcion, horainicio, horafin);
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.EXITO, "Horario creado con éxito");
		}
		catch(ExcepcionSQL e) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, "Error creando horario");
		}
		
		return new Redireccion(map + "/");
	}
	
	@RequestMapping(value = map + "/borrar_horario_accion", method=RequestMethod.POST)
	public ModelAndView borrar_horario_accion(HttpServletRequest request, 
											  HttpServletResponse response,
											  @RequestParam(value="id", required=true) int id) throws Exception {
		
		try {
			h.borrarHorario(id);
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.EXITO, "Horario borrado con éxito");
		}
		catch(ExcepcionSQL e) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, "Error borrando horario");
		}
		
		return new Redireccion(map + "/");
	}
	
	@RequestMapping(value = map + "/usuarios_horario")
	public ModelAndView usuarios_horario(HttpServletRequest request, 
			  							 HttpServletResponse response,
		  							 	 @RequestParam(value="id", required=true) int id) throws Exception {
		
		ModelMap modelo = new ModelMap();
		
		List<Map<String, Object> > horarios = h.obtenerHorario(id);
		
		if(horarios.size() == 0) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, "Horario no encontrado");
			return new Redireccion(map + "/");
		}
		
		modelo.addAttribute("horario", horarios.get(0));
		modelo.addAttribute("usuarios", h.usuariosHorario(id));
		modelo.addAttribute("usuariosAgregar", h.usuariosPorAgregar(id));
		
		return new ModelAndView(view + "/usuarios_horario", modelo);
	}
	
	@RequestMapping(value= map + "/usuarios_horario_accion", method=RequestMethod.POST)
	public ModelAndView usuarios_horario_accion(HttpServletRequest request, 
												HttpServletResponse response,
												@RequestParam(value="id", required=true) int id,
												@RequestParam(value="usuario", required=true) String usuario) {
		
		try { 
			h.insertarUsuarioHorario(id, usuario);
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.EXITO, "Horario de usuario: " + usuario + " actualizado correctamente");
		}
		catch(ExcepcionSQL e) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, "Error al actualizar horario para usuario: " + usuario);
		}
		
		return new Redireccion(map + "/usuarios_horario?id="+Integer.toString(id));
	}
}
