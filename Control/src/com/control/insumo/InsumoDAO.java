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

import com.control.general.ExcepcionSQL;
import com.control.general.Propiedades;
import com.control.referencia.ReferenciaDAO;

public class InsumoDAO {

	private JdbcTemplate jdbcInsumo;
	private Propiedades prop;
	
	public InsumoDAO() throws IOException {
		prop = new Propiedades("insumos.properties");
		jdbcInsumo = null;
	}
	
	@Autowired
	private ReferenciaDAO r;
	
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
		
		String sql = "select tps_referencia_codigo codigo, ts_referencia_descripcion descripcion, ts_referencia_presentacion presentacion," +
					 " t_referencia_cantidad cantidad, ti_referencia_cantmini cantmini, td_referencia_fechacrea fechacrea from t_referencia";
					 
		
		return jdbcInsumo.queryForList(sql);
	}

	public List<Map<String, Object>> consultarReferenciasTerminadas() {
		
		String sql = "select tps_referencia_codigo codigo, ts_referencia_presentacion presentacion," +
					 " t_referencia_cantidad cantidad, ti_referencia_cantmini cantmini, td_referencia_fechacrea fechacrea FROM t_referencia "
					 + "WHERE ti_referencia_cantmini >= t_referencia_cantidad limit 10";
					 
		
		return jdbcInsumo.queryForList(sql);
	}
	
	public List<Map<String, Object>> consultarBodegas() {
		
		String sql = "select tps_bodega_codigo codigo, ts_bodega_nombre nombre from t_bodega";
					 
		
		return jdbcInsumo.queryForList(sql);
	}

	public List<Map<String, Object>> consultarSubBodegas() {
		
		String sql = "select t_subbodega_codigo codigo, t_subbodega_nombre nombre from t_subbodega";
					 
		
		return jdbcInsumo.queryForList(sql);
	}
	
	public List<Insumo> listarInsumos(Insumo insumo) {
		
		Object[] argumentos = {insumo.getCodcaja()+"%", insumo.getCodref()+"%", 
							   insumo.getProveedor()+"%", insumo.getBodega(), insumo.getBodega()};
		
		int[] tipos = {Types.VARCHAR, Types.VARCHAR,
					   Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
		
		String sql = prop.obtenerSQL("insumos.listar");
		
		return jdbcInsumo.query(sql, argumentos, tipos, new InsumoMapper());
	}
	
	public List<Insumo> consultarInsumo(Insumo insumo) {
		
		Object[] argumentos = {insumo.getCodcaja()};
		
		int[] tipos = {Types.VARCHAR};
		
		String sql = prop.obtenerSQL("insumos.encontrarinsumo");
		
		return jdbcInsumo.query(sql, argumentos, tipos, new InsumoMapper());
	}
	
	public List<Map<String, Object>> consultarInsumosVencidos() {
		
		String sql = "SELECT ts_insumo_codcaja codcaja, ts_insumo_codref codigo, ts_insumo_bodega bodega, ti_insumo_cantinsumo cantidad,td_insumo_fechavenc fecha " +
					 "FROM t_insumo WHERE (td_insumo_fechavenc <= DATE_ADD(CURDATE(), INTERVAL 30 DAY)) ORDER BY td_insumo_fechavenc ASC";
					 
		
		return jdbcInsumo.queryForList(sql);
	}

	public List<Map<String, Object>> consultarCajas() {
		
		String sql = "SELECT ts_insumo_codcaja codcaja, ts_insumo_codref codigo, ts_insumo_bodega bodega " +
					 "FROM t_insumo";
					 
		
		return jdbcInsumo.queryForList(sql);
	}
	
	@Transactional(rollbackFor=Exception.class)
	public void insertarInsumo(Insumo insumo) throws Exception {
		
		if(verificarInsumo(insumo.getCodcaja()) > 0 ) {
			throw new Exception("Código de caja ya existe");
		}
		
		//Valores por defecto
		insumo.setFechaCrea(new Date());
		
		//Insertar en tabla de insumos
		Object[] argumentos = { insumo.getCodcaja(), insumo.getCodref(), insumo.getProveedor(), insumo.getFabricante(), insumo.getBodega(), 
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
			Object[] argumentos2 = { insumo.getCantInsumos(), insumo.getCodref()};
			
			int[] tipo2 = {Types.INTEGER, Types.VARCHAR };
					
			String sql2 = prop.obtenerSQL("insumos.actualizarReferencia");
			
			try {
				jdbcInsumo.update(sql2, argumentos2, tipo2);
			}
			catch(DataAccessException dae) {
				throw new Exception(dae.getCause());
			}
			
			//Insertar cantidad de insumos en bodega
			Object[] argumentos3 = {  insumo.getCantInsumos(), insumo.getUsuaCrea(), insumo.getFechaCrea(),  
										insumo.getBodega(), insumo.getCodref(),};
			
			if(r.consultarReferenciaEnBodega(insumo.getBodega(), insumo.getCodref())==0){
				//Insertar referencia en bodega
				Object[] argumentos4 = {insumo.getBodega(), insumo.getCodref(), 
										insumo.getUsuaCrea(), insumo.getFechaCrea()};
				
				int[] tipo4 = {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.TIMESTAMP};
						
				String sql4 = prop.obtenerSQL("insumos.insertar.en.bodega");
				
				try {
					jdbcInsumo.update(sql4, argumentos4, tipo4);
				}
				catch(DataAccessException dae) {
					throw new Exception(dae.getCause());
				}
			}

			int[] tipo3 = { Types.INTEGER, Types.VARCHAR, Types.TIMESTAMP, Types.VARCHAR, Types.VARCHAR  };
			
			String sql3 = prop.obtenerSQL("insumos.actualizarBodegaInsumo");
			
			try {
				jdbcInsumo.update(sql3, argumentos3, tipo3);
			}
			catch(DataAccessException dae) {
				throw new Exception(dae.getCause());
			}
			
			

			int codigo = r.consultarConsecutivo("AJUSTEINVENTARIO");
			//Insertamos el movimiento
			Object[] argumentos4 = {insumo.getCodref(), insumo.getCantInsumos(), "Agregado a " + insumo.getBodega(), "AJUSTEINVENTARIO" + codigo, "AJUSTEINVENTARIO", insumo.getUsuaCrea()};
			
			int[] tipos4 = {Types.VARCHAR, Types.INTEGER, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
			
			String sql4 = prop.obtenerSQL("insumos.movimiento.insertar");
			
			try {
				jdbcInsumo.update(sql4, argumentos4, tipos4);
			}
			catch(DataAccessException dae) {
				throw new SQLException(dae.getMessage() + "1");
			}
			r.actualizarConsecutivo("AJUSTEINVENTARIO", 1);
		
	}
	
	public int verificarInsumo(String codigo) {
		
		Object[] argumentos = {codigo};
		
		int[] tipos = {Types.VARCHAR};
		
		String sql = "select count(*) from t_insumo where ts_insumo_codcaja = ?";
		
		return jdbcInsumo.queryForInt(sql, argumentos, tipos);
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
			
			String sql2 = prop.obtenerSQL("insumos.actualizarBodegaInsumo");
			
	
			
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
	
	@Transactional(rollbackFor=DataAccessException.class)
	public void actualizarInsumoAjuste(String codref, String bodega, Integer cantidad) throws ExcepcionSQL, Exception{
		
		Insumo insumo = new Insumo();
		insumo.setCodref(codref);
		insumo.setBodega(bodega);
		insumo.setProveedor("");
		insumo.setCodcaja("");
		
		List<Insumo> l = listarInsumos(insumo);
		
		Integer centinela=cantidad;
		Integer contador=0;
		
		while((centinela<0) &&(contador<=l.size())&&(!l.isEmpty())){
			
			centinela= centinela + l.get(contador).getCantInsumos();
			if(centinela<=0){
				Object[] argumentos = {l.get(contador).getCodcaja(), insumo.getBodega() };
				
				int[] tipos = {Types.VARCHAR, Types.VARCHAR};
				
				String sql =  prop.obtenerSQL("insumos.eliminar");
				
				try {
					jdbcInsumo.update(sql, argumentos, tipos);
					contador++;
				}
				catch(DataAccessException e) {
					throw new ExcepcionSQL(e.getCause());
				}
			}
			else{
				l.get(contador).setCantInsumos(centinela);
				Object[] argumentos = {l.get(contador).getBodega(), l.get(contador).getCantInsumos(), l.get(contador).getPrecioVent(), 
						l.get(contador).getUsuaModi(), l.get(contador).getFechaModi(), l.get(contador).getCodcaja(), l.get(contador).getCodref() };
				
				int[] tipos = {Types.VARCHAR, Types.INTEGER, Types.VARCHAR,
								Types.VARCHAR, Types.TIMESTAMP, Types.VARCHAR, Types.VARCHAR};
				
				String sql =  prop.obtenerSQL("insumos.actualizar");
				
				try {
					jdbcInsumo.update(sql, argumentos, tipos);
					contador++;
				}
				catch(DataAccessException e) {
					throw new ExcepcionSQL(e.getCause());
				}
			}
		}
	}
	
	@Transactional(rollbackFor=DataAccessException.class)
	public void actualizarInsumo(Insumo insumo, String motivo) throws ExcepcionSQL, Exception {	

			List<Insumo> l = consultarInsumo(insumo);
			
			//Actualizar tabla t_insumo
			Object[] argumentos = {insumo.getBodega(), insumo.getCantInsumos(), insumo.getPrecioVent(), 
									insumo.getUsuaModi(), insumo.getFechaModi(), insumo.getCodcaja(), insumo.getCodref() };
			
			int[] tipos = {Types.VARCHAR, Types.INTEGER, Types.VARCHAR,
							Types.VARCHAR, Types.TIMESTAMP, Types.VARCHAR, Types.VARCHAR};
			
			String sql =  prop.obtenerSQL("insumos.actualizar");
			
			try {
				jdbcInsumo.update(sql, argumentos, tipos);
			}
			catch(DataAccessException e) {
				throw new ExcepcionSQL(e.getCause());
			}
			
				//Insertar cantidad de insumos en referencia
				Object[] argumentos2 = { insumo.getCantInsumos() - l.get(0).getCantInsumos(), insumo.getCodref()};
				
				int[] tipo2 = {Types.INTEGER, Types.VARCHAR };
						
				String sql2 = prop.obtenerSQL("insumos.actualizarReferencia");
				
				try {
					jdbcInsumo.update(sql2, argumentos2, tipo2);
				}
				catch(DataAccessException dae) {
					throw new Exception(dae.getCause());
				}
			//}
			if(!l.get(0).getBodega().equals(insumo.getBodega())){
			
				//Insertar cantidad de insumos en bodega
				Object[] argumentos3 = {  -l.get(0).getCantInsumos(), insumo.getUsuaModi(), insumo.getFechaModi(),  
											l.get(0).getBodega(), insumo.getCodref(),};
				
				int[] tipo3 = { Types.INTEGER, Types.VARCHAR, Types.TIMESTAMP, Types.VARCHAR, Types.VARCHAR  };
						
				String sql3 = prop.obtenerSQL("insumos.actualizarBodega");
				
				try {
					jdbcInsumo.update(sql3, argumentos3, tipo3);
				}
				catch(DataAccessException dae) {
					throw new Exception(dae.getCause());
				}
				
				Object[] argumentos4 = {  insumo.getCantInsumos(), insumo.getUsuaModi(), insumo.getFechaModi(),  
						insumo.getBodega(), insumo.getCodref()};

				int[] tipo4 = { Types.INTEGER, Types.VARCHAR, Types.TIMESTAMP, Types.VARCHAR, Types.VARCHAR  };
					
				String sql4 = prop.obtenerSQL("insumos.actualizarBodega");
				
				try {
					jdbcInsumo.update(sql4, argumentos4, tipo4);
				}
				catch(DataAccessException dae) {
					throw new Exception(dae.getCause());
				}
				
			}
			else{
				//Insertar cantidad de insumos en bodega
				Object[] argumentos3 = {  insumo.getCantInsumos() - l.get(0).getCantInsumos(), insumo.getUsuaModi(), insumo.getFechaModi(),  
											insumo.getBodega(), insumo.getCodref()};
				
				int[] tipo3 = { Types.INTEGER, Types.VARCHAR, Types.TIMESTAMP, Types.VARCHAR, Types.VARCHAR  };
						
				String sql3 = prop.obtenerSQL("insumos.actualizarBodega");
				
				try {
					jdbcInsumo.update(sql3, argumentos3, tipo3);
				}
				catch(DataAccessException dae) {
					throw new Exception(dae.getCause());
				}
			}
			if(insumo.getCantInsumos() <= 0){
				Object[] argumentos5 = { insumo.getCodcaja(), insumo.getBodega() };
				
				int[] tipos5 = {Types.VARCHAR, Types.VARCHAR };
				
				String sql5 =  prop.obtenerSQL("insumos.eliminar");
				
				try {
					jdbcInsumo.update(sql5, argumentos5, tipos5);
				}
				catch(DataAccessException e) {
					throw new ExcepcionSQL(e.getCause());
				}
		
			}
			if((!motivo.equals("OTROS")) &&(!motivo.equals("Eliminado"))){
				if(consultarSubBodegasCreadas(motivo, insumo.getCodref())==0){
					Object[] argumentos5 = {motivo, insumo.getCodref(), insumo.getUsuaModi(), new Date()};
					
					int[] tipos5 = {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.DATE};
					
					String sql5 = prop.obtenerSQL("insumos.insertar.en.subbodega");
					
					try {
						jdbcInsumo.update(sql5, argumentos5, tipos5);
					}
					catch(DataAccessException dae) {
						throw new SQLException(dae.getMessage() + "1");
					}
				}
				Object[] argumentos5 = {motivo, insumo.getCodref(), l.get(0).getCantInsumos() - insumo.getCantInsumos(), insumo.getUsuaModi(), new Date(), motivo, insumo.getCodref(),};
				
				int[] tipos5 = {Types.VARCHAR, Types.VARCHAR, Types.INTEGER, Types.VARCHAR, Types.DATE, Types.VARCHAR, Types.VARCHAR};
				
				String sql5 = prop.obtenerSQL("insumos.actualizar.subbodega");
				
				try {
					jdbcInsumo.update(sql5, argumentos5, tipos5);
				}
				catch(DataAccessException dae) {
					throw new SQLException(dae.getMessage() + "1");
				}
			}
			//definir leyenda en la tabla movimientos
			if(!motivo.equals("Eliminado")){
				if(((insumo.getCantInsumos() - l.get(0).getCantInsumos()) < 0)){
	
					motivo = "Retirado de "+l.get(0).getBodega()+" hasta "+motivo;
				}
				else{
					motivo = "Agregado a "+l.get(0).getBodega();
				}
			}
			else{
				motivo = "Eliminado de "+l.get(0).getBodega();
			}
			
			int codigo = r.consultarConsecutivo("AJUSTEINVENTARIO");
			//Insertamos el movimiento
			Object[] argumentos4 = {insumo.getCodref(), insumo.getCantInsumos() - l.get(0).getCantInsumos(), motivo, "AJUSTEINVENTARIO" + codigo, "AJUSTEINVENTARIO", insumo.getUsuaModi()};
			
			int[] tipos4 = {Types.VARCHAR, Types.INTEGER, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR};
			
			String sql4 = prop.obtenerSQL("insumos.movimiento.insertar");
			
			try {
				jdbcInsumo.update(sql4, argumentos4, tipos4);
			}
			catch(DataAccessException dae) {
				throw new SQLException(dae.getMessage() + "1");
			}
			r.actualizarConsecutivo("AJUSTEINVENTARIO", 1);
	}
	
	public int consultarSubBodegasCreadas(String codigoSubBod, String codigoRef){
		
		Object[] argumentos = {codigoSubBod, codigoRef};
		
		int[] tipos = {Types.VARCHAR, Types.VARCHAR};
		
		String sql = "select count(*) from t_inventario_subbodega where t_subbodega_codigo = ? AND t_referencia_codigo = ?";
		
		return jdbcInsumo.queryForInt(sql, argumentos, tipos);
	}
}
