import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormSection extends StatelessWidget {
  final String title;
  final bool? isShowPadding;
  const FormSection(
      {super.key, required this.title, this.isShowPadding = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: isShowPadding == true ? 16.h : 0.h),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: const Color(0xff000000).withOpacity(.2),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: const Color(0xff212121), fontSize: 14.sp),
            ),
          ),
          Expanded(
            child: Divider(
              color: const Color(0xff000000).withOpacity(.2),
            ),
          ),
        ],
      ),
    );
  }
}
