package com.control.general;

import java.io.IOException;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;

/*
 * Clase para el manejo de correos electrónicos.
 */
public class Correo {
	
	/*
	 * Método que permite el envio de correo electrónicos.
	 * params:
	 *-String destinatario
	 *-String asunto
	 *-String contenido
	 */
	public static void enviar(String destinatario, String asunto, String contenido) throws EmailException, IOException {
		
		if(destinatario == null || destinatario.equals("")) {
			throw new EmailException("Destinatario no asociado");
		}
		
		HtmlEmail email = new HtmlEmail();
		Propiedades propiedades = new Propiedades("correo.properties");
		email.setHostName(propiedades.obtenerSQL("correo.host"));
		try {
			email.setSmtpPort(Integer.parseInt(propiedades.obtenerSQL("correo.puerto")));
		}
		catch(NumberFormatException e) {
			throw new NumberFormatException("Puerto SMTP incorrecto. Por favor, revise el archivo correo.properties");
		}
		email.setAuthentication(propiedades.obtenerSQL("correo.usuario"), propiedades.obtenerSQL("correo.password"));
		email.setCharset("UTF-8");
		email.addTo(destinatario);
		email.setFrom(propiedades.obtenerSQL("correo.usuario"));
		email.setSubject(asunto);
		email.setHtmlMsg(contenido);
		
		email.send();
	}
}
