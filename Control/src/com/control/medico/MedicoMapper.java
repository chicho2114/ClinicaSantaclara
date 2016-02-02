package com.control.medico;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;


public class MedicoMapper implements RowMapper<Medico>  {

	@Override
	public Medico mapRow(ResultSet rs, int rownum) throws SQLException {
		
		Medico m = new Medico();
		
		m.setCedula(rs.getString("cedula"));
		m.setNacionalidad(rs.getString("nacionalidad"));
		m.setNombre(rs.getString("nombre"));
		m.setTelefono(rs.getString("telefono"));
		m.setServicio(rs.getString("servicio"));
		m.setFechacrea(rs.getTimestamp("fechacrea"));
		m.setUsuaCrea(rs.getString("usuacrea"));
		m.setFechamodi(rs.getTimestamp("fechamodi"));
		m.setUsuaModi(rs.getString("usuaModi"));
		
		return m;
	}

}
