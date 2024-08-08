import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_beam/views/profile/screens/profile_screen.dart';
import '../core/parent.dart';
import '../core/primary_button.dart';
import '../core/spacev.dart';

class MultipointRunScreen extends StatelessWidget {
  const MultipointRunScreen({super.key});

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
            CustomPaint(
              size: const Size(200, 200),
              painter: CircularGraphPainter(),
            ),
            SpaceV(height: 19.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 74.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
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
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 14.sp,
                            color: const Color(0xff212121).withOpacity(.5)),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 1.w),
                Container(
                  height: 74.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
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
                            style: Theme.of(context).textTheme.titleMedium,
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
                            style: Theme.of(context).textTheme.titleMedium,
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
                            style: Theme.of(context).textTheme.titleMedium,
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            SpaceV(height: 19.h),
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
                    padding: EdgeInsets.all(8.r), // padding around the grid
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CircularGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final Offset center = Offset(radius, radius);

    // Draw grid
    final paintGrid = Paint()
      ..color = Colors.pink
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    for (double i = 0; i <= 2 * radius; i += radius / 5) {
      canvas.drawLine(Offset(i, 0), Offset(i, 2 * radius), paintGrid);
      canvas.drawLine(Offset(0, i), Offset(2 * radius, i), paintGrid);
    }

    // Draw circle
    final paintCircle = Paint()
      ..color = Colors.teal.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, paintCircle);

    // Draw points and lines
    final paintLine = Paint()
      ..color = Colors.pink
      ..strokeWidth = 2;

    final paintPoint = Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.fill;

    final paintCenter = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.fill;

    final points = [
      Offset(center.dx, center.dy - radius / 2), // Point 1
      Offset(center.dx - radius / 2, center.dy - radius / 4), // Point 2
      Offset(center.dx - radius / 2, center.dy + radius / 4), // Point 3
      Offset(center.dx + radius / 2, center.dy + radius / 4), // Point 4
      Offset(center.dx + radius / 2, center.dy - radius / 4), // Point 5
    ];

    // Draw center point
    canvas.drawCircle(center, 10, paintCenter);
    drawText(canvas, center, '0', Colors.white);

    // Draw lines
    for (var point in points) {
      canvas.drawLine(center, point, paintLine);
    }

    // Draw points
    for (int i = 0; i < points.length; i++) {
      canvas.drawCircle(points[i], 10, paintPoint);
      drawText(canvas, points[i], (i + 1).toString(), Colors.white);
    }
  }

  void drawText(Canvas canvas, Offset position, String text, Color color) {
    final textStyle = TextStyle(
      color: color,
      fontSize: 14,
    );
    final textSpan = TextSpan(
      text: text,
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
    final offset = Offset(
      position.dx - textPainter.width / 2,
      position.dy - textPainter.height / 2,
    );
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CircularGraphPainter oldDelegate) {
    return false;
  }
}
