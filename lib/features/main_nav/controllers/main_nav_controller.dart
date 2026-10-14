import 'package:brofile/features/community/controllers/community_controller.dart';
import 'package:brofile/features/discover/controllers/discover_controller.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/pleasure/controllers/pleasure_controller.dart';
import 'package:brofile/features/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum NavTab { home, community, pleasure, discover, profile }

class MainNavController extends GetxController with GetSingleTickerProviderStateMixin {
  final currentTab = NavTab.home.obs;

  /// 0 = fully visible, 1 = fully hidden.
  final navHidden = 0.0.obs;

  static const _hideRange = 64.0;

  late final AnimationController _navSlide;

  bool get isHome => currentTab.value == NavTab.home;

  @override
  void onInit() {
    super.onInit();
    _navSlide = AnimationController(vsync: this, duration: const Duration(milliseconds: 220));
    _navSlide.addListener(() => navHidden.value = _navSlide.value);
  }

  @override
  void onClose() {
    _navSlide.dispose();
    super.onClose();
  }

  void onScrollStart() {
    _navSlide.stop();
  }

  void onBodyScroll(ScrollUpdateNotification notification) {
    if (notification.metrics.axis != Axis.vertical) return;
    if (notification.metrics.outOfRange) return;
    if (notification.metrics.maxScrollExtent <= 0) return;

    if (notification.metrics.pixels <= 0) {
      _navSlide.value = 0;
      return;
    }

    final delta = notification.scrollDelta;
    if (delta == null || delta.abs() < 0.5) return;

    _navSlide.value = (_navSlide.value + delta / _hideRange).clamp(0.0, 1.0);
  }

  void onScrollEnd() {
    if (_navSlide.value == 0 || _navSlide.value == 1) return;
    _navSlide.animateTo(
      _navSlide.value >= 0.35 ? 1 : 0,
      curve: Curves.easeOutCubic,
    );
  }

  void showNav() {
    if (_navSlide.value == 0) return;
    _navSlide.animateTo(0, duration: const Duration(milliseconds: 180), curve: Curves.easeOutCubic);
  }

  void changeTab(NavTab tab) {
    showNav();
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
          Get.find<ProfileController>().scrollToTop();
      }
      return;
    }
    currentTab.value = tab;
  }

  void backToHome() {
    showNav();
    currentTab.value = NavTab.home;
  }
}
