import 'dart:math';

import 'package:flutter/material.dart';

class GColors {
  static List<Color> getRandomList(int length) {
    List<Color> generatedColors = [];

    Color color = getRandom();

    for (int i = 0; i < length; i++) {
      while ((generatedColors.singleWhere((it) => it.value == color.value,
              orElse: () => null)) !=
          null) {
        color = getRandom();
      }
      generatedColors.add(getRandom());
    }

    return generatedColors;
  }

  static Color getRandom() {
    Random random = Random();

    final colors = [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.green,
      Colors.greenAccent,
      Colors.amber,
      Colors.orange,
      Colors.blue[900],
      Colors.lightGreen,
      Colors.lightBlue,
      Colors.yellow[700],
      Colors.teal,
      Colors.tealAccent,
      Colors.redAccent,
      Colors.red
    ];
    int indexMaterial = random.nextInt(colors.length - 1);

    return colors[indexMaterial];
  }
}