package com.ivpm.horario;

import java.io.IOException;
import java.sql.Types;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import com.control.general.ExcepcionSQL;
import com.control.general.Propiedades;

public class HorarioDAO {
	private JdbcTemplate jdbcHorario;
	private Propiedades prop;
	
	public HorarioDAO() throws IOException {
		prop = new Propiedades("horarios.properties");
		jdbcHorario = null;
	}
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		this.jdbcHorario = new JdbcTemplate(dataSource);
	}
	
	public List<Map<String, Object> > obtenerHorario(int id) {
		
		String sql = prop.obtenerSQL("horarios.obtenerHorarios");
		
		Object[] argumentos = {id, id};
		
		int[] tipos = {Types.INTEGER, Types.INTEGER};
		
		return jdbcHorario.queryForList(sql, argumentos, tipos);
	}

	public void insertarHorario(String descripcion, String horaInicial, String horaFinal) throws ExcepcionSQL {
		
		String sql = prop.obtenerSQL("horarios.insertarHorario");
		
		Object[] argumentos = {descripcion, horaInicial, horaFinal};
		
		int[] tipos = {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
		
		try {
			jdbcHorario.update(sql, argumentos, tipos);
		}
		catch(DataAccessException e) {
			throw new ExcepcionSQL(e.getCause());
		}
	}
	
	public void borrarHorario(int id) throws ExcepcionSQL {
		
		String sql = prop.obtenerSQL("horarios.borrarHorario");
		
		Object[] argumentos = {id};
		
		int[] tipos = {Types.INTEGER};
		
		try {
			jdbcHorario.update(sql, argumentos, tipos);
		}
		catch(DataAccessException e) {
			throw new ExcepcionSQL(e.getCause());
		}
		
	}
	
	public List<Map<String, Object> > usuariosHorario(int id) {
		
		String sql = prop.obtenerSQL("horarios.usuariosHorario");
		
		Object[] argumentos = {id};
		
		int[] tipos = {Types.INTEGER};
		
		return jdbcHorario.queryForList(sql, argumentos, tipos);
	}
	
	public List<Map<String, Object> > usuariosPorAgregar(int id) {
		
		String sql = prop.obtenerSQL("horarios.usuariosPorAgregar");
		
		Object[] argumentos = {id};
		
		int[] tipos = {Types.INTEGER};
		
		return jdbcHorario.queryForList(sql, argumentos, tipos);
	}
	
	public void insertarUsuarioHorario(int id, String usuario) throws ExcepcionSQL {
		
		String sql = prop.obtenerSQL("horarios.borrarUsuarioHorario");
		
		Object[] argumentos = {usuario};
		
		int[] tipos = {Types.VARCHAR};
		
		String sql2 = prop.obtenerSQL("horarios.insertarUsuarioHorario");
		
		Object[] argumentos2 = {id, usuario};
		
		int[] tipos2 = {Types.INTEGER, Types.VARCHAR};
		
		try {
			jdbcHorario.update(sql, argumentos, tipos);
			jdbcHorario.update(sql2, argumentos2, tipos2);
		}
		catch(DataAccessException e) {
			throw new ExcepcionSQL(e.getCause());
		}
	}
}
