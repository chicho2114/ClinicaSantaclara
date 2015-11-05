package com.control.general;

import java.sql.SQLException;

/*
 * Clase que muestra errores
 */
public class ExcepcionSQL extends Exception {

	private static final long serialVersionUID = 1580462443131832910L;
	
	private int codigo;
	private String sqlState;
	private String mensaje;
	
	/*
	 * Constructor
	 */
	public ExcepcionSQL(Throwable cause) {
		super(cause.getMessage());
		SQLException sqle = (SQLException) cause;
		this.codigo = sqle.getErrorCode();
		this.sqlState = sqle.getSQLState();
		this.mensaje = sqle.getMessage();
	}

	/*
	 * Getters
	 */
	public int getCodigo() {
		return codigo;
	}
	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}
	public String getSqlState() {
		return sqlState;
	}
	public void setSqlState(String sqlState) {
		this.sqlState = sqlState;
	}
	public String getMensaje() {
		return mensaje;
	}
	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}
	public String getRazon(){
		return "<strong>Razón:</strong> " + codigo + ". <strong>Estado</strong>: " + sqlState;
	}
}
