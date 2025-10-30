import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// final themeData = ThemeData(
//   useMaterial3: true,
//   textTheme: GoogleFonts.nunitoSansTextTheme(),
//   colorScheme: ColorScheme.fromSwatch(
//     primarySwatch: Colors.indigo,
//     accentColor: Colors.yellowAccent,
//   ),
//   visualDensity: VisualDensity.adaptivePlatformDensity,
// );

final themeData = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  textTheme: GoogleFonts.archivoTextTheme(),
  colorScheme: const ColorScheme.light(
    primary: Colors.black,
    secondary: Color(0xFFF5F5F5),
    surface: Colors.white,      // Replaced background
    surfaceContainer: Color(0xFFE0E0E0),    // Replaced surface
    onPrimary: Colors.white,
    onSecondary: Colors.black,
    onSurface: Colors.black,      // Replaced onBackground
  ),
);