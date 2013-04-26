package com.example.klachtenreg;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;

import com.example.klachtenreg.Base64.InputStream;

import android.os.AsyncTask;

public class UploadData extends AsyncTask<ArrayList<NameValuePair>, Void, Boolean>{

	private Exception exception;

	@Override
	protected Boolean doInBackground(ArrayList<NameValuePair>... params) {
		HttpClient httpclient = new DefaultHttpClient();
	    HttpPost httppost = new HttpPost("http://bartdeman.nl/pages/klachtenregistratie/data.php");
	    

	    try {
	        // Add your data
	       //log.i("LISTAR",params[0].);
	        httppost.setEntity(new UrlEncodedFormEntity(params[0]));

	        // Execute HTTP Post Request
	        HttpResponse response = httpclient.execute(httppost);
	        
	    } catch (ClientProtocolException e) {
	        // TODO Auto-generated catch block
	    } catch (IOException e) {
	        // TODO Auto-generated catch block
	    }

		return null;
	}
	
	/*
	@Override
	protected Boolean doInBackground(ArrayList<NameValuePair>... params) {
		// TODO Auto-generated method stub
try {
			
			HttpClient httpClient = new DefaultHttpClient();
			
			HttpPost postRequest = new HttpPost("http://bartdeman.nl/pages/klachtenregistratie/process.php");
			
			postRequest.setEntity(new UrlEncodedFormEntity(params[0]));
			HttpResponse response = httpClient.execute(postRequest);
			HttpEntity entity = response.getEntity();
			java.io.InputStream is = (InputStream) entity.getContent();
			return true;
		} catch(Exception e) {
			return false;
		}
		//return null;
	}*/
	
}
