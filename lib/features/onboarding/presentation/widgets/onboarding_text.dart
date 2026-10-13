import 'package:brofile/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingText extends StatelessWidget {
  const OnboardingText({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: 30.sp,
            fontWeight: FontWeight.w700,
            height: 38 / 30,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 4.r),
        Text(
          description,
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            height: 24 / 16,
            color: AppColors.textGray800,
          ),
        ),
      ],
    );
  }
}
