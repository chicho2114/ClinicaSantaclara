package com.control.general;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/*
 * Clase para manejar mensajes dentro de las páginas mostradas.
 */
public class ManejadorMensajes {
	
	/*
	 * Agrega un mensaje a la sesion.
	 * params:
	 *-HttpServletRequest request: Petición http
	 *-TipoMensaje tipo: El tipo de mensaje mostrado (ADVERTENCIA, ERROR, EXITO)
	 *-String mensaje: Mensaje a mostrar
	 * return:
	 */
	public static void agregarMensaje(HttpServletRequest request, TipoMensaje tipo, String mensaje) {
		if(request == null || tipo == null || mensaje == null || mensaje.equals("")) {
			return;
		}
		
		HttpSession sesion = request.getSession();
		sesion.setAttribute("mensaje", mensaje);
		sesion.setAttribute("tipo", tipo);
	}
}
