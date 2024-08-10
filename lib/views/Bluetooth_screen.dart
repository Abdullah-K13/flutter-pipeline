import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bluetooth_API.dart';
import 'register_screen.dart';


class BluetoothDevicePage extends StatefulWidget {
  BluetoothDevicePage({super.key});
  @override
  _BluetoothDevicePageState createState() => _BluetoothDevicePageState();
}

class _BluetoothDevicePageState extends State<BluetoothDevicePage> {

  //Bluetooth Related Global variables
  List<Map<String, String>> _devices = [];
  bool isConnecting = false;
  bool connected = false;


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
    } else {
      print('Permissions not granted');
    }
  }


  //////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////     Bluetooth Funtions start    //////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////
  
  BluAPI blueapi = BluAPI();



  Future<void> loadBlueDevice() async {
    print("ENTER _getDeviceList");
    print(_devices.length);
    try {
      final List<dynamic> devices = await blueapi.getDeviceList();

      setState(() {
        _devices = devices.map((d) => Map<String, String>.from(d)).toList();
      });
    } on PlatformException catch (e) {
      print("Failed to get device list: '${e.message}'.");
    }
  }

  Future<void> connectDevice(String device,{Duration timeout = const Duration(seconds: 10)}) async {
    print("ENTER connectDevice" + device);

    setState(() {
      isConnecting = true; // Start showing the loading indicator
    });
    
    
    try {
      connected = await blueapi.connect(device).timeout(timeout, onTimeout: () {
                  print("Connection time out");
                  return false;
                });
      
      setState(() {
      isConnecting = false; // Start showing the loading indicator
      });
    
    } on PlatformException catch (e) {
      print("Failed to get device list: '${e.message}'.");

      setState(() {
        isConnecting = false; // Stop showing the loading indicator
      });

    }

    if(connected){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegisterScreen()),
      );
    }
    else{
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Connection Failed"),
            content: Text("Failed to connect to the device."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    }

    
  }

  //////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////     Bluetooth Funtions end      //////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////



  @override
  void initState() {
    super.initState();

    requestPermissions();
    loadBlueDevice();

  }



  // Futur<void> onDeviceTap(String device) {
  //   // Handle the click event here, e.g., navigate to a new page
  //   //print('Tapped on device: ${device.name} with MAC: ${device.id}');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBar(
          centerTitle: false,
          title: Text(
            "Connecting to Device",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body:  Stack(
        children: [
          // Main content (List of Bluetooth devices)
          buildDeviceList(),

          // Blur and loading indicator overlay
          if (isConnecting) buildLoadingOverlay(),
        ],
      ),
    );


  }


  Widget buildDeviceList() {
      return _devices.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _devices.length,
              itemBuilder: (context, index) {
                final device = _devices[index];
                return ListTile(
                  title: Text(device['name']!),
                  subtitle: Text(device['address']!),
                  onTap: () => connectDevice(device['address']!),
                );
              },
            );
    }



  Widget buildLoadingOverlay() {
    return IgnorePointer(
      ignoring: true,
      child: Container(
        color: Colors.black.withOpacity(0.2),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
