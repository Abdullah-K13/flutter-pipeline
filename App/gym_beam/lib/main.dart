import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'config_data.dart';

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
  //UI related Global variables
  List<List<double>> _positionList = [[]];
  List<List<int>> _positionCM = [[]];
  int _positionCount = 0;
  //TODO: remove these variables
  double DX = 0;
  double DY = 0;

  final GlobalKey _containerKey = GlobalKey();
  double _goundWidth = 0;
  double _groundHeight = 0;
  double _deviceX = 0;
  double _deviceY = 0;


  //Bluetooth Related Global variables
  static const platform = MethodChannel('com.example.gym_beam/bluetooth');
  List<Map<String, String>> _devices = [];
  bool _isConnected = false;

  //////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////     Permission Funtions     ////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////
  
  bool addPoint(double x, double y){
    print("addPoint");

    int _xcm = ((1200 /_groundHeight) * x).round();
    int _ycm = ((1200 /_goundWidth) * y).round() - 600;


    if(_ycm < 0){
      return false;
    }

    _positionCM.add([_xcm, _ycm]);
    return true;
  }

  //////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////     Permission Funtions     ////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////

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
  /////////////////////////////     Bluetooth Funtions     /////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////

//TODO : Need to fix the scan method
////////////////////////////////////////////////////////
  // Future<void> _startScan() async {
  //   try {
  //     await platform.invokeMethod('startScan');
  //   } on PlatformException catch (e) {
  //     print("Failed to start scan: '${e.message}'.");
  //   }
  // }

  // Future<void> _stopScan() async {
  //   try {
  //     await platform.invokeMethod('stopScan');
  //   } on PlatformException catch (e) {
  //     print("Failed to stop scan: '${e.message}'.");
  //   }
  // }
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

  Future<void> _sendData(String data) async {
    //String data = "Hello World";
    try {
      await platform.invokeMethod('sendData', {'data': data});
    } on PlatformException catch (e) {
      print("Failed to connect to device: '${e.message}'.");
    }
  }

  //TODO : just for now
  void connectToPi(){
    print("connecting to bluetooth device");
    for(Map<String, String> device in _devices){
      print(device['name']);
      if(device['name'] == 'raspberrypi'){
        _connectToDevice(device['address']! );
      }
    }
  }

  //TODO : just for now
  Future<void> sendDrill() async{

    String _xdata = '';
    String _ydata = '';
    String data = '';

    await _sendData(_positionCount.toString());
    for(int i=1;i<=_positionCount; i++){

      _xdata = _positionCM[i][0].toString();
      _ydata = _positionCM[i][1].toString();
      data = 'x'+ _xdata + 'y' + _ydata;
      await _sendData(data);
    }
    await _sendData("Z");
    
  }

  //////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////         UI Funtions        /////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////

  List<Widget> createPositionedWidgets() {
    List<Widget> widgets = [];

    //touch calculating widgets
    widgets.add(
      GestureDetector(
      onTapUp: (details) {
        DX = details.localPosition.dx;
        DY = details.localPosition.dy;
        setState(() {
        bool valid = addPoint(DX, DY);
        if(valid){
          _positionList.add([DX, DY]);
          _positionCount += 1;
        }
        
        });

      },
      )
    );

    

    //selected positions
    if (_positionCount != 0){

      for (int i = 1;i <= _positionCount;i++) {
        
        if ( i != 1){
          //draw lines
          widgets.add(
            CustomPaint(
              painter: LinePainter(
                start: Offset(_positionList[i-1][0], _positionList[i-1][1]),
                end: Offset(_positionList[i][0], _positionList[i][1])
              )
            )
          );
        }
        if(i == _positionCount){
          print("last line");
          //draw lines
          widgets.add(
            CustomPaint(
              painter: LinePainter(
                start: Offset(_deviceX, _deviceY),
                end: Offset(_positionList[i][0], _positionList[i][1])
              )
            )
          );
        }

        //draw the laser position
        widgets.add(
          Positioned(
            left: _positionList[i][0] - (AppConfigData.laserPointDouble / 2),
            top: _positionList[i][1] - (AppConfigData.laserPointDouble / 2),
            child: Container(
              width: AppConfigData.laserPointDouble,
              height: AppConfigData.laserPointDouble,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppConfigData.laserPointColor,
              ),
              child: Center(
                child: Text(
                  '$i',
                  style: const TextStyle(color: AppConfigData.laserPointTextColor) ,
                ),
              )
            ),
          )
        );

      }
    }

    //IOT deviece widgets
    widgets.add(
      Positioned(
        left: _deviceX - (AppConfigData.iotDeviceDouble / 2),
        top: _deviceY - (AppConfigData.iotDeviceDouble / 2),
        child: Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppConfigData.iotDeviceColor,
          ),
        ),
      )
    );
    return widgets;
  }


  @override
  void initState() {
    super.initState();
    requestPermissions();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = _containerKey.currentContext?.findRenderObject() as RenderBox;
      setState(() {
        _goundWidth = renderBox.size.width;
        _groundHeight = renderBox.size.height;

        _deviceX = _goundWidth/2;
        _deviceY = _groundHeight/2;
      });
    });

    _getDeviceList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: const Text('GYM-BEAM'),
          actions: <Widget>[
            IconButton(
              onPressed: connectToPi, 
              icon: const Icon(Icons.bluetooth),
              ),

            IconButton(
              onPressed: sendDrill, 
              icon: const Icon(Icons.send)
              ),
            IconButton(
              onPressed: (){
                setState(() {
                  _positionList = [[]];
                  _positionCM = [[]];
                  _positionCount = 0;
                });
                
              }, 
              icon: const Icon(Icons.refresh)
              )
          ],
        ),

        body: AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            
            color: AppConfigData.groundColor,
            margin: const EdgeInsets.all(20),
          
            child: Stack(
              key: _containerKey,
              children: createPositionedWidgets() 
            ),
          ),
        )
      );
  }
}





class LinePainter extends CustomPainter {
  final Offset start;
  final Offset end;

  LinePainter({required this.start, required this.end});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromARGB(255, 66, 64, 64)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
