import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileHero extends GetView<ProfileController> {
  const ProfileHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 229.w,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                  child: Image.asset(
                    ImagePath.profileCover,
                    width: double.infinity,
                    height: 198.w,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 12.w,
                  right: 12.w,
                  child: Row(
                    children: [
                      _CoverIcon(
                        icon: IconPath.profileCoverEdit,
                        onTap: controller.openAboutMe,
                      ),
                      SizedBox(width: 11.w),
                      _CoverIcon(
                        icon: IconPath.addPhotoCamera,
                        onTap: controller.openAboutMe,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 111.w,
                  child: Center(
                    child: Container(
                      width: 109.w,
                      height: 109.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 6.813.w),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              ImagePath.avatarWilliam,
                              fit: BoxFit.cover,
                              width: 109.w,
                              height: 109.w,
                            ),
                          ),
                          Positioned(
                            right: -3.w,
                            bottom: -3.w,
                            child: Container(
                              width: 27.w,
                              height: 27.w,
                              decoration: BoxDecoration(
                                color: AppColors.online,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: controller.openAboutMe,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Text(
                    controller.displayName.value,
                    style: manrope(16, weight: FontWeight.w600, color: AppColors.primary, lineHeight: 24),
                  ),
                ),
                SizedBox(width: 4.w),
                Obx(
                  () => Text(
                    controller.username.value,
                    style: manrope(12, color: AppColors.neutral500, lineHeight: 16),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 10.w, 12.w, 0),
            child: Obx(
              () => Text(
                controller.bio.value,
                textAlign: TextAlign.center,
                style: manrope(14, color: const Color(0xFF4B5563), lineHeight: 20),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 20.w, 12.w, 0),
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 12.w,
              runSpacing: 8.w,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(IconPath.profilePin, width: 20.w, height: 20.w),
                    SizedBox(width: 8.w),
                    Obx(
                      () => Text(
                        controller.locationLabel.value,
                        style: manrope(14, weight: FontWeight.w500, color: AppColors.neutral600, lineHeight: 20),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(IconPath.profileLink, width: 20.w, height: 20.w),
                    SizedBox(width: 8.w),
                    Obx(
                      () => Text(
                        controller.website.value,
                        style: manrope(14, weight: FontWeight.w500, color: AppColors.neutral600, lineHeight: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.w),
            child: Row(
              children: const [
                _Stat(value: '1K', label: AppText.postsLabel),
                _Stat(value: '12K', label: AppText.followers, bordered: true),
                _Stat(value: '10K', label: AppText.following),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CoverIcon extends StatelessWidget {
  const _CoverIcon({required this.icon, required this.onTap});

  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: AppColors.openNowScrim,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: SvgPicture.asset(icon, width: 20.w, height: 20.w),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label, this.bordered = false});

  final String value;
  final String label;
  final bool bordered;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: bordered
            ? const BoxDecoration(
                border: Border.symmetric(
                  vertical: BorderSide(color: AppColors.neutral300),
                ),
              )
            : null,
        child: Column(
          children: [
            Text(
              value,
              textAlign: TextAlign.center,
              style: manrope(16, weight: FontWeight.w700, color: AppColors.neutral700, lineHeight: 24),
            ),
            SizedBox(height: 4.w),
            Text(
              label,
              textAlign: TextAlign.center,
              style: manrope(12, color: AppColors.neutral700, lineHeight: 16),
            ),
          ],
        ),
      ),
    );
  }
}
