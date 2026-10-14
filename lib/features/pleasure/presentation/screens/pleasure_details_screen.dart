import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/helpers/profile_navigation.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/pleasure/controllers/pleasure_details_controller.dart';
import 'package:brofile/features/pleasure/presentation/widgets/activity_cards.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PleasureDetailsScreen extends GetView<PleasureDetailsController> {
  const PleasureDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final activity = controller.activity;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: Column(
          children: [
            PleasureSubHeader(
              title: AppText.pleasureDetails,
              onBack: controller.close,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: ActivityPhoto(
                        activity: activity,
                        width: double.infinity,
                        height: 220.w,
                      ),
                    ),
                    SizedBox(height: 24.w),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            activity.title,
                            style: manrope(
                              16,
                              weight: FontWeight.w700,
                              lineHeight: 22,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.w,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.orangeLight,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            activity.tag,
                            style: manrope(
                              12,
                              weight: FontWeight.w600,
                              color: AppColors.orange,
                              lineHeight: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.w),
                    _MetaRow(
                      icon: IconPath.detailsClock,
                      text: activity.time,
                      style: manrope(
                        14,
                        weight: FontWeight.w600,
                        color: AppColors.neutral600,
                        lineHeight: 20,
                      ),
                    ),
                    if (activity.location != null) ...[
                      SizedBox(height: 8.w),
                      _MetaRow(
                        icon: IconPath.detailsPin,
                        text: activity.location!,
                        style: manrope(
                          14,
                          color: AppColors.neutral600,
                          lineHeight: 20,
                        ),
                      ),
                    ],
                    if (activity.distance != null) ...[
                      SizedBox(height: 8.w),
                      Text(
                        activity.distance!,
                        style: manrope(
                          14,
                          weight: FontWeight.w700,
                          color: AppColors.primary,
                          lineHeight: 20,
                        ),
                      ),
                    ],
                    SizedBox(height: 24.w),
                    _HostRow(
                      activityHost: activity.host,
                      avatar: activity.hostAvatar,
                      onMessage: controller.messageHost,
                      onProfile: () => ProfileNavigation.open(activity.host),
                    ),
                    SizedBox(height: 24.w),
                    Text(
                      AppText.aboutThisEvent,
                      style: manrope(16, weight: FontWeight.w700, lineHeight: 22),
                    ),
                    SizedBox(height: 12.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 18.w,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Text(
                        activity.aboutText,
                        style: manrope(
                          16,
                          color: AppColors.neutral600,
                          lineHeight: 24,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.w),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Obx(
                        () => _ImInButton(
                          joined: activity.isJoined.value,
                          onTap: controller.toggleJoin,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.w),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({
    required this.icon,
    required this.text,
    required this.style,
  });

  final String icon;
  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(icon, width: 18.w, height: 18.w),
        SizedBox(width: 8.w),
        Expanded(child: Text(text, style: style)),
      ],
    );
  }
}

class _HostRow extends StatelessWidget {
  const _HostRow({
    required this.activityHost,
    required this.avatar,
    required this.onMessage,
    required this.onProfile,
  });

  final String activityHost;
  final String avatar;
  final VoidCallback onMessage;
  final VoidCallback onProfile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onProfile,
          child: ClipOval(
            child: Image.asset(avatar, width: 40.w, height: 40.w, fit: BoxFit.cover),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: GestureDetector(
            onTap: onProfile,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppText.hostedBy,
                  style: manrope(14, weight: FontWeight.w700, lineHeight: 20),
                ),
                Text(
                  activityHost,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: manrope(
                    16,
                    weight: FontWeight.w700,
                    color: AppColors.primary,
                    lineHeight: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: onMessage,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.w),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              AppText.message,
              style: manrope(
                16,
                weight: FontWeight.w600,
                color: Colors.white,
                lineHeight: 22,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ImInButton extends StatelessWidget {
  const _ImInButton({required this.joined, required this.onTap});

  final bool joined;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 52.w,
        decoration: BoxDecoration(
          color: joined ? AppColors.joined : AppColors.primary,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: const Color(0x1FFFFFFF), width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              IconPath.imInStar,
              width: 20.w,
              height: 20.w,
            ),
            SizedBox(width: 8.w),
            Text(
              joined ? AppText.youreIn : AppText.imIn,
              style: manrope(
                16,
                weight: FontWeight.w600,
                color: Colors.white,
                lineHeight: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
