import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config_data.dart';


class GridAndDashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.pink
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Draw grid
    for (int i = 0; i <= AppConfigData.diameter; i++) {
      canvas.drawLine(Offset(size.width / AppConfigData.diameter * i, 0),
          Offset(size.width / AppConfigData.diameter * i, size.height), gridPaint);
      canvas.drawLine(Offset(0, size.height / AppConfigData.diameter * i),
          Offset(size.width, size.height / AppConfigData.diameter * i), gridPaint);
    }

    final textPainter = TextPainter(
      text: TextSpan(

        text: '1m',
        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
      ),
      textDirection: TextDirection.ltr,
    );

    // Draw text outside the grid, centered on the grid lines
    for (int i = 0; i <= AppConfigData.diameter; i++) {
      // Draw text at top outside grid
      textPainter.layout();
      textPainter.paint(
          canvas, Offset(size.width / AppConfigData.diameter * i - textPainter.width / 2, -20.h));
    }

    for (int i = 0; i <= 12; i++) {
      // Draw text at left outside grid
      textPainter.layout();
      textPainter.paint(
          canvas, Offset(-20.w, size.height / AppConfigData.diameter * i - textPainter.height / 2));
    }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}


class LinePainter extends CustomPainter {
  final Offset start;
  final Offset end;

  LinePainter({required this.start, required this.end});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromARGB(255, 66, 64, 64)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }




}
