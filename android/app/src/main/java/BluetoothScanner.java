package com.example.gym_beam;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
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
import java.util.UUID;
import android.os.ParcelUuid;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

import java.util.ArrayList;
import java.util.List;

import android.util.Log;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;

public class BluetoothScanner implements Runnable {

    String TAG = "BluettothScanner";

    private BluetoothAdapter bluetoothAdapter;
    private BluetoothLeScanner bluetoothLeScanner;
    private ScanCallback scanCallback;
    private List<BluetoothDevice> deviceList = new ArrayList<BluetoothDevice>();
    private boolean isScanning = false;
    private Handler handler = new Handler();

    private static final UUID MY_UUID = UUID.fromString("00001101-0000-1000-8000-00805f9b34fb"); // Standard UUID for SPP

    private BluetoothSocket bluetoothSocket;
    private InputStream inputStream;
    private OutputStream outputStream;
    private MethodChannel methodChannel;
    private Handler mainHandler = new Handler(Looper.getMainLooper());

    private byte[] buffer; // Buffer store for the stream

    public BluetoothScanner(Context context) {
        bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            bluetoothLeScanner = bluetoothAdapter.getBluetoothLeScanner();
        }
    }

    public void addLinkToFlutter(MethodChannel _methodChannel){
        methodChannel = _methodChannel;
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    public void startScan() {
        if (!isScanning) {
            deviceList.clear();
            isScanning = true;
            scanCallback = new ScanCallback() {
                @Override
                public void onScanResult(int callbackType, ScanResult result) {
                    BluetoothDevice device = result.getDevice();
                    if (!deviceList.contains(device)) {
                        deviceList.add(device);
                    }
                }

                @Override
                public void onBatchScanResults(List<ScanResult> results) {
                    for (ScanResult result : results) {
                        BluetoothDevice device = result.getDevice();
                        if (!deviceList.contains(device)) {
                            deviceList.add(device);
                        }
                    }
                }

                @Override
                public void onScanFailed(int errorCode) {
                    // Handle scan error
                }
            };
            bluetoothLeScanner.startScan(scanCallback);
            handler.postDelayed(() -> stopScan(), 10000); // Stops scanning after 10 seconds.
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
    public void stopScan() {
        if (isScanning) {
            isScanning = false;
            bluetoothLeScanner.stopScan(scanCallback);
        }
    }

    public List<Map<String, String>> getDeviceList() {
        Log.d(TAG, "enter getPairedDevices");
        List<BluetoothDevice> pairedDevices = new ArrayList<BluetoothDevice>(bluetoothAdapter.getBondedDevices());
  
        //need to fix the scan and then add these two list together
        deviceList = pairedDevices;

        List<Map<String, String>> deviceNameList = new ArrayList<>();
        for(BluetoothDevice device: deviceList){
            Map<String, String> deviceInfo = new HashMap<>();
            
            deviceInfo.put("name", device.getName());
            deviceInfo.put("address", device.getAddress());
            deviceNameList.add(deviceInfo);
            
            //TODO: need to delete
            for( ParcelUuid uuidList: device.getUuids()){
                Log.d(TAG, uuidList.toString());
            }
            Log.d(TAG,  device.getName());
        } 
        return deviceNameList;
    }


    public void connectToDevice(String address, ConnectCallback callback) {
        BluetoothDevice device = bluetoothAdapter.getRemoteDevice(address);
        new Thread(() -> {
            try {
                bluetoothSocket = device.createRfcommSocketToServiceRecord(MY_UUID);
                bluetoothSocket.connect();
                inputStream = bluetoothSocket.getInputStream();
                outputStream = bluetoothSocket.getOutputStream();
                Log.d(TAG, "Connected to device: " + address);
                callback.onConnect(true);
                run();
            } catch (IOException e) {
                Log.e(TAG, "Failed to connect to device: " + address, e);
                
                try {
                    bluetoothSocket.close();
                } catch (IOException closeException) {
                    Log.e(TAG, "Failed to close socket.", closeException);
                }
                callback.onConnect(false);
            }
        }).start();
    }

    public interface ConnectCallback {
        void onConnect(boolean success);
    }

    public void sendData(String data) {
        if (outputStream != null) {
            try {
                outputStream.write(data.getBytes());
                Log.d(TAG, "Data sent: " + data);
            } catch (IOException e) {
                Log.e(TAG, "Failed to send data.", e);
            }
        }
    }

    @Override
    public void run() {
        Log.d(TAG, "RUN function start");
        buffer = new byte[1024];  // Buffer store for the stream
        int bytes; // Bytes returned from read()

        // Keep listening to the InputStream until an exception occurs
        while (true) {
            try {
                // Read from the InputStream
                bytes = inputStream.read(buffer);
                String receivedData = new String(buffer, 0, bytes);
                // Handle the received data (e.g., display it or process it)
                handleReceivedData(receivedData);
            } catch (IOException e) {
                e.printStackTrace();
                break;
            }
        }
    }

    // Method to handle the received data
    private void handleReceivedData(String data) {
        // Process the received data (update UI, save to file, etc.)
        // Ensure you run any UI updates on the main thread
        Log.d(TAG, "Received: " + data);
        mainHandler.post(new Runnable() {
            
            @Override
            public void run() {
                Log.d(TAG, "Run Method");
                if (methodChannel != null) {
                    Log.d(TAG, "calling method");
                    methodChannel.invokeMethod("onBluetoothDataReceived", data);
                }
            }
        });
    }
    
    
}
