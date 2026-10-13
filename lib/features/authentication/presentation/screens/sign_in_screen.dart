import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/features/authentication/controllers/sign_in_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/auth_header.dart';
import '../widgets/auth_misc.dart';
import '../widgets/auth_primary_button.dart';
import '../widgets/auth_scaffold.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/social_login_section.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      children: [
        Padding(
          padding: authContentPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 44.h),
              const Center(child: AuthBadge(image: ImagePath.wave)),
              SizedBox(height: 30.h),
              const AuthTitle(title: AppText.signIn, subtitle: AppText.authSubtitle),
              SizedBox(height: 30.h),
              SocialLoginSection(
                onFacebook: controller.signInWithFacebook,
                onGoogle: controller.signInWithGoogle,
              ),
              SizedBox(height: 16.h),
              AuthTextField(
                controller: controller.emailController,
                hint: AppText.emailOrPhone,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),
              Obx(
                () => AuthTextField(
                  controller: controller.passwordController,
                  hint: AppText.password,
                  obscureText: controller.isPasswordHidden.value,
                  onToggleVisibility: controller.togglePasswordVisibility,
                  textInputAction: TextInputAction.done,
                ),
              ),
              SizedBox(height: 12.h),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: controller.goToForgotPassword,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: Text(
                      AppText.forgetPasswordLink,
                      style: GoogleFonts.manrope(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        height: 16 / 12,
                        color: AppColors.gray600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Obx(
                () => AuthPrimaryButton(
                  label: AppText.logIn,
                  isLoading: controller.isLoading.value,
                  onPressed: controller.signIn,
                ),
              ),
              SizedBox(height: 16.h),
              Center(
                child: AuthLinkText(
                  prefix: AppText.noAccount,
                  link: AppText.signUp,
                  onTap: controller.goToSignUp,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
