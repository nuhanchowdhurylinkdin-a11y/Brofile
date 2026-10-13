import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FamilyFriendsSection extends GetView<HomeController> {
  const FamilyFriendsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = controller.friendActivities;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeSectionHeader(title: AppText.familyAndFriends),
          SizedBox(height: 16.w),
          for (var i = 0; i < activities.length; i++)
            _ActivityTile(
              activity: activities[i],
              showDivider: i < activities.length - 1,
              onTap: () => controller.openProfile(activities[i].name),
            ),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({
    required this.activity,
    required this.showDivider,
    required this.onTap,
  });

  final FriendActivity activity;
  final bool showDivider;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bold = manrope(12, weight: FontWeight.w700, lineHeight: 20);
    final regular = manrope(12, lineHeight: 20);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.only(top: 12.w, bottom: showDivider ? 11.w : 12.w),
        decoration: BoxDecoration(
          border: showDivider
              ? const Border(bottom: BorderSide(color: AppColors.neutral200))
              : null,
        ),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(activity.avatar, width: 32.w, height: 32.w, fit: BoxFit.cover),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: activity.name, style: bold),
                        TextSpan(text: ' ', style: regular),
                        TextSpan(text: activity.action, style: regular),
                        if (activity.highlight != null)
                          TextSpan(text: activity.highlight, style: bold),
                      ],
                    ),
                    strutStyle: StrutStyle(fontSize: 12.sp, height: 20 / 12, forceStrutHeight: true),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.w),
                  TrimmedText(
                    activity.timeAgo,
                    style: manrope(12, color: AppColors.neutral500),
                  ),
                ],
              ),
            ),
            if (activity.thumbnail != null) ...[
              SizedBox(width: 8.w),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  activity.thumbnail!,
                  width: 56.w,
                  height: 56.w,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
