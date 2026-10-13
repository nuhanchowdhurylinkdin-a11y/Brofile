import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/features/home/presentation/screens/home_screen.dart';
import 'package:brofile/features/main_nav/controllers/main_nav_controller.dart';
import 'package:brofile/features/main_nav/presentation/widgets/app_bottom_nav_bar.dart';
import 'package:brofile/features/main_nav/presentation/widgets/tab_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainNavScreen extends GetView<MainNavController> {
  const MainNavScreen({super.key});

  static const _tabs = <Widget>[
    HomeScreen(),
    TabPlaceholder(title: AppText.navCommunity),
    TabPlaceholder(title: AppText.navPleasure),
    TabPlaceholder(title: AppText.navDiscover),
    TabPlaceholder(title: AppText.navProfile),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
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
          bottomNavigationBar: const AppBottomNavBar(),
        ),
      ),
    );
  }
}
