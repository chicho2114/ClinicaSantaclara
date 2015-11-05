package com.control.general;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;

/*
 * Permite la redirección hacia una página del sitio
 */
public class Redireccion extends ModelAndView {
	
	/*
	 * Redirecciona hacia la url deseada
	 * params:
	 *-String url
	 * return:
	 */
	public Redireccion(String url) {
		super.setViewName("redirect:" + url);
	}
	
	/*
	 * Redirecciona hacia la url deseada añadiendo datos en modelo
	 * params:
	 *-String url
	 *-ModelMap modelo
	 * return:
	 */
	public Redireccion(String url, ModelMap modelo) {
		super.setViewName("redirect:" + url);
		super.addAllObjects(modelo);
	}
}
