package com.control.general;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.control.usuario.Usuario;
import com.control.usuario.UsuarioDAO;

/*
 * Clase que se encarga de obtener los datos de usuario la base de datos.
 */
@Service
public class ServicioDetallesUsuario implements UserDetailsService {
	
	@Autowired
	private UsuarioDAO u;

	/*
	 * Método que permite cargar un usuario desde la base de datos.
	 * params:
	 *-String nombreUsuario: Usuario a buscar.
	 */
	@Override
	public UserDetails loadUserByUsername(String nombreUsuario)
			throws UsernameNotFoundException, DataAccessException {
		
		List<Usuario> l = u.obtenerUsuario(nombreUsuario); //Obtenemos el usuario
		
		if(l.size() == 0) { //Si no hay resultados
			return null;
		}
		
		Usuario usuario = l.get(0);
		
		String username = usuario.getCodigo();
		String password = usuario.getContrasena();
		boolean enabled = usuario.getVigencia().equals("S"); 
		
		//int dias = u.vigenciaContrasena(username); Descomentar si se desea llevar el control de cambio de contraseña
		boolean accountNonExpired = !usuario.getVigencia().equals("N"); //Cuenta no expirada y horario verificado
		boolean credentialsNonExpired = !usuario.getCambcontra().equals("S"); //Credenciales no expiradas
		
		boolean mayorA45 = false;//dias > 45;
		boolean accountNonLocked = !usuario.getVigencia().equals("N") && !mayorA45; //Cuenta no bloqueada
		
		List<GrantedAuthority> permisos = u.obtenerPermisos(nombreUsuario); //Obtenemos los permisos de usuario
		
		return new User(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, permisos);
	}
}
