import 'package:get/get.dart';

import '../features/authentication/controllers/forgot_password_controller.dart';
import '../features/authentication/controllers/otp_controller.dart';
import '../features/authentication/controllers/reset_password_controller.dart';
import '../features/authentication/controllers/sign_in_controller.dart';
import '../features/authentication/controllers/sign_up_controller.dart';
import '../features/authentication/presentation/screens/forgot_password_screen.dart';
import '../features/authentication/presentation/screens/otp_screen.dart';
import '../features/authentication/presentation/screens/reset_password_screen.dart';
import '../features/authentication/presentation/screens/sign_in_screen.dart';
import '../features/authentication/presentation/screens/sign_up_screen.dart';
import '../features/home/controllers/home_controller.dart';
import '../features/main_nav/controllers/main_nav_controller.dart';
import '../features/main_nav/presentation/screens/main_nav_screen.dart';
import '../features/onboarding/controllers/onboarding_controller.dart';
import '../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../features/splash/controllers/splash_controller.dart';
import '../features/splash/presentation/screens/splash_screen.dart';

class AppRoute {
  static String splashScreen = "/splashScreen";
  static String onboardingScreen = "/onboardingScreen";
  static String signInScreen = "/signInScreen";
  static String signUpScreen = "/signUpScreen";
  static String forgotPasswordScreen = "/forgotPasswordScreen";
  static String otpScreen = "/otpScreen";
  static String resetPasswordScreen = "/resetPasswordScreen";
  static String mainNavScreen = "/mainNavScreen";

  static String getSplashScreen() => splashScreen;
  static String getOnboardingScreen() => onboardingScreen;
  static String getSignInScreen() => signInScreen;
  static String getMainNavScreen() => mainNavScreen;

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
    GetPage(
      name: signInScreen,
      page: () => const SignInScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => SignInController())),
    ),
    GetPage(
      name: signUpScreen,
      page: () => const SignUpScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => SignUpController())),
    ),
    GetPage(
      name: forgotPasswordScreen,
      page: () => const ForgotPasswordScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => ForgotPasswordController())),
    ),
    GetPage(
      name: otpScreen,
      page: () => const OtpScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => OtpController())),
    ),
    GetPage(
      name: resetPasswordScreen,
      page: () => const ResetPasswordScreen(),
      binding: BindingsBuilder(() => Get.lazyPut(() => ResetPasswordController())),
    ),
    GetPage(
      name: mainNavScreen,
      page: () => const MainNavScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => MainNavController());
        Get.lazyPut(() => HomeController());
      }),
    ),
  ];
}
