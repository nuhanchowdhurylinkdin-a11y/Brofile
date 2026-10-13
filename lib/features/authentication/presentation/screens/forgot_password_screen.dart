import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/features/authentication/controllers/forgot_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/auth_header.dart';
import '../widgets/auth_misc.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/auth_text_field.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      showBackButton: true,
      children: [
        Padding(
          padding: authContentPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 24.h),
              const Center(child: AuthStepIndicator(activeStep: 0)),
              SizedBox(height: 70.h),
              const Center(child: AuthBadge(image: ImagePath.envelope)),
              SizedBox(height: 32.h),
              const AuthTitle(title: AppText.forgetPassword, subtitle: AppText.authSubtitle),
              SizedBox(height: 30.h),
              AuthTextField(
                controller: controller.emailController,
                hint: AppText.emailOrMobile,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 32.h),
              Obx(
                () => AuthPrimaryButton(
                  label: AppText.continueText,
                  isLoading: controller.isLoading.value,
                  onPressed: controller.sendOtp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
