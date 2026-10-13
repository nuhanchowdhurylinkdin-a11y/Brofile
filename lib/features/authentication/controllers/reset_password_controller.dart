import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/core/utils/validators/app_validator.dart';
import 'package:brofile/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final isNewPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;
  final isLoading = false.obs;

  void toggleNewPasswordVisibility() => isNewPasswordHidden.toggle();

  void toggleConfirmPasswordVisibility() => isConfirmPasswordHidden.toggle();

  Future<void> resetPassword() async {
    final error = AppValidator.validatePassword(newPasswordController.text) ??
        (newPasswordController.text == confirmPasswordController.text
            ? null
            : AppText.passwordsDoNotMatch);
    if (error != null) {
      AppHelperFunctions.showSnackBar(error);
      return;
    }

    isLoading.value = true;
    try {
      // TODO: call the reset password API.
    } finally {
      isLoading.value = false;
    }
    Get.offAllNamed(AppRoute.signInScreen);
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
