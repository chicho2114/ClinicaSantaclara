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
	
	public List<Proveedor> obtenerProveedor(String codigo) {
		
		Object[] argumentos = {codigo, codigo};
		
		int[] tipos = {Types.VARCHAR, Types.VARCHAR};
		
		String sql = prop.obtenerSQL("proveedores.listar");
		
		return jdbcProveedor.query(sql, argumentos, tipos, new ProveedorMapper());
	}
	
	@Transactional(rollbackFor=DataAccessException.class)
	public void insertarProveedor(Proveedor proveedor) throws ExcepcionSQL, Exception {
		
		if(verificarProveedor(proveedor.getCodigo()) > 0) {
			throw new Exception("Codigo de proveedor ya existe!");
		}
		
		//Valores por defecto
		proveedor.setFechacrea(new Date());
		
		
		//Insertar en tabla de proveedores
		Object[] argumentos = {proveedor.getCodigo(), proveedor.getNombre(), proveedor.getTelefono(), proveedor.getFechacrea(), proveedor.getUsuaCrea(), proveedor.getUsuaModi(), proveedor.getFechamodi()};
		
		int[] tipos = {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,
					   Types.TIMESTAMP, Types.VARCHAR, Types.VARCHAR, Types.TIMESTAMP};
		
		String sql =  prop.obtenerSQL("proveedores.insertar");
		
		try {
			jdbcProveedor.update(sql, argumentos, tipos);
		}
		catch(DataAccessException e) {
			throw new ExcepcionSQL(e.getCause());
		}
		
	}
	
	public int verificarProveedor(String codigo) {
		
		Object[] argumentos = {codigo};
		
		int[] tipos = {Types.VARCHAR};
		
		String sql = prop.obtenerSQL("proveedores.verificarProveedor");
		
		return jdbcProveedor.queryForInt(sql, argumentos, tipos);
	}
	
	public List<Proveedor> listarProveedores(Proveedor proveedor) {
		
		Object[] argumentos = {proveedor.getCodigo()+"%", proveedor.getNombre()+"%", 
							   proveedor.getTelefono(), proveedor.getFechacrea()};
		
		int[] tipos = {Types.VARCHAR, Types.VARCHAR, 
					   Types.VARCHAR, Types.TIMESTAMP};
		
		String sql = prop.obtenerSQL("proveedores.listar");
		
		return jdbcProveedor.query(sql, argumentos, tipos, new ProveedorMapper());
	}
	
}
