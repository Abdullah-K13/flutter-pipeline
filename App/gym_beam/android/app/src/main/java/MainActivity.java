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

    BluetoothScanner scanner = new BluetoothScanner(this);


    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("startScan")) {
                                Log.d("BluetoothScanner", "startScan");
                                //BluetoothScanner scanner = new BluetoothScanner(this);
                                scanner.startScan();
                                result.success("Scanning started");
                            } else if (call.method.equals("stopScan")) {
                                Log.d("BluetoothScanner", "stopScan");
                                //BluetoothScanner scanner = new BluetoothScanner(this);
                                scanner.stopScan();
                                result.success("Scanning stopped");
                            } else if (call.method.equals("getDeviceList")) {
                                Log.d("BluetoothScanner", "getDeviceList");
                                //BluetoothScanner scanner = new BluetoothScanner(this);
                                // List<BluetoothDevice> devices = scanner.getDeviceList();
                                // List<Map<String, String>> deviceList = new ArrayList<>();
                                // for (BluetoothDevice device : devices) {
                                //     Map<String, String> deviceInfo = new HashMap<>();
                                //     deviceInfo.put("name", device.getName());
                                //     deviceInfo.put("address", device.getAddress());
                                //     deviceList.add(deviceInfo);
                                // }
                                // result.success(deviceList);
                                //BluetoothScanner scanner = new BluetoothScanner(this);
                                result.success(scanner.getPairedDevices());
                            } else if (call.method.equals("connectToDevice")){
                                Log.d("BluetoothScanner", "connectToDevice");
                                String address = call.argument("address");
                                scanner.connectToDevice(address, success -> {
                                    runOnUiThread(() -> result.success(success));
                                });
                            } else if(call.method.equals("sendData")){
                                Log.d("BluetoothScanner", "connectToDevice");
                                String data = call.argument("data");
                                scanner.sendData(data);
                                result.success("ok");
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }
}
