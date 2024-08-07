import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Light theme
ThemeData themeLight(BuildContext context) => ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        background: Color(0xffE9F8F7),
        onBackground: Color(0xffCFEDEB),
        primary: Color(0xff005F58),
        onPrimary: Color(0xff111928),
        primaryContainer: Color(0xffE1E0FF),
        onPrimaryContainer: Color(0xff07006C),
        surface: Color(0xffF9FAFB),
        onSurface: Color(0xff111928),
        onSurfaceVariant: Color(0xff3E536E),
        outline: Color(0xffE4E5E6),
        outlineVariant: Color(0xffAEBED1),
        inverseSurface: Color(0xff1F2A37),
        onInverseSurface: Color(0xffF3F4F6),
        inversePrimary: Color(0xffC1C1FF),
        scrim: Color(0xff000000),
        shadow: Color(0xff000000),
        secondary: Color(0xffFF3480),
        onSecondary: Color(0xffFFFFFF),
        secondaryContainer: Color(0xff17ACA1),
        onSecondaryContainer: Color(0xff1B1D00),
        tertiary: Color(0xffB52700),
        onTertiary: Color(0xffFFFFFF),
        tertiaryContainer: Color(0xffFFDAD2),
        onTertiaryContainer: Color(0xff3D0700),
        error: Color(0xffBA1A1A),
        onError: Color(0xffFFFFFF),
        errorContainer: Color(0xffFFDAD6),
        onErrorContainer: Color(0xff410002),
      ),
      useMaterial3: true,
      brightness: Brightness.light,
      textTheme: TextTheme(
        bodySmall: TextStyle(
          fontFamily: "Nunito-Regular",
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
        bodyMedium: TextStyle(
          fontFamily: "Nunito-Medium",
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
        ),
        bodyLarge: TextStyle(
          fontFamily: "Nunito-Bold",
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.50,
        ),
        labelSmall: TextStyle(
          fontFamily: "Nunito-Regular",
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
        ),
        labelMedium: TextStyle(
          fontFamily: "Nunito-Medium",
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
        labelLarge: TextStyle(
          fontFamily: "Nunito-Bold",
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.10,
        ),
        titleSmall: TextStyle(
          fontFamily: "Nunito-Regular",
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.10,
        ),
        titleMedium: TextStyle(
          fontFamily: "Nunito-Medium",
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
        ),
        titleLarge: TextStyle(
          fontFamily: "Nunito-Bold",
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
        // headlineSmall: TextStyle(
        //   fontFamily: "Nunito-Regular",
        //   fontSize: 24.sp,
        //   fontWeight: FontWeight.w800,
        // ),
        // headlineMedium: TextStyle(
        //   fontSize: 28.sp,
        //   fontFamily: "Nunito-Medium",
        //   fontWeight: FontWeight.w800,
        // ),
        // headlineLarge: TextStyle(
        //   fontFamily: "Nunito-Bold",
        //   fontSize: 32.sp,
        //   fontWeight: FontWeight.w800,
        // ),
        displaySmall: TextStyle(
          fontFamily: "Nunito-Regular",
          fontSize: 36.sp,
          fontWeight: FontWeight.w800,
        ),
        displayMedium: TextStyle(
          fontFamily: "Nunito-Medium",
          fontSize: 45.sp,
          fontWeight: FontWeight.w800,
        ),
        displayLarge: TextStyle(
          fontFamily: "Nunito-Bold",
          fontSize: 57.sp,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.25,
        ),
      ),
      iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSurfaceVariant, size: 15.r),
      chipTheme: ChipThemeData(
        labelStyle: Theme.of(context).textTheme.labelMedium,
        iconTheme: Theme.of(context).iconTheme,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        selectedColor: Theme.of(context).colorScheme.secondaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
            width: 1.r,
          ),
        ),
      ),
    );
