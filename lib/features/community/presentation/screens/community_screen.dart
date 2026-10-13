import 'package:brofile/core/common/widgets/search_filter_bar.dart';
import 'package:brofile/core/common/widgets/tab_scroll_view.dart';
import 'package:brofile/core/common/widgets/tab_title_bar.dart';
import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/features/community/controllers/community_controller.dart';
import 'package:brofile/features/community/data/models/community_models.dart';
import 'package:brofile/features/community/presentation/widgets/community_cards.dart';
import 'package:brofile/features/community/presentation/widgets/interest_grid.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/presentation/widgets/category_chips.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommunityScreen extends GetView<CommunityController> {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TabScrollView(
      scrollController: controller.scrollController,
      onRefresh: controller.refreshCommunities,
      onLogoTap: controller.scrollToTop,
      children: [
        TabTitleBar(
          title: AppText.communities,
          subtitle: AppText.communitiesTagline,
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
          selectedColor: AppColors.brandMuted,
          spacing: 4,
          selectedKey: controller.selectedCategoryKey,
        ),
        SizedBox(height: 18.w),
        const _CommunitySections(),
      ],
    );
  }
}

class _CommunitySections extends GetView<CommunityController> {
  const _CommunitySections();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final featured = controller.section(CommunitySection.featured);
      final mine = controller.myCommunities;
      final trending = controller.section(CommunitySection.trending);
      final fresh = controller.section(CommunitySection.newThisWeek);
      final nearby = controller.section(CommunitySection.nearYou);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 28.w,
        children: [
          if (controller.showsInterests) const InterestGrid(),
          if (featured.isNotEmpty)
            _Section(
              title: AppText.featuredCommunity,
              child: FeaturedCommunityCard(
                community: featured.first,
                onTap: () => controller.openCommunity(featured.first),
                onJoin: () => controller.toggleJoin(featured.first),
              ),
            ),
          if (mine.isNotEmpty)
            _Section(
              title: AppText.myCommunities,
              onSeeAll: () => controller.openSeeAll(AppText.myCommunities),
              padded: false,
              child: _HorizontalList(
                spacing: 8,
                children: [
                  for (final community in mine)
                    SizedBox(
                      width: 194.w,
                      child: MyCommunityCard(
                        community: community,
                        onTap: () => controller.openCommunity(community),
                      ),
                    ),
                ],
              ),
            ),
          if (trending.isNotEmpty)
            _Section(
              title: controller.trendingTitle,
              onSeeAll: () => controller.openSeeAll(controller.trendingTitle),
              child: Column(
                spacing: 12.w,
                children: [
                  for (final community in trending)
                    TrendingCommunityRow(
                      community: community,
                      onTap: () => controller.openCommunity(community),
                      onJoin: () => controller.toggleJoin(community),
                    ),
                ],
              ),
            ),
          if (fresh.isNotEmpty)
            _Section(
              title: AppText.newThisWeek,
              onSeeAll: () => controller.openSeeAll(AppText.newThisWeek),
              padded: false,
              child: _HorizontalList(
                spacing: 4,
                children: [
                  for (final community in fresh)
                    NewCommunityCard(
                      community: community,
                      onTap: () => controller.openCommunity(community),
                    ),
                ],
              ),
            ),
          if (nearby.isNotEmpty) _NearYouCarousel(communities: nearby),
          if (!controller.hasResults) const _EmptyState(),
        ],
      );
    });
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.child,
    this.onSeeAll,
    this.padded = true,
  });

  final String title;
  final Widget child;
  final VoidCallback? onSeeAll;

  /// Horizontal lists manage their own edge padding so they can scroll
  /// to the screen edge.
  final bool padded;

  @override
  Widget build(BuildContext context) {
    final inset = EdgeInsets.symmetric(horizontal: 16.w);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: inset,
          child: HomeSectionHeader(title: title, onSeeAll: onSeeAll),
        ),
        SizedBox(height: 16.w),
        padded ? Padding(padding: inset, child: child) : child,
      ],
    );
  }
}

class _HorizontalList extends StatelessWidget {
  const _HorizontalList({required this.children, required this.spacing});

  final List<Widget> children;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spacing.w,
        children: children,
      ),
    );
  }
}

class _NearYouCarousel extends GetView<CommunityController> {
  const _NearYouCarousel({required this.communities});

  final List<CommunityItem> communities;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: HomeSectionHeader(
            title: AppText.communitiesNearYou,
            onSeeAll: () => controller.openSeeAll(AppText.communitiesNearYou),
          ),
        ),
        SizedBox(height: 16.w),
        SizedBox(
          height: NearbyCommunityCard.height,
          child: PageView.builder(
            controller: controller.nearYouPageController,
            itemCount: communities.length,
            onPageChanged: controller.onNearYouChanged,
            itemBuilder: (_, index) {
              final community = communities[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: NearbyCommunityCard(
                  community: community,
                  onTap: () => controller.openCommunity(community),
                  onJoin: () => controller.toggleJoin(community),
                ),
              );
            },
          ),
        ),
        if (communities.length > 1) ...[
          SizedBox(height: 20.w),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 4.w,
              children: [
                for (var i = 0; i < communities.length; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.nearYouIndex.value == i
                          ? AppColors.primary
                          : AppColors.neutral200,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.w),
      child: Text(
        AppText.noCommunitiesFound,
        textAlign: TextAlign.center,
        style: manrope(14, color: AppColors.neutral500, lineHeight: 20),
      ),
    );
  }
}
