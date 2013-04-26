package com.example.klachtenreg;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

public class MainActivity extends Activity {
	
	public final static String EXTRA_MESSAGE = "com.example.klachtenreg.MESSAGE";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        
        
        //below is how to check if the phone has a camera
        
        Context context = this;
        PackageManager manage = context.getPackageManager();
		
        if(manage.hasSystemFeature(PackageManager.FEATURE_CAMERA)) {
    		//has camera
        	Log.i("camera", "has a camwa");
        } else {
        	//no camera

        	Log.i("camera", "does not have camwa");
        }
        // end camera check

    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }
    
    public void sendMessage(View view) {
    	Intent intent = new Intent(this, DisplayMessageActivity.class);
    	EditText editText = (EditText) findViewById(R.id.edit_message);
    	String message = editText.getText().toString();
    	intent.putExtra(EXTRA_MESSAGE, message);
    	intent.putExtra("SOMEVALUE", "TEST");
    	startActivity(intent);
    }
    
}
