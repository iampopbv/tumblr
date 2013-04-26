package com.hetfotogeniekegeluid.activity;

import com.hetfotogeniekegeluid.R;

import android.app.Activity;
import android.content.Intent;
import android.media.MediaPlayer;
import android.os.Bundle;
import android.view.View;

public class InstructionMenuActivity extends Activity {
	
	private MediaPlayer player;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_instruction_main);
		player = MediaPlayer.create(this, R.raw.click);
	}
	
	public void onNextClick(View v) {
		player.start();
		setContentView(R.layout.activity_instruction_second);
	}
	
}
