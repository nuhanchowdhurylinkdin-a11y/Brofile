import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/helpers/app_platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthBackButton extends StatelessWidget {
  const AuthBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: AppBackButton(onTap: Get.back),
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
