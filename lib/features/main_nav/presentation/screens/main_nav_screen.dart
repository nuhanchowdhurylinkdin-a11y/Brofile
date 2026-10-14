import 'package:brofile/features/community/presentation/screens/community_screen.dart';
import 'package:brofile/features/discover/presentation/screens/discover_screen.dart';
import 'package:brofile/features/home/presentation/screens/home_screen.dart';
import 'package:brofile/features/pleasure/presentation/screens/pleasure_screen.dart';
import 'package:brofile/features/main_nav/controllers/main_nav_controller.dart';
import 'package:brofile/features/main_nav/presentation/widgets/app_bottom_nav_bar.dart';
import 'package:brofile/features/profile/presentation/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainNavScreen extends GetView<MainNavController> {
  const MainNavScreen({super.key});

  static const _tabs = <Widget>[
    HomeScreen(),
    CommunityScreen(),
    PleasureScreen(),
    DiscoverScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollStartNotification) {
          controller.onScrollStart();
        } else if (notification is ScrollUpdateNotification) {
          controller.onBodyScroll(notification);
        } else if (notification is ScrollEndNotification) {
          controller.onScrollEnd();
        }
        return false;
      },
      child: Obx(
        () => PopScope(
          canPop: controller.isHome,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) controller.backToHome();
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            extendBody: true,
            body: IndexedStack(
              index: controller.currentTab.value.index,
              children: _tabs,
            ),
            bottomNavigationBar: const _HidingBottomNav(),
          ),
        ),
      ),
    );
  }
}

class _HidingBottomNav extends GetView<MainNavController> {
  const _HidingBottomNav();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final hidden = controller.navHidden.value;
      return ClipRect(
        child: FractionalTranslation(
          translation: Offset(0, hidden),
          child: IgnorePointer(
            ignoring: hidden > 0.85,
            child: const AppBottomNavBar(),
          ),
        ),
      );
    });
  }
}
