import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeWidget extends StatelessWidget {
  const ThemeWidget({super.key});

  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(
      surface: Colors.black,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black87,
      iconTheme: IconThemeData(color: Colors.white),
      systemOverlayStyle: SystemUiOverlayStyle.light,
      toolbarTextStyle: TextStyle(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
    ),
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
