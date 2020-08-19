import 'dart:math';
import 'package:flutter/material.dart';

class BurningPaperPainter extends CustomPainter {
  BurningPaperPainter({
    @required this.color,
    @required this.points,
  });

  Color color;
  List<double> points;

  @override
  void paint(Canvas canvas, Size size) {
    Path hole = Path();
    Path outline = Path();
    Offset center = Offset(size.width / 2, size.height / 2);

    _buildPaths(hole, outline, center);
    _paintPathsOnCanvas(size, outline, hole, canvas);
  }

  void _buildPaths(Path innerHole, Path outerHole, Offset center) {
    for (int i = 0; i < points.length; i++) {
      double point = points[i];
      double radians = pi / 180 * (i / points.length * 360);

      double cosine = cos(radians);
      double sinus = sin(radians);

      double xInner = sinus * point;
      double yInner = cosine * point - sinus;

      double outlineWidth = point * 1.02;

      double nxOuter = sinus * (outlineWidth);
      double nyOuter = cosine * (outlineWidth) - sinus;

      if (i == 0) {
        innerHole.moveTo(xInner + center.dx, yInner * -1 + center.dy);
        outerHole.moveTo(nxOuter + center.dx, nyOuter * -1 + center.dy);
      }

      innerHole.lineTo(xInner + center.dx, yInner * -1 + center.dy);
      outerHole.lineTo(nxOuter + center.dx, nyOuter * -1 + center.dy);
    }
  }

  void _paintPathsOnCanvas(Size size, Path hole, Path outline, Canvas canvas) {
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    Path holePath = Path.combine(
      PathOperation.difference,
      Path()..addRect(
        rect
      ),
      hole
    );

    Path outlinePath = Path.combine(
        PathOperation.difference,
        hole,
        outline
    );

    Paint shadowPaint = Paint()
      ..maskFilter = MaskFilter.blur(BlurStyle.outer, 32)
      ..color = Color(0xff966400);

    canvas.drawPath(holePath, Paint()..color = color);
    canvas.drawPath(hole, shadowPaint);
    canvas.drawPath(outlinePath, Paint()..color = Colors.black.withOpacity(0.5));
  }
  
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}