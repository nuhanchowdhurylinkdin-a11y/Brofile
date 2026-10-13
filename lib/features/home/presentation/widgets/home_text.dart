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

/// Text whose box is trimmed from the first line's cap height to the last
/// line's baseline, matching Figma's `text-box-trim: cap alphabetic`.
class TrimmedText extends StatelessWidget {
  const TrimmedText(
    this.text, {
    super.key,
    required this.style,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
  });

  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final int maxLines;

  // Manrope vertical metrics, relative to the font size.
  static const double _capHeight = 0.72;
  static const double _ascent = 1.066 / 1.366;
  static const double _capTop = _ascent - _capHeight;

  @override
  Widget build(BuildContext context) {
    final fontSize = style.fontSize ?? 14;
    if (maxLines > 1) return _paragraph(context, fontSize);

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

  Widget _paragraph(BuildContext context, double fontSize) {
    final lineHeight = fontSize * (style.height ?? 1);

    return LayoutBuilder(
      builder: (context, constraints) {
        final painter = TextPainter(
          text: TextSpan(text: text, style: style),
          textDirection: Directionality.of(context),
          textScaler: MediaQuery.textScalerOf(context),
          maxLines: maxLines,
          ellipsis: '…',
        )..layout(maxWidth: constraints.maxWidth);
        final lines = painter.computeLineMetrics().length;
        painter.dispose();

        return SizedBox(
          height: (lines - 1) * lineHeight + fontSize * _capHeight,
          child: OverflowBox(
            alignment: Alignment.topLeft,
            maxHeight: double.infinity,
            child: Transform.translate(
              offset: Offset(
                0,
                -(lineHeight * _ascent - fontSize * _capHeight),
              ),
              child: Text(
                text,
                style: style,
                textAlign: textAlign,
                maxLines: maxLines,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );
      },
    );
  }
}

class HomeSectionHeader extends StatelessWidget {
  const HomeSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onSeeAll,
  });

  final String title;
  final String? subtitle;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    final titleText = Text(
      title,
      style: manrope(18, weight: FontWeight.w700, lineHeight: 20),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );

    return Row(
      children: [
        Expanded(
          child: subtitle == null
              ? titleText
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleText,
                    SizedBox(height: 6.w),
                    TrimmedText(subtitle!, style: manrope(12)),
                  ],
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
