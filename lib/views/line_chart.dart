import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveUI extends StatelessWidget {
  const ResponsiveUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w), // Responsive padding
      child: Center(
        child: AspectRatio(
          aspectRatio: 1,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final height = constraints.maxHeight;
              final circleRadius = 20.r;
              final positions = [
                Offset(width * 1 / 6, height * 1 / 6),
                Offset(width * 1 / 6, height * 2 / 6),
                Offset(width * 2 / 6, height * 2 / 6),
                Offset(width * 2 / 6, height * 3 / 6),
                Offset(width * 1 / 6, height * 4 / 6),
                Offset(width * 1 / 6, height * 5 / 6),
                Offset(width * 2 / 6, height * 5 / 6),
                Offset(width * 2 / 6, height * 6 / 6),
                Offset(width * 5 / 6, height * 6 / 6),
              ];

              return Container(
                color: Colors.white,
                child: CustomPaint(
                  painter: GridAndDashedLinePainter(),
                  child: Stack(
                    children: positions.map((position) {
                      return Positioned(
                        left: position.dx -
                            circleRadius, // Centering the circle horizontally
                        top: position.dy -
                            circleRadius, // Centering the circle vertically
                        child: CircleAvatar(
                          radius: circleRadius,
                          backgroundColor:
                              Theme.of(context).colorScheme.secondaryContainer,
                          child: Text(
                            '${positions.indexOf(position) + 1}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class GridAndDashedLinePainter extends CustomPainter {
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

    final dashedLinePaint = Paint()
      ..color = const Color(0xff17ACA1)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(size.width * 1 / 6, size.height * 1 / 6)
      ..lineTo(size.width * 1 / 6, size.height * 2 / 6)
      ..lineTo(size.width * 2 / 6, size.height * 2 / 6)
      ..lineTo(size.width * 2 / 6, size.height * 3 / 6)
      ..lineTo(size.width * 1 / 6, size.height * 4 / 6)
      ..lineTo(size.width * 1 / 6, size.height * 5 / 6)
      ..lineTo(size.width * 2 / 6, size.height * 5 / 6)
      ..lineTo(size.width * 2 / 6, size.height * 6 / 6)
      ..lineTo(size.width * 5 / 6, size.height * 6 / 6);

    final dashedPath = _createDashedPath(path, 10.w);
    canvas.drawPath(dashedPath, dashedLinePaint);
  }

  Path _createDashedPath(Path originalPath, double dashLength) {
    final path = Path();
    double distance = 0.0;
    for (var metric in originalPath.computeMetrics()) {
      while (distance < metric.length) {
        final offset = metric.getTangentForOffset(distance);
        if (offset == null) break;
        path.addOval(Rect.fromCircle(center: offset.position, radius: 1.w));
        distance += dashLength;
      }
    }
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
