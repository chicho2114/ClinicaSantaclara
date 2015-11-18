package com.control.referencia;

import java.io.Serializable;
import java.util.Date;

public class Referencia implements Serializable {

	private static final long serialVersionUID = -6863629628808812571L;
	
	private String codigo;
	private String descripcion;
	private String componente;
	private String presentacion;
	private String fabricante;
	private String categoria;
	private String observacion;
	private Integer cant_minima;
	private String usuaCrea;
	private Date fechaCrea;
	private String usuaModi;
	private Date fechaModi;
	
	public Referencia() {
		codigo = null;
		descripcion = null;
		componente = null;
		presentacion = null;
		fabricante = null;
		categoria = null;
		observacion = null;
		usuaCrea = null;
		fechaCrea = null;
		usuaModi = null;
		fechaModi = null;
	}

	public String getCodigo() {
		return codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public String getComponente() {
		return componente;
	}

	public void setComponente(String componente) {
		this.componente = componente;
	}

	public String getPresentacion() {
		return presentacion;
	}

	public void setPresentacion(String presentacion) {
		this.presentacion = presentacion;
	}

	public String getFabricante() {
		return fabricante;
	}

	public void setFabricante(String fabricante) {
		this.fabricante = fabricante;
	}

	public String getCategoria() {
		return categoria;
	}

	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}

	public String getObservacion() {
		return observacion;
	}

	public void setObservacion(String observacion) {
		this.observacion = observacion;
	}

	public String getUsuaCrea() {
		return usuaCrea;
	}

	public void setUsuaCrea(String usuaCrea) {
		this.usuaCrea = usuaCrea;
	}

	public Date getFechaCrea() {
		return fechaCrea;
	}

	public void setFechaCrea(Date fechaCrea) {
		this.fechaCrea = fechaCrea;
	}

	public String getUsuaModi() {
		return usuaModi;
	}

	public void setUsuaModi(String usuaModi) {
		this.usuaModi = usuaModi;
	}

	public Date getFechaModi() {
		return fechaModi;
	}

	public void setFechaModi(Date fechaModi) {
		this.fechaModi = fechaModi;
	}

	public Integer getCant_minima() {
		return cant_minima;
	}

	public void setCant_minima(Integer cant_minima) {
		this.cant_minima = cant_minima;
	}
}
