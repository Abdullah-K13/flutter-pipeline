package com.example.gym_app

import io.flutter.embedding.android.FlutterActivity

import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.bluetooth.BluetoothSocket
import android.os.Build
import android.os.Bundle
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.util.Log
import java.io.IOException
import java.util.*

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.gym_app/bluetooth"
    private val MY_UUID = UUID.fromString("00001855-0000-1000-8000-00805F9B34FB")

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getPairedDevices") {
                val pairedDevices = getPairedDevices()
                result.success(pairedDevices)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getPairedDevices(): List<Map<String, UUID>> {
        
        val bluetoothAdapter: BluetoothAdapter? = BluetoothAdapter.getDefaultAdapter()
        val pairedDevices: Set<BluetoothDevice>? = bluetoothAdapter?.bondedDevices
        val devicesList = mutableListOf<Map<String, UUID>>()

        pairedDevices?.forEach { device ->
            //val deviceInfo = mapOf("name" to device.name, "address" to device.address)
            //devicesList.add(deviceInfo)

            if(device.name == "raspberrypi"){
                var bluetoothSocket: BluetoothSocket? = null
                try {
                    bluetoothSocket = device.createRfcommSocketToServiceRecord(MY_UUID)
                    bluetoothSocket.connect()

                    



                    val data = "t"
                    bluetoothSocket.outputStream.write(data.toByteArray())
                } catch (e: IOException) {
                    
                    try {
                        bluetoothSocket?.close()
                    } catch (closeException: IOException) {
                        
                    }
                    
                }
            }
        }

        return devicesList
    }
}
