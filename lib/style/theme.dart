import 'dart:ui';

import 'package:flutter/cupertino.dart';

class MyColors {
  const MyColors();

  static const Color loginGradientEnd = const Color(0xFF008c83);
  static const Color loginGradientStart = const Color(0xFF76e1cd);
  static const Color cardBackground = const Color(0xFF76e1cd);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
