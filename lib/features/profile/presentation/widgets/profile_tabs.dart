import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/profile/controllers/profile_controller.dart';
import 'package:brofile/features/profile/data/models/profile_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileTabs extends GetView<ProfileController> {
  const ProfileTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tab = controller.selectedTab.value;
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 6, offset: Offset(0, 2))],
        ),
        child: Column(
          children: [
            Row(
              children: [
                _TabChip(
                  label: AppText.about,
                  icon: IconPath.profileAbout,
                  iconBg: const Color(0x291B6B51),
                  selected: tab == ProfileTab.about,
                  onTap: () => controller.selectTab(ProfileTab.about),
                ),
                SizedBox(width: 8.w),
                _TabChip(
                  label: AppText.hobbies,
                  icon: IconPath.profileHobbies,
                  iconBg: const Color(0x29FFB692),
                  selected: tab == ProfileTab.hobbies,
                  onTap: () => controller.selectTab(ProfileTab.hobbies),
                ),
                SizedBox(width: 8.w),
                _TabChip(
                  label: AppText.communities,
                  icon: IconPath.profileCommunities,
                  iconBg: const Color(0xFFF4EBFF),
                  selected: tab == ProfileTab.communities,
                  onTap: () => controller.selectTab(ProfileTab.communities),
                ),
              ],
            ),
            if (tab == ProfileTab.about) ...[
              SizedBox(height: 8.w),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!controller.isVisitor.value) ...[
                    SizedBox(
                      width: 118.w,
                      child: _TabChip(
                        label: AppText.myCircle,
                        icon: IconPath.profileCircle,
                        iconBg: const Color(0xFFFEE4E2),
                        selected: false,
                        expand: false,
                        onTap: controller.openMyCircle,
                      ),
                    ),
                    SizedBox(width: 8.w),
                  ],
                  SizedBox(
                    width: 118.w,
                    child: _TabChip(
                      label: AppText.aspirations,
                      icon: IconPath.profileAspirations,
                      iconBg: const Color(0xFFD1E9FF),
                      selected: false,
                      expand: false,
                      onTap: controller.openAspirations,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      );
    });
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({
    required this.label,
    required this.icon,
    required this.iconBg,
    required this.selected,
    required this.onTap,
    this.expand = true,
  });

  final String label;
  final String icon;
  final Color iconBg;
  final bool selected;
  final VoidCallback onTap;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final chip = GestureDetector(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(minHeight: 72.w),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.neutral100),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: SvgPicture.asset(icon, width: 18.w, height: 18.w),
            ),
            SizedBox(height: 4.w),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: manrope(
                12,
                weight: selected ? FontWeight.w700 : FontWeight.w400,
                color: selected ? AppColors.primary : AppColors.neutral500,
                lineHeight: 16,
              ),
            ),
          ],
        ),
      ),
    );
    return expand ? Expanded(child: chip) : chip;
  }
}
