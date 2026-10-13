import 'dart:io';

import 'package:brofile/core/common/widgets/avatar_group.dart';
import 'package:brofile/core/common/widgets/join_button.dart';
import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/pleasure/data/models/pleasure_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

const _cardShadow = [BoxShadow(color: Color(0x14000000), blurRadius: 6)];
const _imageShadow = [BoxShadow(color: Color(0x1A000000), blurRadius: 5)];

class StartingSoonCard extends StatelessWidget {
  const StartingSoonCard({
    super.key,
    required this.activity,
    required this.onTap,
    required this.onJoin,
  });

  final ActivityItem activity;
  final VoidCallback onTap;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    final location = activity.location;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: _cardShadow,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 120.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ActivityImage(
                    activity: activity,
                    height: location == null ? 104 : 124,
                  ),
                  SizedBox(height: 16.w),
                  Obx(
                    () => AvatarGroup(
                      images: activity.attendees,
                      extra: activity.extraAttendees,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HostRow(activity: activity),
                  SizedBox(height: 4.w),
                  _ActivityTitle(activity.title),
                  SizedBox(height: 4.w),
                  TrimmedText(
                    activity.description,
                    maxLines: 3,
                    style: manrope(
                      12,
                      color: AppColors.neutral600,
                      lineHeight: 16,
                    ),
                  ),
                  if (location != null) ...[
                    SizedBox(height: 12.w),
                    _LocationLine(
                      icon: IconPath.activityLocation,
                      text: location,
                      style: manrope(12, color: AppColors.neutral500),
                    ),
                  ],
                  SizedBox(height: 12.w),
                  _ActivityJoinButton(activity: activity, onJoin: onJoin),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NearbyActivityCard extends StatelessWidget {
  const NearbyActivityCard({
    super.key,
    required this.activity,
    required this.onTap,
    required this.onJoin,
  });

  final ActivityItem activity;
  final VoidCallback onTap;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: _cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ActivityImage(activity: activity, height: 124),
            SizedBox(height: 12.w),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _HostRow(activity: activity),
                      SizedBox(height: 4.w),
                      _ActivityTitle(activity.title),
                      SizedBox(height: 4.w),
                      _LocationLine(
                        icon: IconPath.activityDistance,
                        text: activity.distance ?? activity.location ?? '',
                        style: manrope(
                          14,
                          weight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 124.w,
                  height: 48.w,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Obx(
                      () => AvatarGroup(
                        images: activity.attendees,
                        extra: activity.extraAttendees,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.w),
            _ActivityJoinButton(activity: activity, onJoin: onJoin),
          ],
        ),
      ),
    );
  }
}

class FriendInterestCard extends StatelessWidget {
  const FriendInterestCard({
    super.key,
    required this.friend,
    required this.onTap,
  });

  final FriendInterest friend;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 174.w,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.cardBorder),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                friend.avatar,
                width: 52.w,
                height: 52.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    friend.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: manrope(14, weight: FontWeight.w700, lineHeight: 20),
                  ),
                  SizedBox(height: 4.w),
                  TrimmedText(
                    AppText.interestedIn,
                    style: manrope(12, color: AppColors.neutral500),
                  ),
                  SizedBox(height: 4.w),
                  Text(
                    friend.activity,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: manrope(
                      12,
                      weight: FontWeight.w700,
                      color: AppColors.primary,
                      lineHeight: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityImage extends StatelessWidget {
  const _ActivityImage({required this.activity, required this.height});

  final ActivityItem activity;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: _imageShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: ActivityPhoto(
          activity: activity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ActivityPhoto extends StatelessWidget {
  const ActivityPhoto({
    super.key,
    required this.activity,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  final ActivityItem activity;
  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    if (activity.isFileImage) {
      return Image.file(
        File(activity.image),
        width: width,
        height: height,
        fit: fit,
        alignment: activity.imageAlignment,
      );
    }
    return Image.asset(
      activity.image,
      width: width,
      height: height,
      fit: fit,
      alignment: activity.imageAlignment,
    );
  }
}

class _HostRow extends StatelessWidget {
  const _HostRow({required this.activity});

  final ActivityItem activity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40.w,
          height: 40.w,
          foregroundDecoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0x14000000), width: 0.5),
          ),
          child: ClipOval(
            child: Image.asset(activity.hostAvatar, fit: BoxFit.cover),
          ),
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                activity.host,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: manrope(18, weight: FontWeight.w600, lineHeight: 28),
              ),
              Text(
                activity.time,
                style: manrope(
                  14,
                  weight: FontWeight.w600,
                  color: AppColors.primary,
                  lineHeight: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActivityTitle extends StatelessWidget {
  const _ActivityTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        maxLines: 1,
        style: manrope(14, weight: FontWeight.w700, lineHeight: 20),
      ),
    );
  }
}

class _LocationLine extends StatelessWidget {
  const _LocationLine({
    required this.icon,
    required this.text,
    required this.style,
  });

  final String icon;
  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 18.w,
      child: Row(
        children: [
          SvgPicture.asset(icon, width: 18.w, height: 18.w),
          SizedBox(width: 8.w),
          Expanded(child: TrimmedText(text, style: style)),
        ],
      ),
    );
  }
}

class _ActivityJoinButton extends StatelessWidget {
  const _ActivityJoinButton({required this.activity, required this.onJoin});

  final ActivityItem activity;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => JoinButton(
        isJoined: activity.isJoined.value,
        onTap: onJoin,
        width: double.infinity,
        height: 42,
        fontSize: 12,
        weight: FontWeight.w700,
      ),
    );
  }
}
