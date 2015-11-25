package com.control.referencia;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;

import com.control.general.ExcepcionSQL;
import com.control.general.Propiedades;

public class ReferenciaDAO {
	
	private JdbcTemplate jdbcReferencia;
	private Propiedades prop;
	
	public ReferenciaDAO() throws IOException {
		prop = new Propiedades("referencias.properties");
	}
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		this.jdbcReferencia = new JdbcTemplate(dataSource);
	}
	
	public List<Referencia> listarReferencias(Referencia referencia) {
		
		Object[] argumentos = {referencia.getCodigo()+"%", referencia.getDescripcion()+"%", 
							   referencia.getFabricante(), referencia.getFabricante(), 
							   referencia.getCategoria(), referencia.getCategoria()};
		
		int[] tipos = {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, 
					   Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
		
		String sql = prop.obtenerSQL("referencias.listar");
		
		return jdbcReferencia.query(sql, argumentos, tipos, new ReferenciaMapper());
	}
	
	public List<Map<String, Object>> inventarioGeneral() {
		
		String sql = prop.obtenerSQL("referencias.inventario.listar");
		
		return jdbcReferencia.queryForList(sql);
	}
	
	@Transactional(rollbackFor=Exception.class)
	public void insertarReferencia(Referencia referencia) throws Exception {
		
		if(verificarReferencia(referencia.getCodigo()) > 0 ) {
			throw new Exception("Código de referencia ya existe");
		}
		
		//Valores por defecto
		referencia.setFechaCrea(new Date());
		
		//Insertar en tabla de referencias
		Object[] argumentos = {referencia.getCodigo(), referencia.getDescripcion(), referencia.getComponente(),
							   referencia.getPresentacion(), referencia.getFabricante(), referencia.getCategoria(),
							   referencia.getObservacion(), referencia.getCant_mini(), referencia.getUsuaCrea(), referencia.getFechaCrea(),
							   referencia.getUsuaModi(), referencia.getFechaModi()};
		
		int[] tipo = {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,
					  Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,
					  Types.VARCHAR, Types.INTEGER, Types.VARCHAR, Types.TIMESTAMP,
					  Types.VARCHAR, Types.TIMESTAMP};
		
		String sql = prop.obtenerSQL("referencias.insertar");
		
		try {
			jdbcReferencia.update(sql, argumentos, tipo);
		}
		catch(DataAccessException dae) {
			throw new Exception(dae.getCause());
		}
		
		for(final Map<String, Object> m : consultarBodegas()) {
			//Insertar referencia en bodega
			Object[] argumentos2 = {(String) m.get("codigo"), referencia.getCodigo(), 
									referencia.getUsuaCrea(), referencia.getFechaCrea()};
			
			int[] tipo2 = {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.TIMESTAMP};
					
			String sql2 = prop.obtenerSQL("referencias.insertar.en.bodega");
			
			try {
				jdbcReferencia.update(sql2, argumentos2, tipo2);
			}
			catch(DataAccessException dae) {
				throw new Exception(dae.getCause());
			}
		}
	}
	
	@Transactional(rollbackFor=SQLException.class)
	public void insertarReferenciasBatch(final List<String> codigos, final List<String> descripciones, final List<String> componentes, 
										 final List<String> presentaciones, final List<String> fabricantes, final List<String> categorias,
										 final List<String> observaciones, final List<Integer> cantminima, final String usuario) throws SQLException {
		
		String sql = prop.obtenerSQL("referencias.insertar");
		
		final Date fechaCreacion = new Date();
		
		try {
			jdbcReferencia.batchUpdate(sql, new BatchPreparedStatementSetter() {
				
				public int getBatchSize() {
					return codigos.size();
				}
	
				@Override
				public void setValues(PreparedStatement ps, int i) throws SQLException {
					ps.setString(1, codigos.get(i));
					ps.setString(2, descripciones.get(i));
					ps.setString(3, componentes.get(i));
					ps.setString(4, presentaciones.get(i));
					ps.setString(5, fabricantes.get(i));
					ps.setString(6, categorias.get(i));
					ps.setString(7, observaciones.get(i));
					ps.setInt(8, cantminima.get(i));
					ps.setString(9, usuario);
					ps.setTimestamp(10, new Timestamp(fechaCreacion.getTime()));
					ps.setString(11, null);
					ps.setTimestamp(12, null);
				}	
			});
		}
		catch(DataAccessException e) {
			throw new SQLException(e);
		}
		
		for(final Map<String, Object> m : consultarBodegas()) {
		
			String sql2 = prop.obtenerSQL("referencias.insertar.en.bodega");
			
			try {
				jdbcReferencia.batchUpdate(sql2, new BatchPreparedStatementSetter() {
					
					public int getBatchSize() {
						return codigos.size();
					}
		
					@Override
					public void setValues(PreparedStatement ps, int i) throws SQLException {
						ps.setString(1, (String)m.get("codigo"));
						ps.setString(2, codigos.get(i));
						ps.setString(3, usuario);
						ps.setTimestamp(4, new Timestamp(fechaCreacion.getTime()));
					}	
				});
			}
			catch(DataAccessException e) {
				throw new SQLException(e);
			}
		}
	}
	
	public int verificarReferencia(String id) {
		
		Object[] argumentos = {id};
		
		int[] tipos = {Types.VARCHAR};
		
		String sql = "select count(*) from t_referencia where tps_referencia_codigo = ?";
		
		return jdbcReferencia.queryForInt(sql, argumentos, tipos);
	}
	
	public int verificarBodega(String id) {
		
		Object[] argumentos = {id};
		
		int[] tipos = {Types.VARCHAR};
		
		String sql = "select count(*) from t_bodega where tps_bodega_codigo = ?";
		
		return jdbcReferencia.queryForInt(sql, argumentos, tipos);
	}
	
	public List<Map<String, Object>> consultarFabricantes() {
		
		String sql = "select tps_fabricante_codigo codigo, ts_fabricante_nombre nombre, ts_fabricante_usuacrea usuaCrea," +
					 " td_fabricante_fechacrea fechCrea from t_fabricante";
		
		return jdbcReferencia.queryForList(sql);
	}
	
	@Transactional(rollbackFor=Exception.class)
	public void insertarFabricante(String codigo, String nombre, String usuaCrea, Date fechaCrea) throws Exception {
		
		Object[] argumentos = {codigo, nombre, usuaCrea, fechaCrea};
		
		int[] tipos = {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.TIMESTAMP};
		
		String sql = prop.obtenerSQL("referencias.fabricante.insertar");
		
		try {
			jdbcReferencia.update(sql, argumentos, tipos);
		}
		catch(DataAccessException dae) {
			throw new Exception(dae.getCause());
		}
	}
	
	public List<Map<String, Object>> consultarCategorias() {
		
		String sql = "select tps_categoria_codigo codigo, ts_categoria_nombre nombre, ts_categoria_usuacrea usuaCrea," +
					 " td_categoria_fechacrea fechCrea from t_categoria";
		
		return jdbcReferencia.queryForList(sql);
	}
	
	@Transactional(rollbackFor=Exception.class)
	public void insertarCategoria(String codigo, String nombre, String usuaCrea, Date fechaCrea) throws Exception {
		
		Object[] argumentos = {codigo, nombre, usuaCrea, fechaCrea};
		
		int[] tipos = {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.TIMESTAMP};
		
		String sql = prop.obtenerSQL("referencias.categoria.insertar");
		
		try {
			jdbcReferencia.update(sql, argumentos, tipos);
		}
		catch(DataAccessException dae) {
			throw new Exception(dae.getCause());
		}
	}
	
	public List<Map<String, Object>> consultarBodegas() {
		
		String sql = "select tps_bodega_codigo codigo, ts_bodega_nombre nombre, ts_bodega_usuacrea usuaCrea,  " +
					 " td_bodega_fechcrea fechCrea from t_bodega";
		
		return jdbcReferencia.queryForList(sql);
	}
	
	@Transactional(rollbackFor=Exception.class)
	public void insertarBodega(String codigo, String nombre, String usuaCrea, Date fechaCrea) throws Exception {
		
		if(verificarBodega(codigo) > 0) {
			throw new Exception("Código de bodega ya existe");
		}
		
		Object[] argumentos = {codigo, nombre, usuaCrea, fechaCrea};
		
		int[] tipos = {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.TIMESTAMP};
		
		String sql = prop.obtenerSQL("referencias.bodega.insertar");
		
		try {
			jdbcReferencia.update(sql, argumentos, tipos);
		}
		catch(DataAccessException dae) {
			throw new Exception(dae.getCause());
		}
	}
	
	public List<Map<String, Object>> consultarInventarioBodega(String codigo) {
		
		Object[] argumentos = {codigo};
		
		int[] tipos = {Types.VARCHAR};
		
		String sql = "select tpfs_invebode_referencia referencia, ts_referencia_descripcion descripcion, ti_invebode_cantidad cantidad " +
				 	 "from t_inventario_bodega, t_referencia " +
				 	 "where tpfs_invebode_referencia = tps_referencia_codigo " +
				 	 "and tpfs_invebode_bodega = ? " +
				 	 "and tpfs_invebode_anomes = DATE_FORMAT(NOW() ,'%Y-%m-01')";
		
		return jdbcReferencia.queryForList(sql, argumentos, tipos);
	}
	
	public List<Map<String, Object>> consultarInventarioReferencia(Referencia referencia) {
		
		Object[] argumentos = {referencia.getCodigo()};
		
		int[] tipos = {Types.VARCHAR};
		
		/*String sql = "select CONCAT(tps_bodega_codigo, CONCAT(' - ', ts_bodega_nombre)) bodega,  CONCAT(tpfs_invebode_referencia, CONCAT(' - ', ts_referencia_descripcion)) refe, ti_invebode_cantidad cantidad " +
				 	 "from t_inventario_bodega, t_referencia, t_bodega " +
				 	 "where tpfs_invebode_referencia = tps_referencia_codigo " +
				 	 "and tpfs_invebode_bodega = tps_bodega_codigo " +
				 	 "and tpfs_invebode_referencia = ? " +
				 	 "and tpfs_invebode_anomes = DATE_FORMAT(NOW() ,'%Y-%m-01')";*/
		String sql = "SELECT CONCAT(tps_bodega_codigo, CONCAT(' - ', ts_bodega_nombre)) bodega, CONCAT(tpfs_invebode_referencia, CONCAT(' - ', ts_referencia_descripcion)) refe, ti_invebode_cantidad cantidad "
					+ "FROM t_inventario_bodega, t_referencia, t_bodega  "
					+ "WHERE tpfs_invebode_referencia = tps_referencia_codigo "
					+ "AND tpfs_invebode_referencia = ?"
					+ "AND tpfs_invebode_bodega = tps_bodega_codigo";
		
		return jdbcReferencia.queryForList(sql, argumentos, tipos);
	}
	
	public int consultarConsecutivo(String tabla) {
		
		Object[] argumentos = {tabla};
		
		int[] tipos = {Types.VARCHAR};
		
		String sql = prop.obtenerSQL("referencias.consecutivo.consultar");
		
		return jdbcReferencia.queryForInt(sql, argumentos, tipos);
	}
	
	@Transactional(rollbackFor=Exception.class)
	public void actualizarConsecutivo(String tabla, int cantidad) {
		
		Object[] argumentos = {cantidad, tabla};
		
		int[] tipos = {Types.INTEGER, Types.VARCHAR};
		
		String sql = prop.obtenerSQL("referencias.consecutivo.actualizar");
		
		jdbcReferencia.update(sql, argumentos, tipos);
	}
	
	@Transactional(rollbackFor=SQLException.class)
	public void insertarAjuste(String bodega, String referencia, int cantidad, String usuario) throws SQLException {
		
		//Establecemos el ajuste 
		int codigo = consultarConsecutivo("AJUSTEINVENTARIO");
		
		Object[] argumentos = {cantidad, bodega, referencia};

		int[] tipos = {Types.INTEGER, Types.VARCHAR, Types.VARCHAR};
		
		String sql = prop.obtenerSQL("referencias.bodega.ajuste");

		try {
			jdbcReferencia.update(sql, argumentos, tipos);
		}
		catch(DataAccessException dae) {
			throw new SQLException(dae.getMessage());
		}
		
		//Insertamos el movimiento
		Object[] argumentos2 = {referencia, cantidad, "AJUSTEINVENTARIO" + codigo, "AJUSTEINVENTARIO", usuario};
		
		int[] tipos2 = {Types.VARCHAR, Types.INTEGER, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
		
		sql = prop.obtenerSQL("referencias.movimiento.insertar");
		
		try {
			jdbcReferencia.update(sql, argumentos2, tipos2);
		}
		catch(DataAccessException dae) {
			throw new SQLException(dae.getMessage() + "1");
		}
		
		//Actualizamos la referencia
		Object[] argumentos3 = {cantidad, referencia};
		
		int[] tipos3 = {Types.INTEGER, Types.VARCHAR}; 
		
		String sql3 = prop.obtenerSQL("referencias.actualizarCantReferencia");
		
		try {
			jdbcReferencia.update(sql3, argumentos3, tipos3);
		}
		catch(DataAccessException dae) {
			throw new SQLException(dae.getMessage() + "1");
		}
		
		actualizarConsecutivo("AJUSTEINVENTARIO", 1);
	}
	
	@Transactional(rollbackFor=SQLException.class)
	public void insertarAjustesBatch(final List<String> codigos, final List<Integer> cantidades, final List<String> bodegas, 
									 final String usuario) throws SQLException {
		
		String sql = prop.obtenerSQL("referencias.bodega.ajuste");
		
		try {
			jdbcReferencia.batchUpdate(sql, new BatchPreparedStatementSetter() {
				
				public int getBatchSize() {
					return codigos.size();
				}
	
				@Override
				public void setValues(PreparedStatement ps, int i) throws SQLException {
					ps.setInt(1, cantidades.get(i));
					ps.setString(2, bodegas.get(i));
					ps.setString(3, codigos.get(i));
				}	
			});
		}
		catch(DataAccessException e) {
			throw new SQLException(e);
		}
		
		final int ajuste = consultarConsecutivo("AJUSTEINVENTARIO");
		String sql2 = prop.obtenerSQL("referencias.movimiento.insertar");
		
		try {
			jdbcReferencia.batchUpdate(sql2, new BatchPreparedStatementSetter() {
				
				public int getBatchSize() {
					return codigos.size();
				}
	
				@Override
				public void setValues(PreparedStatement ps, int i) throws SQLException {
					ps.setString(1, codigos.get(i));
					ps.setInt(2, cantidades.get(i));
					ps.setString(3, "AJUSTEINVENTARIO" + Integer.toString(i+ajuste));
					ps.setString(4, "AJUSTEINVENTARIO");
					ps.setString(5, usuario);
				}	
			});
		}
		catch(DataAccessException e) {
			throw new SQLException(e);
		}
		
		actualizarConsecutivo("AJUSTEINVENTARIO", codigos.size());
	}
	
	@Transactional(rollbackFor=DataAccessException.class)
	public void actualizarReferencia(Referencia referencia) throws ExcepcionSQL, Exception {
				

			//Insertar en tabla de proveedores
			Object[] argumentos = {referencia.getDescripcion(), referencia.getComponente(), referencia.getPresentacion(),
									referencia.getFabricante(), referencia.getCategoria(), referencia.getObservacion(), 
									referencia.getCant_mini(), referencia.getUsuaModi(), referencia.getFechaModi(), referencia.getCodigo()};
			
			int[] tipos = {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,
							Types.VARCHAR,Types.VARCHAR,Types.INTEGER, Types.VARCHAR, Types.TIMESTAMP, Types.VARCHAR};
			
			String sql =  prop.obtenerSQL("referencias.actualizar");
			
			try {
				jdbcReferencia.update(sql, argumentos, tipos);
			}
			catch(DataAccessException e) {
				throw new ExcepcionSQL(e.getCause());
			}
		
	}
	
	@Transactional(rollbackFor=DataAccessException.class)
	public void eliminarReferencia(Referencia referencia) throws ExcepcionSQL, Exception {
		//Establecemos el ajuste 
		int codigo = consultarConsecutivo("AJUSTEINVENTARIO");
		//Insertamos el movimiento
		Object[] argumentos2 = {referencia.getCodigo(), -referencia.getCantidad(), "AJUSTEINVENTARIO" + codigo, "AJUSTEINVENTARIO", referencia.getUsuaModi()};
		
		int[] tipos2 = {Types.VARCHAR, Types.INTEGER, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
		
			String sql2 = prop.obtenerSQL("referencias.movimiento.insertar");
		
		try {
			jdbcReferencia.update(sql2, argumentos2, tipos2);
		}
		catch(DataAccessException dae) {
			throw new SQLException(dae.getMessage() + "1");
		}
		
		actualizarConsecutivo("AJUSTEINVENTARIO", 1);
			//Insertar en tabla de proveedores
			Object[] argumentos = { referencia.getCodigo()};
			
			int[] tipos = {Types.VARCHAR};
			
			String sql =  prop.obtenerSQL("referencias.eliminar");
			
			try {
				jdbcReferencia.update(sql, argumentos, tipos);
			}
			catch(DataAccessException e) {
				throw new ExcepcionSQL(e.getCause());
			}

	}
	
	public List<Referencia> encontrarReferencia(Referencia referencia) {
		
		Object[] argumentos = {referencia.getCodigo()};
		
		int[] tipos = {Types.VARCHAR};
		
		String sql = prop.obtenerSQL("referencias.encontrar");
		
		return jdbcReferencia.query(sql, argumentos, tipos, new ReferenciaMapper());
	}
		

	public List<Map<String, Object>> consultarMovimientos() {
	
		String sql = prop.obtenerSQL("referencias.movimientosConsultar");
	
	return jdbcReferencia.queryForList(sql);
	}
	
	
}
