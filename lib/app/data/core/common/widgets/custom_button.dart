
import 'package:flutter/material.dart';
import 'package:task_project/app/data/core/utils/constans/app_sizer.dart';

import '../../utils/constans/app_color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
        required this.onPressed,
        this.buttonColor = AppColors.primary,
        this.buttonTextColor = Colors.white,
        required this.title,
        this.borderColor,

        this.radius = 10.0, this.height = 44,

      });

  final VoidCallback onPressed;
  final dynamic buttonColor, borderColor; // Can be either Color or Gradient
  final Color buttonTextColor;
  final double radius, height;
  final String title;



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        //padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          gradient: buttonColor is Gradient ? buttonColor : null,
          // Use gradient if provided
          color: buttonColor is Color ? buttonColor : const Color(0xff403B3E),
          // Default color if no gradient is passed
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            width: 1,
            color: borderColor ??
                AppColors
                    .primary, // Use borderColor if provided or fallback to default
          ),
        ),
        child: Center(
          child:   Text(
            title,
            style: TextStyle(
              color: buttonTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              height: 22 / 16,
              letterSpacing: -0.6,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
    );
  }
}