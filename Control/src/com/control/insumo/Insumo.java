package com.control.insumo;

import java.io.Serializable;
import java.util.Date;

public class Insumo implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2257556283567979728L;
	
	private String codigoRef;
	private String proveedor;
	private String fabricante;
	private String bodega;
	private Integer cantInsumos;
	private String precioComp;
	private String precioVent;
	private Date fechaComp;
	private Date fechaVenc;
	private String usuaCrea;
	private Date fechaCrea;
	private String usuaModi;
	private Date fechaModi;

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

	public String getFabricante() {
		return fabricante;
	}
	public void setFabricante(String fabricante) {
		this.fabricante = fabricante;
	}
	public Date getFechaComp() {
		return fechaComp;
	}
	public void setFechaComp(Date fechaComp) {
		this.fechaComp = fechaComp;
	}
	public Date getFechaVenc() {
		return fechaVenc;
	}
	public void setFechaVenc(Date fechaVenc) {
		this.fechaVenc = fechaVenc;
	}
	public String getBodega() {
		return bodega;
	}
	public void setBodega(String bodega) {
		this.bodega = bodega;
	}
	

}
