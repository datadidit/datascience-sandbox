package com.datadidit.azure;

import java.io.IOException;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.ParseException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;

public class AzureMLClient {
	private String url;

	private String authKey;

	private HttpClient client;

	public AzureMLClient(String url, String authKey) {
		client = HttpClientBuilder.create().build();

		this.url = url;
		this.authKey = authKey;
	}

	public String query(String query) throws ParseException, IOException {
		String responseBody = null;
		HttpPost post = new HttpPost(url);
		post.addHeader("Content-Type", "application/json");
		post.addHeader("Accept", "application/json");
		post.addHeader("Authorization", "Bearer " + authKey);
		post.setEntity(new StringEntity(query));

		HttpResponse response = client.execute(post);
		HttpEntity entity = response.getEntity();
		if (entity != null) {
			long len = entity.getContentLength();

			// TODO: Why 2048???
			if (len != -1 && len < 2048) {
				responseBody = EntityUtils.toString(entity);
			} else {
				//TODO: Do something better here
				throw new IOException("Issue with response!!!!");
			}
		}
		
		return responseBody;
	}
}
