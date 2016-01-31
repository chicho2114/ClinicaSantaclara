package com.control.cliente;

import java.io.Serializable;
import java.util.Date;

public class Cliente implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3886326307345685037L;

	private String nombre;
	private String nacionalidad;
	private Integer cedula;
	private String direccion;
	private String telefono;
	private Date fechacrea;
	private String usuaCrea;
	private String usuaModi;
	private Date fechamodi;
	
	
	public Cliente(){

		nombre = null;
		nacionalidad = null;
		setCedula(null);
		direccion = null;
		telefono = null;
		fechacrea = null;
		usuaCrea = null;
		usuaModi = null;
		fechamodi = null;
	}
	
	public Cliente(String nombre, String nacionalidad, Integer cedula, String direccion, String telefono, Date fechacrea, String usuaCrea, Date fechamodi, String usuaModi){

		this.nombre = nombre;
		this.nacionalidad = nacionalidad;
		this.setCedula(cedula);
		this.direccion = direccion;
		this.telefono = telefono;
		this.fechacrea = fechacrea;
		this.usuaCrea = usuaCrea;
		this.usuaModi = usuaModi;
		this.fechamodi = fechamodi;
	}
	
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getDireccion() {
		return direccion;
	}
	public void setDireccion(String direccion) {
		this.direccion = direccion;
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
	public String getNacionalidad() {
		return nacionalidad;
	}
	public void setNacionalidad(String nacionalidad) {
		this.nacionalidad = nacionalidad;
	}
	public Integer getCedula() {
		return cedula;
	}
	public void setCedula(Integer cedula) {
		this.cedula = cedula;
	}

}
