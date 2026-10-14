import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/profile/presentation/widgets/settings_sub_scaffold.dart';
import 'package:brofile/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutBrofileScreen extends StatelessWidget {
  const AboutBrofileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSubScaffold(
      title: AppText.aboutBrofile,
      showClose: true,
      child: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 24.w, 16.w, 32.w),
        children: [
          Center(child: SvgPicture.asset(IconPath.brofileLogo, height: 37.w)),
          SizedBox(height: 8.w),
          Text(
            AppText.brofileWordmark,
            textAlign: TextAlign.center,
            style: manrope(18, weight: FontWeight.w800, color: const Color(0xFF1A1A1A), lineHeight: 27).copyWith(
              letterSpacing: 1.8,
            ),
          ),
          SizedBox(height: 8.w),
          Text(
            AppText.brofileTagline,
            textAlign: TextAlign.center,
            style: manrope(14, weight: FontWeight.w700, color: const Color(0xFF1F5C1F), lineHeight: 21),
          ),
          SizedBox(height: 12.w),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: const Color(0xFFE5E5E5)),
              ),
              child: Text(
                AppText.versionLabel,
                style: manrope(13, weight: FontWeight.w600, color: const Color(0xFF5A5A5A), lineHeight: 20),
              ),
            ),
          ),
          SizedBox(height: 28.w),
          SettingsCard(
            children: [
              _AboutRow(
                icon: IconPath.aboutGlobe,
                title: AppText.website,
                subtitle: AppText.brofileWebsite,
                onTap: () => launchUrl(Uri.parse(AppText.brofileWebsiteUrl)),
              ),
              _AboutRow(
                icon: IconPath.aboutMail,
                title: AppText.supportEmail,
                subtitle: AppText.supportEmailAddress,
                onTap: () => launchUrl(Uri(scheme: 'mailto', path: AppText.supportEmailAddress)),
                last: true,
              ),
            ],
          ),
          SizedBox(height: 16.w),
          SettingsCard(
            children: [
              _AboutRow(
                icon: IconPath.profileTerms,
                title: AppText.termsOfService,
                onTap: () => AppHelperFunctions.showSnackBar(AppText.comingSoon),
              ),
              _AboutRow(
                icon: IconPath.profilePrivacyPolicy,
                title: AppText.privacyPolicy,
                onTap: () => Get.toNamed(AppRoute.privacyPolicyScreen),
              ),
              _AboutRow(
                icon: IconPath.aboutLicenses,
                title: AppText.licenses,
                onTap: () => AppHelperFunctions.showSnackBar(AppText.comingSoon),
                last: true,
              ),
            ],
          ),
          SizedBox(height: 40.w),
          Text(
            AppText.copyrightBrofile,
            textAlign: TextAlign.center,
            style: manrope(12, weight: FontWeight.w600, color: const Color(0xFFB0B0B0), lineHeight: 18),
          ),
          Text(
            AppText.allRightsReserved,
            textAlign: TextAlign.center,
            style: manrope(12, weight: FontWeight.w500, color: const Color(0xFFB0B0B0), lineHeight: 18),
          ),
        ],
      ),
    );
  }
}

class _AboutRow extends StatelessWidget {
  const _AboutRow({
    required this.icon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.last = false,
  });

  final String icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          border: last ? null : const Border(bottom: BorderSide(color: Color(0xFFF0F0F0))),
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon, width: 20.w, height: 20.w),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: manrope(14, weight: FontWeight.w700, color: const Color(0xFF1A1A1A), lineHeight: 21)),
                  if (subtitle != null)
                    Text(subtitle!, style: manrope(12, weight: FontWeight.w500, color: const Color(0xFF9A9A9A), lineHeight: 18)),
                ],
              ),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: SvgPicture.asset(IconPath.profileChevronRight, width: 17.w, height: 17.w),
            ),
          ],
        ),
      ),
    );
  }
}
