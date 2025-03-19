import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTypography {
  static var titleSmall;

  static var bodySmall;

  static TextStyle _zillaSlab(
          {FontWeight? fontWeight,
          double? fontSize,
          double? letterSpacing,
          double? height}) =>
      GoogleFonts.zillaSlab(
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

static TextStyle _unbounded(
          {FontWeight? fontWeight,
          double? fontSize,
          double? letterSpacing,
          double? height}) =>
      GoogleFonts.unbounded(
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

  static TextStyle get font12RegularZillaSlab => _zillaSlab(fontSize: 12);

  static TextStyle get font18RegularZillaSlab => _zillaSlab(fontSize: 18);

  static TextStyle get font20RegularZillaSlab => _zillaSlab(fontSize: 20);

  static TextStyle get font48RegularZillaSlab => _zillaSlab(fontSize: 48);

  static TextStyle get font28RegularZillaSlab => _zillaSlab(fontSize: 28);

  static TextStyle get font28RegularUnbounded => _unbounded(fontSize: 28);

}

extension Weights on TextStyle {
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get semibold => copyWith(fontWeight: FontWeight.w600);

  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  TextStyle get heavy => copyWith(fontWeight: FontWeight.w800);
}


