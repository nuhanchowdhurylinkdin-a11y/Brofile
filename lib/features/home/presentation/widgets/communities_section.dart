import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommunitiesSection extends GetView<HomeController> {
  const CommunitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          HomeSectionHeader(
            title: AppText.suggestedCommunities,
            onSeeAll: () => controller.openSeeAll(AppText.suggestedCommunities),
          ),
          SizedBox(height: 16.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final community in controller.communities)
                _CommunityCard(
                  community: community,
                  onTap: () => controller.openDetails(community.name),
                  onJoin: () => controller.toggleJoin(community),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CommunityCard extends StatelessWidget {
  const _CommunityCard({
    required this.community,
    required this.onTap,
    required this.onJoin,
  });

  final CommunityModel community;
  final VoidCallback onTap;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 128.w,
        padding: EdgeInsets.all(11.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.cardBorder),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.asset(
                community.image,
                width: double.infinity,
                height: 80.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8.w),
            Text(
              community.name,
              style: manrope(14, weight: FontWeight.w700, lineHeight: 20),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 4.w),
            TrimmedText(
              '${community.members} ${AppText.members}',
              style: manrope(12, color: AppColors.neutral500),
            ),
            SizedBox(height: 12.w),
            Obx(() {
              final joined = community.isJoined.value;
              return GestureDetector(
                onTap: onJoin,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: double.infinity,
                  height: 34.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: joined ? Colors.white : AppColors.primary,
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    joined ? AppText.joined : AppText.join,
                    style: manrope(
                      12,
                      weight: FontWeight.w700,
                      color: joined ? AppColors.primary : Colors.white,
                      lineHeight: 18,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
