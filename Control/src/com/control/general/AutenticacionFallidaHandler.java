package com.control.general;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

/*
 * Manejador para la autenticación fallida de un usuario
 */
public class AutenticacionFallidaHandler implements AuthenticationFailureHandler {
	
	private static final Logger logger = Logger.getLogger(AutenticacionFallidaHandler.class);
	
	/*
	 * Método que captura el fallo de autenticación a través de una excepción
	 * de tipo AuthenticactionException.
	 * params:
	 *-HttpServletRequest request: petiticón
	 *-HttpServletResponse response: respuesta
	 *-AuthenticationException: Causa del fallo de autenticación
	 * return:
	 */
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
		
		String usuario = request.getParameter("j_username");
		logger.warn("Falla de autenticacion. Usuario: " + usuario + ". Causa: " + exception.getMessage());
		
		if(exception instanceof LockedException) {
			
			if(exception.getMessage().equals("B")) {
				//Si está bloqueado por mantenimiento
				ManejadorMensajes.agregarMensaje(request, TipoMensaje.ADVERTENCIA, "El sistema de Policlínico Santa Clara.  " +
					"se encuentra en mantenimiento y estaremos de vuelta pronto. " +
					"Si presenta problemas, consulte al administrador de sistema");
			}
			else {
				//Si la sesión estaba activa
				ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, "Sesión de usuario activa. Ciérrela e ingrese nuevamente");
			}
			response.sendRedirect(request.getContextPath());
		}
		
		if(exception instanceof BadCredentialsException) { //Si hubo error de autenticación
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, "Falla de autenticación: Usuario o contraseña inválidos");
			response.sendRedirect(request.getContextPath());
		}
		
		if(exception instanceof AccountExpiredException) { //Si cuenta no está vigente
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, "Falla de autenticación: Usuario no vigente o contraseña expirada");
			response.sendRedirect(request.getContextPath());
		}
		
		if(exception instanceof CredentialsExpiredException) { //Si las credenciales expiraron
			Utils.borrarAtributo(request, "cambiocontrasena");
			Utils.borrarAtributo(request, "usuariocambio");
			
			Utils.registrarAtributo(request, "cambiocontrasena", "1");
			Utils.registrarAtributo(request, "usuariocambio", usuario);
			
			response.sendRedirect(request.getContextPath() + "/usuarios/cambiar_contrasena");
		}
	}
}
