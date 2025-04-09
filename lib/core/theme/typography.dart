import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTypography {
  static var titleSmall;

  static var bodySmall;

  static var font14Regular;

  static TextStyle _montserrat(
          {FontWeight? fontWeight,
          double? fontSize,
          double? letterSpacing,
          double? height}) =>
      GoogleFonts.montserrat(
              fontWeight: fontWeight,
              fontSize: fontSize,
              letterSpacing: letterSpacing,
              height: height)
          .copyWith(
        fontFeatures: <FontFeature>[
          const FontFeature.enable('lnum'),
          const FontFeature.enable('pnum'),
          const FontFeature.disable('liga'),
        ],
      );

  static TextStyle get font12RegularMontserrat => _montserrat(fontSize: 12);

  static TextStyle get font18RegularMontserrat => _montserrat(fontSize: 18);

  static TextStyle get font14RegularMontserrat => _montserrat(fontSize: 14);


  static TextStyle get font20RegularMontserrat => _montserrat(fontSize: 20);

  static TextStyle get font48RegularMontserrat => _montserrat(fontSize: 48);

  static TextStyle get font28RegularMontserrat => _montserrat(fontSize: 28);

  static TextStyle get font32RegularMontserrat => _montserrat(fontSize: 32);


}

extension Weights on TextStyle {
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get semibold => copyWith(fontWeight: FontWeight.w600);

  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  TextStyle get heavy => copyWith(fontWeight: FontWeight.w800);
}