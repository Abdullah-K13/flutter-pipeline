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
          child: Container(
            color: const Color(0xffFEFBFC),
            child: CustomPaint(
              painter: GridAndDashedLinePainter(),
              child: Stack(
                children: List.generate(6, (index) {
                  final positions = ScreenUtil().screenWidth > 600
                      ? [
                          const Offset(0.14, 0.04),
                          const Offset(0.14, 0.23),
                          const Offset(0.65, 0.23),
                          const Offset(0.14, 0.57),
                          const Offset(0.40, 0.75),
                          const Offset(0.64, 0.57),
                        ]
                      : [
                          const Offset(0.12, 0.04),
                          const Offset(0.12, 0.20),
                          const Offset(0.57, 0.20),
                          const Offset(0.12, 0.48),
                          const Offset(0.34, 0.62),
                          const Offset(0.54, 0.50),
                        ];
                  return Positioned(
                    left: positions[index].dx * ScreenUtil().screenWidth.w,
                    top: positions[index].dy * ScreenUtil().screenWidth.w,
                    child: CircleAvatar(
                      radius: ScreenUtil().screenWidth > 600 ? 25.r : 16.r,
                      backgroundColor:
                          Theme.of(context).colorScheme.secondaryContainer,
                      child: Text(
                        (index + 1).toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:
                              ScreenUtil().screenWidth > 600 ? 20.sp : 14.sp,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
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
      ..color = const Color(0xffFF3480).withOpacity(.5)
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
      text: TextSpan(
        text: '1m',
        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
      ),
      textDirection: TextDirection.ltr,
    );

    // Draw text outside the grid, centered on the grid lines
    for (int i = 0; i <= 6; i++) {
      // Draw text at top outside grid
      textPainter.layout();
      textPainter.paint(
          canvas, Offset(size.width / 6 * i - textPainter.width / 2, -20.h));
    }

    for (int i = 0; i <= 6; i++) {
      // Draw text at left outside grid
      textPainter.layout();
      textPainter.paint(
          canvas, Offset(-20.w, size.height / 6 * i - textPainter.height / 2));
    }

    final dashedLinePaint = Paint()
      ..color = const Color(0xff17ACA1)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..moveTo(size.width * 0.2, size.height * 0.1)
      ..lineTo(size.width * 0.2, size.height * 0.3)
      ..lineTo(size.width * 0.8, size.height * 0.3)
      ..lineTo(size.width * 0.5, size.height * 0.5)
      ..lineTo(size.width * 0.2, size.height * 0.7)
      ..lineTo(size.width * 0.5, size.height * 0.9)
      ..lineTo(size.width * 0.8, size.height * 0.7);

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
