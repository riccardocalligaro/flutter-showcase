import 'dart:math';

import 'package:flutter/material.dart';

/// Class that contains all the main appc olors
class MColors {
  MColors._();

  static Color get primary => const Color(0xff2E83F8);
  static Color get titleColor => const Color(0xff223D6C); //2E4773
  static Color get extraLightText => const Color(0xffD8D8D8);
  static Color get lightText => const Color(0xffACACAC);
  static Color get facebookColor => const Color(0xff3A569B);
  static Color get errorColor => const Color(0xffE8431F);
  static Color get bgColor => const Color(0xfff5f8fa);

  static Color get greyBlue => const Color(0xffF5F4F8);
  static Color get lightPurple => const Color(0xff97AFF3);
  static Color get darkYellow => const Color(0xffFEC106);
  static Color get softGreyText => Colors.grey[700];
  static Color get lightOrange => const Color(0xffF28E1A);
  static Color get darkGrey => const Color(0xff484A54);

  static Color get blue => Colors.blue;
  static Color get orange => Colors.orange;
  static Color get red => Colors.red;
  static Color get purple => Colors.purpleAccent;
  static Color get blueGrey => Colors.blueGrey;

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
