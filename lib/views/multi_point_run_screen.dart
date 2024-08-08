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
                    CustomPaint(
                      size: Size(310.w, 340.h),
                      painter:
                          MultiGridAndDashedLinePainter(), // Use the new painter here
                    ),
                  ],
                ),
              ),
              Container(
                color: Theme.of(context).colorScheme.background,
                child: Column(
                  children: [
                    const SpaceV(),
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
                    SpaceV(height: 19.h),
                    const ChartWidget(),
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
