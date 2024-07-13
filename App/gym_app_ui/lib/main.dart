import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int _count = 0;
  List<List<double>> position_list = [[]];
  int num_position = 0;
  double DX = 0;
  double DY = 0;

  final GlobalKey _containerKey = GlobalKey();
  double _containerWidth = 0;
  double _containerHeight = 0;

  List<Widget> createPositionedWidgets() {
    List<Widget> widgets = [];

    //touch calculating widgets
    widgets.add(
      GestureDetector(
      onTapUp: (details) {
        DX = details.localPosition.dx;
        DY = details.localPosition.dy;
        print("tapped");
        print(DX);
        print(DY);
        setState(() {
        position_list.add([DX, DY]);
        num_position += 1;
        });

      },
      )
    );

    

    //selected positions
    if (num_position != 0){

      for (int i = 1;i <= num_position;i++) {
        
        if ( i != 1){
          //draw lines
          widgets.add(
            CustomPaint(
              painter: LinePainter(
                start: Offset(position_list[i-1][0], position_list[i-1][1]),
                end: Offset(position_list[i][0], position_list[i][1])
              )
            )
          );
        }
        if(i == num_position){
          print("last line");
          //draw lines
          widgets.add(
            CustomPaint(
              painter: LinePainter(
                start: Offset(_containerWidth/2, 0),
                end: Offset(position_list[i][0], position_list[i][1])
              )
            )
          );
        }

        //draw the laser position
        widgets.add(
          Positioned(
            left: position_list[i][0] - 15,
            top: position_list[i][1] - 15,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 6, 92, 12),
              ),
              child: Center(
                child: Text(
                  '$i',
                  style: TextStyle(color: Colors.black) ,
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
        left: (_containerWidth / 2) - 15,
        top: 0,
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Color.fromARGB(255, 3, 0, 12),
          ),
          child: Center(
            child: Text(
              'IOT',
              style: TextStyle(color: const Color.fromARGB(255, 236, 236, 236)) ,
            ),
          )
        ),
      )
    );
    return widgets;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = _containerKey.currentContext?.findRenderObject() as RenderBox;
      setState(() {
        _containerWidth = renderBox.size.width;
        _containerHeight = renderBox.size.height;
        print("containe dimentions");
        print(_containerWidth);
        print(_containerHeight);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        appBar: AppBar(
          title: const Text('GYM APP'),
          actions: <Widget>[
            IconButton(
              onPressed: (){
                setState(() {
                  _count += 2;
                });
              }, 
              icon: const Icon(Icons.bluetooth),
              )
          ],
        ),

        body: Container(
          
          color: Colors.blue,
          margin: EdgeInsets.only(
            top: 50,
            bottom: 250,
            left: 20,
            right: 20
          ),

          child: Stack(
            key: _containerKey,
            children: createPositionedWidgets() 
          ),
        )
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
