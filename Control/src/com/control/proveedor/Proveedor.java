package com.control.proveedor;

import java.io.Serializable;
import java.util.Date;

public class Proveedor implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4422067293654999983L;
	
	private String id;
	private String nombre;
	private String telefono;
	private Date fechacrea;
	
	public Proveedor() {
		id = null;
		nombre = null;
		telefono = null;
		fechacrea = null;
	}
	
	public Proveedor(String id, String nombre, String telefono, Date fechacrea) {
	
	this.id = id;
	this.nombre = nombre;
	this.telefono = telefono;
	this.fechacrea = fechacrea;
}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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

		
		



}
