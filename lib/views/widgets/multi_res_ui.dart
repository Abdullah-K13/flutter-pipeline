import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gym_beam/views/widgets/multi_line%20painter.dart';

class MultiResponsiveUI extends StatelessWidget {
  const MultiResponsiveUI({super.key});

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
              final circleRadius = 10.r;
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
                  painter: MultiGridAndDashedLinePainter(),
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
                              fontSize: 14.sp,
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
