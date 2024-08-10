import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_beam/core/spacev.dart';

class ChartWidget extends StatelessWidget {
  List<FlSpot> RunDetails =[
    FlSpot(0, 0),
    FlSpot(1, 0),
    FlSpot(2, 0),
    FlSpot(3, 0),
    FlSpot(4, 0),
    FlSpot(5, 0),
    FlSpot(6, 0),
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
                        spots: const [
                          FlSpot(1, 1.2),
                          FlSpot(2, 1.5),
                          FlSpot(3, 1.3),
                          FlSpot(4, 1.4),
                          FlSpot(5, 1.2),
                        ],
                      ),
                    ],
                    lineTouchData: const LineTouchData(
                      enabled: false,
                    ),
                  ),
                ),
                CustomPaint(
                  size: Size(300, 171.h), // Specify the same size as the chart
                  painter: ValuesPainter([
                    const FlSpot(1, 1.2),
                    const FlSpot(2, 1.5),
                    const FlSpot(3, 1.3),
                    const FlSpot(4, 1.4),
                    const FlSpot(5, 1.2),
                  ]),
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
              children: [
                _buildPageButton("1", true, context),
                _buildPageButton("2", false, context),
                _buildPageButton("3", false, context),
                _buildPageButton("4", false, context),
                _buildPageButton("5", false, context),
                _buildPageButton("6", false, context),
              ],
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
              Container(
                height: 36.h,
                width: 36.w,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(8.r)),
                child: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
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

  Widget _buildPageButton(String text, bool isSelected, BuildContext context) {
    return Container(
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
        text,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: Colors.white),
      ),
    );
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
