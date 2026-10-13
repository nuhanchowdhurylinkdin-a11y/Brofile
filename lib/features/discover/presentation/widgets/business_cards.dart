import 'dart:math' as math;
import 'dart:ui';

import 'package:brofile/core/common/widgets/avatar_group.dart';
import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/discover/data/models/discover_models.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/features/home/presentation/widgets/comments_sheet.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/home/presentation/widgets/post_sheets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BusinessSectionHeader extends StatelessWidget {
  const BusinessSectionHeader({
    super.key,
    required this.title,
    this.onSeeAll,
  });

  final String title;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: manrope(18, weight: FontWeight.w700, lineHeight: 20),
          ),
        ),
        if (onSeeAll != null)
          GestureDetector(
            onTap: onSeeAll,
            child: Text(
              AppText.seeAll,
              style: manrope(14, color: AppColors.primary, lineHeight: 20),
            ),
          ),
      ],
    );
  }
}

class FeaturedOverlayCard extends StatelessWidget {
  const FeaturedOverlayCard({
    super.key,
    required this.business,
    required this.onTap,
  });

  final DiscoverBusiness business;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: SizedBox.expand(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(business.image, fit: BoxFit.cover),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withValues(alpha: 0.7),
                        Colors.transparent,
                      ],
                      stops: const [0.54359, 0.9923],
                      transform: const GradientRotation(48.853 * math.pi / 180),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          _BusinessLogo(business: business, featured: true),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TrimmedText(
                                  business.name,
                                  style: manrope(
                                    20,
                                    weight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 8.w),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      IconPath.pinWhite,
                                      width: 18.w,
                                      height: 18.w,
                                    ),
                                    SizedBox(width: 4.w),
                                    TrimmedText(
                                      business.distance ?? '',
                                      style: manrope(12, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.w),
                      Text(
                        business.tagline,
                        style: manrope(14, color: Colors.white, lineHeight: 20),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          AvatarGroup(images: business.followerAvatars),
                          SizedBox(width: 8.w),
                          Flexible(
                            child: Text(
                              business.followers,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: manrope(
                                12,
                                weight: FontWeight.w500,
                                color: Colors.white,
                                lineHeight: 16,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 8.w,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              AppText.viewProfile,
                              style: manrope(
                                14,
                                weight: FontWeight.w600,
                                color: AppColors.primary,
                                lineHeight: 20,
                              ),
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
      ),
    );
  }
}

class LogoBusinessCard extends StatelessWidget {
  const LogoBusinessCard({
    super.key,
    required this.business,
    required this.onTap,
  });

  final DiscoverBusiness business;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 194.w,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.cardBorder),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: const [
            BoxShadow(color: Color(0x14000000), blurRadius: 4),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 90.w,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 112.w,
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(8.r),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(business.image, fit: BoxFit.cover),
                          if (business.isNew)
                            Positioned(
                              top: 8.w,
                              right: 8.w,
                              child: const _NewArrivalsChip(),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _BusinessLogo(business: business),
                  SizedBox(height: 4.w),
                  Text(
                    business.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: manrope(14, weight: FontWeight.w700, lineHeight: 20),
                  ),
                  SizedBox(height: 4.w),
                  Text(
                    business.tagline,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: manrope(
                      12,
                      weight: FontWeight.w700,
                      color: AppColors.primary,
                      lineHeight: 18,
                    ),
                  ),
                  SizedBox(height: 8.w),
                  TrimmedText(
                    business.followers,
                    style: manrope(12, color: AppColors.neutral700),
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

class NearbyBusinessCard extends StatelessWidget {
  const NearbyBusinessCard({
    super.key,
    required this.business,
    required this.onTap,
  });

  final DiscoverBusiness business;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 194.w,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.cardBorder),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: const [
            BoxShadow(color: Color(0x14000000), blurRadius: 4),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
              child: Image.asset(
                business.image,
                height: 112.w,
                width: 194.w,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    business.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: manrope(14, weight: FontWeight.w700, lineHeight: 20),
                  ),
                  SizedBox(height: 4.w),
                  Text(
                    business.tagline,
                    style: manrope(
                      12,
                      weight: FontWeight.w700,
                      color: AppColors.primary,
                      lineHeight: 18,
                    ),
                  ),
                  SizedBox(height: 4.w),
                  Row(
                    children: [
                      SvgPicture.asset(
                        IconPath.pinGreen,
                        width: 18.w,
                        height: 18.w,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          business.distance ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: manrope(
                            12,
                            weight: FontWeight.w600,
                            lineHeight: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.w),
                  TrimmedText(
                    business.followers,
                    style: manrope(12, color: AppColors.neutral700),
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

class SuggestedBusinessCard extends StatelessWidget {
  const SuggestedBusinessCard({
    super.key,
    required this.business,
    required this.onTap,
    required this.onFollow,
  });

  final DiscoverBusiness business;
  final VoidCallback onTap;
  final VoidCallback onFollow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 207.w,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.neutral100),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    business.image,
                    width: 40.w,
                    height: 40.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        business.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: manrope(
                          16,
                          weight: FontWeight.w700,
                          lineHeight: 24,
                        ),
                      ),
                      Text(
                        business.tagline,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: manrope(12, weight: FontWeight.w500, lineHeight: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.w),
            Obx(() {
              final following = business.isFollowing.value;
              return GestureDetector(
                onTap: onFollow,
                child: Container(
                  height: 34.w,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: following ? AppColors.primary : Colors.white,
                    border: Border.all(color: AppColors.primary),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    following ? AppText.following : AppText.follow,
                    style: manrope(
                      12,
                      weight: FontWeight.w700,
                      color: following ? Colors.white : AppColors.primary,
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

class BusinessFeedPost extends GetView<HomeController> {
  const BusinessFeedPost({super.key, required this.feed});

  final DiscoverFeedPost feed;

  @override
  Widget build(BuildContext context) {
    final post = feed.post;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 12.w),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.neutral200)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => controller.openProfile(post.author),
                child: Padding(
                  padding: EdgeInsets.all(2.w),
                  child: SizedBox.square(
                    dimension: 40.w,
                    child: Stack(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            post.avatar,
                            width: 40.w,
                            height: 40.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        if (post.isOnline)
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 10.w,
                              height: 10.w,
                              decoration: BoxDecoration(
                                color: AppColors.online,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 1.5.w),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            post.author,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: manrope(
                              16,
                              weight: FontWeight.w700,
                              color: AppColors.primary,
                              lineHeight: 24,
                            ),
                          ),
                        ),
                        SizedBox(width: 4.w),
                        TrimmedText(
                          post.timeAgo,
                          style: manrope(12, color: AppColors.neutral400),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.w),
                    TrimmedText(
                      post.tag,
                      style: manrope(12, color: AppColors.neutral500),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => showPostMenu(post),
                child: SvgPicture.asset(
                  IconPath.postMenu,
                  width: 24.w,
                  height: 24.w,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.w),
        if (post.layout == PostLayout.double)
          SizedBox(
            height: 220.w,
            child: Row(
              children: [
                Expanded(child: _RoundedImage(image: post.images[0], height: 220.w)),
                SizedBox(width: 12.w),
                Expanded(child: _RoundedImage(image: post.images[1], height: 220.w)),
              ],
            ),
          )
        else
          _RoundedImage(image: post.images.first, height: 221.w),
        SizedBox(height: 12.w),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
          decoration: const BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(color: AppColors.neutral200),
            ),
          ),
          child: Obx(() {
            final reaction = post.reaction.value;
            return Row(
              children: [
                _Reaction(
                  icon: IconPath.like,
                  count: post.likes.value,
                  isActive: reaction == Reaction.like,
                  onTap: () => controller.react(post, Reaction.like),
                ),
                SizedBox(width: 8.w),
                _Reaction(
                  icon: IconPath.dislike,
                  count: post.dislikes.value,
                  isActive: reaction == Reaction.dislike,
                  onTap: () => controller.react(post, Reaction.dislike),
                ),
                SizedBox(width: 8.w),
                _Reaction(
                  icon: IconPath.comment,
                  count: post.commentCount,
                  onTap: () => showCommentsSheet(post),
                ),
              ],
            );
          }),
        ),
        SizedBox(height: 12.w),
        if (feed.hashtag != null) ...[
          Text(
            feed.hashtag!,
            style: manrope(
              14,
              weight: FontWeight.w500,
              color: AppColors.followBlue,
              lineHeight: 20,
            ),
          ),
          SizedBox(height: 8.w),
        ],
        Text(
          post.text,
          style: manrope(14, color: AppColors.neutral600, lineHeight: 24),
        ),
      ],
    );
  }
}

class _RoundedImage extends StatelessWidget {
  const _RoundedImage({required this.image, required this.height});

  final String image;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Image.asset(
        image,
        width: double.infinity,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _Reaction extends StatelessWidget {
  const _Reaction({
    required this.icon,
    required this.count,
    required this.onTap,
    this.isActive = false,
  });

  final String icon;
  final int count;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.primary : AppColors.neutral400;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          SizedBox.square(
            dimension: 24.w,
            child: Center(
              child: SvgPicture.asset(
                icon,
                height: 20.2.w,
                colorFilter: isActive
                    ? const ColorFilter.mode(AppColors.primary, BlendMode.srcIn)
                    : null,
              ),
            ),
          ),
          SizedBox(width: 4.w),
          SizedBox(
            width: 40.w,
            height: 24.w,
            child: Center(
              child: TrimmedText('$count', style: manrope(12, color: color)),
            ),
          ),
        ],
      ),
    );
  }
}

class _BusinessLogo extends StatelessWidget {
  const _BusinessLogo({required this.business, this.featured = false});

  final DiscoverBusiness business;
  final bool featured;

  @override
  Widget build(BuildContext context) {
    final size = featured ? 48.w : 46.w;
    if (business.goldBadge) {
      return Container(
        width: size,
        height: size,
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 6.w),
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.badgeGold, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(IconPath.peakfitBadge, width: 16.w, height: 16.w),
            SizedBox(height: 2.w),
            FittedBox(
              child: Text(
                'PeakFit Gym',
                style: manrope(
                  7,
                  weight: FontWeight.w700,
                  color: AppColors.badgeGold,
                  lineHeight: 7,
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (business.badgeText != null) {
      return Container(
        width: size,
        height: size,
        padding: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
          color: AppColors.warning100,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Center(
          child: Text(
            business.badgeText!,
            textAlign: TextAlign.center,
            style: manrope(8, weight: FontWeight.w700, lineHeight: 10),
          ),
        ),
      );
    }

    final image = business.logo ?? business.image;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: business.logoBorder == null
            ? null
            : Border.all(color: business.logoBorder!, width: 2),
      ),
      clipBehavior: Clip.antiAlias,
      child: ClipOval(
        child: Image.asset(image, fit: BoxFit.cover),
      ),
    );
  }
}

class _NewArrivalsChip extends StatelessWidget {
  const _NewArrivalsChip();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
          color: Colors.white.withValues(alpha: 0.1),
          child: TrimmedText(
            AppText.newArrivals,
            style: manrope(12, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
