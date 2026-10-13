import 'package:brofile/core/common/widgets/search_filter_bar.dart';
import 'package:brofile/core/common/widgets/tab_scroll_view.dart';
import 'package:brofile/core/common/widgets/tab_title_bar.dart';
import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/presentation/widgets/category_chips.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/pleasure/controllers/pleasure_controller.dart';
import 'package:brofile/features/pleasure/presentation/widgets/activity_cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PleasureScreen extends GetView<PleasureController> {
  const PleasureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TabScrollView(
      scrollController: controller.scrollController,
      onRefresh: controller.refreshActivities,
      onLogoTap: controller.scrollToTop,
      children: [
        TabTitleBar(
          title: AppText.pleasure,
          subtitle: AppText.pleasureTagline,
          onCreate: controller.openCreate,
        ),
        SizedBox(height: 26.w),
        SearchFilterBar(
          controller: controller.searchController,
          onChanged: controller.onSearchChanged,
          onFilter: controller.openFilter,
        ),
        SizedBox(height: 28.w),
        CategoryChips(
          labels: HomeController.categories,
          selected: controller.selectedCategory,
          onSelected: controller.selectCategory,
        ),
        SizedBox(height: 18.w),
        const _PleasureSections(),
      ],
    );
  }
}

class _PleasureSections extends GetView<PleasureController> {
  const _PleasureSections();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final soon = controller.startingSoon;
      final nearby = controller.nearYou;
      final friends = controller.visibleFriends;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 28.w,
        children: [
          if (soon.isNotEmpty)
            _Section(
              title: AppText.startingSoon,
              subtitle: AppText.startingSoonSubtitle,
              onSeeAll: () => controller.openSeeAll(AppText.startingSoon),
              gap: 28,
              child: Column(
                spacing: 16.w,
                children: [
                  for (final activity in soon)
                    StartingSoonCard(
                      activity: activity,
                      onTap: () => controller.openActivity(activity),
                      onJoin: () => controller.toggleJoin(activity),
                    ),
                ],
              ),
            ),
          if (nearby.isNotEmpty)
            _Section(
              title: AppText.nearYou,
              subtitle: AppText.nearYouSubtitle,
              onSeeAll: () => controller.openSeeAll(AppText.nearYou),
              child: Column(
                spacing: 16.w,
                children: [
                  for (final activity in nearby)
                    NearbyActivityCard(
                      activity: activity,
                      onTap: () => controller.openActivity(activity),
                      onJoin: () => controller.toggleJoin(activity),
                    ),
                ],
              ),
            ),
          if (soon.isEmpty && nearby.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.w),
              child: Text(
                AppText.noActivitiesFound,
                textAlign: TextAlign.center,
                style: manrope(14, color: AppColors.neutral500, lineHeight: 20),
              ),
            ),
          if (friends.isNotEmpty)
            _Section(
              title: AppText.friendsAreDoing,
              subtitle: AppText.friendsAreDoingSubtitle,
              onSeeAll: () => controller.openSeeAll(AppText.friendsAreDoing),
              padded: false,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  spacing: 8.w,
                  children: [
                    for (final friend in friends)
                      FriendInterestCard(
                        friend: friend,
                        onTap: () => controller.openFriend(friend),
                      ),
                  ],
                ),
              ),
            ),
        ],
      );
    });
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.subtitle,
    required this.onSeeAll,
    required this.child,
    this.gap = 16,
    this.padded = true,
  });

  final String title;
  final String subtitle;
  final VoidCallback onSeeAll;
  final Widget child;
  final double gap;
  final bool padded;

  @override
  Widget build(BuildContext context) {
    final inset = EdgeInsets.symmetric(horizontal: 16.w);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: inset,
          child: HomeSectionHeader(
            title: title,
            subtitle: subtitle,
            onSeeAll: onSeeAll,
          ),
        ),
        SizedBox(height: gap.w),
        padded ? Padding(padding: inset, child: child) : child,
      ],
    );
  }
}
