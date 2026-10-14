import 'package:brofile/core/common/widgets/tab_scroll_view.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:brofile/features/profile/controllers/profile_controller.dart';
import 'package:brofile/features/profile/data/models/profile_models.dart';
import 'package:brofile/features/profile/presentation/widgets/profile_about.dart';
import 'package:brofile/features/profile/presentation/widgets/profile_communities.dart';
import 'package:brofile/features/profile/presentation/widgets/profile_hero.dart';
import 'package:brofile/features/profile/presentation/widgets/profile_hobbies.dart';
import 'package:brofile/features/profile/presentation/widgets/profile_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key, this.asVisitor = false});

  final bool asVisitor;

  @override
  Widget build(BuildContext context) {
    if (asVisitor) return const _VisitorProfileView();
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

class _VisitorProfileView extends StatefulWidget {
  const _VisitorProfileView();

  @override
  State<_VisitorProfileView> createState() => _VisitorProfileViewState();
}

class _VisitorProfileViewState extends State<_VisitorProfileView> {
  final _scroll = ScrollController();
  late final ProfileController _profile = Get.find<ProfileController>();

  @override
  void dispose() {
    _scroll.dispose();
    if (Get.isRegistered<ProfileController>()) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (Get.isRegistered<ProfileController>()) {
          _profile.exitVisitor();
        }
      });
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: Column(
          children: [
            Obx(
              () => PleasureSubHeader(
                title: _profile.displayName.value,
                onBack: Get.back,
                showClose: false,
              ),
            ),
            Expanded(
              child: ListView(
                controller: _scroll,
                padding: EdgeInsets.only(top: 8.w, bottom: 32.w),
                children: [
                  const ProfileHero(),
                  SizedBox(height: 16.w),
                  const ProfileTabs(),
                  SizedBox(height: 28.w),
                  Obx(() {
                    return switch (_profile.selectedTab.value) {
                      ProfileTab.hobbies => const ProfileHobbiesBody(),
                      ProfileTab.communities => const ProfileCommunitiesBody(),
                      ProfileTab.about => const ProfileAboutBody(),
                    };
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
