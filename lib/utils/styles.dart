import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: Colors.green,
        onPrimary: const Color.fromARGB(255, 5, 111, 54),
        secondary: Colors.white,
      ),
);

const Color darkPrimaryColor = Color.fromARGB(255, 3, 96, 30);
const Color darkSecondaryColor = Color.fromARGB(255, 33, 231, 184);

ThemeData darkTheme = ThemeData.dark().copyWith(
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        primary: darkPrimaryColor,
        onPrimary: Colors.black,
        secondary: darkSecondaryColor,
      ),
);
