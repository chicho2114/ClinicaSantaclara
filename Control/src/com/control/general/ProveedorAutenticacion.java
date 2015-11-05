package com.control.general;

import java.util.Collection;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AccountExpiredException;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.LockedException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.session.SessionRegistryImpl;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

/*
 * Clase que se encarga de autenticar a un usuario.
 */
@Component
public class ProveedorAutenticacion implements AuthenticationProvider {
	
	@Autowired
	private ServicioDetallesUsuario detallesUsuario;
	
	@Resource(name="sessionRegistry")
	private SessionRegistryImpl sessionRegistry; //Registro de sesiones activas
	
	/*
	 * Método que permite la autenticación de un usuario
	 * params:
	 * Authentication autenticacion: Objeto que contiene todos los datos de autenticación de un usuario.
	 * return:
	 * Authentication: Token de autenticacion
	 */
	@Override
	public Authentication authenticate(Authentication autenticacion) throws AuthenticationException {
		
		String nombreUsuario = autenticacion.getName();
		String password = (String) autenticacion.getCredentials();
		
		UserDetails usuario = detallesUsuario.loadUserByUsername(nombreUsuario); //Obtiene los datos de usuario guardados en base de datos.
		
		if(usuario == null) { //Si no existe en la base de datos
			throw new BadCredentialsException("Usuario inexistente");
		}
		
		if(sessionRegistry.getAllPrincipals().contains(usuario.getUsername())) {
			throw new LockedException("A");
		}
		
		List<String> a = Utils.obtenerPermisosUsuario(usuario); //Se extraen los permisos de usuario en una lista.
		
		Collection<GrantedAuthority> permisos = usuario.getAuthorities();
		
		if(!usuario.isAccountNonLocked() && !a.contains("ROLE_ADMIN")) { //Si la cuenta no está vigente
			throw new AccountExpiredException("Cuenta no vigente");
		}
		else {
			if(!usuario.isAccountNonLocked() && a.contains("ROLE_ADMIN")) {
				throw new CredentialsExpiredException("Cambio de contrasena");
			}
		}
		
		if(!usuario.isAccountNonExpired()) {
			throw new AccountExpiredException("Cuenta no vigente");
		}
		
		ShaPasswordEncoder spe = new ShaPasswordEncoder(256);
		
		if(!spe.encodePassword(password, nombreUsuario).equals(usuario.getPassword())) { //Contraseña incorrecta
			throw new BadCredentialsException("Contrasena incorrecta");
		}
		
		if(!usuario.isCredentialsNonExpired()) { //Expiraron credenciales
			throw new CredentialsExpiredException("Cambio de contrasena");
		}
		
		return new UsernamePasswordAuthenticationToken(nombreUsuario, password, permisos);
	}

	@Override
	public boolean supports(Class<? extends Object> arg0) {
		// TODO Auto-generated method stub
		return true;
	}
}
