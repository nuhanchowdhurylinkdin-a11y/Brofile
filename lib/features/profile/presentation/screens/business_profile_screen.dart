import 'package:brofile/core/common/widgets/hide_on_scroll.dart';
import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/features/community/presentation/widgets/community_media.dart';
import 'package:brofile/features/discover/presentation/widgets/discover_cards.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/features/home/presentation/widgets/category_chips.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:brofile/features/profile/controllers/business_profile_controller.dart';
import 'package:brofile/features/profile/data/models/profile_models.dart';
import 'package:brofile/features/profile/presentation/widgets/business_profile_about.dart';
import 'package:brofile/features/profile/presentation/widgets/business_profile_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BusinessProfileScreen extends GetView<BusinessProfileController> {
  const BusinessProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: const _BusinessProfileBody(),
      ),
    );
  }
}

class _BusinessProfileBody extends GetView<BusinessProfileController> {
  const _BusinessProfileBody();

  @override
  Widget build(BuildContext context) {
    return HideOnScroll(
      header: Obx(
        () => PleasureSubHeader(
          title: controller.studioName.value,
          onBack: Get.back,
          showClose: false,
        ),
      ),
      body: CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              SliverPadding(
                padding: EdgeInsets.only(top: 8.w),
                sliver: const SliverToBoxAdapter(child: _BusinessHero()),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 20.w)),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: const SliverToBoxAdapter(child: _ActionButtons()),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 16.w)),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: const SliverToBoxAdapter(child: _ProfileTabs()),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 16.w)),
              SliverToBoxAdapter(
                child: Obx(() {
                  final tab = controller.tab.value;
                  return KeyedSubtree(
                    key: ValueKey(tab),
                    child: switch (tab) {
                      BusinessProfileTab.posts => const _PostsTab(),
                      BusinessProfileTab.products => const _ProductsTab(),
                      BusinessProfileTab.services => const _ServicesTab(),
                      BusinessProfileTab.events => const _EventsTab(),
                      BusinessProfileTab.about => const BusinessProfileAbout(),
                    },
                  );
                }),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 32.w)),
            ],
          ),
    );
  }
}

class _BusinessHero extends GetView<BusinessProfileController> {
  const _BusinessHero();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 238.w,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(
                    ImagePath.bizCoverYoga,
                    width: double.infinity,
                    height: 198.w,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 12.w,
                  top: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.w),
                    decoration: BoxDecoration(
                      color: const Color(0x4D000000),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      AppText.openNow,
                      style: manrope(12, weight: FontWeight.w500, color: Colors.white, lineHeight: 16),
                    ),
                  ),
                ),
                Obx(() {
                  if (controller.isVisitor.value) return const SizedBox.shrink();
                  return Positioned(
                    right: 12.w,
                    top: 12.w,
                    child: GestureDetector(
                      onTap: controller.editProfile,
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: AppColors.openNowScrim,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: SvgPicture.asset(IconPath.profileCoverEdit),
                      ),
                    ),
                  );
                }),
                Positioned(
                  left: 34.w,
                  top: 158.w,
                  child: ClipOval(
                    child: Image.asset(
                      ImagePath.bizLogoGreenleaf,
                      width: 80.w,
                      height: 80.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.w),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.w,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Obx(
                () => Text(
                  controller.studioName.value,
                  style: manrope(16, weight: FontWeight.w600, color: AppColors.primary, lineHeight: 24),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.w),
                decoration: BoxDecoration(
                  color: AppColors.orangeLight,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  AppText.fitnessYoga,
                  style: manrope(12, weight: FontWeight.w500, color: AppColors.orange, lineHeight: 16),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.w),
          Obx(
            () => Text(
              controller.handle.value,
              style: manrope(12, color: AppColors.neutral500, lineHeight: 16),
            ),
          ),
          SizedBox(height: 20.w),
          Obx(() {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.bio,
                  style: manrope(14, color: const Color(0xFF4B5563), lineHeight: 20),
                ),
                SizedBox(height: 4.w),
                GestureDetector(
                  onTap: controller.toggleBio,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        controller.bioExpanded.value ? AppText.showLess : AppText.showMore,
                        style: manrope(
                          12,
                          weight: FontWeight.w600,
                          color: const Color(0xFF1B4332),
                          lineHeight: 18,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      SvgPicture.asset(
                        IconPath.chevronDown,
                        width: 16.w,
                        height: 16.w,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
          SizedBox(height: 20.w),
          Obx(() => _MetaRow(icon: IconPath.profilePin, label: controller.address.value)),
          SizedBox(height: 16.w),
          _MetaRow(icon: IconPath.profileLink, label: AppText.greenleafWebsite),
          SizedBox(height: 16.w),
          _MetaRow(icon: IconPath.bizPhone, label: AppText.greenleafPhone),
          SizedBox(height: 20.w),
          const _StatsRow(),
        ],
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.icon, required this.label});

  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon, width: 20.w, height: 20.w),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(label, style: manrope(14, color: AppColors.neutral600, lineHeight: 20)),
        ),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.neutral200)),
      ),
      padding: EdgeInsets.symmetric(vertical: 20.w),
      child: Row(
        children: const [
          _StatItem(value: AppText.followersCount, label: AppText.followers),
          _StatItem(value: AppText.productsCount, label: AppText.products, bordered: true),
          _StatItem(value: AppText.servicesCount, label: AppText.services),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.value, required this.label, this.bordered = false});

  final String value;
  final String label;
  final bool bordered;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: 120.w,
        decoration: bordered
            ? const BoxDecoration(
                border: Border.symmetric(vertical: BorderSide(color: AppColors.neutral300)),
              )
            : null,
        child: Column(
          children: [
            Text(value, textAlign: TextAlign.center, style: manrope(16, weight: FontWeight.w700, lineHeight: 24)),
            SizedBox(height: 4.w),
            Text(label, textAlign: TextAlign.center, style: manrope(12, lineHeight: 16)),
          ],
        ),
      ),
    );
  }
}

class _ActionButtons extends GetView<BusinessProfileController> {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final followMode =
          controller.isVisitor.value || controller.tab.value == BusinessProfileTab.about;
      return Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: followMode ? controller.toggleFollow : controller.openCreate,
              child: Container(
                height: 44.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.orange,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: const Color(0x1FFFFFFF), width: 2),
                ),
                child: Text(
                  followMode
                      ? (controller.isFollowing.value ? AppText.following : AppText.follow)
                      : AppText.createNew,
                  style: manrope(16, weight: FontWeight.w600, color: Colors.white, lineHeight: 24),
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: GestureDetector(
              onTap: controller.message,
              child: Container(
                height: 44.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: AppColors.primary, width: 1.5),
                ),
                child: Text(
                  AppText.message,
                  style: manrope(16, weight: FontWeight.w600, color: AppColors.neutral700, lineHeight: 24),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class _ProfileTabs extends GetView<BusinessProfileController> {
  const _ProfileTabs();

  static const _selected = Color(0xFF1B4332);
  static const _unselected = Color(0xFF6B7280);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller.tabController,
      onTap: (index) => controller.selectTab(BusinessProfileTab.values[index]),
      isScrollable: false,
      tabAlignment: TabAlignment.fill,
      labelPadding: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      splashFactory: NoSplash.splashFactory,
      labelColor: _selected,
      unselectedLabelColor: _unselected,
      labelStyle: manrope(12, lineHeight: 16),
      unselectedLabelStyle: manrope(12, lineHeight: 16),
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: _selected, width: 2.w),
        insets: EdgeInsets.zero,
      ),
      dividerColor: const Color(0xFFF3F4F6),
      tabs: [
        Tab(text: AppText.postsTab, height: 44.w),
        Tab(text: AppText.products, height: 44.w),
        Tab(text: AppText.services, height: 44.w),
        Tab(text: AppText.events, height: 44.w),
        Tab(text: AppText.aboutTab, height: 44.w),
      ],
    );
  }
}

class _PostsTab extends GetView<BusinessProfileController> {
  const _PostsTab();

  @override
  Widget build(BuildContext context) {
    final event = controller.discover.events.first;
    return Obx(() {
      controller.listedPosts.length;
      return Column(
        children: [
          for (final post in controller.listedPosts) ...[
            BusinessProfilePost(post: post, child: _PostImages(post: post)),
            SizedBox(height: 12.w),
          ],
          BusinessProfilePost(
            post: controller.promoPost,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                ImagePath.bizPostSummer,
                width: double.infinity,
                height: 184.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 12.w),
          BusinessProfilePost(
            post: controller.eventPost,
            child: DiscoverEventCard(
              event: event,
              onInterested: () => controller.toggleEvent(event),
              onDetails: () => controller.openEvent(event),
            ),
          ),
          SizedBox(height: 12.w),
          BusinessProfilePost(
            post: controller.productPost,
            child: BusinessEmbeddedProduct(
              product: controller.yogaMat,
              onView: () => controller.openDetails(controller.yogaMat.name),
            ),
          ),
        ],
      );
    });
  }
}

class _PostImages extends StatelessWidget {
  const _PostImages({required this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    if (post.images.isEmpty) return const SizedBox.shrink();
    if (post.images.length == 1) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: SizedBox(
          width: double.infinity,
          height: 221.w,
          child: CommunityMedia.image(post.images.first),
        ),
      );
    }
    return Row(
      children: [
        for (var i = 0; i < post.images.take(2).length; i++) ...[
          if (i > 0) SizedBox(width: 20.w),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: SizedBox(
                height: 221.w,
                child: CommunityMedia.image(post.images[i]),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _CategoryHeader extends GetView<BusinessProfileController> {
  const _CategoryHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            AppText.exploreByCategory,
            style: manrope(18, weight: FontWeight.w700, lineHeight: 20),
          ),
        ),
        SizedBox(height: 16.w),
        CategoryChips(
          labels: HomeController.categories,
          selected: controller.selectedCategory,
          onSelected: controller.selectCategory,
        ),
        SizedBox(height: 16.w),
      ],
    );
  }
}

class _ProductsTab extends GetView<BusinessProfileController> {
  const _ProductsTab();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.selectedCategory.value;
      controller.listedProducts.length;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _CategoryHeader(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: _ProductGrid(
              products: controller.products,
              onTap: (product) => controller.openDetails(product.name),
              onFavorite: controller.toggleProductFavorite,
            ),
          ),
        ],
      );
    });
  }
}

class _ServicesTab extends GetView<BusinessProfileController> {
  const _ServicesTab();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.selectedCategory.value;
      controller.listedServices.length;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _CategoryHeader(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              spacing: 12.w,
              children: [
                for (final service in controller.services)
                  ServiceCard(
                    service: service,
                    onTap: () => controller.openDetails(service.name),
                  ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

class _EventsTab extends GetView<BusinessProfileController> {
  const _EventsTab();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.selectedCategory.value;
      controller.listedEvents.length;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _CategoryHeader(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              spacing: 12.w,
              children: [
                for (final event in controller.events)
                  DiscoverEventCard(
                    event: event,
                    onInterested: () => controller.toggleEvent(event),
                    onDetails: () => controller.openEvent(event),
                  ),
              ],
            ),
          ),
        ],
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
    if (products.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 24.w),
        child: Text(
          AppText.noDiscoverResults,
          textAlign: TextAlign.center,
          style: manrope(14, color: AppColors.neutral500, lineHeight: 20),
        ),
      );
    }
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
