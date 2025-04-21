
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_project/app/data/core/utils/constans/app_sizer.dart';

import '../../utils/constans/app_color.dart';


class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextOverflow? textOverflow;
  final TextDecoration? decoration;
  final Color? decorationColor;

  final TextAlign? textAlign;
  const CustomText(
      {super.key,
        required this.text,
        this.maxLines,
        this.textOverflow,
        this.fontSize,
        this.color,
        this.fontWeight,
        this.decoration,
        this.decorationColor, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,
      text,

      style: GoogleFonts.poppins(
          decoration: decoration,
          decorationColor: decorationColor ?? const Color(0xffA59F92),
          fontSize: fontSize ?? 16.sp,
          //letterSpacing: 1,
          color: color ?? AppColors.textPrimary,
          fontWeight: fontWeight ?? FontWeight.w500),
      overflow: textOverflow,
      maxLines: maxLines,

    );
  }
}