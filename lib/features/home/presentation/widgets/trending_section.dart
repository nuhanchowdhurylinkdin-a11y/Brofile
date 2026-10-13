import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TrendingSection extends GetView<HomeController> {
  const TrendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final trips = controller.trendingTrips;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              children: [
                HomeSectionHeader(
                  title: AppText.trendingPleasure,
                  onSeeAll: () => controller.openSeeAll(AppText.trendingPleasure),
                ),
                SizedBox(height: 16.w),
                SizedBox(
                  height: 128.w,
                  child: PageView.builder(
                    controller: controller.trendingPageController,
                    itemCount: trips.length,
                    onPageChanged: controller.onTrendingPageChanged,
                    itemBuilder: (_, index) => _TrendingCard(
                      trip: trips[index],
                      onTap: () => controller.openDetails(trips[index].title),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 18.w),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < trips.length; i++)
                  GestureDetector(
                    onTap: () => controller.goToTrendingPage(i),
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: controller.trendingIndex.value == i
                              ? AppColors.primary
                              : AppColors.neutral200,
                        ),
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

class _TrendingCard extends StatelessWidget {
  const _TrendingCard({required this.trip, required this.onTap});

  final TrendingTrip trip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 120.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: const [
                BoxShadow(color: Color(0x1A000000), blurRadius: 5),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(trip.image, fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(11.w),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.infoBorder),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      trip.title,
                      style: manrope(16, weight: FontWeight.w700, lineHeight: 24),
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(height: 4.w),
                  Text(
                    trip.dates,
                    style: manrope(
                      14,
                      weight: FontWeight.w600,
                      color: AppColors.neutral500,
                      lineHeight: 20,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8.w),
                  Row(
                    children: [
                      SvgPicture.asset(IconPath.location, width: 18.w, height: 18.w),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: TrimmedText(
                          trip.location,
                          style: manrope(12, color: AppColors.neutral700),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.w),
                  Row(
                    children: [
                      Text(
                        AppText.viewDetails,
                        style: manrope(
                          12,
                          weight: FontWeight.w600,
                          color: AppColors.primary,
                          lineHeight: 18,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      SvgPicture.asset(IconPath.arrowUpRight, width: 18.w, height: 18.w),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
