import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class ThemeClass {

  static Color primaryColor = HexColor('#0076FF');
  static Color secondColor = HexColor('#4795EE');
  static Color thirdColor = HexColor('#006DEB');
  static Color fourthColor = HexColor('#20436B');
  static Color fifthColor = HexColor('#0056B8');

  static AppBarTheme appBarTema = AppBarTheme(
      color: HexColor('#1C1C1C'),
      centerTitle: true,
      titleTextStyle: GoogleFonts.oxanium(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold));

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: HexColor('#404040'),//HexColor('#333536'),
    colorScheme: ColorScheme.dark(),
    appBarTheme: appBarTema,
  );
}
