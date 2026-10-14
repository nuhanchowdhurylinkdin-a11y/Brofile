import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/features/discover/controllers/discover_controller.dart';
import 'package:brofile/features/discover/presentation/widgets/discover_cards.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/home/presentation/widgets/post_card.dart';
import 'package:brofile/features/profile/controllers/profile_controller.dart';
import 'package:brofile/features/profile/data/models/profile_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileAboutBody extends GetView<ProfileController> {
  const ProfileAboutBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Obx(
            () => Row(
              children: [
                Expanded(
                  child: Text(
                    controller.publicLabel(AppText.myBusiness),
                    style: manrope(18, weight: FontWeight.w700, color: AppColors.primary, lineHeight: 20),
                  ),
                ),
                if (!controller.isVisitor.value)
                  GestureDetector(
                    onTap: controller.addBusiness,
                    child: Row(
                      children: [
                        SvgPicture.asset(IconPath.profilePlus, width: 20.w, height: 20.w),
                        SizedBox(width: 4.w),
                        Text(
                          AppText.addBusiness,
                          style: manrope(12, color: AppColors.orange, lineHeight: 16),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.w),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 6, offset: Offset(0, 2))],
          ),
          child: Row(
            children: [
              for (var i = 0; i < controller.businesses.length; i++) ...[
                if (i > 0) SizedBox(width: 12.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.openBusiness(controller.businesses[i]),
                    child: _BusinessChip(business: controller.businesses[i]),
                  ),
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: 28.w),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Obx(
            () => Text(
              controller.publicLabel(AppText.myActivities),
              style: manrope(18, weight: FontWeight.w700, color: AppColors.primary, lineHeight: 20),
            ),
          ),
        ),
        SizedBox(height: 16.w),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Obx(() {
            final selected = controller.activityFilter.value;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (final filter in ProfileActivityFilter.values) ...[
                      _ActivityChip(
                        label: switch (filter) {
                          ProfileActivityFilter.all => AppText.all,
                          ProfileActivityFilter.community => AppText.communities,
                          ProfileActivityFilter.pleasure => AppText.navPleasure,
                          ProfileActivityFilter.recycle => AppText.recycle,
                        },
                        selected: selected == filter,
                        onTap: () => controller.selectActivity(filter),
                      ),
                      SizedBox(width: 4.w),
                    ],
                  ],
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 28.w),
        Obx(() {
          final filter = controller.activityFilter.value;
          return Column(
            children: [
              if (filter == ProfileActivityFilter.all ||
                  filter == ProfileActivityFilter.community)
                for (final post in controller.posts) ...[
                  PostCard(post: post),
                  SizedBox(height: 28.w),
                ],
              if (filter == ProfileActivityFilter.all ||
                  filter == ProfileActivityFilter.pleasure) ...[
                const _ProfileEventCard(),
                SizedBox(height: 28.w),
                const _CatchReleaseCard(),
              ],
              if (filter == ProfileActivityFilter.recycle) const _RecycleGrid(),
            ],
          );
        }),
      ],
    );
  }
}

class _BusinessChip extends StatelessWidget {
  const _BusinessChip({required this.business});

  final ProfileBusiness business;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(business.logo, width: 39.w, height: 39.w, fit: BoxFit.cover),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  business.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: manrope(14, weight: FontWeight.w700, lineHeight: 20),
                ),
                SizedBox(height: 4.w),
                Text(
                  business.category,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: manrope(12, color: AppColors.neutral400, lineHeight: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityChip extends StatelessWidget {
  const _ActivityChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          label,
          style: manrope(
            12,
            weight: selected ? FontWeight.w700 : FontWeight.w400,
            color: selected ? AppColors.primary : AppColors.neutral500,
            lineHeight: selected ? 18 : 16,
          ),
        ),
      ),
    );
  }
}

class _ProfileEventCard extends GetView<ProfileController> {
  const _ProfileEventCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: SizedBox(
          height: 264.w,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(ImagePath.catchRelease, fit: BoxFit.cover),
              Positioned(
                right: 12.w,
                top: 12.w,
                child: GestureDetector(
                  onTap: controller.eventFavorited.toggle,
                  behavior: HitTestBehavior.opaque,
                  child: SizedBox(width: 44.w, height: 44.w),
                ),
              ),
              Positioned(
                left: 16.w,
                right: 16.w,
                bottom: 16.w,
                height: 44.w,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.event.isInterested.toggle(),
                        behavior: HitTestBehavior.opaque,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.openDetails(AppText.morningTrekTitle),
                        behavior: HitTestBehavior.opaque,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CatchReleaseCard extends GetView<ProfileController> {
  const _CatchReleaseCard();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Image.asset(
              ImagePath.profileEvent,
              width: double.infinity,
              height: 184.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 24.w),
          Row(
            children: [
              Flexible(
                child: Text(
                  AppText.catchAndRelease,
                  style: manrope(
                    16,
                    weight: FontWeight.w700,
                    color: AppColors.textGray800,
                    lineHeight: 24,
                  ),
                ),
              ),
              SizedBox(width: 11.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.w),
                decoration: BoxDecoration(
                  color: AppColors.orangeLight,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  AppText.adventureFishing,
                  style: manrope(12, weight: FontWeight.w500, color: AppColors.orange, lineHeight: 16),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.w),
          Row(
            children: [
              SvgPicture.asset(IconPath.profileCalendar, width: 18.w, height: 18.w),
              SizedBox(width: 4.w),
              Text('Date', style: manrope(14, color: AppColors.neutral500, lineHeight: 20)),
              SizedBox(width: 40.w),
              SvgPicture.asset(IconPath.profileMarker, width: 18.w, height: 18.w),
              SizedBox(width: 4.w),
              Text('Location', style: manrope(14, color: AppColors.neutral500, lineHeight: 20)),
            ],
          ),
          SizedBox(height: 16.w),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text:
                      'Weekend fishing memories with friends. Beautiful rivers, amazing catches, and unforgettable outdoor moments. ',
                  style: manrope(16, color: AppColors.neutral600, lineHeight: 24),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: GestureDetector(
                    onTap: () => controller.openDetails(AppText.catchAndRelease),
                    child: Text(
                      AppText.viewDetails,
                      style: manrope(14, weight: FontWeight.w600, color: AppColors.primary, lineHeight: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RecycleGrid extends StatelessWidget {
  const _RecycleGrid();

  @override
  Widget build(BuildContext context) {
    final discover = Get.find<DiscoverController>();
    final products = discover.visibleRecycler.take(4).toList();
    if (products.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
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
        children: [
          for (var i = 0; i < products.length; i += 2) ...[
            if (i > 0) SizedBox(height: 16.w),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: DiscoverProductCard(
                    product: products[i],
                    onTap: () => discover.openRecyclerProduct(products[i]),
                    onFavorite: () => discover.toggleProductFavorite(products[i]),
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: i + 1 < products.length
                      ? DiscoverProductCard(
                          product: products[i + 1],
                          onTap: () => discover.openRecyclerProduct(products[i + 1]),
                          onFavorite: () =>
                              discover.toggleProductFavorite(products[i + 1]),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
