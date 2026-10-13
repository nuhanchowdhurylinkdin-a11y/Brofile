import 'dart:ui';

import 'package:brofile/core/common/widgets/avatar_group.dart';
import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/discover/data/models/discover_models.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FeaturedBusinessCard extends StatelessWidget {
  const FeaturedBusinessCard({
    super.key,
    required this.business,
    required this.onTap,
    required this.onFavorite,
  });

  final DiscoverBusiness business;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 254.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: const [
            BoxShadow(color: Color(0x0F000000), blurRadius: 12, offset: Offset(2, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 134.w,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                    child: Image.asset(business.image, fit: BoxFit.cover),
                  ),
                  Positioned(
                    left: 8.w,
                    top: 8.w,
                    child: _OpenNowChip(visible: business.isOpen),
                  ),
                  Positioned(
                    right: 8.w,
                    top: 8.w,
                    child: _FavoriteButton(
                      isFavorite: business.isFavorite,
                      onTap: onFavorite,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      if (business.logo != null) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: Image.asset(
                            business.logo!,
                            width: 24.w,
                            height: 24.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: 8.w),
                      ],
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
                            Text(
                              business.tagline,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: manrope(
                                12,
                                weight: FontWeight.w600,
                                color: AppColors.neutral500,
                                lineHeight: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.w),
                  Row(
                    children: [
                      SvgPicture.asset(
                        IconPath.pinGreen,
                        width: 18.w,
                        height: 18.w,
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: TrimmedText(
                          business.distance ?? '',
                          style: manrope(
                            12,
                            color: business.rating == null
                                ? AppColors.primary
                                : AppColors.neutral500,
                          ),
                        ),
                      ),
                      if (business.rating != null)
                        Row(
                          children: [
                            SvgPicture.asset(
                              IconPath.ratingStar,
                              width: 12.w,
                              height: 12.w,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              business.rating!.toStringAsFixed(1),
                              style: manrope(12, lineHeight: 16),
                            ),
                          ],
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

class DiscoverProductCard extends StatelessWidget {
  const DiscoverProductCard({
    super.key,
    required this.product,
    required this.onTap,
    required this.onFavorite,
    this.width,
  });

  final ProductModel product;
  final VoidCallback onTap;
  final VoidCallback onFavorite;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: const [BoxShadow(color: Color(0x1A000000), blurRadius: 5)],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 139.w,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(product.image, fit: BoxFit.cover),
                    Positioned(
                      top: 12.w,
                      right: 12.w,
                      child: _FavoriteButton(
                        isFavorite: product.isFavorite,
                        onTap: onFavorite,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: product.name,
                            style: manrope(14, weight: FontWeight.w700, lineHeight: 20),
                          ),
                          if (product.subtitle != null)
                            TextSpan(
                              text: ' ${product.subtitle}',
                              style: manrope(12, color: AppColors.neutral500, lineHeight: 16),
                            ),
                        ],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.w),
                    Row(
                      children: [
                        Text(
                          product.price,
                          style: manrope(
                            16,
                            weight: FontWeight.w700,
                            color: AppColors.orange,
                            lineHeight: 24,
                          ),
                        ),
                        const Spacer(),
                        if (product.condition != null)
                          _ConditionTag(condition: product.condition!)
                        else if (product.rating != null)
                          Row(
                            children: [
                              SvgPicture.asset(
                                IconPath.ratingStar,
                                width: 18.w,
                                height: 18.w,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                product.rating!.toStringAsFixed(1),
                                style: manrope(16, lineHeight: 24),
                              ),
                            ],
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

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    super.key,
    required this.service,
    required this.onTap,
  });

  final DiscoverService service;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 6)],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                service.image,
                width: 120.w,
                height: 125.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: SizedBox(
                height: 125.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: manrope(16, weight: FontWeight.w700, lineHeight: 24),
                    ),
                    SizedBox(height: 4.w),
                    TrimmedText(
                      service.description,
                      maxLines: 2,
                      style: manrope(
                        12,
                        color: AppColors.neutral600,
                        lineHeight: 16,
                      ),
                    ),
                    SizedBox(height: 8.w),
                    Row(
                      children: [
                        SvgPicture.asset(
                          IconPath.detailsPin,
                          width: 18.w,
                          height: 18.w,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: TrimmedText(
                            service.location,
                            style: manrope(12, color: AppColors.neutral500),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          service.action,
                          style: manrope(
                            12,
                            weight: FontWeight.w600,
                            color: AppColors.primary,
                            lineHeight: 18,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        SvgPicture.asset(
                          IconPath.viewDetailsArrow,
                          width: 14.w,
                          height: 14.w,
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

class DiscoverEventCard extends StatelessWidget {
  const DiscoverEventCard({
    super.key,
    required this.event,
    required this.onInterested,
    required this.onDetails,
    this.actionColor = AppColors.orange,
  });

  final EventModel event;
  final VoidCallback onInterested;
  final VoidCallback onDetails;
  final Color actionColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 6)],
      ),
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(event.image, width: 160.w, fit: BoxFit.cover),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 8.w),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(8.w, 8.w, 8.w, 5.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(8.r),
                                ),
                              ),
                              child: Column(
                                children: [
                                  TrimmedText(
                                    event.day,
                                    style: manrope(
                                      20,
                                      weight: FontWeight.w700,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  Text(
                                    event.month,
                                    style: manrope(
                                      16,
                                      weight: FontWeight.w600,
                                      color: AppColors.primary,
                                      lineHeight: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            AvatarGroup(
                              images: event.attendees,
                              extra: event.extraAttendees,
                            ),
                          ],
                        ),
                        SizedBox(height: 8.w),
                        Text(
                          event.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: manrope(14, weight: FontWeight.w700, lineHeight: 20),
                        ),
                        SizedBox(height: 8.w),
                        Row(
                          children: [
                            SvgPicture.asset(
                              IconPath.clock,
                              width: 18.w,
                              height: 18.w,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: TrimmedText(
                                event.time,
                                style: manrope(12, color: AppColors.neutral500),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.w),
                        Row(
                          children: [
                            SvgPicture.asset(
                              IconPath.locationGray,
                              width: 18.w,
                              height: 18.w,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: TrimmedText(
                                event.location,
                                style: manrope(12, color: AppColors.neutral500),
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
          SizedBox(height: 12.w),
          Row(
            children: [
              Expanded(
                child: Obx(() {
                  final on = event.isInterested.value;
                  return GestureDetector(
                    onTap: onInterested,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: on ? Colors.white : actionColor,
                        border: Border.all(color: actionColor),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            IconPath.star,
                            width: 20.w,
                            height: 20.w,
                            colorFilter: ColorFilter.mode(
                              on ? actionColor : Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            AppText.interested,
                            style: manrope(
                              14,
                              weight: FontWeight.w600,
                              color: on ? actionColor : Colors.white,
                              lineHeight: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: GestureDetector(
                  onTap: onDetails,
                  child: SizedBox(
                    height: 36.w,
                    child: Center(
                      child: Text(
                        AppText.seeDetails,
                        style: manrope(
                          14,
                          weight: FontWeight.w600,
                          color: AppColors.primary,
                          lineHeight: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OpenNowChip extends StatelessWidget {
  const _OpenNowChip({required this.visible});

  final bool visible;

  @override
  Widget build(BuildContext context) {
    if (!visible) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.w),
      decoration: BoxDecoration(
        color: AppColors.openNowScrim,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        AppText.openNow,
        style: manrope(12, color: Colors.white, lineHeight: 16),
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({required this.isFavorite, required this.onTap});

  final RxBool isFavorite;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 34.w,
            height: 34.w,
            color: AppColors.openNowScrim,
            alignment: Alignment.center,
            child: Obx(
              () => isFavorite.value
                  ? Icon(Icons.favorite_rounded, color: AppColors.orange, size: 18.w)
                  : SvgPicture.asset(
                      IconPath.favoriteOutline,
                      width: 18.w,
                      height: 18.w,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ConditionTag extends StatelessWidget {
  const _ConditionTag({required this.condition});

  final ProductCondition condition;

  @override
  Widget build(BuildContext context) {
    final (label, background, foreground) = switch (condition) {
      ProductCondition.likeNew => ('Like New', AppColors.tagBlueBg, AppColors.tagBlueText),
      ProductCondition.good => ('Good', AppColors.primaryContainer, AppColors.primary),
    };
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.w),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        label,
        style: manrope(12, weight: FontWeight.w500, color: foreground, lineHeight: 16),
      ),
    );
  }
}
