import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {
  List<BluetoothDevice> _devices = [];
  static const platform = MethodChannel('com.example.gym_app/bluetooth');
  List<Map<String, String>> pairedDevices = [];
  List<BluetoothDevice> pairedDevicesList = [];
  BluetoothDevice? connectedDevice;

  void requestPermissions() async {
    var status = await [
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.location,
    ].request();

    if (status[Permission.bluetooth]!.isGranted &&
        status[Permission.bluetoothConnect]!.isGranted &&
        status[Permission.bluetoothScan]!.isGranted &&
        status[Permission.location]!.isGranted) {
         print('Permissions  granted'); 
      //_scanDevices();
    } else {
      print('Permissions not granted');
    }
  }

  Future<void> getPairedDevices() async {
    try {
      final List<dynamic> devices = await platform.invokeMethod('getPairedDevices');

      // for (var device in devices) {
      //   String name = device['name'];
      //   String address = device['address'];
        
      //   // Creating a BluetoothDevice instance
      //   var bluetoothDevice = BluetoothDevice(
      //     id: DeviceIdentifier(address),
      //     name: name,
      //     type: BluetoothDeviceType.unknown, // You can update the type if needed
      //   );
      //   pairedDevicesList.add(bluetoothDevice);
      // }


      setState(() {
        pairedDevices = devices.map((d) => Map<String, String>.from(d)).toList();
      });



    } on PlatformException catch (e) {
      print("Failed to get paired devices: '${e.message}'.");
    }
  }

  void connectToDevice(BluetoothDevice device) async {
    await device.connect();
    setState(() {
      connectedDevice = device;
    });

    // Discover services after connecting
    List<BluetoothService> services = await device.discoverServices();
    services.forEach((service) {
      // Do something with the services
      print('Discovered service: ${service.uuid}');
    });
  }


  Future<List<BluetoothDevice>> scanDevices() async {
    List<BluetoothDevice> devices = [];


    try {
      // Start scanning for Bluetooth devices
      await FlutterBlue.instance.startScan(
        timeout: const Duration(seconds: 4),
        withServices: [
          //Guid('123e4567-e89b-12d3-a456-426614174000'), // Example UUID
          Guid('00000001710e4a5b8d753e5b444b3c3f'),
          Guid('00000002710e4a5b8d753e5b444b3c3f'),
          Guid('00000003710e4a5b8d753e5b444b3c3f'),
        ],
        withDevices:[
          //Guid('123e4567-e89b-12d3-a456-426614174000'), // Example UUID
          Guid('00000001-710e-4a5b-8d75-3e5b444b3c3f'),
          Guid('00000002-710e-4a5b-8d75-3e5b444b3c3f'),
          Guid('00000003-710e-4a5b-8d75-3e5b444b3c3f'),
        ],

      );

      // Listen for discovered devices
      FlutterBlue.instance.scanResults.listen((results) {
        print('listen');
        for (ScanResult result in results) {
          print("listen 2");
          if (!devices.contains(result.device)) {
            devices.add(result.device);
            print(result.device.name);
          }
        }
      }
      );

      // Wait for the scan to complete
      await Future.delayed(const Duration(seconds: 4));

      

      // Stop scanning
      //await FlutterBlue.instance.stopScan();
    } catch (e) {
      print('Error scanning for devices: $e');
    }

    return devices;
  }


  

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  Future<void> _scanDevices() async {
    List<BluetoothDevice> devices = await scanDevices();
    setState(() {
      _devices = devices;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Bluetooth Devices'),
        ),
        body: TextButton(
          child: Text("Scan Me"),
          onPressed: () {
            print("Scan Me clilced");
            // print(pairedDevices.length);
            // if(pairedDevices.length != 0){
            //   for(var i in pairedDevices){
            //     print(i);

            //     // if(i['name'] == 'raspberrypi'){
            //     //   connectToDevice(i);
            //     // }
            //   }
            // }
            getPairedDevices();
            //scanDevices() ;
          },
        )
      ),
    );
  }
}