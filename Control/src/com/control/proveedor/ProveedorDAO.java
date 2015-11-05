package com.control.proveedor;

import java.io.IOException;
import java.sql.Types;
import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;

import com.control.general.ExcepcionSQL;
import com.control.general.Propiedades;


public class ProveedorDAO {

	private JdbcTemplate jdbcProveedor;
	private Propiedades prop;
	
	public ProveedorDAO() throws IOException {
		prop = new Propiedades("proveedores.properties");
		jdbcProveedor = null;
	}
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		this.jdbcProveedor = new JdbcTemplate(dataSource);
	}
	
	public List<Proveedor> obtenerProveedor(String id) {
		
		Object[] argumentos = {id, id};
		
		int[] tipos = {Types.VARCHAR, Types.VARCHAR};
		
		String sql = prop.obtenerSQL("proveedores.listar");
		
		return jdbcProveedor.query(sql, argumentos, tipos, new ProveedorMapper());
	}
	
	@Transactional(rollbackFor=DataAccessException.class)
	public void insertarProveedor(Proveedor proveedor) throws ExcepcionSQL, Exception {
		
		if(verificarProveedor(proveedor.getId()) > 0) {
			throw new Exception("Este proveedor ya existe!");
		}
		
		//Valores por defecto
		proveedor.setFechacrea(new Date());
		
		//Insertar en tabla de usuarios
		Object[] argumentos = {proveedor.getId(), proveedor.getNombre(), proveedor.getTelefono(), proveedor.getFechacrea()};
		
		int[] tipos = {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,
					   Types.TIMESTAMP};
		
		String sql =  prop.obtenerSQL("proveedores.insertar");
		
		try {
			jdbcProveedor.update(sql, argumentos, tipos);
		}
		catch(DataAccessException e) {
			throw new ExcepcionSQL(e.getCause());
		}
		
	}
	
	public int verificarProveedor(String id) {
		
		Object[] argumentos = {id};
		
		int[] tipos = {Types.VARCHAR};
		
		String sql = prop.obtenerSQL("proveedores.verificarProveedor");
		
		return jdbcProveedor.queryForInt(sql, argumentos, tipos);
	}
	
}
