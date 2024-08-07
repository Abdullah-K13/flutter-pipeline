import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/parent.dart';
import '../core/primary_button.dart';
import '../core/primary_outline_button.dart';
import '../core/spacev.dart';
import 'line_chart.dart';
import 'multi_point_run_screen.dart';

class CreateExerciseScreen extends StatelessWidget {
  const CreateExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  const ResponsiveUI(),
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
                                "1",
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
                                "130.70°",
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
                                "20.31",
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
                      const Expanded(
                        child: PrimaryOutlineButton(
                          buttonText: "Clear",
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: PrimaryButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MultipointRunScreen(),
                            ),
                          ),
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
    );
  }
}
