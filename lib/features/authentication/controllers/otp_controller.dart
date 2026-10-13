import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  static const int otpLength = 5;

  /// Email or phone number the OTP was sent to, passed from the previous screen.
  final String recipient = Get.arguments as String? ?? '';
  final code = ''.obs;
  final isLoading = false.obs;

  List<TextEditingController?> _fieldControllers = const [];

  void attachFieldControllers(List<TextEditingController?> controllers) =>
      _fieldControllers = controllers;

  void onDigitChanged(String _) =>
      code.value = _fieldControllers.map((c) => c?.text ?? '').join();

  Future<void> verifyOtp() async {
    if (code.value.length != otpLength) {
      AppHelperFunctions.showSnackBar(AppText.otpIncomplete);
      return;
    }

    isLoading.value = true;
    try {
      // TODO: call the verify OTP API.
    } finally {
      isLoading.value = false;
    }
    Get.toNamed(AppRoute.resetPasswordScreen, arguments: recipient);
  }

  Future<void> resendOtp() async {
    // TODO: call the resend OTP API.
    AppHelperFunctions.showSnackBar(AppText.otpResent);
  }
}
