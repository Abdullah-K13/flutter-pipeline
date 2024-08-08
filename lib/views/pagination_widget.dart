import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaginationWidget extends StatelessWidget {
  const PaginationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.r,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 66.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: const Color(0xffE4E5E6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.r),
                bottomLeft: Radius.circular(15.r),
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios,
                color: Color(0xff95989C),
              ),
            ),
          ),
          _buildPageButton("Run 1", true),
          _buildPageButton("2", false),
          _buildPageButton("3", false),
          _buildPageButton("4", false),
          _buildPageButton("5", false),
          Container(
            height: 66.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: const Color(0xff17ACA1).withOpacity(.2),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(15.r),
                bottomRight: Radius.circular(15.r),
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xff005F58),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageButton(String text, bool isSelected) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
              color: isSelected
                  ? const Color(0xff17ACA1)
                  : const Color(0xffE4E5E6),
              width: 1.w),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.teal : Colors.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
