package com.control.general;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.ui.ModelMap;

import com.control.usuario.Usuario;

/*
 * Clase con funciones útiles
 */
public class Utils {
	
	public static void registarUsuario(HttpServletRequest request, String usuario) {
		if(request.getSession().getAttribute("usuario") == null) {
			request.getSession().setAttribute("usuario", usuario);
		}
	}
	
	public static String obtenerUsuario(HttpServletRequest request) {
		Usuario u = (Usuario) request.getSession().getAttribute("usuario");
		
		if(u == null) {
			return null;
		}
		
		return u.getCodigo();
	}
	
	public static List<String> obtenerPermisosUsuario(UserDetails u) {
		
		List<String> permisos = new ArrayList<String>();
		
		Collection<GrantedAuthority> p = u.getAuthorities();
    	
    	for(GrantedAuthority g : p) {
    		permisos.add(g.getAuthority());
    	}
		
		return permisos;
	}
	
	public static void registrarAtributo(HttpServletRequest request, String atributo, Object valor) {
		request.getSession().setAttribute(atributo, valor);
	}
	
	public static String obtenerAtributo(HttpServletRequest request, String atributo) {
		return (String) request.getSession().getAttribute(atributo);
	}
	
	public static void borrarAtributo(HttpServletRequest request, String atributo) {
		request.getSession().removeAttribute(atributo);
	}
	
	public static void registrarUsuario(HttpServletRequest request, Usuario usuario) {
		request.getSession().setAttribute("usuario", usuario);
	}
	
	public static void paginacion(ModelMap modelo, int numeroElementos, int pagina) {
		
		boolean rollback = false;

		if(pagina % 12 == 0) {
			pagina = pagina - 1;
			rollback = true;
		}
		
		modelo.addAttribute("offset", (pagina/12)*12);
		if(Math.abs((pagina/12)*12 - numeroElementos/12) > 12) {
			if((pagina/12)*12 - 1 > 0) {
				modelo.addAttribute("atras", "1");
			}
			modelo.addAttribute("siguiente", "1");
			modelo.addAttribute("numeroPaginas", 12);
		}
		else {
			int numeroPaginas =  Math.abs((pagina/12)*12 - numeroElementos/12);
			if(numeroElementos % 12 > 0) {
				numeroPaginas++;
			}
			if((pagina/12)*12 > 0) {
				modelo.addAttribute("atras", "1");
			}
			
			modelo.addAttribute("numeroPaginas", numeroPaginas);
		}
		
		if(rollback) {
			pagina = pagina + 1;
		}
		
		modelo.addAttribute("pagina", pagina);
	}
	
	public static String validarContrasena(String contrasena, String usuario) {
		
		if(contrasena.length() < 8) {
			return "Debe ser de mínimo 8 caracteres";
		}
		
		if(contrasena.charAt(0) < 'A' || contrasena.charAt(0) > 'Z') {
			return "Debe comenzar por una letra mayúscula";
		}
		
		if((contrasena.charAt(1) < 'a' && contrasena.charAt(1) > 'z') || (contrasena.charAt(1) < 'A' && contrasena.charAt(1) > 'Z')) {
			return "El segundo caracter debe ser una letra";
		}
		
		if((contrasena.contains(usuario) || contrasena.contains(new StringBuilder(usuario).reverse().toString()))) {
			return "No debe contener el nombre de usuario ni al derecho ni al revés";
		}
		
		if(contrasena.charAt(contrasena.length()-1) < '0' || contrasena.charAt(contrasena.length()-1) > '9') {
			return "Debe finalizar con un caracter numérico";
		}
		
		for(int i = 0; i < contrasena.length(); i++) {
			if((contrasena.charAt(i) < 'A' || contrasena.charAt(i) > 'Z') && 
			   (contrasena.charAt(i) < 'a' || contrasena.charAt(i) > 'z') &&
			   (contrasena.charAt(i) < '0' || contrasena.charAt(i) > '9') && 
			   (contrasena.charAt(i) != '$') && (contrasena.charAt(i) != '#') && (contrasena.charAt(i) != '@')) {
				return "La contraseña debe ser alfanumérica y solamente están permitidos los caracteres @, $ y #";
			}   
		}
		
		return null;
	}
}
