package com.example.klachtenreg;

import android.os.Bundle;
import android.app.Activity;
import android.content.Intent;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioButton;

public class Complaint extends Activity {

	//area
	public static String HOUSETYPE = "housetype";
	public static String LOCATION = "where";
	public static String TYPERELEFENCE = "boop";
	
	public static String EXPLANATION = "etc";
	
	//personal info
	public final static String FIRSTNAME = "com.example.klachtenreg.FIRSTNAME";;
	public final static String LASTNAME = "com.example.klachtenreg.LASTNAME";
	public final static String STREETNAME = "com.example.klachtenreg.STREETNAME";
	public final static String POSTALCODE = "com.example.klachtenreg.POSTALCODE";
	public final static String PHONENUMBER = "com.example.klachtenreg.PHONENUMBER";
	public final static String EMAIL = "com.example.klachtenreg.EMAIL";
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		
		super.onCreate(savedInstanceState);
	
		//button1 = (Button) findViewById(R.id.button1);
		
		setContentView(R.layout.step1);
		
	}
	
	public void stepTwo(View view) {
    	
    	Intent intent = new Intent(this, ComplaintStepTwo.class);
    	EditText editText = (EditText) findViewById(R.id.etKlachtomschrijving);
    	String message = editText.getText().toString();
    	intent.putExtra(HOUSETYPE, HOUSETYPE);
    	intent.putExtra(LOCATION, LOCATION);
    	intent.putExtra(TYPERELEFENCE, TYPERELEFENCE);
    	intent.putExtra(EXPLANATION, message);
    	startActivity(intent);

	}
	
	
	//todo alles netjes opdelen
	public void onRadioButtonClicked(View view) {
		boolean checked = ((RadioButton) view).isChecked();
	    
	    // Check which radio button was clicked
	    switch(view.getId()) {
	        case R.id.rbAppartement:
	            if (checked)
	            	HOUSETYPE = "appartement";
	                // Pirates are the best

	    	    	setContentView(R.layout.step1_1appartement);
	            break;
	        case R.id.rbWoonhuis:
	            if (checked)
	                // Ninjas rule
	            	HOUSETYPE = "woonhuis";
	            	//setContentView(R.layout.step1_2);
	            	//Log.i("HOUSETYPE","woonhuis");
	            	setContentView(R.layout.step1_2thuis);
	            break;
	        case R.id.rbBuren:
	        	if(checked)
	        		LOCATION = "Buren";
	        	
	        		setContentView(R.layout.step1_2buren);
	        	break;
	        	
	        case R.id.rbGeluid:
	        	if(checked)
	        		TYPERELEFENCE = "geluid";
	        	
	        		setContentView(R.layout.step1_3omschrijving);
	        	break;
	        		
	    }
	    

	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.complaint, menu);
		return true;
	}

}
