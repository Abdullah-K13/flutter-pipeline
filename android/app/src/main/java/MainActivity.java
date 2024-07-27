package com.example.gym_beam;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import android.os.Build;
import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.le.ScanCallback;
import android.bluetooth.le.ScanResult;
import android.bluetooth.le.BluetoothLeScanner;
import android.content.Context;
import android.os.Build;
import android.os.Handler;
import androidx.annotation.RequiresApi;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import java.util.ArrayList;
import java.util.List;


import androidx.annotation.NonNull;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;

import android.util.Log;


public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.example.gym_beam/bluetooth";
    String TAG = "MainActivity";

    BluetoothScanner scanner = new BluetoothScanner(this);


    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            switch(call.method){
                                case "startScan":
                                    Log.d(TAG, "startScan");
                                    scanner.startScan();
                                    result.success("Scanning started");
                                    break;

                                case "stopScan":
                                    Log.d(TAG, "stopScan");
                                    scanner.stopScan();
                                    result.success("Scanning stopped");
                                    break;

                                case "getDeviceList":
                                    Log.d(TAG, "getDeviceList");
                                    result.success(scanner.getDeviceList());
                                    break;

                                case "connectToDevice":
                                    Log.d(TAG, "connectToDevice");
                                    String address = call.argument("address");
                                    scanner.connectToDevice(address, success -> {
                                        runOnUiThread(() -> result.success(success));
                                    });
                                    break;

                                case "sendData":
                                    Log.d(TAG, "connectToDevice");
                                    String data = call.argument("data");
                                    scanner.sendData(data);
                                    result.success("ok");
                                    break;
                                
                                default:
                                    result.notImplemented();
                            }
                        }
                );
    }
}
