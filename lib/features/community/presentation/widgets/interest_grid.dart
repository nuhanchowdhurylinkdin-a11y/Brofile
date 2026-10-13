import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/features/community/controllers/community_controller.dart';
import 'package:brofile/features/community/data/models/community_models.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class InterestGrid extends GetView<CommunityController> {
  const InterestGrid({super.key});

  static const int _perRow = 4;

  @override
  Widget build(BuildContext context) {
    const interests = CommunityController.interests;
    final rows = [
      for (var i = 0; i < interests.length; i += _perRow)
        interests.sublist(i, (i + _perRow).clamp(0, interests.length)),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        spacing: 4.w,
        children: [
          for (final row in rows)
            Row(
              spacing: 4.w,
              children: [
                for (final interest in row)
                  Expanded(
                    child: Obx(
                      () => _InterestChip(
                        interest: interest,
                        isSelected: controller.selectedInterests.contains(
                          interest.label,
                        ),
                        onTap: () => controller.toggleInterest(interest.label),
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

class _InterestChip extends StatelessWidget {
  const _InterestChip({
    required this.interest,
    required this.isSelected,
    required this.onTap,
  });

  final CommunityInterest interest;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = isSelected ? Colors.white : AppColors.neutral500;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 40.w,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.neutral200,
          borderRadius: BorderRadius.circular(34.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              interest.icon,
              width: 16.w,
              height: 16.w,
              colorFilter: ColorFilter.mode(foreground, BlendMode.srcIn),
            ),
            SizedBox(width: 4.w),
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  interest.label,
                  maxLines: 1,
                  style: manrope(12, color: foreground, lineHeight: 32),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
