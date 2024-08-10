import 'dart:ffi';

import 'package:flutter/material.dart';

class AppConfigData {
  static const Color groundColor = Color.fromARGB(255, 29, 31, 30);
  static const Color iotDeviceColor = Color.fromARGB(255, 74, 73, 75);
  static const Color laserPointColor = Color.fromARGB(255, 9, 129, 39);
  static const Color laserPointTextColor = Color.fromARGB(255, 255, 255, 255);

  static const double laserPointDouble = 30.0;
  static const double iotDeviceDouble = 30.0;

  static const int radius = 4; //work area radius in meters 
  static const int diameter = 8; //work area diameter in meters 
}
