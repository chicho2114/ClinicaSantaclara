package com.control.proveedor;

import java.io.IOException;
import java.sql.SQLException;
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
import com.control.referencia.ReferenciaDAO;

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
	
	@Autowired
	private ReferenciaDAO r;
	
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
		
		//Establecemos el ajuste 
				int codigo = r.consultarConsecutivo("AJUSTEPROVEEDOR");
				//Insertamos el movimiento
				Object[] argumentos2 = {proveedor.getCodigo(), 1, "AJUSTEPROVEEDOR" + codigo, "AJUSTEPROVEEDOR", proveedor.getUsuaCrea()};
				
				int[] tipos2 = {Types.VARCHAR, Types.INTEGER, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
				
					String sql2 = prop.obtenerSQL("proveedores.movimiento.insertar");
				
				try {
					jdbcProveedor.update(sql2, argumentos2, tipos2);
				}
				catch(DataAccessException dae) {
					throw new SQLException(dae.getMessage() + "1");
				}
				r.actualizarConsecutivo("AJUSTEPROVEEDOR", 1);
		
	}
	
	public int verificarProveedor(String codigo) {
		
		Object[] argumentos = {codigo};
		
		int[] tipos = {Types.VARCHAR};
		
		String sql = prop.obtenerSQL("proveedores.verificarProveedor");
		
		return jdbcProveedor.queryForInt(sql, argumentos, tipos);
	}
	
	public List<Proveedor> listarProveedores(Proveedor proveedor) {
		
		Object[] argumentos = {proveedor.getCodigo()+"%", proveedor.getNombre()+"%", 
							   proveedor.getTelefono()+"%"};
		
		int[] tipos = {Types.VARCHAR, Types.VARCHAR, 
					   Types.VARCHAR};
		
		String sql = prop.obtenerSQL("proveedores.listar");
		
		return jdbcProveedor.query(sql, argumentos, tipos, new ProveedorMapper());
	}
	
	@Transactional(rollbackFor=DataAccessException.class)
	public void actualizarProveedor(Proveedor proveedor) throws ExcepcionSQL, Exception {
		
		if(verificarProveedor(proveedor.getCodigo()) > 0) {		
			
			//Insertar en tabla de proveedores
			Object[] argumentos = {proveedor.getNombre(), proveedor.getTelefono(), proveedor.getUsuaModi(), proveedor.getFechamodi(), proveedor.getCodigo()};
			
			int[] tipos = {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,
						   Types.TIMESTAMP, Types.VARCHAR};
			
			String sql =  prop.obtenerSQL("proveedores.actualizar");
			
			try {
				jdbcProveedor.update(sql, argumentos, tipos);
			}
			catch(DataAccessException e) {
				throw new ExcepcionSQL(e.getCause());
			}
		}
		
	}
	
	public List<Proveedor> encontrarProveedor(Proveedor proveedor) {
		
		Object[] argumentos = {proveedor.getCodigo()};
		
		int[] tipos = {Types.VARCHAR};
		
		String sql = prop.obtenerSQL("proveedores.encontrar");
		
		return jdbcProveedor.query(sql, argumentos, tipos, new ProveedorMapper());
	}
	
	@Transactional(rollbackFor=DataAccessException.class)
	public void eliminarProveedor(Proveedor proveedor) throws ExcepcionSQL, Exception {
		//Establecemos el ajuste 
		int codigo = r.consultarConsecutivo("AJUSTEPROVEEDOR");
		//Insertamos el movimiento
		Object[] argumentos2 = {proveedor.getCodigo(), -1, "AJUSTEPROVEEDOR" + codigo, "AJUSTEPROVEEDOR", proveedor.getUsuaModi()};
		
		int[] tipos2 = {Types.VARCHAR, Types.INTEGER, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
		
			String sql2 = prop.obtenerSQL("proveedores.movimiento.insertar");
		
		try {
			jdbcProveedor.update(sql2, argumentos2, tipos2);
		}
		catch(DataAccessException dae) {
			throw new SQLException(dae.getMessage() + "1");
		}
		
		r.actualizarConsecutivo("AJUSTEPROVEEDOR", 1);
			//Insertar en tabla de proveedores
			Object[] argumentos = { proveedor.getCodigo()};
			
			int[] tipos = {Types.VARCHAR};
			
			String sql =  prop.obtenerSQL("proveedores.eliminar");
			
			try {
				jdbcProveedor.update(sql, argumentos, tipos);
			}
			catch(DataAccessException e) {
				throw new ExcepcionSQL(e.getCause());
			}

	}
	
}
