package com.control.usuario;

import java.io.Serializable;
import java.util.Date;

public class Usuario implements Serializable {

	private static final long serialVersionUID = 5877900832171862328L;
	
	private String codigo;
	private String contrasena;
	private String cambcontra;
	private Date ultcambcontra;
	private String vigencia;
	private String cedula;
	private String nombre;
	private String area;
	private String cargo;
	private String usuacrea;
	private Date fechacrea;
	private String usuamodi;
	private Date fechamodi;
	
	public Usuario() {
		codigo = null;
		contrasena = null;
		cambcontra = null;
		ultcambcontra = null;
		vigencia = null;
		cedula = null;
		nombre = null;
		area = null;
		cargo = null;
		usuacrea = null;
		fechacrea = null;
		usuamodi = null;
		fechamodi = null;
	}
	
	public Usuario(String codigo, String contrasena, String cambcontra, 
				   Date ultcambcontra, String vigencia,
				   String cedula, String nombre, String area, 
				   String cargo, String usuacrea, Date fechacrea,
				   String usuamodi, Date fechamodi) {
		
		this.codigo = codigo;
		this.contrasena = contrasena;
		this.cambcontra = cambcontra;
		this.ultcambcontra = ultcambcontra;
		this.vigencia = vigencia;
		this.cedula = cedula;
		this.nombre = nombre; 
		this.area = area;
		this.cargo = cargo; 
		this.usuacrea = usuacrea;
		this.fechacrea = fechacrea;
		this.usuamodi = usuamodi;
		this.fechamodi = fechamodi;
	}

	public String getCodigo() {
		return codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	public String getContrasena() {
		return contrasena;
	}

	public void setContrasena(String contrasena) {
		this.contrasena = contrasena;
	}

	public String getVigencia() {
		return vigencia;
	}

	public void setVigencia(String vigencia) {
		this.vigencia = vigencia;
	}

	public String getCedula() {
		return cedula;
	}

	public void setCedula(String cedula) {
		this.cedula = cedula;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getCargo() {
		return cargo;
	}

	public void setCargo(String cargo) {
		this.cargo = cargo;
	}

	public String getUsuacrea() {
		return usuacrea;
	}

	public void setUsuacrea(String usuacrea) {
		this.usuacrea = usuacrea;
	}

	public Date getFechacrea() {
		return fechacrea;
	}

	public void setFechacrea(Date fechacrea) {
		this.fechacrea = fechacrea;
	}

	public String getUsuamodi() {
		return usuamodi;
	}

	public void setUsuamodi(String usuamodi) {
		this.usuamodi = usuamodi;
	}

	public Date getFechamodi() {
		return fechamodi;
	}

	public void setFechamodi(Date fechamodi) {
		this.fechamodi = fechamodi;
	}

	public String getCambcontra() {
		return cambcontra;
	}

	public void setCambcontra(String cambcontra) {
		this.cambcontra = cambcontra;
	}

	public Date getUltcambcontra() {
		return ultcambcontra;
	}

	public void setUltcambcontra(Date ultcambcontra) {
		this.ultcambcontra = ultcambcontra;
	}
}
