import 'dart:math' as math;

import 'package:dartz/dartz.dart' show Tuple2;
import 'package:flutter/material.dart';
import 'package:gioco/game/presentation/widget/section.dart';

typedef OnCorrectAnswer(Color color);

/// Correct answer, User given answer
typedef OnWrongAnswer(Tuple2<Color, Color> wrongAndCorrectColor);

class AnswerCircleSectionCustomPainter extends CustomPainter {
  static const double CENTER_SPACE_RADIUS = 120.0;

  static const double DEGREES_TO_RADIANTS = math.pi / 180.0;

  Paint _sectionPaint;

  Section section;

  int index;

  Path path;

  AnswerCircleSectionCustomPainter({
    @required this.index,
    @required this.section,
  }) {
    _sectionPaint = Paint()..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _drawSection(canvas, size, 90);
  }

  void _drawSection(Canvas canvas, Size viewSize, double sectionAngle) {
    final Offset center = Offset(viewSize.width / 2, viewSize.height / 2);

    path = Path();
    double tempAngle = 0;

    final sectionDegree = sectionAngle;

    final rect = Rect.fromCircle(
      center: center,
      radius: _calculateCenterRadius(viewSize, CENTER_SPACE_RADIUS) + (30 / 2),
    );

    _sectionPaint.color = section.color;
    _sectionPaint.strokeWidth = section.radius;

    if (index == 0) {
      tempAngle = -90;
    } else if (index == 1) {
      tempAngle = 0;
    } else if (index == 2) {
      tempAngle = 90;
    } else {
      tempAngle = 180;
    }
    final double sweepAngle = sectionDegree;
    canvas.drawArc(
      rect,
      radians(tempAngle),
      radians(sweepAngle),
      false,
      _sectionPaint,
    );

    double tempPath = tempAngle - 15;
    double tempSweep = sweepAngle + 15;
    path.arcTo(
      Rect.fromCircle(
        center: center,
        radius: _calculateCenterRadiusPath(viewSize, 165.0),
      ),
      radians(tempPath),
      radians(tempSweep),
      false,
    );
  }

  @override
  bool hitTest(Offset position) {
    print(path.contains(position));
    return path.contains(position);
  }

  double _calculateCenterRadiusPath(Size viewSize, double givenCenterRadius) {
    if (!givenCenterRadius.isInfinite) {
      return givenCenterRadius;
    }

    double maxRadius = 0;
    if (section.radius > maxRadius) {
      maxRadius = section.radius;
    }

    final minWidthHeight = math.min(viewSize.width, viewSize.height);
    final centerRadius = (minWidthHeight - (maxRadius * 2)) / 2;
    return centerRadius;
  }

  double _calculateCenterRadius(Size viewSize, double givenCenterRadius) {
    if (!givenCenterRadius.isInfinite) {
      return givenCenterRadius;
    }

    double maxRadius = 0;
    if (section.radius > maxRadius) {
      maxRadius = section.radius;
    }

    final minWidthHeight = math.min(viewSize.width, viewSize.height);
    final centerRadius = (minWidthHeight - (maxRadius * 2)) / 2;
    return centerRadius;
  }

  double radians(double degrees) => degrees * DEGREES_TO_RADIANTS;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
