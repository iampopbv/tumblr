package com.hetfotogeniekegeluid.activity;

import java.util.ArrayList;

import android.app.ActivityManager;
import android.app.ActivityManager.RunningServiceInfo;
import android.app.AlertDialog;
import android.content.ComponentName;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.ServiceConnection;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Bundle;
import android.os.Handler;
import android.os.IBinder;
import android.provider.Settings;
import android.support.v4.app.FragmentActivity;
import android.util.Log;
import android.view.Display;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.SeekBar;
import android.widget.SeekBar.OnSeekBarChangeListener;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.GoogleMap.OnMapClickListener;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.BitmapDescriptor;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;
import com.google.android.gms.maps.model.Polyline;
import com.google.android.gms.maps.model.PolylineOptions;
import com.google.android.maps.OverlayItem;
import com.hetfotogeniekegeluid.R;
import com.hetfotogeniekegeluid.model.LocationStore;
import com.hetfotogeniekegeluid.model.MenuItems;
import com.hetfotogeniekegeluid.model.MyService;
import com.hetfotogeniekegeluid.model.MyService.LocalBinder;
import com.hetfotogeniekegeluid.model.Site;

/**
 * This class initiates the map, and creates links to other activities.
 * 
 * @author Casper
 * 
 */
public class MapActivity extends FragmentActivity implements LocationListener,
		OnSeekBarChangeListener, OnMapClickListener {

	private GoogleMap map;
	private ArrayList<Marker> markers;
	private LocationStore locationStore;
	private ArrayList<OverlayItem> mapOverlays;
	private MyService mService;
	private SeekBar mSeekBar;
	private Button mPausePlay;
	private Handler mHandler = new Handler();
	private boolean updateBar = true;
	private boolean ppclicked = false;
	private View barPosition;
	private boolean barVisible = false;
	private TextView durationText;

	/**
	 * This happens on when the application starts.
	 */
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_map);

		mapOverlays = new ArrayList<OverlayItem>();
		markers = new ArrayList<Marker>();

		SupportMapFragment mapFragment = (SupportMapFragment) getSupportFragmentManager()
				.findFragmentById(R.id.map);
		map = mapFragment.getMap();
		map.setMyLocationEnabled(true);
		map.setIndoorEnabled(true);
		map.setOnMapClickListener(this);

		locationStore = LocationStore.getInstance();

		// Check for internet for the map
		if (checkInternet()) {
			// Check for GPS
			checkForGPS();
			createMap();
		} else {
			// Show that you need internet to continue and quit to the main menu
			final AlertDialog.Builder builder = new AlertDialog.Builder(this);
			builder.setMessage(
					"U heeft momenteel geen actieve netwerkverbinding. De plattegrond zal niet weergeven worden.")
					.setCancelable(false);
			final AlertDialog alert = builder.create();
			alert.setButton("OK", new DialogInterface.OnClickListener() {
				public void onClick(DialogInterface dialog, int which) {
					// Go to previous activity.
					MapActivity.this.finish();
				}
			});

			alert.show();
		}

		Intent intent = new Intent(this, MyService.class);

		if (!isMyServiceRunning()) {
			startService(intent);
		}

		bindService(intent, mConnection, Context.BIND_AUTO_CREATE);
		mSeekBar = (SeekBar) findViewById(R.id.seekBar1);
		mSeekBar.setOnSeekBarChangeListener(this);
		mPausePlay = (Button) findViewById(R.id.pauseplay);
		durationText = (TextView) findViewById(R.id.audioText);

		barPosition = (View) findViewById(R.id.audioBar);
		barPosition.setVisibility(View.INVISIBLE);
		// Move the map to the view
		map.moveCamera(CameraUpdateFactory.newLatLngZoom(new LatLng(52.380498,
				4.802291), 15));
	}

	public void addremoveBar() {
		if (barVisible) {
			barPosition.startAnimation(AnimationUtils.loadAnimation(this,
					R.drawable.slideout));
			barPosition.setVisibility(View.INVISIBLE);
			barVisible = false;
		} else {
			barPosition.startAnimation(AnimationUtils.loadAnimation(this,
					R.drawable.slidein));
			barPosition.setVisibility(View.VISIBLE);
			barVisible = true;
		}

	}

	@Override
	protected void onDestroy() {
		super.onDestroy();
		unbindService(mConnection);
	}

	public void audioStart(View v) {
		mService.startstopAudio();
		if (ppclicked) {
			ppclicked = false;
			mPausePlay.setBackgroundResource(R.drawable.play);
		} else {
			ppclicked = true;
			mPausePlay.setBackgroundResource(R.drawable.pause);
		}
	}

	private void createMap() {
		createMarkers();
		createRoute();
	}

	private boolean isMyServiceRunning() {
		ActivityManager manager = (ActivityManager) getSystemService(Context.ACTIVITY_SERVICE);
		for (RunningServiceInfo service : manager
				.getRunningServices(Integer.MAX_VALUE)) {
			if (MyService.class.getName()
					.equals(service.service.getClassName())) {
				return true;
			}
		}
		return false;
	}

	/**
	 * Draws a route on the map from the registered markers.
	 * 
	 * @return false when there are no markers from which the route can be drawn
	 *         from.
	 */
	private boolean createRoute() {
		if (!markers.isEmpty()) {
			// Instantiates a new Polyline object and adds points to define a
			// rectangle
			PolylineOptions rectOptions = new PolylineOptions();

			for (com.hetfotogeniekegeluid.model.Location location : locationStore
					.getLocations()) {
				rectOptions.add(location.getLatLng());
			}
			rectOptions.color(0xBF3794D3);// 0x005DD49C
			// 0xff000000

			// add the route to the map
			Polyline polyline = map.addPolyline(rectOptions);
			return true;
		} else
			return false;
	}

	private boolean createMarkers() {
		// Clear any old markers
		markers.clear();

		// Add the markers defined in the LocationStore.
		int counter = 1;
		for (Site place : locationStore.getSites()) {
			Display display = getWindowManager().getDefaultDisplay();
			BitmapDescriptor icon;

			if (display.getWidth() < 480) {
				icon = BitmapDescriptorFactory.fromAsset("icon/mdpi/m"
						+ counter++ + ".png");
			} else if (display.getWidth() < 720) {
				icon = BitmapDescriptorFactory.fromAsset("icon/mdpi/m"
						+ counter++ + ".png");
			} else {
				icon = BitmapDescriptorFactory.fromAsset("icon/mdpi/m"
						+ counter++ + ".png");
			}

			Log.w("DEBUG", "Map: " + map);
			Log.w("DEBUG", "place: " + place);
			Log.w("DEBUG", "title: " + place.getDescription());
			Log.w("DEBUG", "icon: " + icon);

			Log.w("DEBUG", "counter: " + counter);
			Marker tmpMarker = map.addMarker(new MarkerOptions()
					.title(place.getName()).snippet(place.getDescription())
					.position(place.getLatLng()).icon(icon));

			markers.add(tmpMarker);

		}

		if (!markers.isEmpty())
			return true;
		return false;
	}

	/**
	 * Checks if internet is available, and if not, displays a message.
	 */
	private boolean checkInternet() {
		final ConnectivityManager conMgr = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);
		final NetworkInfo activeNetwork = conMgr.getActiveNetworkInfo();
		if (activeNetwork == null
				|| activeNetwork.getState() != NetworkInfo.State.CONNECTED) {
			return false;
		}
		return true;
	}

	/**
	 * Checks whether GPS is enabled or not. If not it will prompt a dialog to
	 * set it on.
	 */
	public void checkForGPS() {
		LocationManager service = (LocationManager) getSystemService(LOCATION_SERVICE);
		boolean enabled = service
				.isProviderEnabled(LocationManager.GPS_PROVIDER);

		// Check if enabled and if not send user to the GSP settings
		// Better solution would be to display a dialog and suggesting to
		// go to the settings

		if (!enabled) {
			final AlertDialog alertDialog = new AlertDialog.Builder(this)
					.create();
			alertDialog.setTitle("GPS");
			alertDialog.setMessage("GPS staat uit. Wil je dit aanzetten?");
			alertDialog.setButton("Ja", new DialogInterface.OnClickListener() {
				public void onClick(DialogInterface dialog, int which) {
					Intent intent = new Intent(
							Settings.ACTION_LOCATION_SOURCE_SETTINGS);
					startActivity(intent);
				}
			});
			alertDialog.setButton2("Nee",
					new DialogInterface.OnClickListener() {
						public void onClick(DialogInterface dialog, int which) {
							alertDialog.dismiss();
						}
					});

			alertDialog.show();

		}
	}

	/**
	 * Creates the option menu.
	 */
	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.main, menu);
		return true;
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		// TODO Auto-generated method stub

		Intent selectedActivity = null;
		if (item.getTitle().equals(MenuItems.Colofon.toString())) {
			selectedActivity = new Intent(MapActivity.this,
					ColofonActivity.class);
		}

		startActivity(selectedActivity);
		return super.onOptionsItemSelected(item);
	}

	/**
	 * LocationListener methods.
	 */

	/**
	 * 
	 */
	@Override
	public void onLocationChanged(Location location) {
	}

	/**
	 * 
	 */
	@Override
	public void onProviderEnabled(String provider) {
		Toast.makeText(this, "Enabled new provider " + provider,
				Toast.LENGTH_SHORT).show();

	}

	/**
	 * 
	 */
	@Override
	public void onProviderDisabled(String provider) {
		Toast.makeText(this, "Disabled provider " + provider,
				Toast.LENGTH_SHORT).show();
	}

	/**
	 * 
	 */
	@Override
	public void onStatusChanged(String provider, int status, Bundle extras) {
		// TODO Auto-generated method stub

	}

	public void onProgressChanged(SeekBar seekBar, int progress,
			boolean fromUser) {
		// TODO Auto-generated method stub

		// change progress text label with current seekbar value
		// textProgress.setText("The value is: "+progress);
		// change action text label to changing
		// textAction.setText("changing");
	}

	@Override
	public void onStartTrackingTouch(SeekBar seekBar) {
		// TODO Auto-generated method stub
		// textAction.setText("starting to track touch");
		updateBar = false;
	}

	@Override
	public void onStopTrackingTouch(SeekBar seekBar) {
		// TODO Auto-generated method stub
		mService.setPos(seekBar.getProgress()); // seekBar.getProgress();
		// textAction.setText("ended tracking touch");
		updateBar = true;
	}

	/** Defines callbacks for service binding, passed to bindService() */
	private ServiceConnection mConnection = new ServiceConnection() {

		@Override
		public void onServiceConnected(ComponentName className, IBinder service) {
			// We've bound to LocalService, cast the IBinder and get
			// LocalService instance
			LocalBinder binder = (LocalBinder) service;
			mService = binder.getService();

			// mBound = true;

			if (mService.checkPlaying()) {
				ppclicked = true;
				mPausePlay.setBackgroundResource(R.drawable.pause);
			}

			mHandler.postDelayed(moveSeekBarThread, 1000);
		}

		@Override
		public void onServiceDisconnected(ComponentName arg0) {
			// mBound = false;
		}

	};

	private Runnable moveSeekBarThread = new Runnable() {
		private boolean startTxt = true;

		public void run() {

			if (mService.getPos() + 100 > mService.getDur()) {
				mService.setPos(0);
				mSeekBar.setProgress(0);
				mService.pauseAudio();
				mPausePlay.setBackgroundResource(R.drawable.play);

				int endSeconds = mService.getDur() / 1000;
				int endMinutes = endSeconds / 60;
				endSeconds = endSeconds % 60;

				String endSec;
				if (endSeconds < 10) {
					endSec = "0" + String.valueOf(endSeconds);
				} else {
					endSec = String.valueOf(endSeconds);
				}

				durationText.setText(mService.getTrackName() + "0" + ":" + "00"
						+ " / " + endMinutes + ":" + endSec);
			}

			if ((mService.checkPlaying() && updateBar) || startTxt) {
				startTxt = false;
				mSeekBar.setMax(mService.getDur());
				mSeekBar.setProgress(mService.getPos());

				int curSeconds = mService.getPos() / 1000;
				int curMinutes = curSeconds / 60;
				curSeconds = curSeconds % 60;
				int endSeconds = mService.getDur() / 1000;
				int endMinutes = endSeconds / 60;
				endSeconds = endSeconds % 60;

				String curSec, endSec;
				if (curSeconds < 10) {
					curSec = "0" + String.valueOf(curSeconds);
				} else {
					curSec = String.valueOf(curSeconds);
				}

				if (endSeconds < 10) {
					endSec = "0" + String.valueOf(endSeconds);
				} else {
					endSec = String.valueOf(endSeconds);
				}

				durationText.setText(mService.getTrackName() + curMinutes + ":"
						+ curSec + " / " + endMinutes + ":" + endSec);
			}
			mHandler.postDelayed(this, 100); // Looping the thread after 0.1
												// second
			// seconds
		}

	};

	@Override
	public void onMapClick(LatLng point) {
		addremoveBar();
	}
}
