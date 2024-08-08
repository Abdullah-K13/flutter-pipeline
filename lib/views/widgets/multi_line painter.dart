import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math';

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
        text: '1m',
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
        text: '1m',
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

    // Draw circle with increased transparency
    final radius = size.width / 2.2;
    final center = Offset(size.width / 2, size.height / 2);
    final paintCircle = Paint()
      ..color = Colors.teal.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, paintCircle);

    // Draw circle outline covering 4/5 of the circumference
    final paintOutline = Paint()
      ..color = Colors.teal
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromCircle(center: center, radius: radius);
    const startAngle = -0.5 * pi;
    const sweepAngle = 1.6 * pi;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paintOutline);

    // Draw starting pointer on the outline
    final endAngle = startAngle + sweepAngle;
    final startPoint = Offset(
      center.dx + radius * cos(endAngle),
      center.dy + radius * sin(endAngle),
    );
    final paintStartPointer = Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.fill;

    canvas.drawCircle(startPoint, 6.w, paintStartPointer);
    final paintStartPointerOutline = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(startPoint, 6.w, paintStartPointerOutline);

    // Draw the pink outline circle with increased transparency
    final pinkOutlinePaint = Paint()
      ..color = Colors.pink.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.w;

    final outlineRadius = 20.w;

    canvas.drawCircle(center, outlineRadius, pinkOutlinePaint);

    // Draw the inner circle with pink background and "0"
    final pinkBackgroundPaint = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.fill;

    final innerCircleRadius = 14.w;

    canvas.drawCircle(center, innerCircleRadius, pinkBackgroundPaint);

    _drawText(canvas, center, '0', Colors.white);

    // Define the points and lines
    final points = [
      Offset(center.dx, center.dy - radius * 0.6), // Point 1
      Offset(center.dx - radius * 0.6, center.dy), // Point 2
      Offset(center.dx, center.dy + radius * 0.6), // Point 3
      Offset(center.dx + radius * 0.6, center.dy), // Point 4
      Offset(center.dx + radius * 0.3, center.dy - radius * 0.4), // Point 5
    ];

    // Draw dashed lines connecting points sequentially with increased transparency
    final dashedLinePaint = Paint()
      ..color = Colors.pink.withOpacity(0.5)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < points.length; i++) {
      _drawDashedLine(
          canvas, i == 0 ? center : points[i - 1], points[i], dashedLinePaint);
    }

    // Draw points
    final paintPoint = Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.fill;

    for (int i = 0; i < points.length; i++) {
      canvas.drawCircle(points[i], 10.w, paintPoint);
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
      fontWeight: FontWeight.bold,
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
