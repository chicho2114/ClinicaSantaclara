package com.control.medico;

import java.io.Serializable;
import java.util.Date;

public class Medico implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -7636275524045498363L;
	
	private String cedula;
	private String nacionalidad;
	private String nombre;
	private String telefono;
	private String servicio;
	private Date fechacrea;
	private String usuaCrea;
	private String usuaModi;
	private Date fechamodi;
	
	public Medico(){
		cedula = null;
		nacionalidad = null;
		nombre = null;
		telefono = null;
		servicio = null;
		fechacrea = null;
		usuaCrea = null;
		usuaModi = null;
		fechamodi = null;
	}
	
	public Medico(String cedula, String nacionalidad, String nombre, String telefono, String servicio, Date fechacrea, String usuaCrea, String usuaModi, Date fechamodi){
		
		this.cedula = cedula;
		this.nacionalidad = nacionalidad;
		this.nombre = nombre;
		this.telefono = telefono;
		this.servicio = servicio;
		this.fechacrea = fechacrea;
		this.usuaCrea = usuaCrea;
		this.usuaModi = usuaModi;
		this.fechamodi = fechamodi;
	}
	
	public String getCedula() {
		return cedula;
	}
	public void setCedula(String cedula) {
		this.cedula = cedula;
	}
	public String getNacionalidad() {
		return nacionalidad;
	}
	public void setNacionalidad(String nacionalidad) {
		this.nacionalidad = nacionalidad;
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
	public String getServicio() {
		return servicio;
	}
	public void setServicio(String servicio) {
		this.servicio = servicio;
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
