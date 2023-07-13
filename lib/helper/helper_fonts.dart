import 'package:flutter/material.dart';
import 'package:tif_assignment/helper/helper_font_height.dart';

class HelperFonts {
  static TextStyle title(Color color, double size, double height) => TextStyle(
        fontFamily: 'Inter',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w500,
        height: height.toFigmaHeight(size),
      );

  static TextStyle subTitle(Color color, double size, double height) =>
      TextStyle(
        fontFamily: 'Inter',
        color: color,
        fontSize: size,
        fontWeight: FontWeight.w400,
        height: height.toFigmaHeight(size),
      );
}
