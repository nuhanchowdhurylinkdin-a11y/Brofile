import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/core/utils/validators/app_validator.dart';
import 'package:brofile/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;

  Future<void> sendOtp() async {
    final error = AppValidator.validateEmailOrPhone(emailController.text);
    if (error != null) {
      AppHelperFunctions.showSnackBar(error);
      return;
    }

    isLoading.value = true;
    try {
      // TODO: call the forgot password (send OTP) API.
    } finally {
      isLoading.value = false;
    }
    Get.toNamed(AppRoute.otpScreen, arguments: emailController.text.trim());
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
