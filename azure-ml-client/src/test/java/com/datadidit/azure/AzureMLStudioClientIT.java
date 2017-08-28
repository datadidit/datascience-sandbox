package com.datadidit.azure;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.assertNotNull;

import io.vertx.core.Handler;
import io.vertx.core.Vertx;
import io.vertx.core.http.HttpClient;
import io.vertx.core.http.HttpClientRequest;
import io.vertx.core.http.HttpClientResponse;

public class AzureMLStudioClientIT {	
	private Vertx vertx; 
	
	private String url = "https://ussouthcentral.services.azureml.net/workspaces/5642a9272b2b4d2e9fd7319539683744/services/1246b83e5b3346b7be7d99502bca5b34/execute?api-version=2.0&details=true";
	
	private String authorization; 
	
	@Before
	public void setup(){
		authorization = System.getProperty("authorization");
		assertNotNull("Auth must be set to make request", authorization);
		System.out.println("Auth: "+authorization);
	}
	
	@Test
	public void testSimpleClient(){
		Vertx vertx = Vertx.vertx();
		HttpClient client = vertx.createHttpClient();
		Handler<HttpClientResponse> responseHandler = new Handler<HttpClientResponse>(){
			@Override
			public void handle(HttpClientResponse response) {
				  System.out.println("Received response with status code " + response.statusCode());
			}
		};
		
		//
		client.getNow(8080, "localhost", "/", responseHandler);		
		
		while(true);
	}
	
	@Test
	public void testVertxMLClient() throws IOException{
		File file = new File("src/test/resources/azure/titanic_samplerequest.json");
		String jsonRequestBody = FileUtils.readFileToString(file);
		
		//Create vertx instance
		vertx = Vertx.vertx();
		
		//Create client
		HttpClient client = vertx.createHttpClient();
	
		//Create request
		HttpClientRequest request = client.post(url, response -> {
			  System.out.println("Received response with status code " + response.statusCode());
		});
		
		
		//Add headers
		request.putHeader("Content-Type", "application/json");
		request.putHeader("Accept", "application/json");
		request.putHeader("Authorization", "Bearer "+authorization);
		request.putHeader("Content-Length", new Integer(jsonRequestBody.length()).toString());

		//System.out.println("Hello World");
		//System.out.println(jsonRequestBody);
		request.end();	
		
	}
	
	@Test
	public void oldSchoolClient() throws IOException{
		File file = new File("src/test/resources/azure/titanic_samplerequest.json");
		String jsonRequestBody = FileUtils.readFileToString(file);
		
		org.apache.http.client.HttpClient httpclient =HttpClientBuilder.create().build();
		
		HttpPost post = new HttpPost(url);
		
		post.addHeader("Content-Type", "application/json");
		post.addHeader("Accept", "application/json");
		post.addHeader("Authorization", "Bearer "+authorization);
		//post.addHeader("Content-Length", new Integer(jsonRequestBody.length()).toString());
		post.setEntity(new StringEntity(jsonRequestBody));

		HttpResponse response = httpclient.execute(post);
		try {
		    HttpEntity entity = response.getEntity();
		    if (entity != null) {
		        long len = entity.getContentLength();
		        if (len != -1 && len < 2048) {
		            System.out.println(EntityUtils.toString(entity));
		        } else {
		            // Stream content out
		        }
		    }
		} finally {
		   // response.close();
		}
	}
}
