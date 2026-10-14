import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/features/main_nav/controllers/main_nav_controller.dart';
import 'package:brofile/features/profile/controllers/profile_controller.dart';
import 'package:brofile/routes/app_routes.dart';
import 'package:get/get.dart';

class ProfileNavigation {
  static const _selfNames = {'william', '@william', 'you'};

  static bool isSelf(String name) {
    final value = name.trim().toLowerCase();
    return value == AppText.you.toLowerCase() || _selfNames.contains(value);
  }

  static bool isBusiness(String name) {
    final value = name.toLowerCase();
    return value.contains('greenleaf') ||
        value.contains('pizzavita') ||
        value.contains('artisan') ||
        value.contains('ocean grill') ||
        value.contains('yoga studio') ||
        value.contains('restaurant');
  }

  static String publicLabel(String label) {
    return label.startsWith('My ') ? label.substring(3) : label;
  }

  static void open(String name) {
    if (isSelf(name)) {
      _openOwnProfile();
      return;
    }
    if (isBusiness(name)) {
      openBusiness(visitor: true);
      return;
    }
    if (Get.isRegistered<ProfileController>()) {
      Get.find<ProfileController>().enterVisitor();
    }
    Get.toNamed(AppRoute.userProfileScreen);
  }

  static void openBusiness({bool visitor = true}) {
    Get.toNamed(AppRoute.businessProfileScreen, arguments: {'visitor': visitor});
  }

  static void _openOwnProfile() {
    if (Get.isRegistered<ProfileController>()) {
      Get.find<ProfileController>().exitVisitor();
    }
    if (!Get.isRegistered<MainNavController>()) return;
    if (Get.currentRoute != AppRoute.mainNavScreen) {
      Get.until(
        (route) =>
            route.settings.name == AppRoute.mainNavScreen || route.isFirst,
      );
    }
    Get.find<MainNavController>().changeTab(NavTab.profile);
  }
}
