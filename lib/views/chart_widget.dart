import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gym_beam/core/spacev.dart';

class ChartWidget extends StatelessWidget {
  List<FlSpot> RunDetails =[
    FlSpot(0, 0),
    FlSpot(1, 0),
    FlSpot(2, 0),
    FlSpot(3, 0),

  ];

  ChartWidget({
    Key? key,
    required this.RunDetails,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 278.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.r,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 113.h,
            child: Stack(
              children: [
                LineChart(
                  LineChartData(
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    titlesData: const FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        isCurved: true,
                        color: Colors.teal,
                        barWidth: 2,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, barData, index) {
                            if (index == barData.spots.length - 1) {
                              return FlDotCirclePainter(
                                radius: 6,
                                color: Colors.teal,
                                strokeWidth: 2,
                                strokeColor: Colors.white,
                              );
                            } else {
                              return FlDotCirclePainter(
                                radius: 3,
                                color: Colors.teal,
                                strokeWidth: 0,
                              );
                            }
                          },
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: [
                              Colors.teal.withOpacity(0.3),
                              Colors.teal.withOpacity(0),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        spots: RunDetails
                      ),
                    ],
                    lineTouchData: const LineTouchData(
                      enabled: false,
                    ),
                  ),
                ),
                CustomPaint(
                  size: Size(300, 171.h), // Specify the same size as the chart
                  painter: ValuesPainter(RunDetails),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _buildPageButton( 1, context, RunDetails.length),
            ),
          ),
          const SpaceV(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 36.h,
                width: 36.w,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(8.r)),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 24.w),
              GestureDetector(
                onTap: (){
                  print("TAP TAP");
                  
                },
                child: Container(
                  height: 36.h,
                  width: 36.w,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(8.r)),
                  child: 
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTitle(String text, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xff212121).withOpacity(.5),
              fontSize: 12.sp,
            ),
      ),
    );
  }

  List<Widget> _buildPageButton(int Selectednum, BuildContext context, int itemcount ) {
    List<Widget> pointbuttons = [];
    bool isSelected = false;
    for(int i=0;i<itemcount;i++){
      isSelected = Selectednum == i? true: false;
      pointbuttons.add(
          Container(
          width: 30.w,
          height: 30.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).colorScheme.secondaryContainer
                : Colors.teal,
            shape: BoxShape.circle,
          ),
          child: Text(
            '${i+1}',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white),
          ),
        ));
    }
    return pointbuttons;
  }
}

class ValuesPainter extends CustomPainter {
  final List<FlSpot> spots;

  ValuesPainter(this.spots);

  @override
  void paint(Canvas canvas, Size size) {
    final textStyle = TextStyle(
      color: Colors.grey,
      fontSize: 12.sp,
      fontWeight: FontWeight.bold,
    );

    for (final spot in spots) {
      final textSpan = TextSpan(
        text: '${spot.y.toStringAsFixed(2)}s',
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: double.infinity,
      );
      final xOffset = spot.x * (size.width / (spots.length + 1));
      final yOffset = (1 - spot.y / 2) * size.height;
      final offset = Offset(
        xOffset - textPainter.width / 2,
        yOffset - textPainter.height - 5,
      );
      textPainter.paint(canvas, offset);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
