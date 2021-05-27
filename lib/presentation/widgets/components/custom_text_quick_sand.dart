import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextQuickSand extends StatelessWidget {
  final double size;
  final FontWeight weight;
  final FontStyle style;
  final Color color;
  final String text;
  final double spacing;
  final int maxLines;
  final TextOverflow overflow;
  CustomTextQuickSand(this.text,
      {this.size,
      this.overflow,
      this.weight,
      this.style,
      this.color,
      this.spacing,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.quicksand(
          fontSize: size,
          fontWeight: weight,
          height: spacing,
          fontStyle: style,
          color: color ?? Colors.white),
    );
  }
}
