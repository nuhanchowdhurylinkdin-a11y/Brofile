import 'package:get/get.dart';

import '../features/authentication/presentation/screens/login_screen.dart';
import '../features/onboarding/controllers/onboarding_controller.dart';
import '../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../features/splash/controllers/splash_controller.dart';
import '../features/splash/presentation/screens/splash_screen.dart';

class AppRoute {
  static String splashScreen = "/splashScreen";
  static String onboardingScreen = "/onboardingScreen";
  static String loginScreen = "/loginScreen";

  static String getSplashScreen() => splashScreen;
  static String getOnboardingScreen() => onboardingScreen;
  static String getLoginScreen() => loginScreen;

  static List<GetPage> routes = [
    GetPage(
      name: splashScreen,
      page: () => const SplashScreen(),
      binding: BindingsBuilder(() {
        Get.put(SplashController());
      }),
    ),
    GetPage(
      name: onboardingScreen,
      page: () => const OnboardingScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => OnboardingController())),
    ),
    GetPage(name: loginScreen, page: () => const HomeScreen()),
  ];
}
