package com.control.general;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/*
 * Permite la carga de un archivo de propiedades
 */
public class Propiedades {
	
	private Properties propiedades;
	
	/*
	 * Carga un archivo .properties ubicado en el contexto de esta clase
	 * params:
	 *-String archivo: Nombre de archivo a cargar.
	 * return:
	 */
	public Propiedades(String archivo) throws IOException {
		propiedades = new Properties();
		InputStream is = this.getClass().getResourceAsStream(archivo);
		propiedades.load(is);
	}
	
	/*
	 * Obtiene una propiedad mediante su nombre
	 * params:
	 *-String idConsulta: propiedad a obtener.
	 * return:
	 * String: valor de propiedad.
	 */
	public String obtenerSQL(String idConsulta) {
		return propiedades.getProperty(idConsulta);
	}
}
