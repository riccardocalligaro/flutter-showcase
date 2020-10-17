import 'package:flutter/material.dart';

/// A quarter of the circle
/// This rapresents a possible [answer]
class Section {
  final Color color;
  final double radius;

  Section({
    @required this.color,
    @required this.radius,
  })  : assert(color != null),
        assert(radius != null);

  @override
  String toString() => 'Section(color: $color, radius: $radius)';
}
