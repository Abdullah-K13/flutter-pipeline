import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../core/parent.dart';
import '../core/primary_button.dart';
import '../core/primary_outline_button.dart';
import '../core/spacev.dart';

class MultipointRunScreen extends StatelessWidget {
  const MultipointRunScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List gridItems = [
      {"icon": "assets/icons/run_icon.svg", "label": "Runs", "value": "8"},
      {
        "icon": "assets/icons/distance_icon.svg",
        "label": "Distance",
        "value": "0.5"
      },
      {
        "icon": "assets/icons/active_time_icon.svg",
        "label": "Active time",
        "value": "0.5 Hours"
      },
      {
        "icon": "assets/icons/speed_icon.svg",
        "label": "Speed",
        "value": "7.7 Kmph"
      },
      {
        "icon": "assets/icons/consistency_icon.svg",
        "label": "Consistency",
        "value": "56.2%"
      },
      {
        "icon": "assets/icons/reflex_score_icon.svg",
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
            Container(
              height: 300.h,
              color: Colors.white,
              padding: EdgeInsets.all(18.r),
              child: Column(
                children: [
                  Text(
                    "Create a Drill",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 14.sp),
                  ),
                  // const Expanded(
                  //   child: CustomChart(
                  //     isShowingMainData: true,
                  //   ),
                  // ),
                ],
              ),
            ),
            SpaceV(height: 19.h),
            Padding(
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
                                  SvgPicture.asset(
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Expanded(
                        child: PrimaryOutlineButton(
                          buttonText: "Clear",
                        ),
                      ),
                      SizedBox(width: 20.w),
                      const Expanded(
                        child: PrimaryButton(buttonText: "Start a Drill"),
                      )
                    ],
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
