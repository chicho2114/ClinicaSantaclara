package com.control.insumo;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;


public class InsumoMapper implements RowMapper<Insumo> {
	
	@Override
	public Insumo mapRow(ResultSet rs, int rownum) throws SQLException {
		Insumo i = new Insumo();
		
		i.setCodcaja(rs.getString("codcaja"));
		i.setCodigoRef(rs.getString("codigoRef"));
		i.setProveedor(rs.getString("proveedor"));
		i.setFabricante(rs.getString("fabricante"));
		i.setBodega(rs.getString("bodega"));
		i.setCantInsumos(rs.getInt("cantInsumos"));
		i.setPrecioComp(rs.getString("precioComp"));
		i.setPrecioVent(rs.getString("precioVent"));
		i.setFechaComp(rs.getDate("fechaComp"));
		i.setFechaVenc(rs.getDate("fechaVenc"));
		i.setUsuaCrea(rs.getString("usuaCrea"));
		i.setFechaCrea(rs.getTimestamp("fechaCrea"));
		i.setUsuaModi(rs.getString("usuaModi"));
		i.setFechaModi(rs.getTimestamp("fechaModi"));		
		
		return i;
	}

}
