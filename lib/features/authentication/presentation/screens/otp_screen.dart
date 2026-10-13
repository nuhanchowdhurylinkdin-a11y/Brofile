import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/features/authentication/controllers/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/auth_header.dart';
import '../widgets/auth_misc.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_scaffold.dart';

class OtpScreen extends GetView<OtpController> {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      showBackButton: true,
      children: [
        SizedBox(height: 24.h),
        const Center(child: AuthStepIndicator(activeStep: 1)),
        SizedBox(height: 70.h),
        const Center(child: AuthBadge(image: ImagePath.envelope)),
        SizedBox(height: 32.h),
        Padding(
          padding: authContentPadding,
          child: AuthTitle(
            title: AppText.enterOtp,
            subtitle: AppText.enterOtpSubtitle,
            subtitleLineGap: 14.h,
          ),
        ),
        SizedBox(height: 24.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 29.w),
          child: OtpTextField(
            numberOfFields: OtpController.otpLength,
            fieldWidth: 56.w,
            fieldHeight: 70.h,
            margin: EdgeInsets.zero,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            showFieldAsBox: true,
            filled: true,
            fillColor: AppColors.inputFill,
            borderWidth: 1,
            borderColor: AppColors.gray100,
            enabledBorderColor: AppColors.gray100,
            focusedBorderColor: AppColors.primary,
            borderRadius: BorderRadius.circular(12.r),
            cursorColor: AppColors.gray800,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textStyle: GoogleFonts.manrope(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.gray900,
            ),
            handleControllers: controller.attachFieldControllers,
            onCodeChanged: controller.onDigitChanged,
            onSubmit: controller.onDigitChanged,
          ),
        ),
        SizedBox(height: 52.h),
        Padding(
          padding: authContentPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(
                () => AuthPrimaryButton(
                  label: AppText.resetPassword,
                  usePoppins: true,
                  isLoading: controller.isLoading.value,
                  onPressed: controller.verifyOtp,
                ),
              ),
              SizedBox(height: 16.h),
              Align(
                alignment: Alignment.centerLeft,
                child: AuthLinkText(
                  prefix: AppText.noOtp,
                  link: AppText.resendOtp,
                  usePoppins: true,
                  onTap: controller.resendOtp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
