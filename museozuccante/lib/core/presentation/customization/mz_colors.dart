import 'dart:math';

import 'package:flutter/material.dart';

/// Class that contains all the main appc olors
class MZColors {
  MZColors._();
  static Color get primary => const Color(0xff014343);
  static Color get errorColor => const Color(0xffE8431F);
  static Color get backgroundColor => const Color(0xffEDEEEE);
  static Color get alternativeBackgroundColor => const Color(0xffE5F4F4);

  static Color get ocra => const Color(0xffE5DCA5);
  static Color get black => const Color(0xff282928);
  static Color get pink => const Color(0xffE7CDC6);

  static Color get lightGrey => const Color(0xffbec2c2);

  static Color getColor(int index) {
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

    if (index > colors.length) {
      Random random = Random();
      int indexMaterial = random.nextInt(Colors.primaries.length - 1);
      return Colors.primaries[indexMaterial];
    }
    return colors[index];
  }

  static List<Color> getColorGradient(int index) {
    final colors = [
      [Colors.red, Colors.red[300]],
      [Colors.pink, Colors.pink[300]],
      [Colors.purple, Colors.purple[300]],
      [Colors.deepPurple, Colors.deepPurple[300]],
      [Colors.indigo, Colors.indigo[300]],
      [Colors.blue, Colors.blue[300]],
      [Colors.green, Colors.green[300]],
      [Colors.greenAccent, Colors.greenAccent[700]],
      [Colors.amber, Colors.amber[300]],
      [Colors.orange, Colors.orange[300]],
      [Colors.blue[900], Colors.blue[300]],
      [Colors.lightGreen, Colors.lightGreen[300]],
      [Colors.lightBlue, Colors.lightBlue[300]],
      [Colors.yellow[700], Colors.yellow[300]],
      [Colors.teal, Colors.teal[300]],
      [Colors.tealAccent, Colors.tealAccent[400]],
      [Colors.redAccent, Colors.redAccent[700]],
      [Colors.red, Colors.red[800]]
    ];

    if (index > colors.length) {
      Random random = Random();
      int indexMaterial = random.nextInt(Colors.primaries.length - 1);
      return [Colors.primaries[indexMaterial], Colors.primaries[indexMaterial]];
    }
    return colors[index];
  }
}
