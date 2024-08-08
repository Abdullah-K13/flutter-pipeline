import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MultiGridAndDashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.pink
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Draw grid
    for (int i = 0; i <= 6; i++) {
      canvas.drawLine(Offset(size.width / 6 * i, 0),
          Offset(size.width / 6 * i, size.height), gridPaint);
      canvas.drawLine(Offset(0, size.height / 6 * i),
          Offset(size.width, size.height / 6 * i), gridPaint);
    }

    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    // Draw text centered within the grid boxes
    for (int i = 0; i < 6; i++) {
      // Draw X-axis labels at the top
      final xTextSpan = TextSpan(
        text: '${i + 1}m',
        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
      );
      textPainter.text = xTextSpan;
      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset(
              (size.width / 6) * i + (size.width / 12) - textPainter.width / 2,
              -16.h));
    }

    for (int i = 0; i < 6; i++) {
      // Draw Y-axis labels on the left
      final yTextSpan = TextSpan(
        text: '${i + 1}m',
        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
      );
      textPainter.text = yTextSpan;
      textPainter.layout();
      textPainter.paint(
          canvas,
          Offset(
              -24.w,
              size.height -
                  (size.height / 6) * i -
                  (size.height / 12) -
                  textPainter.height / 2));
    }

    // Draw circle
    final radius = size.width / 2;
    final center = Offset(size.width / 2, size.height / 2);
    final paintCircle = Paint()
      ..color = Colors.teal.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, paintCircle);

    // Draw center point
    final paintCenter = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 10.w, paintCenter);
    _drawText(canvas, center, '0', Colors.white);

    // Define the points and lines
    final points = [
      Offset(center.dx, center.dy - radius * 0.7), // Point 1
      Offset(center.dx - radius * 0.7, center.dy), // Point 2
      Offset(center.dx, center.dy + radius * 0.7), // Point 3
      Offset(center.dx + radius * 0.7, center.dy), // Point 4
      Offset(center.dx + radius * 0.3, center.dy - radius * 0.4), // Point 5
    ];

    // Draw dashed lines connecting points sequentially
    final dashedLinePaint = Paint()
      ..color = Colors.pink
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < points.length; i++) {
      _drawDashedLine(
          canvas, i == 0 ? center : points[i - 1], points[i], dashedLinePaint);
    }

    // Draw points
    for (int i = 0; i < points.length; i++) {
      canvas.drawCircle(points[i], 10.w, paintCircle);
      _drawText(canvas, points[i], (i + 1).toString(), Colors.white);
    }
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const int dashWidth = 5;
    const int dashSpace = 5;
    double distance = (end - start).distance;
    double dx = (end.dx - start.dx) / distance;
    double dy = (end.dy - start.dy) / distance;
    double startX = start.dx;
    double startY = start.dy;

    while (distance >= 0) {
      canvas.drawLine(Offset(startX, startY),
          Offset(startX + dx * dashWidth, startY + dy * dashWidth), paint);
      startX += dx * (dashWidth + dashSpace);
      startY += dy * (dashWidth + dashSpace);
      distance -= dashWidth + dashSpace;
    }
  }

  void _drawText(Canvas canvas, Offset position, String text, Color color) {
    final textStyle = TextStyle(
      color: color,
      fontSize: 14.sp,
    );
    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: double.infinity,
    );
    final offset = Offset(
      position.dx - textPainter.width / 2,
      position.dy - textPainter.height / 2,
    );
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
