package com.control.usuario;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class UsuarioMapper implements RowMapper<Usuario> {

	@Override
	public Usuario mapRow(ResultSet rs, int rownum) throws SQLException {
		Usuario u = new Usuario();
		
		u.setCodigo(rs.getString("codigo"));
		u.setContrasena(rs.getString("contrasena"));
		u.setCambcontra(rs.getString("cambcontra"));
		u.setUltcambcontra(rs.getTimestamp("ultcamcon"));
		u.setVigencia(rs.getString("vigencia"));
		u.setCedula(rs.getString("cedula"));
		u.setNombre(rs.getString("nombre"));
		u.setArea(rs.getString("area"));
		u.setCargo(rs.getString("cargo"));
		u.setUsuacrea(rs.getString("usuacrea"));
		u.setFechacrea(rs.getTimestamp("fechacrea"));
		u.setUsuamodi(rs.getString("usuamodi"));
		u.setFechamodi(rs.getTimestamp("fechamodi"));
		
		return u;
	}

}
