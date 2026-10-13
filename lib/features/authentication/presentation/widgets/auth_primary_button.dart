import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthPrimaryButton extends StatelessWidget {
  const AuthPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.usePoppins = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool usePoppins;

  @override
  Widget build(BuildContext context) {
    final labelStyle = usePoppins || isLoading
        ? GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            height: 24 / 16,
            color: Colors.white,
          )
        : GoogleFonts.manrope(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            height: 24 / 16,
            color: Colors.white,
          );

    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(14.r),
        child: SizedBox(
          height: 60.h,
          width: double.infinity,
          child: Center(
            child: isLoading
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const _Spinner(),
                      SizedBox(width: 12.w),
                      Text(AppText.submitting, style: labelStyle),
                    ],
                  )
                : Text(label, style: labelStyle),
          ),
        ),
      ),
    );
  }
}

class _Spinner extends StatefulWidget {
  const _Spinner();

  @override
  State<_Spinner> createState() => _SpinnerState();
}

class _SpinnerState extends State<_Spinner> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 1),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: SizedBox(
        width: 24.r,
        height: 24.r,
        child: Center(
          child: SvgPicture.asset(IconPath.loading, width: 21.r, height: 21.75.r),
        ),
      ),
    );
  }
}
