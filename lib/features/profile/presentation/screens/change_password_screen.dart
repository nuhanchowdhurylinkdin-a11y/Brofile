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

class ChangePasswordScreen extends GetView<SettingsController> {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSubScaffold(
      title: AppText.changePassword,
      child: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 32.w),
        children: [
          _PasswordField(
            label: AppText.currentPassword,
            controller: controller.currentPasswordController,
            hidden: controller.hideCurrentPassword,
          ),
          SizedBox(height: 16.w),
          _PasswordField(
            label: AppText.newPassword,
            controller: controller.newPasswordController,
            hidden: controller.hideNewPassword,
            onChanged: controller.onNewPasswordChanged,
          ),
          SizedBox(height: 16.w),
          _PasswordField(
            label: AppText.confirmNewPassword,
            controller: controller.confirmPasswordController,
            hidden: controller.hideConfirmPassword,
          ),
          SizedBox(height: 24.w),
          const _RequirementsCard(),
          SizedBox(height: 32.w),
          Center(
            child: GestureDetector(
              onTap: controller.savePassword,
              child: Container(
                width: 118.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F5C1F),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  AppText.save,
                  style: manrope(16, weight: FontWeight.w600, color: Colors.white, lineHeight: 22),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.label,
    required this.controller,
    required this.hidden,
    this.onChanged,
  });

  final String label;
  final TextEditingController controller;
  final RxBool hidden;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: manrope(16, weight: FontWeight.w700, color: AppColors.textGray800, lineHeight: 24)),
        SizedBox(height: 12.w),
        Obx(
          () => Container(
            height: 60.w,
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: AppColors.neutral300),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    obscureText: hidden.value,
                    onChanged: onChanged,
                    cursorColor: AppColors.primary,
                    style: manrope(16, color: AppColors.gray900, lineHeight: 24),
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: hidden.toggle,
                  child: SvgPicture.asset(IconPath.visibilityOff, width: 24.w, height: 24.w),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RequirementsCard extends GetView<SettingsController> {
  const _RequirementsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEEF4EE),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppText.passwordRequirements,
            style: manrope(14, weight: FontWeight.w700, color: const Color(0xFF1A1A1A), lineHeight: 21),
          ),
          SizedBox(height: 12.w),
          Obx(() => _Requirement(AppText.minEightCharacters, controller.hasEightChars)),
          SizedBox(height: 8.w),
          Obx(() => _Requirement(AppText.oneUppercaseLetter, controller.hasUppercase)),
          SizedBox(height: 8.w),
          Obx(() => _Requirement(AppText.oneNumber, controller.hasNumber)),
        ],
      ),
    );
  }
}

class _Requirement extends StatelessWidget {
  const _Requirement(this.label, this.met);

  final String label;
  final bool met;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.check_circle,
          size: 18.w,
          color: met ? AppColors.joined : AppColors.neutral300,
        ),
        SizedBox(width: 10.w),
        Text(
          label,
          style: manrope(13, weight: FontWeight.w500, color: const Color(0xFF3A3A3A), lineHeight: 20),
        ),
      ],
    );
  }
}
