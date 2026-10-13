import 'package:brofile/core/services/storage_service.dart';
import 'package:brofile/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  static const int pageCount = 3;
  static const Duration _pageAnimationDuration = Duration(milliseconds: 350);

  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  bool get isLastPage => currentPage.value == pageCount - 1;

  void onPageChanged(int index) => currentPage.value = index;

  void next() {
    if (isLastPage) {
      completeOnboarding();
      return;
    }
    pageController.nextPage(
      duration: _pageAnimationDuration,
      curve: Curves.easeInOut,
    );
  }

  Future<void> completeOnboarding() async {
    await StorageService.setOnboardingCompleted();
    Get.offAllNamed(AppRoute.getSignInScreen());
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
