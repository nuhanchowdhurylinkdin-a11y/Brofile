import 'dart:ui';

import 'package:brofile/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthBadge extends StatelessWidget {
  const AuthBadge({
    super.key,
    required this.image,
    this.backgroundColor = AppColors.primary100,
    this.showGlow = false,
  });

  final String image;
  final Color backgroundColor;
  final bool showGlow;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (showGlow)
          Positioned(
            left: 3.5.w,
            top: 35.h,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 22.r, sigmaY: 22.r),
              child: Container(
                width: 49.w,
                height: 32.h,
                color: AppColors.highlight,
              ),
            ),
          ),
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(25.r),
          ),
          child: Image.asset(image, width: 70.r, height: 70.r, fit: BoxFit.cover),
        ),
      ],
    );
  }
}

class AuthTitle extends StatelessWidget {
  const AuthTitle({
    super.key,
    required this.title,
    required this.subtitle,
    this.subtitleStyle,
    this.subtitleLineGap = 0,
  });

  final String title;
  final String subtitle;
  final TextStyle? subtitleStyle;

  /// Extra space between explicit (`\n`) subtitle lines.
  final double subtitleLineGap;

  @override
  Widget build(BuildContext context) {
    final style = subtitleStyle ??
        GoogleFonts.manrope(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          height: 20 / 14,
          color: AppColors.gray700,
        );
    final lines = subtitleLineGap > 0 ? subtitle.split('\n') : [subtitle];

    return Column(
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
        SizedBox(height: 16.h),
        for (var i = 0; i < lines.length; i++) ...[
          if (i > 0) SizedBox(height: subtitleLineGap),
          Text(lines[i], textAlign: TextAlign.center, style: style),
        ],
      ],
    );
  }
}
