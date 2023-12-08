import 'package:bigdata_frontend_test/common/colors.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class StarShapePainter extends CustomPainter {
  final Paint _paint;

  StarShapePainter() : _paint = Paint()..color = PRIMARY_COLOR;

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double outerRadius = size.width / 2;
    final double innerRadius = size.width / 4; 
    final double startAngle = -math.pi / 2; 

    Path path = Path();
    final double angle = 2 * math.pi / 5; 

    for (int i = 0; i < 5; i++) {
      double outerX = centerX + outerRadius * math.cos(startAngle + i * angle);
      double outerY = centerY + outerRadius * math.sin(startAngle + i * angle);

      double innerX = centerX + innerRadius * math.cos(startAngle + (i + 0.5) * angle);
      double innerY = centerY + innerRadius * math.sin(startAngle + (i + 0.5) * angle);

      if (i == 0) {
        path.moveTo(outerX, outerY);
      } else {
        path.lineTo(outerX, outerY);
      }

      path.lineTo(innerX, innerY);
    }

    path.close();

    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
