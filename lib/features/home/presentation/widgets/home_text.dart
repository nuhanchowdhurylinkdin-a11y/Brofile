import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle manrope(
  double size, {
  FontWeight weight = FontWeight.w400,
  Color color = AppColors.textGray800,
  double? lineHeight,
}) {
  return GoogleFonts.manrope(
    fontSize: size.sp,
    fontWeight: weight,
    color: color,
    height: lineHeight == null ? null : lineHeight / size,
  );
}

/// Single line text whose box is trimmed to the cap height, matching
/// Figma's `text-box-trim: cap alphabetic`.
class TrimmedText extends StatelessWidget {
  const TrimmedText(
    this.text, {
    super.key,
    required this.style,
    this.textAlign = TextAlign.start,
  });

  final String text;
  final TextStyle style;
  final TextAlign textAlign;

  // Manrope vertical metrics, relative to the font size.
  static const double _capHeight = 0.72;
  static const double _capTop = 1.066 / 1.366 - _capHeight;

  @override
  Widget build(BuildContext context) {
    final fontSize = style.fontSize ?? 14;

    return Transform.translate(
      offset: Offset(0, -fontSize * _capTop),
      child: Align(
        alignment: Alignment.topLeft,
        widthFactor: 1,
        heightFactor: _capHeight,
        child: Text(
          text,
          style: style.copyWith(height: 1),
          textAlign: textAlign,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class HomeSectionHeader extends StatelessWidget {
  const HomeSectionHeader({super.key, required this.title, this.onSeeAll});

  final String title;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: manrope(18, weight: FontWeight.w700, lineHeight: 20),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (onSeeAll != null)
          GestureDetector(
            onTap: onSeeAll,
            behavior: HitTestBehavior.opaque,
            child: Text(
              AppText.seeAll,
              style: manrope(14, color: AppColors.primary, lineHeight: 20),
            ),
          ),
      ],
    );
  }
}
