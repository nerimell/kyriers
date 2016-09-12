package com.vittach.couriers;

import android.os.Bundle;
import android.content.Intent;
import android.content.Context;
import android.net.ConnectivityManager;

import android.provider.Settings;
import com.vittach.couriers.simpleEngine.MyEngine;
import com.vittach.couriers.interfaces.ActivityWiFiHandler;
import com.badlogic.gdx.backends.android.AndroidApplication;
import com.badlogic.gdx.backends.android.AndroidApplicationConfiguration;

public class AndroidLauncher extends AndroidApplication implements ActivityWiFiHandler{
	@Override
	protected void onCreate (Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		AndroidApplicationConfiguration config = new AndroidApplicationConfiguration();
		config.useAccelerometer = false;
		initialize(new MyEngine(1), config);
	}

	@Override
	public boolean isWifiEnabled() {
		//http://badlogicgames.com/forum/viewtopic.php?t=2679&p=13729
		ConnectivityManager conMan;
		conMan = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);
		Boolean status = conMan.getNetworkInfo(ConnectivityManager.TYPE_WIFI).isConnectedOrConnecting();
		if (status) return true;
		else
		{
			startActivity(new Intent(Settings.ACTION_WIFI_SETTINGS));
			return false;
		}

	}
}
