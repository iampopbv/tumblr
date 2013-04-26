package com.example.klachtenreg;

import java.io.ByteArrayOutputStream;
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

import android.net.Uri;
import android.os.Bundle;
import android.app.Activity;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Bitmap.CompressFormat;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.ImageView;

public class ComplaintStepTwo extends Activity implements OnClickListener {

	ImageButton createPicture;
	
	Intent pictureIntent;
	
	final static int cameraData = 0;
	
	ImageView displayPicture;
	
	Bitmap picture;
	
	Uri uri;
	
	java.io.InputStream is;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		
		super.onCreate(savedInstanceState);
		setContentView(R.layout.step2);
		
		displayPicture = (ImageView) findViewById(R.id.ivReturnedPic);
		createPicture = (ImageButton) findViewById(R.id.ibTakePic);
		
		createPicture.setOnClickListener(this);
		
	}

	@Override
	public void onClick(View v) {
		// TODO Auto-generated method stub
		switch (v.getId()) {
			case R.id.ibTakePic:
				pictureIntent = new Intent(android.provider.MediaStore.ACTION_IMAGE_CAPTURE);
				startActivityForResult(pictureIntent, cameraData);
				break;
		}
		
	}
	
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.complaint_step_two, menu);
		return true;
	}
	
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		// TODO Auto-generated method stub
		super.onActivityResult(requestCode, resultCode, data);
		
		if(resultCode == RESULT_OK){
			
			Bundle extras = data.getExtras();
			picture = (Bitmap) extras.get("data");
			uri = data.getData();
			//Log.i("DATA","LOLOL" + uri.toString());
			displayPicture.setImageBitmap(picture); 
			
		}
	}
	
	public void stepThree(View view) {
		Intent intent = getIntent();
		String description = intent.getStringExtra(Complaint.EXPLANATION);
		String houseType = intent.getStringExtra(Complaint.HOUSETYPE);
		String location = intent.getStringExtra(Complaint.LOCATION);
		String typePlace = intent.getStringExtra(Complaint.TYPERELEFENCE);
		
		
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		picture.compress(CompressFormat.JPEG, 100, bos);
		
		byte[] data = bos.toByteArray();
		
		String byteArray = Base64.encodeBytes(data);
		
		
		
		
		ArrayList<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>();
        nameValuePairs.add(new BasicNameValuePair("description", description));
        nameValuePairs.add(new BasicNameValuePair("housetype", houseType));
        nameValuePairs.add(new BasicNameValuePair("location", location));
        nameValuePairs.add(new BasicNameValuePair("typeplace", typePlace));

		nameValuePairs.add(new BasicNameValuePair("image", byteArray));
        
        new UploadData().execute(nameValuePairs);
        

		setContentView(R.layout.step3_internet);
	     
		/*
		try {
			
		}catch(Exception e) {

				Log.e("log_tag", "Error in http connection "+e.toString());
		}*/
		
	}

}
