import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Pill that toggles between "Join" and "Joined".
class JoinButton extends StatelessWidget {
  const JoinButton({
    super.key,
    required this.isJoined,
    required this.onTap,
    required this.height,
    this.width,
    this.fontSize = 14,
    this.weight = FontWeight.w600,
    this.radius = 30,
    this.light = false,
    this.outlined = false,
  });

  final bool isJoined;
  final VoidCallback onTap;
  final double height;
  final double? width;
  final double fontSize;
  final FontWeight weight;
  final double radius;

  /// White pill with primary text, used on top of imagery.
  final bool light;

  /// Adds the subtle 2px white ring.
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    final background = switch ((light, isJoined)) {
      (true, _) => Colors.white,
      (false, true) => AppColors.joined,
      (false, false) => AppColors.primary,
    };
    final foreground = !light
        ? Colors.white
        : isJoined
        ? AppColors.joined
        : AppColors.primary;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: width?.w,
        height: height.w,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(radius.r),
          border: outlined
              ? Border.all(color: const Color(0x1FFFFFFF), width: 2)
              : null,
        ),
        child: Center(
          widthFactor: 1,
          child: Text(
            isJoined ? AppText.joined : AppText.join,
            maxLines: 1,
            style: manrope(
              fontSize,
              weight: weight,
              color: foreground,
              lineHeight: fontSize + 6,
            ),
          ),
        ),
      ),
    );
  }
}
