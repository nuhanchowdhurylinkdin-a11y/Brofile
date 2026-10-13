import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/core/utils/validators/app_validator.dart';
import 'package:brofile/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordHidden = true.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() => isPasswordHidden.toggle();

  Future<void> signIn() async {
    final error = AppValidator.validateEmailOrPhone(emailController.text) ??
        (passwordController.text.isEmpty ? AppText.passwordRequired : null);
    if (error != null) {
      AppHelperFunctions.showSnackBar(error);
      return;
    }

    isLoading.value = true;
    try {
      // TODO: call the sign in API and save the token.
      Get.offAllNamed(AppRoute.getMainNavScreen());
    } finally {
      isLoading.value = false;
    }
  }

  void signInWithFacebook() {
    // TODO: integrate Facebook sign in.
  }

  void signInWithGoogle() {
    // TODO: integrate Google sign in.
  }

  void goToForgotPassword() => Get.toNamed(AppRoute.forgotPasswordScreen);

  void goToSignUp() => Get.offNamed(AppRoute.signUpScreen);

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
