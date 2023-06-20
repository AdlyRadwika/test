import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const ColorScheme myColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0XFF006992),
  onPrimary: Colors.white,
  secondary: Color(0xff27476e),
  onSecondary: Colors.white,
  error: Color(0xffd21400),
  onError: Colors.white,
  background: Colors.white,
  onBackground: Color(0XFF243240),
  surface: Color(0xffbacbff),
  onSurface: Colors.black12,
);

final TextTheme myTextTheme = TextTheme(
  displayLarge: GoogleFonts.poppins(
      fontSize: 93, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  displayMedium: GoogleFonts.poppins(
      fontSize: 58, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  displaySmall: GoogleFonts.poppins(fontSize: 46, fontWeight: FontWeight.w400),
  headlineMedium: GoogleFonts.poppins(
      fontSize: 33, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headlineSmall: GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400),
  titleLarge: GoogleFonts.poppins(
      fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  titleMedium: GoogleFonts.poppins(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  titleSmall: GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyLarge: GoogleFonts.poppins(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyMedium: GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  labelLarge: GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  bodySmall: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  labelSmall: GoogleFonts.poppins(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

ThemeData myThemeData = ThemeData(
    colorScheme: myColorScheme,
    textTheme: myTextTheme,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.white,
      selectionColor: Colors.white.withOpacity(0.5),
      selectionHandleColor: Colors.grey,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: myColorScheme.primary,
      selectedItemColor: myColorScheme.onPrimary,
      unselectedItemColor: myColorScheme.secondary,
    ),
);