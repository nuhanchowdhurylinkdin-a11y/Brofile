import 'package:brofile/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isPasswordHidden = true.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() => isPasswordHidden.toggle();

  void signIn() => Get.offAllNamed(AppRoute.getMainNavScreen());

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
