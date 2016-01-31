package com.control.cliente;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;


public class ClienteMapper implements RowMapper<Cliente> {

	@Override
	public Cliente mapRow(ResultSet rs, int rownum) throws SQLException {
		
		Cliente c = new Cliente();
		
		c.setCedula(rs.getInt("cedula"));
		c.setNombre(rs.getString("nombre"));
		c.setNacionalidad(rs.getString("nacionalidad"));
		c.setDireccion(rs.getString("direccion"));
		c.setTelefono(rs.getString("telefono"));
		c.setFechacrea(rs.getTimestamp("fechacrea"));
		c.setUsuaCrea(rs.getString("usuacrea"));
		c.setFechamodi(rs.getTimestamp("fechamodi"));
		c.setUsuaModi(rs.getString("usuamodi"));
		
		return c;
	}

}
