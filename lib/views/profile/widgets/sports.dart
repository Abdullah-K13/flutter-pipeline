import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SportsWidget extends StatelessWidget {
  const SportsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r), color: Colors.white),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                SvgPicture.asset("assets/icons/sports_icon.svg"),
                SizedBox(width: 4.w),
                Text(
                  'Sports',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontSize: 14.sp),
                ),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 8.0, // horizontal spacing
              runSpacing: 4.0, // vertical spacing
              children: [
                {"icon": "assets/icons/gym_icon.svg", "label": "Gym"},
                {"icon": "assets/icons/football_icon.svg", "label": "Football"},
                {"icon": "assets/icons/tennis_icon.svg", "label": "Tennis"},
                {"icon": "assets/icons/baseball_icon.svg", "label": "Baseball"},
                {
                  "icon": "assets/icons/badminton_icon.svg",
                  "label": "Badminton"
                },
                {"icon": "assets/icons/cricket_icon.svg", "label": "Cricket"},
                {"icon": "assets/icons/hockey_icon.svg", "label": "Hockey"},
              ]
                  .map(
                    (e) => Container(
                      margin: EdgeInsets.only(bottom: 12.h),
                      child: ChoiceChip(
                        backgroundColor: e["label"] == "Gym"
                            ? Theme.of(context).colorScheme.secondaryContainer
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.outline,
                            width: 1.r,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 12.5.h, horizontal: 13.w),
                        avatar: e["icon"] != null
                            ? SvgPicture.asset(
                                e["icon"]!,
                                colorFilter: ColorFilter.mode(
                                    e["label"] == "Gym"
                                        ? Colors.white
                                        : const Color(0xff212121)
                                            .withOpacity(.5),
                                    BlendMode.srcIn),
                              )
                            : null,
                        label: Text(
                          e["label"] ?? "",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                  color: e["label"] == "Gym"
                                      ? Colors.white
                                      : const Color(0xff212121).withOpacity(.5),
                                  fontSize: 14.sp),
                        ),
                        selected: false,
                        onSelected: (selected) {},
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
