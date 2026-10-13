import 'package:brofile/features/community/controllers/community_controller.dart';
import 'package:brofile/features/discover/controllers/discover_controller.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/pleasure/controllers/pleasure_controller.dart';
import 'package:get/get.dart';

enum NavTab { home, community, pleasure, discover, profile }

class MainNavController extends GetxController {
  final currentTab = NavTab.home.obs;

  bool get isHome => currentTab.value == NavTab.home;

  void changeTab(NavTab tab) {
    if (tab == currentTab.value) {
      switch (tab) {
        case NavTab.home:
          Get.find<HomeController>().scrollToTop();
        case NavTab.community:
          Get.find<CommunityController>().scrollToTop();
        case NavTab.pleasure:
          Get.find<PleasureController>().scrollToTop();
        case NavTab.discover:
          Get.find<DiscoverController>().scrollToTop();
        case NavTab.profile:
          break;
      }
      return;
    }
    currentTab.value = tab;
  }

  void backToHome() => currentTab.value = NavTab.home;
}
