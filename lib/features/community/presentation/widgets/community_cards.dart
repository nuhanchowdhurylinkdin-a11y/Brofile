import 'dart:math' as math;
import 'dart:ui';

import 'package:brofile/core/common/widgets/avatar_group.dart';
import 'package:brofile/core/common/widgets/join_button.dart';
import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/community/data/models/community_models.dart';
import 'package:brofile/features/community/presentation/widgets/member_stats.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FeaturedCommunityCard extends StatelessWidget {
  const FeaturedCommunityCard({
    super.key,
    required this.community,
    required this.onTap,
    required this.onJoin,
  });

  final CommunityItem community;
  final VoidCallback onTap;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: SizedBox(
          height: 172.w,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(community.image, fit: BoxFit.cover),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF060300), Color(0x00060300)],
                    stops: [0.01, 0.83],
                    transform: GradientRotation(14 * math.pi / 180),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRect(
                        child: Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width: 181.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                community.name,
                                style: manrope(
                                  18,
                                  weight: FontWeight.w700,
                                  color: Colors.white,
                                  lineHeight: 20,
                                ),
                              ),
                              SizedBox(height: 4.w),
                              MemberStats(
                                members: community.members,
                                online: community.online,
                                style: manrope(
                                  12,
                                  weight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 12.w),
                              Flexible(
                                child: TrimmedText(
                                  community.description,
                                  maxLines: 3,
                                  style: manrope(
                                    12,
                                    color: Colors.white,
                                    lineHeight: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AvatarGroup(
                          images: community.memberAvatars,
                          extra: community.extraMembers,
                        ),
                        Obx(
                          () => JoinButton(
                            isJoined: community.isJoined.value,
                            onTap: onJoin,
                            light: true,
                            width: 74,
                            height: 40,
                            radius: 20,
                          ),
                        ),
                      ],
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

class MyCommunityCard extends StatelessWidget {
  const MyCommunityCard({
    super.key,
    required this.community,
    required this.onTap,
  });

  final CommunityItem community;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.cardBorder),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 104 / 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(community.image, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 8.w),
            MemberStats(
              members: community.members,
              online: community.online,
              spread: true,
              style: manrope(12, color: AppColors.neutral700),
            ),
            SizedBox(height: 8.w),
            Text(
              community.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: manrope(14, weight: FontWeight.w700, lineHeight: 20),
            ),
            SizedBox(height: 4.w),
            TrimmedText(
              community.tagline,
              style: manrope(12, color: AppColors.neutral500),
            ),
          ],
        ),
      ),
    );
  }
}

class TrendingCommunityRow extends StatelessWidget {
  const TrendingCommunityRow({
    super.key,
    required this.community,
    required this.onTap,
    required this.onJoin,
  });

  final CommunityItem community;
  final VoidCallback onTap;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 120.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                boxShadow: const [
                  BoxShadow(color: Color(0x1A000000), blurRadius: 5),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                // Positioned keeps the image's natural height out of the
                // row's intrinsic height.
                child: Stack(
                  children: [
                    Positioned.fill(child: Image.asset(community.image, fit: BoxFit.cover)),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.infoBorder),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      community.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: manrope(
                        18,
                        weight: FontWeight.w700,
                        lineHeight: 20,
                      ),
                    ),
                    SizedBox(height: 4.w),
                    MemberStats(
                      members: community.members,
                      online: community.online,
                      style: manrope(14, color: AppColors.neutral700),
                    ),
                    SizedBox(height: 12.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AvatarGroup(
                          images: community.memberAvatars,
                          extra: community.extraMembers,
                        ),
                        Obx(
                          () => JoinButton(
                            isJoined: community.isJoined.value,
                            onTap: onJoin,
                            width: 104,
                            height: 34,
                            fontSize: 12,
                            weight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
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

class NewCommunityCard extends StatelessWidget {
  const NewCommunityCard({
    super.key,
    required this.community,
    required this.onTap,
  });

  final CommunityItem community;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 194.w,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.neutral100),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4.r),
              child: Image.asset(
                community.image,
                width: 64.w,
                height: 64.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    community.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: manrope(16, weight: FontWeight.w700, lineHeight: 24),
                  ),
                  SizedBox(height: 4.w),
                  Text(
                    '${community.members} ${AppText.membersTitle}',
                    style: manrope(14, lineHeight: 20),
                  ),
                  SizedBox(height: 4.w),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          AppText.viewDetails,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: manrope(
                            12,
                            weight: FontWeight.w600,
                            color: AppColors.primary,
                            lineHeight: 18,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        IconPath.viewDetailsArrow,
                        width: 18.w,
                        height: 18.w,
                      ),
                    ],
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

class NearbyCommunityCard extends StatelessWidget {
  const NearbyCommunityCard({
    super.key,
    required this.community,
    required this.onTap,
    required this.onJoin,
  });

  static double get height => 290.w;
  static double get _imageHeight => 198.w;
  static double get _overlap => 18.w;

  final CommunityItem community;
  final VoidCallback onTap;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(12.r);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: _imageHeight,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: radius),
                child: Image.asset(community.image, fit: BoxFit.cover),
              ),
            ),
            Positioned(
              top: 12.w,
              left: 12.w,
              right: 12.w,
              child: Row(
                children: [
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: _CategoryTag(label: community.category),
                    ),
                  ),
                  _GlassPill(
                    width: 82,
                    height: 26,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 12.w,
                            height: 12.w,
                            decoration: const BoxDecoration(
                              color: AppColors.online,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            '${community.online} ${AppText.onlineLower}',
                            style: manrope(
                              12,
                              weight: FontWeight.w600,
                              color: Colors.white,
                              lineHeight: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: _imageHeight - _overlap,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(bottom: radius),
                ),
                foregroundDecoration: BoxDecoration(
                  border: Border.all(color: AppColors.neutral200),
                  borderRadius: BorderRadius.vertical(bottom: radius),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            community.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: manrope(
                              16,
                              weight: FontWeight.w700,
                              color: AppColors.primary,
                              lineHeight: 24,
                            ),
                          ),
                          SizedBox(height: 4.w),
                          Text(
                            community.address,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: manrope(
                              12,
                              weight: FontWeight.w500,
                              color: AppColors.neutral700,
                              lineHeight: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8.w),
                    SizedBox(
                      width: 124.w,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AvatarGroup(
                            images: community.memberAvatars,
                            extra: community.extraMembers,
                          ),
                          SizedBox(height: 12.w),
                          Obx(
                            () => JoinButton(
                              isJoined: community.isJoined.value,
                              onTap: onJoin,
                              width: 124,
                              height: 40,
                              outlined: true,
                            ),
                          ),
                        ],
                      ),
                    ),
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

class _CategoryTag extends StatelessWidget {
  const _CategoryTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.w,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.w, top: 3.w),
            child: _GlassPill(
              height: 26,
              padding: EdgeInsets.symmetric(horizontal: 23.w),
              child: Text(
                label,
                style: manrope(
                  12,
                  weight: FontWeight.w600,
                  color: Colors.white,
                  lineHeight: 18,
                ),
              ),
            ),
          ),
          Container(
            width: 32.w,
            height: 32.w,
            padding: EdgeInsets.all(8.w),
            decoration: const BoxDecoration(
              color: AppColors.lifestyleTag,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(IconPath.lifestyle),
          ),
        ],
      ),
    );
  }
}

class _GlassPill extends StatelessWidget {
  const _GlassPill({
    required this.height,
    required this.child,
    this.width,
    this.padding,
  });

  final double height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          width: width?.w,
          height: height.w,
          padding: padding,
          alignment: Alignment.center,
          color: AppColors.blackAlpha40,
          child: child,
        ),
      ),
    );
  }
}
