import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/features/authentication/controllers/sign_up_controller.dart';
import 'package:flutter/gestures.dart';
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

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

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
              const Center(child: AuthBadge(image: ImagePath.claps)),
              SizedBox(height: 30.h),
              const AuthTitle(title: AppText.signUp, subtitle: AppText.authSubtitle),
              SizedBox(height: 30.h),
              SocialLoginSection(
                onFacebook: controller.signUpWithFacebook,
                onGoogle: controller.signUpWithGoogle,
              ),
              SizedBox(height: 16.h),
              AuthTextField(
                controller: controller.nameController,
                hint: AppText.name,
                keyboardType: TextInputType.name,
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
              SizedBox(height: 10.h),
              _TermsAgreement(controller: controller),
              SizedBox(height: 34.h),
              Obx(
                () => AuthPrimaryButton(
                  label: AppText.createAccount,
                  isLoading: controller.isLoading.value,
                  onPressed: controller.createAccount,
                ),
              ),
              SizedBox(height: 16.h),
              Center(
                child: AuthLinkText(
                  prefix: AppText.haveAccount,
                  link: AppText.signIn,
                  onTap: controller.goToSignIn,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TermsAgreement extends StatefulWidget {
  const _TermsAgreement({required this.controller});

  final SignUpController controller;

  @override
  State<_TermsAgreement> createState() => _TermsAgreementState();
}

class _TermsAgreementState extends State<_TermsAgreement> {
  late final TapGestureRecognizer _termsRecognizer = TapGestureRecognizer()
    ..onTap = widget.controller.openTermsOfService;
  late final TapGestureRecognizer _privacyRecognizer = TapGestureRecognizer()
    ..onTap = widget.controller.openPrivacyPolicy;

  @override
  void dispose() {
    _termsRecognizer.dispose();
    _privacyRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final muted = GoogleFonts.manrope(
      fontSize: 12.sp,
      fontWeight: FontWeight.w400,
      height: 16 / 12,
      color: AppColors.gray600,
    );
    final link = muted.copyWith(color: AppColors.linkSecondary);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: widget.controller.toggleTerms,
          child: Obx(
            () => Container(
              width: 24.r,
              height: 24.r,
              decoration: BoxDecoration(
                color: AppColors.gray50,
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: widget.controller.hasAgreedToTerms.value
                  ? Icon(Icons.check, size: 18.r, color: AppColors.primary)
                  : null,
            ),
          ),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  style: muted,
                  children: [
                    const TextSpan(text: AppText.agreeTo),
                    TextSpan(text: AppText.termsOfService, style: link, recognizer: _termsRecognizer),
                    const TextSpan(text: AppText.and),
                    TextSpan(text: AppText.privacy, style: link, recognizer: _privacyRecognizer),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Text.rich(
                TextSpan(text: AppText.policy, style: link, recognizer: _privacyRecognizer),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
