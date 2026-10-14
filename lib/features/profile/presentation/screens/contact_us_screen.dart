import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/profile/controllers/settings_controller.dart';
import 'package:brofile/features/profile/presentation/widgets/settings_sub_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ContactUsScreen extends GetView<SettingsController> {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSubScaffold(
      title: AppText.contactUsTitle,
      child: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 32.w),
        children: [
          Text(AppText.subject, style: manrope(14, weight: FontWeight.w700, color: const Color(0xFF1A1A1A), lineHeight: 21)),
          SizedBox(height: 8.w),
          _SoftField(
            controller: controller.subjectController,
            hint: AppText.enterSubject,
            height: 52,
          ),
          SizedBox(height: 20.w),
          Text(AppText.message, style: manrope(14, weight: FontWeight.w700, color: const Color(0xFF1A1A1A), lineHeight: 21)),
          SizedBox(height: 8.w),
          _SoftField(
            controller: controller.messageController,
            hint: AppText.writeYourMessage,
            height: 200,
            maxLines: 8,
          ),
          SizedBox(height: 20.w),
          GestureDetector(
            onTap: controller.openSupportEmail,
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0xFFEBEBEB)),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    IconPath.profileContactUs,
                    width: 26.w,
                    height: 26.w,
                    colorFilter: const ColorFilter.mode(Color(0xFF1F5C1F), BlendMode.srcIn),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppText.supportEmail, style: manrope(14, weight: FontWeight.w700, color: const Color(0xFF1A1A1A), lineHeight: 21)),
                        Text(AppText.supportEmailAddress, style: manrope(13, weight: FontWeight.w500, color: const Color(0xFF8A8A8A), lineHeight: 20)),
                      ],
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 3,
                    child: SvgPicture.asset(IconPath.profileChevronRight, width: 18.w, height: 18.w),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 32.w),
          GestureDetector(
            onTap: controller.sendMessage,
            child: Container(
              height: 56.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F5C1F),
                borderRadius: BorderRadius.circular(28.r),
              ),
              alignment: Alignment.center,
              child: Text(
                AppText.sendMessage,
                style: manrope(16, weight: FontWeight.w700, color: Colors.white, lineHeight: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SoftField extends StatelessWidget {
  const _SoftField({
    required this.controller,
    required this.hint,
    required this.height,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String hint;
  final double height;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        textAlignVertical: TextAlignVertical.top,
        cursorColor: AppColors.primary,
        style: manrope(14, weight: FontWeight.w500, color: AppColors.textGray800, lineHeight: 22),
        decoration: InputDecoration(
          isDense: true,
          hintText: hint,
          hintStyle: manrope(14, weight: FontWeight.w500, color: const Color(0xFFC0C0C0)),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
