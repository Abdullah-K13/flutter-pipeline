import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/parent.dart';
import '../core/primary_button.dart';
import '../core/primary_outline_button.dart';
import '../core/spacev.dart';
import 'line_chart.dart';
import 'multi_point_run_screen.dart';
import '../config_data.dart';
import '../bluetooth_API.dart';
import 'dart:math';

class CreateExerciseScreen extends StatefulWidget {
  CreateExerciseScreen({super.key});

  @override
  State<CreateExerciseScreen> createState() => _CreateExerciseScreenState();
}

class _CreateExerciseScreenState extends State<CreateExerciseScreen> {

  BluAPI blueapi = BluAPI();
  bool isloading = false;

  final GlobalKey _containerKey = GlobalKey();
  double _goundWidth = 0;
  double _groundHeight = 0;
  double _deviceX = 0;
  double _deviceY = 0;

  int _positionCount = -1;
  List<List<double>> _positionList = [];
  List<List<int>> _positionM = [];


  double angle = 0;
  double distance = 0;
  int index = 0;


  void ShowPointDetails(int Index, int x, int y){
    setState(() {
      index = Index;
      if(x == 0){
        distance =  y.toDouble();
        angle = 90;
      }
      else if(y == 0){
        if(x < 0){
          distance =   -1 * x.toDouble();
        }else{
          distance =  x.toDouble() ;
        }
          
        angle = 180;
      }
      else{

        if (x < 0){
          x = -1 * x;
          angle = 90;
        }
        else{
          angle = 0;
        }

        distance = sqrt( pow(x,2) + pow(y,2) );
        angle += atan(y/x) * (180.0 / pi);
        
      }
      distance = double.parse(distance.toStringAsFixed(2));
      angle = double.parse(angle.toStringAsFixed(2));

    });
  }


  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = _containerKey.currentContext?.findRenderObject() as RenderBox;
      setState(() {
        _goundWidth = renderBox.size.width;
        _groundHeight = renderBox.size.height;

        _deviceX = _goundWidth/2;
        _deviceY = _groundHeight/2;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
          Parent(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(50.h),
              child: AppBar(
                backgroundColor: Colors.white,
                centerTitle: false,
                title: Text(
                  "Create Exercise",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 18.sp),
                ),
              )),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFFFFFF),
                            elevation: .1),
                        child: Text(
                          "Create a Drill",
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 14.sp),
                        ),
                      ),
                      const SpaceV(),
                      //ResponsiveUI(onDataChanged: selectPoint),
                      Padding(
                        padding: EdgeInsets.all(16.w), // Responsive padding
                        child: Center(
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              color: Colors.white,
                              child: CustomPaint(
                                painter: GridAndDashedLinePainter(),
                                child: Stack(
                                  key: _containerKey,
                                  children: touchableGride(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SpaceV(height: 19.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(13.r),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x140D0A2C),
                              blurRadius: 6,
                              offset: Offset(0, 2),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer,
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(8.r),
                                child: Center(
                                  child: Text(
                                    "$index",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            fontSize: 18.sp, color: Colors.white),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/angle_icon.svg",
                                        height: 20.h,
                                        width: 20.w,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        "Angle",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                fontSize: 18.sp,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "${angle}°",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontSize: 14.sp),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: 64.h, child: const VerticalDivider()),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/icons/distance_icon.png",
                                        height: 20.h,
                                        width: 20.w,
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        "Distance",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                fontSize: 18.sp,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "$distance cm",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(fontSize: 14.sp),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SpaceV(height: 40.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: PrimaryOutlineButton(
                              buttonText: "Clear",
                              onPressed: (){
                                setState(() {
                                _positionCount = -1;
                                _positionList = [];
                                _positionM = [];
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 20.w),
                          Expanded(
                            child: PrimaryButton(
                              onPressed: () async{ 
                                isloading = true;
                                isloading = !await blueapi.sendDrill(_positionM, _positionCount + 1);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MultipointRunScreen(),
                                  ),
                                );
                              },
                              buttonText: "Start a Drill",
                            ),
                          )
                        ],
                      ),
                      SpaceV(height: 50.h),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        if (isloading)
        ...[
          ModalBarrier(
            dismissible: false,
            color: Colors.black.withOpacity(0.5),
          ),
          const Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ]
    );
  }



  List<Widget> touchableGride(){
    List<Widget> widgets = [];

    //selected positions
    if (_positionCount != -1){

      for (int i = 0;i <= _positionCount;i++) {
        
        if ( i != _positionCount){
          //draw lines
          widgets.add(
            CustomPaint(
              painter: LinePainter(
                start: Offset(_positionList[i][0], _positionList[i][1]),
                end: Offset(_positionList[i+1][0], _positionList[i+1][1])
              )
            )
          );
        }
        if(i == _positionCount){
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
                  '${i+1}',
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

    widgets.add(
      GestureDetector(
        onTapUp: (details) {
          double DX = details.localPosition.dx;
          double DY = details.localPosition.dy;
          addPoint(DX, DY);
        },
      )
    );
    

    return widgets;
  }


  bool selectPoint(int x, int y){

    int index = -1;
    for(int i = 0; i <= _positionCount; i++){
      if(_positionM[i][0] == x && _positionM[i][1] == y){
        index = i;
        break;
      }
    }


    if (index == -1){
      return false;
    }
    
    ShowPointDetails(index+1, _positionM[index][0], _positionM[index][1]);//_positionList[index][0], _positionList[index][1]);

    return true;
  }

  void addPoint(double x, double y){

    //round up for closet meter
    double pixelCountX = _groundHeight/AppConfigData.diameter;
    double pixelCountY = _goundWidth/AppConfigData.diameter;

    int mx = (x / pixelCountX).ceil();
    int my = (y / pixelCountY).ceil();

    //remove the upper half of the play area
    if(my < AppConfigData.radius){
      return;
    }

    if(selectPoint((mx * 100), (my * 100 - (AppConfigData.radius * 100)))){
      return;
    }

    ////////////////////////////////////////////////////////////////
    int sendX = 0, sendY = 0;
    if(AppConfigData.radius == mx){
      sendX = 0;
    }
    if (AppConfigData.radius < mx){
      sendX = mx - AppConfigData.radius;
    }else{
      sendX = AppConfigData.radius - mx;
      sendX = -1 * sendX;
    }

    sendY = my - AppConfigData.radius;
    sendX = sendX * 100;
    sendY = sendY * 100;
    print("Add new data point : " + sendX.toString() + " : "+ sendY.toString());
    _positionM.add([sendX , sendY ]);
    ////////////////////////////////////////////////

    setState(() {
     
      _positionList.add([mx*pixelCountX, my*pixelCountY]);
      _positionCount += 1;

    });

    ShowPointDetails(_positionCount + 1, (mx * 100), (my * 100 - (AppConfigData.radius * 100)));

  }

}
