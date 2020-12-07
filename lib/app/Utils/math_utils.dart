import 'dart:math';

class MathUtils {
  static round({double number, int decimalPlaces}) {
    return (number * pow(10, decimalPlaces)).round() / pow(10, decimalPlaces);
  }
}
