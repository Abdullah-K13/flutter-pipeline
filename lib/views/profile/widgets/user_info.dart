import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_beam/views/profile/screens/edit_profile.dart';
import '../../../core/spacev.dart';

class UserInfoWidget extends StatelessWidget {
  final bool isEditProfile;
  const UserInfoWidget({super.key, required this.isEditProfile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          SpaceV(height: 23.h),
          Container(
            height: 120.h,
            width: 120.w,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/place_holder.png"),
              ),
            ),
          ),
          Text(
            "Jasmine",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontSize: 18.sp),
          ),
          Text(
            "jasmine0056",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontSize: 14.sp),
          ),
          SpaceV(height: 7.h),
          if (isEditProfile)
            InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const EditProfileScreen(),
                ),
              ),
              child: Container(
                width: 143.w,
                height: 48.h,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: ShapeDecoration(
                  color: const Color(0x0CFF3480),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0x19FF3480)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/edit_icon.svg"),
                    SizedBox(width: 9.w),
                    Text(
                      "Edit Profile",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontSize: 16.sp),
                    )
                  ],
                ),
              ),
            ),
          SpaceV(height: 25.h),
          Row(
            children: [
              SvgPicture.asset(
                "assets/icons/phone_icon.svg",
                height: 20.h,
                width: 20.h,
              ),
              SizedBox(width: 12.w),
              Text(
                "98745678944",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14.sp,
                      color: const Color(0xff212121).withOpacity(.5),
                    ),
              ),
              SizedBox(width: 12.w),
              Image.asset(
                "assets/icons/verified_icon.png",
                height: 20.h,
                width: 20.h,
              ),
            ],
          ),
          const SpaceV(),
          Row(
            children: [
              SvgPicture.asset(
                "assets/icons/email_icon.svg",
                height: 20.h,
                width: 20.h,
              ),
              SizedBox(width: 12.w),
              Text(
                "JasminePhillips@gmail.com",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14.sp,
                      color: const Color(0xff212121).withOpacity(.5),
                    ),
              ),
              SizedBox(width: 12.w),
              Image.asset(
                "assets/icons/unverified_icon.png",
                height: 20.h,
                width: 20.h,
              ),
            ],
          ),
          SpaceV(height: 24.h),
        ],
      ),
    );
  }
}
