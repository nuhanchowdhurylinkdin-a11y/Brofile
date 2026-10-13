import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PleasureSubHeader extends StatelessWidget {
  const PleasureSubHeader({
    super.key,
    required this.title,
    required this.onBack,
    this.onClose,
  });

  final String title;
  final VoidCallback onBack;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 16.w, 24.w, 16.w),
          child: Row(
            children: [
              GestureDetector(
                onTap: onBack,
                behavior: HitTestBehavior.opaque,
                child: SvgPicture.asset(
                  IconPath.pleasureBack,
                  width: 24.w,
                  height: 24.w,
                ),
              ),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: manrope(
                    14,
                    weight: FontWeight.w600,
                    color: AppColors.neutral600,
                    lineHeight: 20,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onClose ?? onBack,
                behavior: HitTestBehavior.opaque,
                child: SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: SvgPicture.asset(
                    IconPath.pleasureClose,
                    width: 24.w,
                    height: 24.w,
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
