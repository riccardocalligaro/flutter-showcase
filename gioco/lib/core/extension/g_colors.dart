import 'dart:math';

import 'package:flutter/material.dart';

class GColors {
  static Color get primary => Color(0xff121212);

  static List<Color> getRandomList(int length) {
    List<Color> generatedColors = [];

    Color color = getRandom();

    for (int i = 0; i < length; i++) {
      while ((generatedColors.singleWhere((it) => it.value == color.value,
              orElse: () => null)) !=
          null) {
        color = getRandom();
      }
      generatedColors.add(color);
    }

    return generatedColors;
  }

  static Color getRandom() {
    Random random = Random();

    // final colors = [
    //   Colors.red,
    //   Colors.pink,
    //   Colors.purple,
    //   Colors.deepPurple,
    //   Colors.indigo,
    //   Colors.blue,
    //   Colors.green,
    //   Colors.greenAccent,
    //   Colors.amber,
    //   Colors.orange,
    //   Colors.blue[900],
    //   Colors.lightGreen,
    //   Colors.lightBlue,
    //   Colors.yellow[700],
    //   Colors.teal,
    //   Colors.tealAccent,
    //   Colors.redAccent,
    //   Colors.red
    // ];

    final colors = [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.indigo,
      Colors.blue,
      Colors.green,
      Colors.greenAccent,
      Colors.amber,
      Colors.orange,
      Colors.cyan,
      Colors.lime,
      Colors.lightGreenAccent,
      Colors.brown,
    ];

    int indexMaterial = random.nextInt(colors.length - 1);

    return colors[indexMaterial];
  }
}
