import 'package:brofile/core/common/widgets/hide_on_scroll.dart';
import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:brofile/features/profile/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: HideOnScroll(
          header: PleasureSubHeader(
            title: AppText.settings,
            onBack: Get.back,
            showClose: false,
          ),
          body: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 32.w),
                children: [
                  _GroupTitle(AppText.account),
                  _SettingsRow(
                    icon: IconPath.profileLock,
                    label: AppText.changePassword,
                    onTap: controller.openChangePassword,
                  ),
                  _SettingsRow(
                    icon: IconPath.profileLanguage,
                    label: AppText.language,
                    onTap: controller.pickLanguage,
                  ),
                  _GroupTitle(AppText.preference),
                  _SettingsRow(
                    icon: IconPath.profileNotifications,
                    label: AppText.notifications,
                    onTap: controller.openNotifications,
                  ),
                  _SettingsRow(
                    icon: IconPath.profileBlocked,
                    label: AppText.blockedUsers,
                    onTap: controller.openBlockedUsers,
                  ),
                  _SettingsRow(
                    icon: IconPath.profileHiddenCommunities,
                    label: AppText.hiddenCommunities,
                    onTap: controller.openHiddenCommunities,
                  ),
                  _GroupTitle(AppText.privacyShortcuts),
                  _PrivacyRow(AppText.whoCanSeeAbout, IconPath.profileUser),
                  _PrivacyRow(AppText.whoCanSeeHobbies, IconPath.profilePrivacyStar),
                  _PrivacyRow(AppText.whoCanSeeCommunities, IconPath.profileUsers),
                  _PrivacyRow(AppText.whoCanSeeBusiness, IconPath.profileCommunities),
                  _PrivacyRow(AppText.whoCanSeeActivities, IconPath.profilePrivacyActivities),
                  _PrivacyRow(AppText.whoCanSeeAspirations, IconPath.profilePodcast),
                  _PrivacyRow(AppText.whoCanSeeCircle, IconPath.profilePrivacyCircle),
                  _GroupTitle(AppText.support),
                  _SettingsRow(
                    icon: IconPath.profileHelp,
                    label: AppText.helpCenter,
                    onTap: controller.openHelpCenter,
                  ),
                  _SettingsRow(
                    icon: IconPath.profileContactUs,
                    label: AppText.contactUs,
                    onTap: controller.openContactUs,
                  ),
                  _SettingsRow(
                    icon: IconPath.profileTerms,
                    label: AppText.termsOfService,
                    onTap: controller.comingSoon,
                  ),
                  _SettingsRow(
                    icon: IconPath.profilePrivacyPolicy,
                    label: AppText.privacyPolicy,
                    onTap: controller.openPrivacyPolicy,
                  ),
                  _SettingsRow(
                    icon: IconPath.profileAlert,
                    label: AppText.aboutBrofile,
                    value: AppText.appVersion,
                    valueColor: AppColors.neutral500,
                    onTap: controller.openAboutBrofile,
                  ),
                  SizedBox(height: 32.w),
                  Center(
                    child: GestureDetector(
                      onTap: controller.logOut,
                      child: Container(
                        width: 320.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEE4E2),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(IconPath.profileLogout, width: 20.w, height: 20.w),
                            SizedBox(width: 8.w),
                            Text(
                              AppText.logOut,
                              style: manrope(
                                16,
                                weight: FontWeight.w600,
                                color: const Color(0xFFD92D20),
                                lineHeight: 22,
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
      ),
    );
  }
}

class _GroupTitle extends StatelessWidget {
  const _GroupTitle(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 16.w, 12.w, 4.w),
      child: Text(
        label,
        style: manrope(16, weight: FontWeight.w700, color: AppColors.textGray800, lineHeight: 24),
      ),
    );
  }
}

class _PrivacyRow extends GetView<SettingsController> {
  const _PrivacyRow(this.label, this.icon);

  final String label;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _SettingsRow(
        icon: icon,
        label: label,
        value: controller.privacy[label] ?? AppText.circle,
        onTap: () => controller.pickPrivacy(label),
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.value,
    this.valueColor = AppColors.primary,
  });

  final String icon;
  final String label;
  final VoidCallback onTap;
  final String? value;
  final Color valueColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.neutral300)),
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon, width: 20.w, height: 20.w),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                style: manrope(16, color: AppColors.textGray800, lineHeight: 24),
              ),
            ),
            if (value != null) ...[
              Text(
                value!,
                style: manrope(14, weight: FontWeight.w500, color: valueColor, lineHeight: 20),
              ),
              SizedBox(width: 8.w),
            ],
            RotatedBox(
              quarterTurns: 3,
              child: SvgPicture.asset(IconPath.profileChevronRight, width: 20.w, height: 20.w),
            ),
          ],
        ),
      ),
    );
  }
}
