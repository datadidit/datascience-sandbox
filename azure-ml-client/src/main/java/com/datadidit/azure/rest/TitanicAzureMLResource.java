package com.datadidit.azure.rest;

import java.io.IOException;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.MediaType;

import org.apache.cxf.rs.security.cors.CrossOriginResourceSharing;
import org.apache.http.ParseException;

import com.datadidit.azure.AzureMLClient;

@Path("/titanic")
@CrossOriginResourceSharing(
		allowAllOrigins = true,
		allowOrigins = {
			"http://localhost:8080"
		}
		)
public class TitanicAzureMLResource {
	private static AzureMLClient client = null;
	
	public static void init(){
		String auth = System.getProperty("authorization");
		String url = "https://ussouthcentral.services.azureml.net/workspaces/5642a9272b2b4d2e9fd7319539683744/services/1246b83e5b3346b7be7d99502bca5b34/execute?api-version=2.0&details=true";
		
		System.out.println("Auth is: "+auth);
		client = new AzureMLClient(url, auth);
	}
	
	@GET
	@Produces(MediaType.TEXT_PLAIN)
	@Path("/hello")
	public String helloWorld(){
		return "Hello World";
	}
	
	@POST
	@Produces(MediaType.APPLICATION_JSON)
	@Consumes(MediaType.APPLICATION_JSON)
	public String getSurvivalScore(String body){
		if(client==null)
			init();
		
		try {
			return client.query(body);
		} catch (ParseException | IOException e) {
			throw new WebApplicationException("Issue running query", e);
		}
	}
}	
