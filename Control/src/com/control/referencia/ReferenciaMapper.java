package com.control.referencia;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class ReferenciaMapper implements RowMapper<Referencia> {

	@Override
	public Referencia mapRow(ResultSet rs, int rownum) throws SQLException {
		Referencia r = new Referencia();
	
		r.setCodigo(rs.getString("codigo"));
		r.setDescripcion(rs.getString("descripcion"));
		r.setComponente(rs.getString("componente"));
		r.setPresentacion(rs.getString("presentacion"));
		r.setFabricante(rs.getString("fabricante"));
		r.setCategoria(rs.getString("categoria"));
		r.setObservacion(rs.getString("observacion"));
		r.setUsuaCrea(rs.getString("usuacrea"));
		r.setFechaCrea(rs.getTimestamp("fechacrea"));
		r.setUsuaModi(rs.getString("usuamodi"));
		r.setFechaModi(rs.getTimestamp("fechamodi"));
		
		return r;
	}
}
