import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ThemeFonts {
  static double headerFontSize = 18.0;
  static double defaultFontSize = 20.0;
  static double logReg = 58.0;

  static TextStyle textTitleDict = GoogleFonts.cinzel(
      fontSize: defaultFontSize,
      fontWeight: FontWeight.w300,
    color: Colors.white
      );

  static TextStyle textStyle200 = GoogleFonts.roboto(
      fontSize: defaultFontSize,
      fontWeight: FontWeight.w600,
      );

  static TextStyle textStyle300 = GoogleFonts.poppins(
      fontSize: defaultFontSize,
      fontWeight: FontWeight.w300,
      );

  static TextStyle textItem = GoogleFonts.poppins(
      fontSize: defaultFontSize,
      fontWeight: FontWeight.w300,
      );

  static TextStyle textStyle400 = GoogleFonts.balooPaaji(
    fontSize: logReg,
    fontWeight: FontWeight.w400,
  );

  static TextStyle textApk = GoogleFonts.viga(
      fontSize: defaultFontSize,
      fontWeight: FontWeight.w500,
      );

  static TextStyle tPrice = GoogleFonts.anton(
    fontSize: defaultFontSize,
    fontWeight: FontWeight.w500,
  );
}