package com.control.proveedor;


import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class ProveedorMapper implements RowMapper<Proveedor> {

	@Override
	public Proveedor mapRow(ResultSet rs, int rownum) throws SQLException {
		Proveedor p = new Proveedor();
		
		p.setId(rs.getString("id"));
		p.setNombre(rs.getString("nombre"));
		p.setTelefono(rs.getString("telefono"));
		p.setFechacrea(rs.getTimestamp("fechacrea"));
		
		return p;
	}
	
}
