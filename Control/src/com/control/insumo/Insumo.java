package com.control.insumo;

import java.util.Date;

public class Insumo {
	
	private Integer id;
	private String codigoRef;
	private String proveedor;
	private Integer cantInsumos;
	private String precioComp;
	private String precioVent;
	private Date fechaCompa;
	private Date fechaVenc;
	private String usuaCrea;
	private Date fechaCrea;
	private String usuaModi;
	private Date fechaModi;
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCodigoRef() {
		return codigoRef;
	}
	public void setCodigoRef(String codigoRef) {
		this.codigoRef = codigoRef;
	}
	public String getProveedor() {
		return proveedor;
	}
	public void setProveedor(String proveedor) {
		this.proveedor = proveedor;
	}
	public Integer getCantInsumos() {
		return cantInsumos;
	}
	public void setCantInsumos(Integer cantInsumos) {
		this.cantInsumos = cantInsumos;
	}
	public String getPrecioComp() {
		return precioComp;
	}
	public void setPrecioComp(String precioComp) {
		this.precioComp = precioComp;
	}
	public String getPrecioVent() {
		return precioVent;
	}
	public void setPrecioVent(String precioVent) {
		this.precioVent = precioVent;
	}
	public Date getFechaCompa() {
		return fechaCompa;
	}
	public void setFechaCompa(Date fechaCompa) {
		this.fechaCompa = fechaCompa;
	}
	public Date getFechaVenc() {
		return fechaVenc;
	}
	public void setFechaVenc(Date fechaVenc) {
		this.fechaVenc = fechaVenc;
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
	

}
