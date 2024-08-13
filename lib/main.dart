import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/theme.dart';
import 'views/Bluetooth_screen.dart';
import 'views/register_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final bool isTablet = constraints.maxWidth > 600;

      return ScreenUtilInit(
        designSize: isTablet ? const Size(768, 1024) : const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
            title: 'Gym-Beam',
            theme: themeLight(context),
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: BluetoothDevicePage(),
          );
        },
      );
    });
  }
}
