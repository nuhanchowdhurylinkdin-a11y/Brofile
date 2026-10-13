import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Tab title with a tagline and the "Create New" action.
class TabTitleBar extends StatelessWidget {
  const TabTitleBar({
    super.key,
    required this.title,
    required this.subtitle,
    this.onCreate,
    this.createLabel = AppText.createNew,
    this.titleColor = AppColors.primary,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onCreate;
  final String createLabel;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: manrope(
                    18,
                    weight: FontWeight.w700,
                    color: titleColor,
                    lineHeight: 20,
                  ),
                ),
                SizedBox(height: 8.w),
                TrimmedText(
                  subtitle,
                  style: manrope(12, color: AppColors.neutral700),
                ),
              ],
            ),
          ),
          if (onCreate != null)
          GestureDetector(
            onTap: onCreate,
            child: Container(
              height: 42.w,
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.buttonShadow,
                    offset: Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    IconPath.addSquare,
                    width: 20.w,
                    height: 20.w,
                  ),
                  SizedBox(width: 4.w),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: Text(
                      createLabel,
                      style: manrope(
                        14,
                        weight: FontWeight.w600,
                        color: AppColors.primary,
                        lineHeight: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
