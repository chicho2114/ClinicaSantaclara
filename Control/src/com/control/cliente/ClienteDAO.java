package com.control.cliente;

import java.io.IOException;
import java.sql.Types;
import java.util.Date;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;

import com.control.general.ExcepcionSQL;
import com.control.general.Propiedades;

public class ClienteDAO {
	
	private JdbcTemplate jdbcCliente;
	private Propiedades prop;

	public ClienteDAO() throws IOException {
		prop = new Propiedades("clientes.properties");
		jdbcCliente = null;
	}
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		this.jdbcCliente = new JdbcTemplate(dataSource);
	}
	
	@Transactional(rollbackFor=DataAccessException.class)
	public void insertarCliente(Cliente cliente) throws ExcepcionSQL, Exception {
		
		if(verificarCliente(cliente.getCedula()) > 0) {
			throw new Exception("Este cliente ya existe en el sistema!");
		}
		
		//Valores por defecto
		cliente.setFechacrea(new Date());
		
		
		//Insertar en tabla de clientes
		Object[] argumentos = {cliente.getCedula(), cliente.getNacionalidad(), cliente.getNombre(), cliente.getTelefono(), cliente.getDireccion(), cliente.getFechacrea(), cliente.getUsuaCrea()};
		
		int[] tipos = {Types.INTEGER, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,
					   Types.TIMESTAMP, Types.VARCHAR};
		
		String sql =  prop.obtenerSQL("clientes.insertar");
		
		try {
			jdbcCliente.update(sql, argumentos, tipos);
		}
		catch(DataAccessException e) {
			throw new ExcepcionSQL(e.getCause());
		}
		
	}
	
	public int verificarCliente(Integer cedula) {
		
		Object[] argumentos = {cedula};
		
		int[] tipos = {Types.INTEGER};
		
		String sql = prop.obtenerSQL("clientes.verificarCliente");
		
		return jdbcCliente.queryForInt(sql, argumentos, tipos);
	}
	
}
