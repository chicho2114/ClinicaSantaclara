package com.control.proveedor;

import java.io.Serializable;
import java.util.Date;

public class Proveedor implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4422067293654999983L;
	
	private String codigo;
	private String nombre;
	private String telefono;
	private Date fechacrea;
	private String usuaCrea;
	private String usuaModi;
	private Date fechamodi;

	public Proveedor() {
		codigo = null;
		nombre = null;
		telefono = null;
		fechacrea = null;
		usuaCrea = null;
		usuaModi = null;
	}
	
	public Proveedor(String codigo, String nombre, String telefono, Date fechacrea, String usuaCrea, String usuaModi) {
	
	this.codigo = codigo;
	this.nombre = nombre;
	this.telefono = telefono;
	this.fechacrea = fechacrea;
	this.usuaCrea = usuaCrea;
	this.usuaModi = usuaModi;
	
}

	public String getCodigo() {
		return codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public Date getFechacrea() {
		return fechacrea;
	}

	public void setFechacrea(Date fechacrea) {
		this.fechacrea = fechacrea;
	}

	public String getUsuaCrea() {
		return usuaCrea;
	}

	public void setUsuaCrea(String usuaCrea) {
		this.usuaCrea = usuaCrea;
	}

	public String getUsuaModi() {
		return usuaModi;
	}

	public void setUsuaModi(String usuaModi) {
		this.usuaModi = usuaModi;
	}

	public Date getFechamodi() {
		return fechamodi;
	}

	public void setFechamodi(Date fechamodi) {
		this.fechamodi = fechamodi;
	}
}
