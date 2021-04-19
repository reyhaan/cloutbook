import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'dart:async';

class Debouncer {
  int? milliseconds = 0;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({
    this.milliseconds,
  });
  run(VoidCallback action) {
    if (_timer != null) {
      _timer?.cancel();
    }
    _timer = Timer(
        Duration(milliseconds: int.parse(milliseconds.toString())), action);
  }
}

Uint8List processDataImage(imageString) {
  final stripped = imageString?.replaceFirst(
      RegExp(r'data:image/[^;]+;base64,'), '') as String;
  return base64.decode(stripped);
}

class NumberFormatter {
  static String formatter(String currentBalance) {
    try {
      // suffix = {' ', 'k', 'M', 'B', 'T', 'P', 'E'};
      double value = double.parse(currentBalance);

      if (value >= 1000 && value < 1000000) {
        // less than a million
        double result = value / 1000;
        return result.toStringAsFixed(2) + "K";
      } else if (value >= 1000000 && value < (1000000 * 10 * 100)) {
        // less than 100 million
        double result = value / 1000000;
        return result.toStringAsFixed(2) + "M";
      } else if (value >= (1000000 * 10 * 100) &&
          value < (1000000 * 10 * 100 * 100)) {
        // less than 100 billion
        double result = value / (1000000 * 10 * 100);
        return result.toStringAsFixed(2) + "B";
      } else if (value >= (1000000 * 10 * 100 * 100) &&
          value < (1000000 * 10 * 100 * 100 * 100)) {
        // less than 100 trillion
        double result = value / (1000000 * 10 * 100 * 100);
        return result.toStringAsFixed(2) + "T";
      }
      return '';
    } catch (e) {
      throw e;
    }
  }
}
