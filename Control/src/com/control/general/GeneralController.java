package com.control.general;

import java.io.DataInputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
//import org.springframework.security.authentication.encoding.ShaPasswordEncoder;

import com.control.insumo.InsumoDAO;
import com.control.usuario.Usuario;
import com.control.usuario.UsuarioDAO;


/*
 * Controlador General
 */
@Controller
public class GeneralController {
	
	private static final String map = "/";
	private static final String view = "/general";
	
	@Autowired
	private UsuarioDAO u;
	@Autowired
	private InsumoDAO i;
	
	private static final Logger logger = Logger.getLogger(GeneralController.class);
	
	/*
	 * Página index
	 */
	@RequestMapping(value = map)
	public ModelAndView index(HttpServletRequest request, 
							  HttpServletResponse response) throws Exception {
		
		String user = SecurityContextHolder.getContext().getAuthentication().getName();
		
		//ShaPasswordEncoder s = new ShaPasswordEncoder(256);
		//System.out.println(s.encodePassword("prueba", "prueba"));
		
		if(!SecurityContextHolder.getContext().getAuthentication().getPrincipal().equals("anonymousUser")) { //Si se ha autenticado satisfactoriamente
			
			if(Utils.obtenerUsuario(request) == null) {
				Usuario usuario = u.obtenerUsuario(user).get(0);
				
				//Registramos la sesión
				Utils.registrarUsuario(request, usuario);
				
			}
			
			
			ModelMap modelo = new ModelMap();
			modelo.addAttribute("referencias", i.consultarReferencias());
			modelo.addAttribute("insumos", i.consultarInsumos());
			
			return new ModelAndView(view + "/usuario", modelo);
		}
		
		return new ModelAndView(view + "/login");
	}
	
	/*
	 * Descarga de políticas de seguridad
	 */
	@RequestMapping(value = map + "/politicas_seguridad")
	public ModelAndView politicas_seguridad(HttpServletRequest request,
											HttpServletResponse response) {
		try {
			ServletOutputStream outputStream = response.getOutputStream(); //Obtenemos el outputStream de la respuesta Http
	        
	        byte[] buffer = new byte[4096];
	        DataInputStream in = new DataInputStream(this.getClass().getClassLoader().getResourceAsStream("politicas.pdf")); //Cargamos archivo
	        
	        /*
	         * Actualizamos cabeceras en la respuesta
	         */
	        response.setContentType("application/pdf");
			response.setHeader("Content-disposition","inline; filename=politicas.pdf"); 
			response.setHeader("Cache-Control", "no-cache");  
	        response.setDateHeader("Expires", 0);  
	        response.setHeader("Pragma", "No-cache"); 
	        
	        /*
	         * Escribimos archivo en la respuesta http.
	         */
	        int length;
			while((in != null ) && ((length = in.read(buffer)) != -1)) {
				outputStream.write(buffer,0,length);
			}
			in.close();
			outputStream.close();
		}
		catch(Exception e) {
			logger.error("Usuario: " + Utils.obtenerUsuario(request) + " " + e.getMessage());
		}
        
		return null;
	}
}