import 'package:brofile/features/onboarding/controllers/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widgets/onboarding_page_indicator.dart';
import '../widgets/onboarding_pages.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: controller.next,
          child: Stack(
            children: [
              PageView(
                controller: controller.pageController,
                onPageChanged: controller.onPageChanged,
                children: const [
                  OnboardingFirstPage(),
                  OnboardingSecondPage(),
                  OnboardingThirdPage(),
                ],
              ),
              Positioned(
                top: 750.h,
                left: 0,
                right: 0,
                child: Center(
                  child: Obx(
                    () => OnboardingPageIndicator(
                      count: OnboardingController.pageCount,
                      currentIndex: controller.currentPage.value,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
