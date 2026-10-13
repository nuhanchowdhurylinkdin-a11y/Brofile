import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/features/home/presentation/widgets/category_chips.dart';
import 'package:brofile/features/home/presentation/widgets/communities_section.dart';
import 'package:brofile/features/home/presentation/widgets/family_friends_section.dart';
import 'package:brofile/features/home/presentation/widgets/home_header.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/home/presentation/widgets/people_you_may_know.dart';
import 'package:brofile/features/home/presentation/widgets/photo_album_section.dart';
import 'package:brofile/features/home/presentation/widgets/post_card.dart';
import 'package:brofile/features/home/presentation/widgets/product_list_section.dart';
import 'package:brofile/features/home/presentation/widgets/trending_section.dart';
import 'package:brofile/features/home/presentation/widgets/upcoming_event_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    final headerBottom = padding.top + HomeHeader.contentHeight;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: ColoredBox(
        color: Colors.white,
        child: Stack(
          children: [
            RefreshIndicator(
              color: AppColors.primary,
              edgeOffset: headerBottom,
              onRefresh: controller.refreshFeed,
              child: Obx(() {
                final feed = controller.visibleFeed;
                return ListView.builder(
                  controller: controller.scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                    top: headerBottom + 17.w,
                    bottom: padding.bottom + 10.w,
                  ),
                  itemCount: feed.length,
                  itemBuilder: (_, index) => Padding(
                    padding: EdgeInsets.only(top: _gapBefore(feed, index)),
                    child: _FeedEntryView(entry: feed[index]),
                  ),
                );
              }),
            ),
            const Positioned(top: 0, left: 0, right: 0, child: HomeHeader()),
          ],
        ),
      ),
    );
  }

  double _gapBefore(List<FeedEntry> feed, int index) {
    if (index == 0) return 0;
    final previous = feed[index - 1];
    final current = feed[index];
    // The friends block carries its own 16px vertical padding.
    if (previous is SectionEntry && previous.section == HomeSection.friends) {
      return 18.w;
    }
    if ((previous is SectionEntry && previous.section == HomeSection.trending) ||
        (current is SectionEntry && current.section == HomeSection.communities)) {
      return 26.w;
    }
    return 28.w;
  }
}

class _FeedEntryView extends GetView<HomeController> {
  const _FeedEntryView({required this.entry});

  final FeedEntry entry;

  @override
  Widget build(BuildContext context) {
    return switch (entry) {
      PostEntry(:final post) => PostCard(key: ValueKey(post.id), post: post),
      SectionEntry(:final section) => switch (section) {
          HomeSection.categories => const CategoryChips(),
          HomeSection.people => const PeopleYouMayKnow(),
          HomeSection.friends => const FamilyFriendsSection(),
          HomeSection.trending => const TrendingSection(),
          HomeSection.communities => const CommunitiesSection(),
          HomeSection.recommendedGear => ProductListSection(
              title: AppText.recommendedGear,
              products: controller.recommendedGear,
            ),
          HomeSection.photoAlbums => const PhotoAlbumSection(title: AppText.photoAlbums),
          HomeSection.recycler => ProductListSection(
              title: AppText.recyclerNearYou,
              products: controller.recyclerItems,
            ),
          HomeSection.gears => const PhotoAlbumSection(title: AppText.gears),
          HomeSection.events => const UpcomingEventSection(),
          HomeSection.emptyPosts => const _EmptyPosts(),
        },
    };
  }
}

class _EmptyPosts extends StatelessWidget {
  const _EmptyPosts();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.w),
      child: Center(
        child: Text(
          AppText.noPostsInCategory,
          style: manrope(14, color: AppColors.neutral500, lineHeight: 20),
        ),
      ),
    );
  }
}
