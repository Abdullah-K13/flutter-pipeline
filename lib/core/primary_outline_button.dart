import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryOutlineButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onPressed;
  final double? height;
  final double? width;
  const PrimaryOutlineButton({
    super.key,
    required this.buttonText,
    this.onPressed,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Center(
        child: Container(
          height: height ?? 45.h,
          width: width ?? double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary,
              width: 1.w,
            ),
          ),
          child: Center(
            child: Text(
              buttonText,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
        ),
      ),
    );
  }
}
