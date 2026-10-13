import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// "18K Members • 128 Online" line, laid out on a 10px row like Figma.
class MemberStats extends StatelessWidget {
  const MemberStats({
    super.key,
    required this.members,
    required this.online,
    required this.style,
    this.spread = false,
  });

  final String members;
  final int online;
  final TextStyle style;

  /// Pushes the online count to the far end of the row.
  final bool spread;

  @override
  Widget build(BuildContext context) {
    Widget fit(Widget child, {Alignment alignment = Alignment.centerLeft}) {
      return FittedBox(fit: BoxFit.scaleDown, alignment: alignment, child: child);
    }

    final membersText = fit(TrimmedText('$members ${AppText.membersTitle}', style: style));
    final onlineText = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8.w,
          height: 8.w,
          decoration: const BoxDecoration(
            color: AppColors.online,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4.w),
        fit(TrimmedText('$online ${AppText.online}', style: style)),
      ],
    );

    return SizedBox(
      height: 10.w,
      child: Row(
        children: [
          Flexible(child: membersText),
          if (spread) const Spacer() else SizedBox(width: 8.w),
          onlineText,
        ],
      ),
    );
  }
}
