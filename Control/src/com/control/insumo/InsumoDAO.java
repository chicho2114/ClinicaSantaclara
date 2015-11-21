package com.control.insumo;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;

import com.control.general.Propiedades;

public class InsumoDAO {

	private JdbcTemplate jdbcInsumo;
	private Propiedades prop;
	
	public InsumoDAO() throws IOException {
		prop = new Propiedades("insumos.properties");
		jdbcInsumo = null;
	}
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		this.jdbcInsumo = new JdbcTemplate(dataSource);
	}
	
	public List<Map<String, Object>> agregadosRecientemente() {
		
		String sql = "SELECT ts_insumo_codcaja codcaja, ts_insumo_codref codref, ts_insumo_bodega bodega, "
				+ "ti_insumo_cantinsumo cantidad, ts_insumo_usuacrea usuario, td_insumo_fechacrea fecha FROM t_insumo ORDER BY td_insumo_fechacrea DESC limit 10";
		
		return jdbcInsumo.queryForList(sql);
	}
	
	
	public List<Map<String, Object>> consultarFabricantes() {
		
		String sql = "select tps_fabricante_codigo codigo, ts_fabricante_nombre nombre, ts_fabricante_usuacrea usuaCrea," +
					 " td_fabricante_fechacrea fechCrea from t_fabricante";
		
		return jdbcInsumo.queryForList(sql);
	}
	
	public List<Map<String, Object>> consultarProveedores() {
		
		String sql = "select ts_proveedor_codigo codigo, ts_proveedor_nombre nombre, ts_proveedor_usuacrea usuacrea," +
					 " td_proveedor_fechacrea fechacrea from t_proveedor";
					 

		
		return jdbcInsumo.queryForList(sql);
	}
	
	public List<Map<String, Object>> consultarReferencias() {
		
		String sql = "select tps_referencia_codigo codigo, ts_referencia_presentacion presentacion," +
					 " t_referencia_cantidad cantidad, ti_referencia_cantmini cantmini, td_referencia_fechacrea fechacrea from t_referencia";
					 
		
		return jdbcInsumo.queryForList(sql);
	}

	public List<Map<String, Object>> consultarReferenciasTerminadas() {
		
		String sql = "select tps_referencia_codigo codigo, ts_referencia_presentacion presentacion," +
					 " t_referencia_cantidad cantidad, ti_referencia_cantmini cantmini, td_referencia_fechacrea fechacrea FROM t_referencia "
					 + "WHERE ti_referencia_cantmini >= t_referencia_cantidad";
					 
		
		return jdbcInsumo.queryForList(sql);
	}
	
	public List<Map<String, Object>> consultarBodegas() {
		
		String sql = "select tps_bodega_codigo codigo, ts_bodega_nombre nombre from t_bodega";
					 
		
		return jdbcInsumo.queryForList(sql);
	}
	
	public List<Map<String, Object>> consultarInsumosVencidos() {
		
		String sql = "SELECT ts_insumo_codref codigo, ts_insumo_bodega bodega, ti_insumo_cantinsumo cantidad,td_insumo_fechavenc fecha " +
					 "FROM t_insumo WHERE (td_insumo_fechavenc <= DATE_ADD(CURDATE(), INTERVAL 30 DAY))";
					 
		
		return jdbcInsumo.queryForList(sql);
	}
	
	@Transactional(rollbackFor=Exception.class)
	public void insertarInsumo(Insumo insumo) throws Exception {
		
		//Valores por defecto
		insumo.setFechaCrea(new Date());
		
		//Insertar en tabla de insumos
		Object[] argumentos = { insumo.getCodcaja(), insumo.getCodigoRef(), insumo.getProveedor(), insumo.getFabricante(), insumo.getBodega(), 
								insumo.getCantInsumos(), insumo.getPrecioComp(), insumo.getPrecioVent(), 
								insumo.getFechaComp(), insumo.getFechaVenc(),  insumo.getUsuaCrea(), 
								insumo.getFechaCrea(), insumo.getUsuaModi(), insumo.getFechaModi()};
		
		int[] tipo = {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,
					  Types.INTEGER, Types.VARCHAR, Types.VARCHAR,
					  Types.DATE, Types.DATE, Types.VARCHAR,
					  Types.TIMESTAMP, Types.VARCHAR, Types.TIMESTAMP};
		
		String sql = prop.obtenerSQL("insumos.insertar");
		
		try {
			jdbcInsumo.update(sql, argumentos, tipo);
		}
		catch(DataAccessException dae) {
			throw new Exception(dae.getCause());
		}
		
			//Insertar cantidad de insumos en referencia
			Object[] argumentos2 = { insumo.getCantInsumos(), insumo.getCodigoRef()};
			
			int[] tipo2 = {Types.INTEGER, Types.VARCHAR };
					
			String sql2 = prop.obtenerSQL("insumos.actualizarReferencia");
			
			try {
				jdbcInsumo.update(sql2, argumentos2, tipo2);
			}
			catch(DataAccessException dae) {
				throw new Exception(dae.getCause());
			}
			
			//Insertar cantidad de insumos en bodega
			Object[] argumentos3 = {  insumo.getCantInsumos(), insumo.getUsuaModi(), insumo.getFechaModi(),  
										insumo.getBodega(), insumo.getCodigoRef(),};
			
			int[] tipo3 = { Types.INTEGER, Types.VARCHAR, Types.TIMESTAMP, Types.VARCHAR, Types.VARCHAR  };
					
			String sql3 = prop.obtenerSQL("insumos.actualizarBodega");
			
			try {
				jdbcInsumo.update(sql3, argumentos3, tipo3);
			}
			catch(DataAccessException dae) {
				throw new Exception(dae.getCause());
			}
		
	}
	
	@Transactional(rollbackFor=SQLException.class)
	public void insertarInsumosBatch(final List<String> codigosCajas, final List<String> codigosRef, final List<String> proveedores, final List<String> fabricantes, 
										 final List<String> bodegas, final List<Integer> cantidad, final List<String> preciocompra, 
										 final List<String> precioventa, final List<String> fechacompra, final List<String> fechavenc, final String usuario) throws SQLException {
		
						
				
				
		final SimpleDateFormat fechatxt = new SimpleDateFormat("yyyy-MM-dd");	
		
		String sql = prop.obtenerSQL("insumos.insertar");
		
		final Date fechaCreacion = new Date();
		
		try {
			jdbcInsumo.batchUpdate(sql, new BatchPreparedStatementSetter() {
				
				public int getBatchSize() {
					return codigosRef.size();
				}
	
				@Override
				public void setValues(PreparedStatement ps, int i) throws SQLException {
					ps.setString(1, codigosCajas.get(i));
					ps.setString(2, codigosRef.get(i));
					ps.setString(3, proveedores.get(i));
					ps.setString(4, fabricantes.get(i));
					ps.setString(5, bodegas.get(i));
					ps.setInt(6, cantidad.get(i));				
					ps.setString(7, preciocompra.get(i));
					ps.setString(8, precioventa.get(i));
					try {
						ps.setDate(9, new java.sql.Date(fechatxt.parse(fechacompra.get(i)).getTime()));
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}					
					try {
						ps.setDate(10, new java.sql.Date(fechatxt.parse(fechavenc.get(i)).getTime()));
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					ps.setString(11, usuario);
					ps.setTimestamp(12, new Timestamp(fechaCreacion.getTime()));
					ps.setString(13, null);
					ps.setTimestamp(14, null);
				}	
			});
		}
		catch(DataAccessException e) {
			throw new SQLException(e);
		}
		
			//Insertar cantidad de insumos en bodega
			
			String sql2 = prop.obtenerSQL("insumos.actualizarBodega");
			
	
			
			try {
				jdbcInsumo.batchUpdate(sql2, new BatchPreparedStatementSetter() {
					
					public int getBatchSize() {
						return codigosRef.size();
					}
		
					@Override
					public void setValues(PreparedStatement ps, int i) throws SQLException {
						ps.setInt(1, cantidad.get(i));
						ps.setString(2, usuario);
						ps.setTimestamp(3, new Timestamp(fechaCreacion.getTime()));
						ps.setString(4, bodegas.get(i));
						ps.setString(5, codigosRef.get(i));
						
					}	
				});
			}
			catch(DataAccessException e) {
				throw new SQLException(e);
			}
			
			//Actualizar cantidad en referencia
			String sql3 = prop.obtenerSQL("insumos.actualizarReferencia");
			
			try {
				jdbcInsumo.batchUpdate(sql3, new BatchPreparedStatementSetter() {
					
					public int getBatchSize() {
						return codigosRef.size();
					}
		
					@Override
					public void setValues(PreparedStatement ps, int i) throws SQLException {
						ps.setInt(1, cantidad.get(i));
						ps.setString(2, codigosRef.get(i));
						
					}	
				});
			}
			catch(DataAccessException e) {
				throw new SQLException(e);
			}
		
	}
}
