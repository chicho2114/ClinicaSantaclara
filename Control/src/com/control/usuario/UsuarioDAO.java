package com.control.usuario;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.transaction.annotation.Transactional;

import com.control.general.ExcepcionSQL;
import com.control.general.Propiedades;
import com.control.general.Utils;

public class UsuarioDAO {
	
	private JdbcTemplate jdbcUsuario;
	private Propiedades prop;
	
	public UsuarioDAO() throws IOException {
		prop = new Propiedades("usuarios.properties");
		jdbcUsuario = null;
	}
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		this.jdbcUsuario = new JdbcTemplate(dataSource);
	}
	
	public List<Usuario> obtenerUsuario(String codigo) {
		
		Object[] argumentos = {codigo, codigo};
		
		int[] tipos = {Types.VARCHAR, Types.VARCHAR};
		
		String sql = prop.obtenerSQL("usuarios.listar");
		
		return jdbcUsuario.query(sql, argumentos, tipos, new UsuarioMapper());
	}

	public List<Map<String, Object>> obtenerRoles() {
		
		String sql = "SELECT tpi_rol_codigo codigo, ts_rol_descripcion rol FROM t_rol";
		return jdbcUsuario.queryForList(sql);
	}
	
	public List<GrantedAuthority> obtenerPermisos(String codigo) {
		
		Object[] argumentos = {codigo};
		
		int[] tipos = {Types.VARCHAR};
		
		String sql = prop.obtenerSQL("usuarios.obtenerPermisos");
		
		return jdbcUsuario.query(sql, argumentos, tipos, new RowMapper<GrantedAuthority>() {
			public GrantedAuthority mapRow(ResultSet rs, int i) throws SQLException {
				GrantedAuthority g = new GrantedAuthorityImpl(rs.getString("rol"));
				return g;
			}
		});
		
	}
	
	public List<Map<String, Object>> obtenerPermisoUsuario(String codigo) {
		
		Object[] argumentos = {codigo};
		
		int[] tipos = {Types.VARCHAR};
		
		String sql = "select tpi_rol_codigo rol from t_rol_usuario ru, t_rol r where ru.tpfi_rolusuario_codigo = r.tpi_rol_codigo and ru.tfs_rolusuario_usuario = ?";
		
		return jdbcUsuario.queryForList(sql, argumentos, tipos);
		
	}
	
	@Transactional(rollbackFor=DataAccessException.class)
	public void insertarUsuario(Usuario usuario, int permisologia) throws ExcepcionSQL, Exception {
		
		if(verificarUsuario(usuario.getCodigo()) > 0) {
			throw new Exception("Codigo de usuario ya existe!");
		}
		
		//Valores por defecto
		usuario.setVigencia("V");
		usuario.setCambcontra("N");
		usuario.setUltcambcontra(new Date());
		
		//Insertar en tabla de usuarios
		Object[] argumentos = {usuario.getCodigo(), usuario.getContrasena(), usuario.getCambcontra(),
							   usuario.getUltcambcontra(), usuario.getVigencia(), usuario.getCedula(),
							   usuario.getNombre(), usuario.getArea(), usuario.getCargo(),
							   usuario.getUsuacrea(), usuario.getFechacrea()};
		
		int[] tipos = {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,
					   Types.TIMESTAMP, Types.VARCHAR, Types.VARCHAR,
					   Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, 
					   Types.VARCHAR, Types.TIMESTAMP};
		
		String sql =  prop.obtenerSQL("usuarios.insertar");
		
		try {
			jdbcUsuario.update(sql, argumentos, tipos);
		}
		catch(DataAccessException e) {
			throw new ExcepcionSQL(e.getCause());
		}
		
		//Insertar permisología
		Object[] argumentos2 = {permisologia, usuario.getCodigo()};
		
		int[] tipos2 = {Types.INTEGER, Types.VARCHAR};
		
		String sql2 = prop.obtenerSQL("usuarios.insertarPermiso");
		
		try {
			jdbcUsuario.update(sql2, argumentos2, tipos2);
		}
		catch(DataAccessException e) {
			throw new ExcepcionSQL(e.getCause());
		}
	}
	
	public void actualizarUsuario(Usuario usuario, int permisologia) throws ExcepcionSQL, Exception {

		//Modificacion de datos de usuario
		Object[] argumentos = { usuario.getVigencia(), usuario.getCedula(), usuario.getNombre(), usuario.getCargo(),
							   usuario.getUsuamodi(), usuario.getFechamodi(), usuario.getCodigo()};
		
		int[] tipos = {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,
					   Types.VARCHAR, Types.VARCHAR, Types.TIMESTAMP, Types.VARCHAR};
		
		String sql = prop.obtenerSQL("usuarios.actualizar");
		
		try {
			jdbcUsuario.update(sql, argumentos, tipos);
		}
		catch(DataAccessException e) {
			throw new ExcepcionSQL(e.getCause());
		}
		
		//Actualizar permisología
		Object[] argumentos2 = {permisologia, usuario.getCodigo(), usuario.getCodigo()};
		
		int[] tipos2 = {Types.INTEGER, Types.VARCHAR, Types.VARCHAR};
		
		String sql2 = prop.obtenerSQL("usuarios.actualizarPermiso");
		
		try {
			jdbcUsuario.update(sql2, argumentos2, tipos2);
		}
		catch(DataAccessException e) {
			throw new ExcepcionSQL(e.getCause());
		}
	}

	public void cambiarContrasena(Usuario usuario) throws ExcepcionSQL, Exception {
		
		List<Usuario> l = obtenerUsuario(usuario.getCodigo());
		
		if(usuario.getContrasena() == l.get(0).getContrasena()) {
			throw new Exception("La contraseña debe ser diferente a la anterior.");
		}
		
		Object[] argumentos = {usuario.getContrasena(), usuario.getFechamodi(), usuario.getUsuamodi(),
							   usuario.getFechamodi(), usuario.getCodigo()};
		
		int[] tipos = {Types.VARCHAR, Types.TIMESTAMP, Types.VARCHAR, 
					   Types.TIMESTAMP, Types.VARCHAR};
		
		String sql = prop.obtenerSQL("usuarios.cambiarContrasena");
		
		try {
			jdbcUsuario.update(sql, argumentos, tipos);
		}
		catch(DataAccessException e) {
			throw new ExcepcionSQL(e.getCause());
		}
	}
	
	@Transactional(rollbackFor=DataAccessException.class)
	public int cambiarContrasenaExpirada(Usuario usuario, String nuevaContrasena) throws ExcepcionSQL, Exception {
	
		usuario.setFechamodi(new Date());
		
		int cantidadContrasenas = obtenerCantidadContrasenas();
		
		if(!verificarNuevaContrasena(usuario, nuevaContrasena, cantidadContrasenas)) {
			throw new Exception("La contraseña debe ser diferente a últimas " + Integer.toString(cantidadContrasenas) + " contraseñas.");
		}
		
		Object[] argumentos = {nuevaContrasena, usuario.getFechamodi(), usuario.getUsuamodi(), 
							   usuario.getFechamodi(), usuario.getCodigo(), usuario.getContrasena()};
		
		int[] tipos = {Types.VARCHAR, Types.TIMESTAMP, Types.VARCHAR, 
					   Types.TIMESTAMP, Types.VARCHAR, Types.VARCHAR};
		
		String sql = prop.obtenerSQL("usuarios.cambiarContrasenaExpirada");
		
		try {
			
			int i = jdbcUsuario.update(sql, argumentos, tipos);
			
			if(i > 0) {
				insertarNuevaContrasena(usuario, nuevaContrasena);
			}
			
			return i;
		}
		catch(DataAccessException e) {
			throw new ExcepcionSQL(e.getCause());
		}
	}
	
	private int obtenerCantidadContrasenas() {
		
		String sql = prop.obtenerSQL("usuarios.cantidadContrasenas");
		
		return jdbcUsuario.queryForInt(sql);
	}
	
	private boolean verificarNuevaContrasena(Usuario usuario, String nuevaContrasena, int cantidadContrasenas) throws ExcepcionSQL {
		
		Object[] argumentos = {usuario.getCodigo(), cantidadContrasenas};
		
		int[] tipos = {Types.VARCHAR, Types.INTEGER};
		
		String sql = prop.obtenerSQL("usuarios.ultimasContrasenas");
		
		List<String> resultados = jdbcUsuario.queryForList(sql, argumentos, tipos, String.class);
		
		return !resultados.contains(nuevaContrasena);
	}
	
	private void insertarNuevaContrasena(Usuario usuario, String nuevaContrasena) throws ExcepcionSQL {
		
		Object[] argumentos = {usuario.getCodigo(), nuevaContrasena, usuario.getFechamodi()};
		
		int[] tipos = {Types.VARCHAR, Types.VARCHAR, Types.TIMESTAMP};
		
		String sql = prop.obtenerSQL("usuarios.insertarContrasenaTablaControl");
		
		jdbcUsuario.update(sql, argumentos, tipos);
	}
	
	public int verificarUsuario(String id) {
		
		Object[] argumentos = {id};
		
		int[] tipos = {Types.VARCHAR};
		
		String sql = prop.obtenerSQL("usuarios.verificarUsuario");
		
		return jdbcUsuario.queryForInt(sql, argumentos, tipos);
	}
	
	public boolean verificarHorario(String id) {
		
		Object[] argumentos = {id};
		
		int[] tipos = {Types.VARCHAR};
		
		String sql = prop.obtenerSQL("usuarios.verificarHorario");
		
		return jdbcUsuario.queryForInt(sql, argumentos, tipos) == 1;
	}
	
	public int vigenciaContrasena(String id) {
		
		String sql = "SELECT DATEDIFF(now(), u.td_usuario_ultcamcon) " +
					 "FROM t_usuario u " +
					 "WHERE u.tps_usuario_codigo = ?";
		
		return jdbcUsuario.queryForInt(sql, id);
		
	}
	
	public void eliminarUsuario(String codigo) throws ExcepcionSQL {
		
		Object[] argumentos = {codigo};
		
		int[] tipos = {Types.VARCHAR};
		
		String sql = prop.obtenerSQL("usuarios.eliminar");
		
		jdbcUsuario.update(sql, argumentos, tipos);
	}
}
