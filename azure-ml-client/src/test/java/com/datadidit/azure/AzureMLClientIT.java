package com.datadidit.azure;

import static org.junit.Assert.assertNotNull;

import java.io.File;
import java.io.IOException;

import org.apache.commons.io.FileUtils;
import org.junit.Before;
import org.junit.Test;

public class AzureMLClientIT {
	private String url = "https://ussouthcentral.services.azureml.net/workspaces/5642a9272b2b4d2e9fd7319539683744/services/1246b83e5b3346b7be7d99502bca5b34/execute?api-version=2.0&details=true";
	
	private String authorization; 
	
	private AzureMLClient azClient;
	
	@Before
	public void setup(){
		authorization = System.getProperty("authorization");
		assertNotNull("Auth must be set to make request", authorization);
		
		azClient = new AzureMLClient(url, authorization);
	}
	
	@Test
	public void test() throws IOException{
		File file = new File("src/test/resources/azure/titanic_samplerequest.json");
		String jsonRequestBody = FileUtils.readFileToString(file);
		
		String response = azClient.query(jsonRequestBody);
	
		System.out.println("Response: "+response);
	}
}
