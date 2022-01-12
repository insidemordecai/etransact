import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor kTeal = const MaterialColor(
    0xff009bad, // 0% - color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xff008c9c), //10%
      100: const Color(0xff007c8a), //20%
      200: const Color(0xff006d79), //30%
      300: const Color(0xff005d68), //40%
      400: const Color(0xff004e57), //50%
      500: const Color(0xff003e45), //60%
      600: const Color(0xff002e34), //70%
      700: const Color(0xff001f23), //80%
      800: const Color(0xff000f11), //90%
      900: const Color(0xff000000), //100%
    },
  );
}
