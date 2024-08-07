import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecondryButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onPressed;
  final double? height;
  final double? width;
  final Widget? icon;
  const SecondryButton(
      {super.key,
      required this.buttonText,
      this.onPressed,
      this.height,
      this.width,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Center(
        child: Container(
          height: height ?? 45.h,
          width: width ?? double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xffFFFFFF),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: const Color(0xffE4E4E4),
              width: 1.w,
            ),
          ),
          child: Center(
            child: icon == null
                ? Text(
                    buttonText,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.grey),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon!,
                      SizedBox(width: 10.w),
                      Text(
                        buttonText,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: const Color(0xff212121).withOpacity(.5),
                            fontSize: 14.sp),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
