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

  double sectionAngle;

  int length;

  AnswerCircleSectionCustomPainter({
    @required this.index,
    @required this.section,
    @required this.sectionAngle,
    @required this.length,
  }) {
    _sectionPaint = Paint()..style = PaintingStyle.stroke;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _drawSection(canvas, size, sectionAngle);
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

    tempAngle = -sectionAngle;

    if (index >= 1) {
      tempAngle += (tempAngle * index);
    }

    final double sweepAngle = sectionDegree;

    canvas.drawArc(
      rect,
      radians(tempAngle),
      radians(sweepAngle),
      false,
      _sectionPaint,
    );

    if (length == 4) {
      for (int j = 0; j <= 40; j += 5) {
        path.arcTo(
          Rect.fromCircle(
            center: center,
            radius: _calculateCenterRadius(viewSize, CENTER_SPACE_RADIUS) + j,
          ),
          radians(tempAngle),
          radians(sweepAngle),
          false,
        );
      }
    } else {
      for (int j = -10; j <= 40; j += 5) {
        path.arcTo(
          Rect.fromCircle(
            center: center,
            radius: _calculateCenterRadius(viewSize, CENTER_SPACE_RADIUS) + j,
          ),
          radians(tempAngle - 5),
          radians(sweepAngle + 7),
          false,
        );
      }
    }
  }

  @override
  bool hitTest(Offset position) {
    return path.contains(position);
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
