import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/discover/data/models/discover_models.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DiscoverTypeChips extends StatelessWidget {
  const DiscoverTypeChips({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final Rx<DiscoverType> selected;
  final ValueChanged<DiscoverType> onSelected;

  static const _items = <(DiscoverType, String, String?)>[
    (DiscoverType.all, AppText.all, null),
    (DiscoverType.business, AppText.business, IconPath.typeBusiness),
    (DiscoverType.products, AppText.products, IconPath.typeProducts),
    (DiscoverType.services, AppText.services, IconPath.typeServices),
    (DiscoverType.events, AppText.events, IconPath.typeEvents),
    (DiscoverType.recycle, AppText.recycle, IconPath.typeRecycle),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43.w,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: _items.length,
        separatorBuilder: (_, _) => SizedBox(width: 4.w),
        itemBuilder: (_, index) {
          final (type, label, icon) = _items[index];
          return Obx(() {
            final isSelected = selected.value == type;
            final isRecycle = type == DiscoverType.recycle;
            final foreground = isSelected ? Colors.white : AppColors.neutral500;
            return GestureDetector(
              onTap: () => onSelected(type),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 43.w,
                padding: EdgeInsets.symmetric(horizontal: isRecycle ? 8.w : 12.w),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.white,
                  border: Border.all(
                    color: isRecycle && !isSelected
                        ? AppColors.neutral300
                        : AppColors.typeChipBorder,
                  ),
                  borderRadius: BorderRadius.circular(isRecycle ? 8.r : 32.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (icon != null) ...[
                      SvgPicture.asset(
                        icon,
                        width: 18.w,
                        height: 18.w,
                        colorFilter: ColorFilter.mode(
                          isSelected
                              ? Colors.white
                              : isRecycle
                              ? AppColors.neutral400
                              : AppColors.neutral500,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 4.w),
                    ],
                    Text(
                      label,
                      style: manrope(
                        isRecycle ? 12 : 14,
                        color: isRecycle && !isSelected
                            ? AppColors.neutral400
                            : foreground,
                        lineHeight: isRecycle ? 16 : 20,
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }
}

class DiscoverSectionHeader extends StatelessWidget {
  const DiscoverSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.onSeeAll,
  });

  final String title;
  final String? subtitle;
  final String? icon;
  final Color? iconColor;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          if (icon != null) ...[
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: iconColor ?? AppColors.headerGreen,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                icon!,
                width: 18.w,
                height: 18.w,
                colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
            SizedBox(width: 12.w),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: manrope(18, weight: FontWeight.w700, lineHeight: 20),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 8.w),
                  TrimmedText(
                    subtitle!,
                    style: manrope(12, color: AppColors.neutral700),
                  ),
                ],
              ],
            ),
          ),
          if (onSeeAll != null)
            GestureDetector(
              onTap: onSeeAll,
              child: Text(
                AppText.seeAll,
                style: manrope(
                  12,
                  weight: FontWeight.w600,
                  color: AppColors.primary,
                  lineHeight: 18,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
