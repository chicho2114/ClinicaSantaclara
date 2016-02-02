package com.control.medico;

import java.io.IOException;
import java.sql.Types;
import java.util.Date;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.transaction.annotation.Transactional;


import com.control.general.ExcepcionSQL;
import com.control.general.Propiedades;

public class MedicoDAO {

	private JdbcTemplate jdbcMedico;
	private Propiedades prop;
	
	public MedicoDAO() throws IOException {
		prop = new Propiedades("medicos.properties");
		jdbcMedico = null;
	}
	
	@Autowired
	public void setDataSource(DataSource dataSource) {
		this.jdbcMedico = new JdbcTemplate(dataSource);
	}
	
	/*//////////////////////////////////////////////////INICIO INSERTAR MEDICO////////////////////////////////////////*/
	@Transactional(rollbackFor=DataAccessException.class)
	public void insertarMedico(Medico medico) throws ExcepcionSQL, Exception {
		
		if(verificarMedico(medico.getCedula(), medico.getNacionalidad()) > 0) {
			throw new Exception("Este medico ya esta registrado en el sistema!");
		}
		
		//Valores por defecto
		medico.setFechacrea(new Date());
		
		
		//Insertar en tabla de clientes
		Object[] argumentos = {medico.getCedula(), medico.getNacionalidad(), medico.getNombre(), medico.getTelefono(), medico.getServicio(), medico.getFechacrea(), medico.getUsuaCrea()};
		
		int[] tipos = {Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR, Types.VARCHAR,
					   Types.TIMESTAMP, Types.VARCHAR};
		
		String sql =  prop.obtenerSQL("medicos.insertar");
		
		try {
			jdbcMedico.update(sql, argumentos, tipos);
		}
		catch(DataAccessException e) {
			throw new ExcepcionSQL(e.getCause());
		}	
		
		
	}
	/*//////////////////////////////////////////////////FINAL INSERTAR MEDICO////////////////////////////////////////*/
	/*////////////////////////////////////////////////////INICIO VERIFICAR MEDICO//////////////////////////////////////*/
	public int verificarMedico(String cedula, String nacionalidad) {
		
		Object[] argumentos = {cedula, nacionalidad};
		
		int[] tipos = {Types.VARCHAR, Types.VARCHAR};
		
		String sql = prop.obtenerSQL("medicos.verificarMedico");
		
		return jdbcMedico.queryForInt(sql, argumentos, tipos);
	}

	/*////////////////////////////////////////////////////FINAL VERIFICAR MEDICO//////////////////////////////////////*/
}
