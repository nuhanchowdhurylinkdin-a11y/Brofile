import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthBackButton extends StatelessWidget {
  const AuthBackButton({super.key, this.icon = IconPath.arrowBack});

  final String icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Get.back,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.all(8.r),
        child: SvgPicture.asset(icon, width: 24.r, height: 24.r),
      ),
    );
  }
}

class AuthStepIndicator extends StatelessWidget {
  const AuthStepIndicator({super.key, required this.activeStep, this.steps = 3});

  final int activeStep;
  final int steps;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(steps, (index) {
        return Container(
          width: 32.w,
          height: 4.h,
          margin: EdgeInsets.only(left: index == 0 ? 0 : 12.w),
          decoration: BoxDecoration(
            color: index == activeStep ? AppColors.primary : AppColors.stepInactive,
            borderRadius: BorderRadius.circular(2.r),
          ),
        );
      }),
    );
  }
}

/// "Prefix text + blue link" line used under the auth buttons.
class AuthLinkText extends StatelessWidget {
  const AuthLinkText({
    super.key,
    required this.prefix,
    required this.link,
    required this.onTap,
    this.usePoppins = false,
  });

  final String prefix;
  final String link;
  final VoidCallback onTap;
  final bool usePoppins;

  @override
  Widget build(BuildContext context) {
    final style = usePoppins
        ? GoogleFonts.poppins(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            height: 22 / 14,
            color: AppColors.gray800,
          )
        : GoogleFonts.manrope(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            height: 20 / 14,
            color: AppColors.gray800,
          );
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Text.rich(
        TextSpan(
          style: style,
          children: [
            TextSpan(text: prefix),
            TextSpan(text: link, style: const TextStyle(color: AppColors.link)),
          ],
        ),
      ),
    );
  }
}
