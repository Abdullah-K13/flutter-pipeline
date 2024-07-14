import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BluetoothScreen(),
    );
  }
}

class BluetoothScreen extends StatefulWidget {
  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  static const platform = MethodChannel('com.example.gym_beam/bluetooth');
  List<Map<String, String>> _devices = [];
  bool _isConnected = false;

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
////////////////////////////////////////////////////////
  Future<void> _startScan() async {
    try {
      await platform.invokeMethod('startScan');
    } on PlatformException catch (e) {
      print("Failed to start scan: '${e.message}'.");
    }
  }

  Future<void> _stopScan() async {
    try {
      await platform.invokeMethod('stopScan');
    } on PlatformException catch (e) {
      print("Failed to stop scan: '${e.message}'.");
    }
  }
////////////////////////////////////////////////////////

  Future<void> _getDeviceList() async {
    print("ENTER _getDeviceList");
    print(_devices.length);
    try {
      final List<dynamic> devices = await platform.invokeMethod('getDeviceList');

      setState(() {
        _devices = devices.map((d) => Map<String, String>.from(d)).toList();
      });
    } on PlatformException catch (e) {
      print("Failed to get device list: '${e.message}'.");
    }
  }

  Future<void> _connectToDevice(String address) async {
    try {
      final bool connected = await platform.invokeMethod('connectToDevice', {'address': address});
      setState(() {
        _isConnected = connected;
        print("connected : ");
        print(_isConnected);
      });
    } on PlatformException catch (e) {
      print("Failed to connect to device: '${e.message}'.");
    }
  }

  Future<void> _sendData() async {
    String data = "Hello World";
    try {
      await platform.invokeMethod('sendData', {'data': data});
    } on PlatformException catch (e) {
      print("Failed to connect to device: '${e.message}'.");
    }
  }


  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Scanner'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _startScan,
            child: Text('Start Scan'),
          ),
          ElevatedButton(
            onPressed: _stopScan,
            child: Text('Stop Scan'),
          ),
          ElevatedButton(
            onPressed: _getDeviceList,
            child: Text('Get Device List'),
          ),
          ElevatedButton(
            onPressed: _sendData,
            child: Text('Send Data'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _devices.length,
              itemBuilder: (context, index) {
                final device = _devices[index];
                return ListTile(
                  title: Text(device['name'] ?? 'Unknown Device'),
                  subtitle: Text(device['address'] ?? 'No Address'),
                  onTap: () => _connectToDevice(device['address']!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
