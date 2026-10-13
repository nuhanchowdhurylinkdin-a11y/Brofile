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
import '../features/community/controllers/community_controller.dart';
import '../features/discover/controllers/create_product_controller.dart';
import '../features/discover/controllers/discover_controller.dart';
import '../features/discover/controllers/recycle_product_details_controller.dart';
import '../features/discover/presentation/screens/create_product_screen.dart';
import '../features/discover/presentation/screens/recycle_product_details_screen.dart';
import '../features/home/controllers/home_controller.dart';
import '../features/main_nav/controllers/main_nav_controller.dart';
import '../features/pleasure/controllers/create_pleasure_controller.dart';
import '../features/pleasure/controllers/pleasure_controller.dart';
import '../features/pleasure/controllers/pleasure_details_controller.dart';
import '../features/profile/controllers/add_hobby_controller.dart';
import '../features/profile/controllers/album_details_controller.dart';
import '../features/profile/controllers/profile_controller.dart';
import '../features/profile/presentation/screens/add_hobby_screen.dart';
import '../features/profile/presentation/screens/album_details_screen.dart';
import '../features/profile/presentation/screens/hobbies_screen.dart';
import '../features/pleasure/presentation/screens/create_pleasure_screen.dart';
import '../features/pleasure/presentation/screens/pleasure_details_screen.dart';
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
  static String pleasureDetailsScreen = "/pleasureDetailsScreen";
  static String createPleasureScreen = "/createPleasureScreen";
  static String createProductScreen = "/createProductScreen";
  static String recycleProductDetailsScreen = "/recycleProductDetailsScreen";
  static String hobbiesScreen = "/hobbiesScreen";
  static String addHobbyScreen = "/addHobbyScreen";
  static String albumDetailsScreen = "/albumDetailsScreen";

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
        Get.lazyPut(() => CommunityController());
        Get.lazyPut(() => PleasureController());
        Get.lazyPut(() => DiscoverController());
        Get.lazyPut(() => ProfileController());
      }),
    ),
    GetPage(
      name: pleasureDetailsScreen,
      page: () => const PleasureDetailsScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => PleasureDetailsController()),
      ),
    ),
    GetPage(
      name: createPleasureScreen,
      page: () => const CreatePleasureScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => CreatePleasureController()),
      ),
    ),
    GetPage(
      name: createProductScreen,
      page: () => const CreateProductScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => CreateProductController()),
      ),
    ),
    GetPage(
      name: recycleProductDetailsScreen,
      page: () => const RecycleProductDetailsScreen(),
      binding: BindingsBuilder(
        () => Get.lazyPut(() => RecycleProductDetailsController()),
      ),
    ),
    GetPage(
      name: hobbiesScreen,
      page: () => const HobbiesScreen(),
    ),
    GetPage(
      name: addHobbyScreen,
      page: () => const AddHobbyScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<AddHobbyController>()) {
          Get.delete<AddHobbyController>();
        }
        Get.put(AddHobbyController());
      }),
    ),
    GetPage(
      name: albumDetailsScreen,
      page: () => const AlbumDetailsScreen(),
      binding: BindingsBuilder(() {
        if (Get.isRegistered<AlbumDetailsController>()) {
          Get.delete<AlbumDetailsController>();
        }
        Get.put(AlbumDetailsController());
      }),
    ),
  ];
}
