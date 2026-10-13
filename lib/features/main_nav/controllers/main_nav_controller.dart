import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:get/get.dart';

enum NavTab { home, community, pleasure, discover, profile }

class MainNavController extends GetxController {
  final currentTab = NavTab.home.obs;

  bool get isHome => currentTab.value == NavTab.home;

  void changeTab(NavTab tab) {
    if (tab == currentTab.value) {
      if (tab == NavTab.home) Get.find<HomeController>().scrollToTop();
      return;
    }
    currentTab.value = tab;
  }

  void backToHome() => currentTab.value = NavTab.home;
}
