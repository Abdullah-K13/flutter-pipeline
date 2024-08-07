import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpaceV extends StatelessWidget {
  final double? height;
  final double? width;
  const SpaceV({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 16.h,
      width: width,
    );
  }
}
