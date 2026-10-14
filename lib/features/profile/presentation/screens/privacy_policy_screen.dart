import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/profile/presentation/widgets/settings_sub_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSubScaffold(
      title: AppText.privacyPolicy,
      child: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 32.w),
        children: [
          Text(
            AppText.lastUpdatedPrivacy,
            style: manrope(12, weight: FontWeight.w500, color: const Color(0xFFA0A0A0), lineHeight: 18),
          ),
          SizedBox(height: 20.w),
          const _PolicyBlock(title: AppText.infoWeCollect, body: AppText.infoWeCollectBody),
          SizedBox(height: 20.w),
          const _PolicyBlock(title: AppText.howWeUseInformation, body: AppText.howWeUseInformationBody),
          SizedBox(height: 20.w),
          const _PolicyBlock(title: AppText.dataProtection, body: AppText.dataProtectionBody),
          SizedBox(height: 20.w),
          const _PolicyBlock(title: AppText.yourChoices, body: AppText.yourChoicesBody),
          SizedBox(height: 20.w),
          const _PolicyBlock(title: AppText.contactUsTitle, body: AppText.privacyContactBody),
        ],
      ),
    );
  }
}

class _PolicyBlock extends StatelessWidget {
  const _PolicyBlock({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: manrope(14, weight: FontWeight.w700, color: const Color(0xFF1A1A1A), lineHeight: 21)),
        SizedBox(height: 6.w),
        Text(body, style: manrope(13, weight: FontWeight.w500, color: const Color(0xFF5A5A5A), lineHeight: 21)),
      ],
    );
  }
}
