import 'package:brofile/core/services/storage_service.dart';
import 'package:brofile/routes/app_routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  static const Duration splashDuration = Duration(seconds: 2);

  @override
  void onReady() {
    super.onReady();
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    await Future.delayed(splashDuration);
    Get.offAllNamed(
      StorageService.isOnboardingCompleted
          ? AppRoute.getSignInScreen()
          : AppRoute.getOnboardingScreen(),
    );
  }
}
