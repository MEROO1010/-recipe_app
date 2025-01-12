// lib/ui/fonts/fonts.dart
import 'package:flutter/material.dart';

class AppFonts {
  static const String primaryFont = 'Roboto';

  static const TextStyle headline1 = TextStyle(
    fontFamily: primaryFont,
    fontWeight: FontWeight.bold,
    fontSize: 32.0,
  );

  static const TextStyle headline2 = TextStyle(
    fontFamily: primaryFont,
    fontWeight: FontWeight.bold,
    fontSize: 24.0,
  );

  static const TextStyle bodyText1 = TextStyle(
    fontFamily: primaryFont,
    fontWeight: FontWeight.normal,
    fontSize: 16.0,
  );

  static const TextStyle bodyText2 = TextStyle(
    fontFamily: primaryFont,
    fontWeight: FontWeight.normal,
    fontSize: 14.0,
  );
}
