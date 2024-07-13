import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}



// class MyApp extends StatefulWidget {
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   int _count = 0;
//   FlutterBlue flutterBlue = FlutterBlue.instance;
//   List<Map<String, dynamic>> pairedDevices = [];

  

//   void requestPermissions() async {
//     print("[ENTER] requestPermissions");
//     if (await Permission.bluetoothScan.request().isGranted &&
//         await Permission.bluetoothConnect.request().isGranted &&
//         await Permission.bluetooth.request().isGranted &&
//         await Permission.locationWhenInUse.request().isGranted) {

//         print("Start scanning...");
//         FlutterBlue.instance.startScan(timeout: const Duration(seconds: 10));

//         // print("found devices");
//         // var subscription = flutterBlue.scanResults.listen((results) {
//         //   // do something with scan results
//         //   print("Printing devicess ...");
//         //   for (ScanResult r in results) {
//         //       print('${r.device.name} found! ');
//         //   }
//         // },
//         // onDone: () {
//         // // Scan completed
//         // print('Scan completed');
        
//         // },
//         // onError: (error) {
//         //   // Handle error
//         //   print('Scan error: $error');
          
//         // },
//         // cancelOnError: true,
        
//         // );
        
//         // Stop scanning
//         //flutterBlue.stopScan();
//     } else {
//       // Handle the case where permissions are not granted
//       print('Permissions not granted');
//     }
//     print("[EXIT] requestPermissions");
//   }

  

//   void bluetoothButton(){
    
//     setState(() {
//       _count += 2;
//     });

    
//     requestPermissions();


//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(

//         appBar: AppBar(
//           title: const Text('GYM APP'),
//           actions: <Widget>[
//             IconButton(
//               onPressed: bluetoothButton, 
//               icon: const Icon(Icons.bluetooth),
//               )
//           ],
//         ),

//         body: Center(child: Text('You have pressed the button $_count times.')),
        
//       ),
//     );
//   }
// }


class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {
  List<BluetoothDevice> _devices = [];

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
      _scanDevices();
    } else {
      print('Permissions not granted');
    }
  }


  Future<List<BluetoothDevice>> scanDevices() async {
    List<BluetoothDevice> devices = [];


    try {
      // Start scanning for Bluetooth devices
      await FlutterBlue.instance.startScan(
        timeout: const Duration(seconds: 4),
        withServices: [
          Guid('123e4567-e89b-12d3-a456-426614174000'), // Example UUID
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
        body: ListView.builder(
          itemCount: _devices.length,
          itemBuilder: (context, index) {
            BluetoothDevice device = _devices[index];
            return ListTile(
              title: Text(device.name),
              subtitle: Text(device.id.toString()),
            );
          },
        ),
      ),
    );
  }
}