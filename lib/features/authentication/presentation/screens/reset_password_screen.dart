import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/features/authentication/controllers/reset_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/auth_header.dart';
import '../widgets/auth_misc.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/auth_text_field.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      showBackButton: true,
      backIcon: IconPath.arrowBackDark,
      children: [
        Padding(
          padding: authContentPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 24.h),
              const Center(child: AuthStepIndicator(activeStep: 2)),
              SizedBox(height: 70.h),
              const Center(
                child: AuthBadge(
                  image: ImagePath.lock,
                  backgroundColor: AppColors.gray100,
                  showGlow: true,
                ),
              ),
              SizedBox(height: 32.h),
              AuthTitle(
                title: AppText.resetPassword,
                subtitle: AppText.authSubtitle,
                subtitleStyle: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  height: 22 / 14,
                  color: AppColors.gray700,
                ),
              ),
              SizedBox(height: 26.h),
              Obx(
                () => AuthTextField(
                  controller: controller.newPasswordController,
                  hint: AppText.newPassword,
                  obscureText: controller.isNewPasswordHidden.value,
                  onToggleVisibility: controller.toggleNewPasswordVisibility,
                ),
              ),
              SizedBox(height: 16.h),
              Obx(
                () => AuthTextField(
                  controller: controller.confirmPasswordController,
                  hint: AppText.confirmPassword,
                  obscureText: controller.isConfirmPasswordHidden.value,
                  onToggleVisibility: controller.toggleConfirmPasswordVisibility,
                  textInputAction: TextInputAction.done,
                ),
              ),
              SizedBox(height: 32.h),
              Obx(
                () => AuthPrimaryButton(
                  label: AppText.continueText,
                  usePoppins: true,
                  isLoading: controller.isLoading.value,
                  onPressed: controller.resetPassword,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
