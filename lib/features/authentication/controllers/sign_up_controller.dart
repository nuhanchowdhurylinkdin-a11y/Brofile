import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/core/utils/validators/app_validator.dart';
import 'package:brofile/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordHidden = true.obs;
  final hasAgreedToTerms = false.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() => isPasswordHidden.toggle();

  void toggleTerms() => hasAgreedToTerms.toggle();

  Future<void> createAccount() async {
    final error = (nameController.text.trim().isEmpty ? AppText.nameRequired : null) ??
        AppValidator.validateEmailOrPhone(emailController.text) ??
        AppValidator.validatePassword(passwordController.text) ??
        (hasAgreedToTerms.value ? null : AppText.acceptTerms);
    if (error != null) {
      AppHelperFunctions.showSnackBar(error);
      return;
    }

    isLoading.value = true;
    try {
      // TODO: call the sign up API.
    } finally {
      isLoading.value = false;
    }
    Get.offNamed(AppRoute.signInScreen);
  }

  void signUpWithFacebook() {
    // TODO: integrate Facebook sign up.
  }

  void signUpWithGoogle() {
    // TODO: integrate Google sign up.
  }

  void openTermsOfService() {
    // TODO: open the Terms of Service page.
  }

  void openPrivacyPolicy() {
    // TODO: open the Privacy Policy page.
  }

  void goToSignIn() => Get.offNamed(AppRoute.signInScreen);

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
