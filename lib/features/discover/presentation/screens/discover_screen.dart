import 'package:brofile/core/common/widgets/search_filter_bar.dart';
import 'package:brofile/core/common/widgets/tab_scroll_view.dart';
import 'package:brofile/core/common/widgets/tab_title_bar.dart';
import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/discover/controllers/discover_controller.dart';
import 'package:brofile/features/discover/data/models/discover_models.dart';
import 'package:brofile/features/discover/presentation/widgets/business_feed.dart';
import 'package:brofile/features/discover/presentation/widgets/discover_cards.dart';
import 'package:brofile/features/discover/presentation/widgets/discover_chrome.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/features/home/presentation/widgets/category_chips.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DiscoverScreen extends GetView<DiscoverController> {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TabScrollView(
      scrollController: controller.scrollController,
      onRefresh: controller.refreshDiscover,
      onLogoTap: controller.scrollToTop,
      children: [
        Obx(
          () => TabTitleBar(
            title: controller.title,
            subtitle: controller.subtitle,
            titleColor: AppColors.textGray800,
            onCreate: controller.selectedType.value == DiscoverType.recycle
                ? controller.openCreateProduct
                : null,
            createLabel: AppText.createPost,
          ),
        ),
        SizedBox(height: 12.w),
        SearchFilterBar(
          controller: controller.searchController,
          onChanged: controller.onSearchChanged,
          onFilter: controller.openFilter,
        ),
        SizedBox(height: 16.w),
        DiscoverTypeChips(
          selected: controller.selectedType,
          onSelected: controller.selectType,
        ),
        SizedBox(height: 28.w),
        DiscoverSectionHeader(
          title: AppText.exploreByCategory,
          onSeeAll: controller.openFilter,
        ),
        SizedBox(height: 24.w),
        CategoryChips(
          labels: HomeController.categories,
          selected: controller.selectedCategory,
          onSelected: controller.selectCategory,
          selectedKey: controller.selectedCategoryKey,
        ),
        SizedBox(height: 28.w),
        const _DiscoverBody(),
      ],
    );
  }
}

class _DiscoverBody extends GetView<DiscoverController> {
  const _DiscoverBody();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return switch (controller.selectedType.value) {
        DiscoverType.all => const _HubBody(),
        DiscoverType.business => const BusinessFeed(),
        DiscoverType.products => const _ProductsBody(),
        DiscoverType.services => const _ServicesBody(),
        DiscoverType.events => const _EventsBody(),
        DiscoverType.recycle => const _RecycleBody(),
      };
    });
  }
}

class _HubBody extends GetView<DiscoverController> {
  const _HubBody();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final businesses = controller.visibleFeatured;
      final products = controller.hubProducts;
      final services = controller.hubServices;
      final recycler = controller.visibleRecycler;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 28.w,
        children: [
          if (businesses.isNotEmpty)
            Column(
              children: [
                DiscoverSectionHeader(
                  title: AppText.featuredBusinesses,
                  icon: IconPath.headerBusiness,
                  iconColor: AppColors.headerGreen,
                  onSeeAll: () => controller.openSeeAll(DiscoverType.business),
                ),
                SizedBox(height: 24.w),
                SizedBox(
                  height: 248.w,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: businesses.length,
                    separatorBuilder: (_, _) => SizedBox(width: 16.w),
                    itemBuilder: (_, index) {
                      final business = businesses[index];
                      return FeaturedBusinessCard(
                        business: business,
                        onTap: () => controller.openBusinessProfile(business.name),
                        onFavorite: () => controller.toggleFavorite(business),
                      );
                    },
                  ),
                ),
              ],
            ),
          if (products.isNotEmpty)
            Column(
              children: [
                DiscoverSectionHeader(
                  title: AppText.products,
                  subtitle: AppText.discoverCompareExplore,
                  icon: IconPath.headerProducts,
                  iconColor: AppColors.headerBlue,
                  onSeeAll: () => controller.openSeeAll(DiscoverType.products),
                ),
                SizedBox(height: 24.w),
                SizedBox(
                  height: 220.w,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    clipBehavior: Clip.none,
                    itemCount: products.length,
                    separatorBuilder: (_, _) => SizedBox(width: 20.w),
                    itemBuilder: (_, index) {
                      final product = products[index];
                      return DiscoverProductCard(
                        product: product,
                        width: 188.w,
                        onTap: () => controller.openDetails(product.name),
                        onFavorite: () =>
                            controller.toggleProductFavorite(product),
                      );
                    },
                  ),
                ),
              ],
            ),
          if (services.isNotEmpty)
            Column(
              children: [
                DiscoverSectionHeader(
                  title: AppText.servicesNearYou,
                  subtitle: AppText.discoverCompareExplore,
                  icon: IconPath.headerServices,
                  iconColor: AppColors.headerOrange,
                  onSeeAll: () => controller.openSeeAll(DiscoverType.services),
                ),
                SizedBox(height: 24.w),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    spacing: 12.w,
                    children: [
                      for (final service in services)
                        ServiceCard(
                          service: service,
                          onTap: () => controller.openDetails(service.name),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          Column(
            children: [
              DiscoverSectionHeader(
                title: AppText.upcomingEvents,
                subtitle: AppText.discoverCompareExplore,
                icon: IconPath.headerEvents,
                iconColor: AppColors.headerViolet,
                onSeeAll: () => controller.openSeeAll(DiscoverType.events),
              ),
              SizedBox(height: 24.w),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: DiscoverEventCard(
                  event: controller.event,
                  onInterested: controller.toggleInterested,
                  onDetails: () => controller.openDetails(controller.event.title),
                ),
              ),
            ],
          ),
          if (recycler.isNotEmpty)
            Column(
              children: [
                DiscoverSectionHeader(
                  title: AppText.recyclerNearYou,
                  subtitle: AppText.discoverCompareExplore,
                  icon: IconPath.headerRecycle,
                  iconColor: AppColors.headerGreen,
                  onSeeAll: () => controller.openSeeAll(DiscoverType.recycle),
                ),
                SizedBox(height: 24.w),
                SizedBox(
                  height: 220.w,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    clipBehavior: Clip.none,
                    itemCount: recycler.length,
                    separatorBuilder: (_, _) => SizedBox(width: 20.w),
                    itemBuilder: (_, index) {
                      final product = recycler[index];
                      return DiscoverProductCard(
                        product: product,
                        width: 188.w,
                        onTap: () => controller.openRecyclerProduct(product),
                        onFavorite: () =>
                            controller.toggleProductFavorite(product),
                      );
                    },
                  ),
                ),
              ],
            ),
        ],
      );
    });
  }
}

class _ProductsBody extends GetView<DiscoverController> {
  const _ProductsBody();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final products = controller.visibleProducts;
      if (products.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.w),
          child: Text(
            AppText.noDiscoverResults,
            textAlign: TextAlign.center,
            style: manrope(14, color: AppColors.neutral500, lineHeight: 20),
          ),
        );
      }
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: _ProductGrid(
          products: products,
          onTap: (product) => controller.openDetails(product.name),
          onFavorite: controller.toggleProductFavorite,
        ),
      );
    });
  }
}

class _ServicesBody extends GetView<DiscoverController> {
  const _ServicesBody();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final services = controller.visibleServices;
      if (services.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.w),
          child: Text(
            AppText.noDiscoverResults,
            textAlign: TextAlign.center,
            style: manrope(14, color: AppColors.neutral500, lineHeight: 20),
          ),
        );
      }
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          spacing: 12.w,
          children: [
            for (final service in services)
              ServiceCard(
                service: service,
                onTap: () => controller.openDetails(service.name),
              ),
          ],
        ),
      );
    });
  }
}

class _EventsBody extends GetView<DiscoverController> {
  const _EventsBody();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final events = controller.visibleEvents;
      if (events.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.w),
          child: Text(
            AppText.noDiscoverResults,
            textAlign: TextAlign.center,
            style: manrope(14, color: AppColors.neutral500, lineHeight: 20),
          ),
        );
      }
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          spacing: 12.w,
          children: [
            for (final event in events)
              DiscoverEventCard(
                event: event,
                actionColor: AppColors.primary,
                onInterested: () => controller.toggleInterested(event),
                onDetails: () => controller.openDetails(event.title),
              ),
          ],
        ),
      );
    });
  }
}

class _ProductGrid extends StatelessWidget {
  const _ProductGrid({
    required this.products,
    required this.onTap,
    required this.onFavorite,
  });

  final List<ProductModel> products;
  final void Function(ProductModel product) onTap;
  final void Function(ProductModel product) onFavorite;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < products.length; i += 2) ...[
          if (i > 0) SizedBox(height: 16.w),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: DiscoverProductCard(
                  product: products[i],
                  onTap: () => onTap(products[i]),
                  onFavorite: () => onFavorite(products[i]),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: i + 1 < products.length
                    ? DiscoverProductCard(
                        product: products[i + 1],
                        onTap: () => onTap(products[i + 1]),
                        onFavorite: () => onFavorite(products[i + 1]),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _RecycleBody extends GetView<DiscoverController> {
  const _RecycleBody();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final items = controller.visibleRecycler;
      if (items.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.w),
          child: Text(
            AppText.noDiscoverResults,
            textAlign: TextAlign.center,
            style: manrope(14, color: AppColors.neutral500, lineHeight: 20),
          ),
        );
      }
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: _ProductGrid(
          products: items,
          onTap: controller.openRecyclerProduct,
          onFavorite: controller.toggleProductFavorite,
        ),
      );
    });
  }
}
