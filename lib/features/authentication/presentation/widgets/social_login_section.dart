import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({
    super.key,
    required this.onFacebook,
    required this.onGoogle,
  });

  final VoidCallback onFacebook;
  final VoidCallback onGoogle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _SocialButton(
                icon: SvgPicture.asset(IconPath.facebook, width: 24.r, height: 24.r),
                label: AppText.facebook,
                onTap: onFacebook,
              ),
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: _SocialButton(
                icon: SizedBox(
                  width: 24.r,
                  height: 24.r,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SvgPicture.asset(IconPath.google, width: 23.52.r, height: 24.r),
                  ),
                ),
                label: AppText.google,
                onTap: onGoogle,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        const _OrDivider(),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final Widget icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.inputFill,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: SizedBox(
          height: 60.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              SizedBox(width: 16.w),
              SizedBox(
                width: 91.w,
                child: Text(
                  label,
                  style: GoogleFonts.manrope(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    height: 24 / 16,
                    color: AppColors.gray700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    final line = Expanded(
      child: SvgPicture.asset(
        IconPath.dividerLine,
        height: 1,
        fit: BoxFit.fill,
      ),
    );
    return Row(
      children: [
        line,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 11.w),
          child: Text(
            AppText.or,
            style: GoogleFonts.manrope(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              height: 20 / 14,
              color: AppColors.gray900,
            ),
          ),
        ),
        line,
      ],
    );
  }
}
