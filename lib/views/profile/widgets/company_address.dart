import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/spacev.dart';

class CompanyAddressWidget extends StatelessWidget {
  const CompanyAddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r), color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              children: [
                SvgPicture.asset("assets/icons/company_address_icon.svg"),
                SizedBox(width: 4.w),
                Text(
                  'Company Address',
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
            padding: EdgeInsets.all(16.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '13th Street. 47 W 13th St',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 14.sp, color: const Color(0xff95989C)),
                ),
                SpaceV(height: 8.h),
                Text(
                  'New York',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 14.sp, color: const Color(0xff95989C)),
                ),
                SpaceV(height: 8.h),
                Text(
                  '15205',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 14.sp, color: const Color(0xff95989C)),
                ),
                SpaceV(height: 8.h),
                Text(
                  'USA',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 14.sp, color: const Color(0xff95989C)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
