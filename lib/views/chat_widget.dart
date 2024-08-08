import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({super.key});

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
        children: [
          SizedBox(
            height: 171.h,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                titlesData: const FlTitlesData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    // colors: [Colors.teal],
                    barWidth: 2,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      // colors: [Colors.teal.withOpacity(0.3)],
                    ),
                    spots: [
                      const FlSpot(0, 1.22),
                      const FlSpot(1, 0.1),
                      const FlSpot(2, 1.63),
                      const FlSpot(3, 1.9),
                      const FlSpot(4, 1.63),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const PageWidget(),
        ],
      ),
    );
  }
}

class PageWidget extends StatelessWidget {
  const PageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildPageButton("1", true, context),
        _buildPageButton("2", false, context),
        _buildPageButton("3", false, context),
        _buildPageButton("4", false, context),
        _buildPageButton("5", false, context),
        _buildPageButton("6", false, context),
      ],
    );
  }

  Widget _buildPageButton(String text, bool isSelected, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            shape: BoxShape.circle),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
