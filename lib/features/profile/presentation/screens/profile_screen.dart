import 'package:brofile/core/common/widgets/tab_scroll_view.dart';
import 'package:brofile/features/profile/controllers/profile_controller.dart';
import 'package:brofile/features/profile/data/models/profile_models.dart';
import 'package:brofile/features/profile/presentation/widgets/profile_about.dart';
import 'package:brofile/features/profile/presentation/widgets/profile_communities.dart';
import 'package:brofile/features/profile/presentation/widgets/profile_hero.dart';
import 'package:brofile/features/profile/presentation/widgets/profile_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TabScrollView(
      scrollController: controller.scrollController,
      onRefresh: controller.refreshProfile,
      onLogoTap: controller.scrollToTop,
      children: [
        const ProfileHero(),
        SizedBox(height: 16.w),
        const ProfileTabs(),
        SizedBox(height: 28.w),
        Obx(() {
          if (controller.selectedTab.value == ProfileTab.communities) {
            return const ProfileCommunitiesBody();
          }
          return const ProfileAboutBody();
        }),
      ],
    );
  }
}
