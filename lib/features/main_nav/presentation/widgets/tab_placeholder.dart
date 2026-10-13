import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Stand-in for tabs whose screens have not been designed yet.
class TabPlaceholder extends StatelessWidget {
  const TabPlaceholder({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: GoogleFonts.manrope(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.textGray800,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              AppText.comingSoon,
              style: GoogleFonts.manrope(fontSize: 14.sp, color: AppColors.neutral500),
            ),
          ],
        ),
      ),
    );
  }
}
