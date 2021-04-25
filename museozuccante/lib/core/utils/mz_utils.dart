import 'dart:math';

class MZUtils {
  static int getRandomNumber() {
    Random random = Random();
    int randomNumber = random.nextInt(999999);
    return randomNumber;
  }
}
