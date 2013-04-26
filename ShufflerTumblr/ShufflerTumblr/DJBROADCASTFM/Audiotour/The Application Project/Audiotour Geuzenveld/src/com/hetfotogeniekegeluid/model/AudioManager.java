package com.hetfotogeniekegeluid.model;

import java.io.File;
import java.io.FileDescriptor;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import android.app.Activity;
import android.content.res.AssetFileDescriptor;
import android.content.res.AssetManager;
import android.media.AudioFormat;
import android.media.AudioTrack;
import android.media.MediaPlayer;

public class AudioManager {
	private List<AssetFileDescriptor> audioFileDescriptors;
	private MediaPlayer mediaPlayer;
	private AssetManager assetManager;
	private static AudioManager audioManager;
	
	public AudioManager(Activity context) {
		audioFileDescriptors = new ArrayList<AssetFileDescriptor>();
		mediaPlayer = new MediaPlayer();
		
		assetManager = context.getAssets();
//		play(0);
	}
	
	public static AudioManager getInstance(Activity context){
		if(audioManager == null)
			audioManager = new AudioManager(context);
		return audioManager;
	}

	public void loadAudioFiles() throws IOException {
		String[] fileListS = assetManager.list("audio");
		for(String file: fileListS){
			AssetFileDescriptor tmp;
			tmp = assetManager.openFd("audio/" + file);
			audioFileDescriptors.add(tmp);
		}
	}
	
	public void play(int index){
		AssetFileDescriptor descriptor = audioFileDescriptors.get(index);
		
		try {
			mediaPlayer.setDataSource(descriptor.getFileDescriptor(), descriptor.getStartOffset(), descriptor.getLength() );
			mediaPlayer.prepare();
			mediaPlayer.start();
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
