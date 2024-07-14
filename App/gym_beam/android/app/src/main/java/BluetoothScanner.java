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

public class BluetoothScanner {

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

    public BluetoothScanner(Context context) {
        bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            bluetoothLeScanner = bluetoothAdapter.getBluetoothLeScanner();
        }
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
                        // if(!device.equals(null)){
                        //     Log.d("BluetoothScanner found 2", device.getName());
                        //     for( ParcelUuid uuidList: device.getUuids()){
                        //         Log.d("BluetoothScanner UUID ", uuidList.toString());
                        //     }
                        // }
                    }
                }

                @Override
                public void onBatchScanResults(List<ScanResult> results) {
                    for (ScanResult result : results) {
                        BluetoothDevice device = result.getDevice();
                        if (!deviceList.contains(device)) {
                            deviceList.add(device);
                            // if(!device.equals(null)){
                            //     Log.d("BluetoothScanner found 1", device.getName());
                            //     for( ParcelUuid uuidList: device.getUuids()){
                            //         Log.d("BluetoothScanner UUID ", uuidList.toString());
                            //     }
                            // }
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

    public List<BluetoothDevice> getDeviceList() {
        return deviceList;
    }

    public List<Map<String, String>> getPairedDevices() {
        Log.d("BluetoothScanner", "enter getPairedDevices");
        List<BluetoothDevice> pairedDevices = new ArrayList<BluetoothDevice>(bluetoothAdapter.getBondedDevices());
  
        //need to fix the scan and then add these two list together
        deviceList = pairedDevices;


        List<Map<String, String>> deviceNameList = new ArrayList<>();
        for(BluetoothDevice device: deviceList){
            Map<String, String> deviceInfo = new HashMap<>();
            
            deviceInfo.put("name", device.getName());
            
            

                for( ParcelUuid uuidList: device.getUuids()){
                    Log.d("BluetoothScanner UUID ", uuidList.toString());
                }
            
            
            deviceInfo.put("address", device.getAddress());

            deviceNameList.add(deviceInfo);
            Log.d("BluetoothScanner list ", device.getName());
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
                Log.d("BluetoothScanner", "Connected to device: " + address);
                callback.onConnect(true);
            } catch (IOException e) {
                Log.e("BluetoothScanner", "Failed to connect to device: " + address, e);
                
                try {
                    bluetoothSocket.close();
                } catch (IOException closeException) {
                    Log.e("BluetoothScanner", "Failed to close socket.", closeException);
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
                Log.d("BluetoothScanner", "Data sent: " + data);
            } catch (IOException e) {
                Log.e("BluetoothScanner", "Failed to send data.", e);
            }
        }
    }
    
}
