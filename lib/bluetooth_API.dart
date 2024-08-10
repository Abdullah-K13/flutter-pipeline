import 'package:flutter/services.dart';
import 'dart:convert';


class BluAPI{

  Function ?onDataReceive;
  bool callbackRegistered = false;

  //Bluetooth Related Global variables
  static const platform = MethodChannel('com.example.gym_beam/bluetooth');
  //List<Map<String, String>> _devices = [];
  bool isConnected = false;


  BluAPI(){
    platform.setMethodCallHandler(handleMethodCall);
  }

  void registerCallback(Function(Map<String, dynamic>) ondatareceive){
    print("registerCallback");
    onDataReceive = ondatareceive;
    callbackRegistered = true;

  }


  //method that call from the bluetooth java file
  Future<void> handleMethodCall(MethodCall call) async {
    print("ENTER handleMethodCall");
    switch (call.method) {
      case 'onBluetoothDataReceived':

        if(callbackRegistered){
          print("callbackRegistered");
          String _receivedData = call.arguments;
          print(_receivedData);
          Map<String, dynamic> jsonData = json.decode(_receivedData);
          if(null != onDataReceive){
            print("Callback found");
            onDataReceive!(jsonData);
          }
        }
        break;
      default:
        throw MissingPluginException('notImplemented');
    }
  }


//////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<List<Map<String, String>>> getDeviceList() async {
    List<Map<String, String>> _devices = [];

    try {
      final List<dynamic> devices = await platform.invokeMethod('getDeviceList');

      _devices = devices.map((d) => Map<String, String>.from(d)).toList();

      print(_devices);
      
    } on PlatformException catch (e) {
      print("Failed to get device list: '${e.message}'.");
    }
    return _devices;
  }


//////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<bool> connect(String address) async {
    print("Bluetooth connecting address : " + address);
    try {
      final bool connected = await platform.invokeMethod('connectToDevice', {'address': address});

        isConnected = connected;
        print("connected");
        if (isConnected){
          sendTime();
        }

    } on PlatformException catch (e) {
      print("Failed to connect to device: '${e.message}'.");
    }
    return isConnected;
  }


//////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<void> sendData(String data) async {
    print("sending data : " +  data);
    try {
      await platform.invokeMethod('sendData', {'data': data});
    } on PlatformException catch (e) {
      print("Failed to connect to device: '${e.message}'.");
    }
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<void> sendTime() async{

    //send the current date and time to device
    DateTime now = DateTime.now();
    print('Current date and time: $now');

    Map<String, dynamic> data = {
      'command': 'Time',
      'year': now.year.toString(),
      'month': now.month.toString(),
      'date' : now.day.toString(),
      'hour' : now.hour.toString(),
      'minutes' : now.minute.toString(),
      'second' : now.second.toString()
    };
    String jsonString = jsonEncode(data);

    await sendData(jsonString);
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<bool> sendDrill(List<List<int>> positionM, int positionCount) async{
    Map<String, dynamic> data = {
      'command': 'Drill',
      'name' : "drill_test",
      'coordinateCount' : positionCount,
      'cordinates' : positionM
    };
    String jsonString = jsonEncode(data);

    await sendData(jsonString);
    return true;
  }

  

}