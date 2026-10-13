import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/features/discover/controllers/discover_controller.dart';
import 'package:brofile/features/discover/data/models/discover_models.dart';
import 'package:brofile/features/discover/presentation/widgets/business_cards.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BusinessFeed extends GetView<DiscoverController> {
  const BusinessFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.businessFeedEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.w),
          child: Text(
            AppText.noDiscoverResults,
            textAlign: TextAlign.center,
            style: manrope(14, color: AppColors.neutral500, lineHeight: 20),
          ),
        );
      }

      final featured = controller.visibleFeaturedCarousel;
      final trending = controller.visibleTrending;
      final suggested = controller.visibleSuggested;
      final nearby = controller.visibleNearby;
      final newest = controller.visibleNew;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 28.w,
        children: [
          if (featured.isNotEmpty) _FeaturedSection(items: featured),
          if (trending.isNotEmpty)
            _LogoCardSection(
              title: AppText.trendingBusinesses,
              items: trending,
            ),
          if (controller.artisanVisible)
            _Padded(child: BusinessFeedPost(feed: controller.artisanPost)),
          if (suggested.isNotEmpty) _SuggestedSection(items: suggested),
          if (controller.artisanVisible)
            _Padded(child: BusinessFeedPost(feed: controller.artisanPost2)),
          if (nearby.isNotEmpty) _NearbySection(items: nearby),
          if (controller.williamVisible)
            _Padded(child: BusinessFeedPost(feed: controller.williamPost)),
          if (newest.isNotEmpty)
            _LogoCardSection(
              title: AppText.newOnBrofile,
              items: newest,
            ),
        ],
      );
    });
  }
}

class _FeaturedSection extends GetView<DiscoverController> {
  const _FeaturedSection({required this.items});

  final List<DiscoverBusiness> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BusinessSectionHeader(
            title: AppText.featuredBusiness,
            onSeeAll: controller.openFilter,
          ),
        ),
        SizedBox(height: 16.w),
        SizedBox(
          height: 232.w,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              PageView.builder(
                controller: controller.featuredPageController,
                itemCount: items.length,
                onPageChanged: controller.onFeaturedPageChanged,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: 16.w,
                      right: index < items.length - 1 ? 48.w : 16.w,
                    ),
                    child: FeaturedOverlayCard(
                      business: items[index],
                      onTap: () => controller.openDetails(items[index].name),
                    ),
                  );
                },
              ),
              Obx(() {
                final index = controller.featuredIndex.value;
                if (index >= items.length - 1) {
                  return const SizedBox.shrink();
                }
                final next = items[index + 1];
                return Positioned(
                  right: 8.w,
                  top: 52.w,
                  child: GestureDetector(
                    onTap: () => controller.featuredPageController.nextPage(
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeOut,
                    ),
                    child: Container(
                      width: 96.w,
                      height: 96.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x33000000),
                            blurRadius: 8,
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(next.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        SizedBox(height: 12.w),
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < items.length; i++)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: controller.featuredIndex.value == i ? 16.w : 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: controller.featuredIndex.value == i
                          ? AppColors.primary
                          : AppColors.neutral200,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LogoCardSection extends GetView<DiscoverController> {
  const _LogoCardSection({required this.title, required this.items});

  final String title;
  final List<DiscoverBusiness> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BusinessSectionHeader(
            title: title,
            onSeeAll: controller.openFilter,
          ),
        ),
        SizedBox(height: 16.w),
        SizedBox(
          height: 252.w,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            clipBehavior: Clip.none,
            itemCount: items.length,
            separatorBuilder: (_, _) => SizedBox(width: 8.w),
            itemBuilder: (_, index) {
              final business = items[index];
              return LogoBusinessCard(
                business: business,
                onTap: () => controller.openDetails(business.name),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SuggestedSection extends GetView<DiscoverController> {
  const _SuggestedSection({required this.items});

  final List<DiscoverBusiness> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BusinessSectionHeader(
            title: AppText.suggestedBusinesses,
            onSeeAll: controller.openFilter,
          ),
        ),
        SizedBox(height: 16.w),
        SizedBox(
          height: 122.w,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: items.length,
            separatorBuilder: (_, _) => SizedBox(width: 4.w),
            itemBuilder: (_, index) {
              final business = items[index];
              return SuggestedBusinessCard(
                business: business,
                onTap: () => controller.openDetails(business.name),
                onFollow: () => controller.toggleFollow(business),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _NearbySection extends GetView<DiscoverController> {
  const _NearbySection({required this.items});

  final List<DiscoverBusiness> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BusinessSectionHeader(
            title: AppText.businessesNearYou,
            onSeeAll: controller.openFilter,
          ),
        ),
        SizedBox(height: 16.w),
        SizedBox(
          height: 268.w,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            clipBehavior: Clip.none,
            itemCount: items.length,
            separatorBuilder: (_, _) => SizedBox(width: 8.w),
            itemBuilder: (_, index) {
              final business = items[index];
              return NearbyBusinessCard(
                business: business,
                onTap: () => controller.openDetails(business.name),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _Padded extends StatelessWidget {
  const _Padded({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: child,
    );
  }
}
