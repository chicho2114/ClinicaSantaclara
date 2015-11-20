package com.control.insumo;

import java.io.IOException;
import java.nio.charset.Charset;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.control.general.ManejadorMensajes;
import com.control.general.Redireccion;
import com.control.general.TipoMensaje;
import com.control.general.Utils;
import com.csvreader.CsvReader;


@Controller
public class InsumoController {

	private static final String map = "/insumos";
	private static final String view = "/insumos";
	
	@Autowired
	private InsumoDAO i;
	
	
	@RequestMapping(value = map + "/cargar_insumos")
	public ModelAndView cargar_form(HttpServletRequest request,
								    HttpServletResponse response) {
		
		ModelMap modelo = new ModelMap();
		
		modelo.addAttribute("referencias", i.consultarReferencias());
		modelo.addAttribute("proveedores", i.consultarProveedores());
		modelo.addAttribute("fabricantes", i.consultarFabricantes());
		modelo.addAttribute("bodegas", i.consultarBodegas());
		return new ModelAndView(view + "/cargar_insumos", modelo);
	}
	
	@RequestMapping(value = map + "/crear_accion", method = RequestMethod.POST)
	public ModelAndView crear_accion(HttpServletRequest request, 
									 HttpServletResponse response, 
									 @RequestParam(value="referencia", required=true) String referencia,
									 @RequestParam(value="proveedor", required=true) String proveedor,
									 @RequestParam(value="fabricante", required=true) String fabricante,
									 @RequestParam(value="bodega", required=true) String bodega,
									 @RequestParam(value="cantidad", required=true) Integer cantidad,
									 @RequestParam(value="precioComp", required=true) String precioComp,
									 @RequestParam(value="precioVent", required=true) String precioVent,
									 @RequestParam(value="fechaComp", required=true) String fechaComp,
									 @RequestParam(value="fechaVenc", required=true) String fechaVenc) {
	
		SimpleDateFormat fechatxt = new SimpleDateFormat("yyyy-MM-dd");
		
		
		
		Insumo insumo = new Insumo();
		insumo.setCodigoRef(referencia);
		insumo.setProveedor(proveedor);
		insumo.setFabricante(fabricante);
		insumo.setBodega(bodega);
		insumo.setCantInsumos(cantidad);
		insumo.setPrecioComp(precioComp);
		insumo.setPrecioVent(precioVent);
		try {
			insumo.setFechaComp(fechatxt.parse(fechaComp));
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		try {
			insumo.setFechaVenc(fechatxt.parse(fechaVenc));
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}	
		
		insumo.setUsuaCrea(Utils.obtenerUsuario(request));
		
		try {
			this.i.insertarInsumo(insumo);
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.EXITO, "El insumo de ha a�adido satisfactoriamente");
		} catch (Exception e) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, e.getMessage());
		}
		
		return new Redireccion(map + "/cargar_insumos");
	}
	
	@RequestMapping(value = map + "/crear_archivo")
	public ModelAndView crear_archivo_form(HttpServletRequest request,
								   HttpServletResponse response) {
		
		return new ModelAndView(view + "/crear_archivo_form");
	}
	
	@RequestMapping(value = map + "/crear_archivo_accion",
					method = RequestMethod.POST)
	public ModelAndView crear_archivo_accion(HttpServletRequest request,
								   			 HttpServletResponse response,
								   			 @RequestParam(value="arcParte", required=true) CommonsMultipartFile arcParte) {
		
		List<String> codigosReferencias = new ArrayList<String>();
		List<String> insumosProveedor = new ArrayList<String>();
		List<String> fabricantes = new ArrayList<String>();
		List<String> bodegas = new ArrayList<String>();
		List<Integer> cantidad = new ArrayList<Integer>();
		List<String> preciocompra = new ArrayList<String>();
		List<String> precioventa = new ArrayList<String>();
		List<String> fechacompra = new ArrayList<String>();
		List<String> fechavenc = new ArrayList<String>();
		
		try {
			CsvReader lector = new CsvReader(arcParte.getInputStream(), Charset.forName("UTF-8"));
			lector.setDelimiter(';');
			
			lector.readHeaders();
			
			if(lector.getHeaderCount() != 9) {
				ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, "Error leyendo archivo .CSV. El número de columnas especificado es incorrecto");
				return new Redireccion(map + "/crear_archivo");
			}
			
			
			while(lector.readRecord()) {
				codigosReferencias.add(lector.get(0));
				insumosProveedor.add(lector.get(1));
				fabricantes.add(lector.get(2));
				bodegas.add(lector.get(3));
				cantidad.add(Integer.parseInt(lector.get(4)));
				preciocompra.add(lector.get(5));
				precioventa.add(lector.get(6));
				fechacompra.add(lector.get(7));
				fechavenc.add(lector.get(8));
			}
			lector.close();
		}
		catch(IOException e) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, "Error leyendo archivo .CSV");
		}
		
		try {
			i.insertarInsumosBatch(codigosReferencias, insumosProveedor, fabricantes, bodegas, cantidad, preciocompra, precioventa, fechacompra, fechavenc, Utils.obtenerUsuario(request)); 
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.EXITO, codigosReferencias.size() + " insumos agregados satisfactoriamente");
		} catch (SQLException e) {
			ManejadorMensajes.agregarMensaje(request, TipoMensaje.ERROR, e.getMessage());
		}
		
		return new Redireccion(map + "/crear_archivo");
	}
}
