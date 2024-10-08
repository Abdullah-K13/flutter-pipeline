// lib/features/multipoint_run/presentation/pages/multipoint_run_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_beam/core/parent.dart';
import 'package:gym_beam/core/primary_button.dart';
import 'package:gym_beam/core/spacev.dart';
import 'package:gym_beam/views/chart_widget.dart';
import 'package:gym_beam/views/pagination_widget.dart';
import 'package:gym_beam/views/profile/screens/profile_screen.dart';
import 'package:gym_beam/views/widgets/multi_line%20painter.dart';
import 'package:fl_chart/fl_chart.dart';
import '../bluetooth_API.dart';
import '../api/web_API.dart';

class MultipointRunScreen extends StatefulWidget {

  List<List<double>> pointList;
  
  MultipointRunScreen({
    super.key,
    required this.pointList,
    });



  @override
  State<MultipointRunScreen> createState() => _MultipointRunScreenState(pointList);
}

class _MultipointRunScreenState extends State<MultipointRunScreen> {

  List<List<double>> pointList = [];
  _MultipointRunScreenState(List<List<double>> PointList){
    pointList = PointList;
  }

  BluAPI blueapi = BluAPI();


  List<List<FlSpot>> allRunsData = [];
  List<FlSpot> selectedRun =[
    FlSpot(0, 0),
    FlSpot(1, 0),
    FlSpot(2, 0),
    FlSpot(3, 0),
    FlSpot(4, 0),
    FlSpot(5, 0),
    FlSpot(6, 0),
  ];

  int convertToInt(var timeVal){
    int? val;

    // Check if value is int
    if (timeVal is int) {
      val = timeVal;
    }
    // Check if value is String that can be converted to int
    else if (timeVal is String) {
      val = int.tryParse(timeVal); // Safely parse the string to int
    }
    // Check if value is double, you might want to round or floor it
    else if (timeVal is double) {
      val = timeVal.toInt();
    } else {
      print("Unexpected type for 'point': ${timeVal.runtimeType}");
      val = 0;
    }
    return val!;
  }

  void receiveBlueData(Map<String, dynamic> jsonData){
    print("ENTER receiveBlueData");
    print(jsonData["type"]);
    print(jsonData["name"]);
    print(jsonData["coordinateCount"]);
    
    List<FlSpot> newrun = [];

    List<DateTime> timedetails = [];

    for(int i=0;i<jsonData["coordinateCount"];i++){
      if(jsonData.containsKey("point$i")){
        newrun.add(FlSpot(i.toDouble(), jsonData["point$i"]));
        int val = convertToInt(jsonData["point$i"]);
        timedetails.add(DateTime.fromMillisecondsSinceEpoch(val * 1000));
      }
    }
    print("new run : "+  newrun.toString());

    print("Sending drilld ata to server");
    WebAPI.instance.createDrill(jsonData["name"], jsonData["coordinateCount"], timedetails);

    setState(() {
      allRunsData.add(newrun);
      selectedRun = newrun;
    });

    
  }


  @override
  void initState() {
    super.initState();
    
    blueapi.registerCallback(receiveBlueData);
  }

  @override
  Widget build(BuildContext context) {
    List gridItems = [
      {"icon": "assets/icons/run_icon.png", "label": "Runs", "value": "8"},
      {
        "icon": "assets/icons/distance_icon.png",
        "label": "Distance",
        "value": "0.5"
      },
      {
        "icon": "assets/icons/active_time.png",
        "label": "Active time",
        "value": "0.5 Hours"
      },
      {
        "icon": "assets/icons/speed_icon.png",
        "label": "Speed",
        "value": "7.7 Kmph"
      },
      {
        "icon": "assets/icons/consistency_icon.png",
        "label": "Consistency",
        "value": "56.2%"
      },
      {
        "icon": "assets/icons/reflex_score.png",
        "label": "Reflex Score",
        "value": "3.5"
      },
    ];
    return Parent(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBar(
          backgroundColor: Colors.white,
          centerTitle: false,
          title: Text(
            "Multi Point Run",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontSize: 18.sp),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Divider(),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
                color: const Color(0xffFEFBFC),
                child: Column(
                  children: [
                    const PaginationWidget(),
                    SpaceV(height: 32.h),
                    ////////////////////////////////////////////////////////////////////////////////////
                    //////////////// Play Area [Start]
                    ///////////////////////////////////////////////////////////////////////////////////
                    CustomPaint(
                      size: Size(310.w, 340.h),
                      painter:
                          MultiGridAndDashedLinePainter(pointList), // Use the new painter here
                    ),
                    ////////////////////////////////////////////////////////////////////////////////////
                    //////////////// Play Area [End]
                    ///////////////////////////////////////////////////////////////////////////////////
                  ],
                ),
              ),
              Container(
                color: Theme.of(context).colorScheme.background,
                child: Column(
                  children: [
                    const SpaceV(),
                    ///////////////////////////////////////////////////////////////////////////
                    /////////////////// Spped Details - Logo  [Start]
                    //////////////////////////////////////////////////////////////////////////
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 74.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 4.h),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.r),
                                bottomLeft: Radius.circular(10.r),
                              ),
                            ),
                            shadows: [
                              BoxShadow(
                                color: const Color(0x140D0A2C),
                                blurRadius: 6.r,
                                offset: const Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/stopwatch_icon.png",
                                height: 24.h,
                                width: 24.w,
                              ),
                              Text(
                                'Speed\nKmph',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontSize: 14.sp,
                                        color: const Color(0xff212121)
                                            .withOpacity(.5)),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width: 1.w),
                        Container(
                          height: 74.h,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 14.h),
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x140D0A2C),
                                blurRadius: 6,
                                offset: Offset(0, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          ///////////////////////////////////////////////////////////////////////////
                          /////////////////// Spped Details - Logo  [END]
                  
                          /////////////////// Spped Details [Start]
                          //////////////////////////////////////////////////////////////////////////
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/icons/high_speed.png",
                                        height: 20.h,
                                        width: 20.w,
                                      ),
                                      SizedBox(width: 11.w),
                                      Text(
                                        "HIGH",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondaryContainer,
                                                fontWeight: FontWeight.w700),
                                      )
                                    ],
                                  ),
                                  Text(
                                    "9.2",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: const VerticalDivider(),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/icons/avg_speed.png",
                                        height: 20.h,
                                        width: 20.w,
                                      ),
                                      SizedBox(width: 11.w),
                                      Text(
                                        "Avg",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: const Color(0xffD8A40B),
                                                fontWeight: FontWeight.w700),
                                      )
                                    ],
                                  ),
                                  Text(
                                    "9.2",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: const VerticalDivider(),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        "assets/icons/low_speed.png",
                                        height: 20.h,
                                        width: 20.w,
                                      ),
                                      SizedBox(width: 11.w),
                                      Text(
                                        "Low",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                color: const Color(0xffD32F2F),
                                                fontWeight: FontWeight.w700),
                                      )
                                    ],
                                  ),
                                  Text(
                                    "9.2",
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    //////////////////////////////////////////////////////////////////////////
                    /////////////////// Spped Details [end]
                    //////////////////////////////////////////////////////////////////////////
                    SpaceV(height: 19.h),
                    ChartWidget(RunDetails: selectedRun),
                    const SpaceV(),
                  ],
                ),
              ),
              Container(
                color: const Color(0xffFEFBFC),
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // number of items in each row
                        mainAxisSpacing: 8.0, // spacing between rows
                        crossAxisSpacing: 8.0, // spacing between columns
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h), // padding around the grid
                      itemCount: gridItems.length, // total number of items
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(5.r),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 1, color: Color(0x19FF3480)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      gridItems[index]["icon"],
                                      height: 20.h,
                                      width: 20.w,
                                    ),
                                    Text(
                                      gridItems[index]["label"],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: const Color(0xFF9290A4),
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                    Text(
                                      gridItems[index]["value"],
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(fontSize: 18.sp),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    SpaceV(height: 36.h),
                    PrimaryButton(
                      buttonText: "Detailed Analytics",
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ProfileScreen(),
                        ),
                      ),
                    ),
                    const SpaceV()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
