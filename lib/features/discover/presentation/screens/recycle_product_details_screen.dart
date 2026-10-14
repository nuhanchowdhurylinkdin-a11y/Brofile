import 'dart:ui';

import 'package:brofile/core/common/widgets/hide_on_scroll.dart';
import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/helpers/profile_navigation.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/discover/controllers/recycle_product_details_controller.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RecycleProductDetailsScreen extends GetView<RecycleProductDetailsController> {
  const RecycleProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = controller.product;
    final conditionLabel = switch (product.condition) {
      ProductCondition.likeNew => AppText.likeNew,
      ProductCondition.good => 'Good',
      null => AppText.likeNew,
    };

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: HideOnScroll(
          header: PleasureSubHeader(
            title: AppText.productDetails,
            onBack: controller.close,
          ),
          body: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: SizedBox(
                        height: 220.w,
                        width: double.infinity,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(product.image, fit: BoxFit.cover),
                            Positioned(
                              top: 12.w,
                              right: 12.w,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.r),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: GestureDetector(
                                    onTap: controller.toggleFavorite,
                                    child: Container(
                                      width: 34.w,
                                      height: 34.w,
                                      color: AppColors.openNowScrim,
                                      alignment: Alignment.center,
                                      child: Obx(
                                        () => product.isFavorite.value
                                            ? Icon(
                                                Icons.favorite_rounded,
                                                color: AppColors.orange,
                                                size: 18.w,
                                              )
                                            : SvgPicture.asset(
                                                IconPath.favoriteOutline,
                                                width: 18.w,
                                                height: 18.w,
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16.w),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 4.w,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.sellChipBg,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          product.recycleType ?? AppText.sell,
                          style: manrope(
                            12,
                            weight: FontWeight.w600,
                            color: AppColors.sellChipText,
                            lineHeight: 20,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.w),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            product.name,
                            style: manrope(
                              14,
                              weight: FontWeight.w700,
                              lineHeight: 20,
                            ),
                          ),
                        ),
                        if (product.tag != null)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 4.w,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.orangeLight,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              product.tag!,
                              style: manrope(
                                12,
                                weight: FontWeight.w500,
                                color: AppColors.orange,
                                lineHeight: 16,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 16.w),
                    Text(
                      product.price,
                      style: manrope(
                        16,
                        weight: FontWeight.w700,
                        color: AppColors.orange,
                        lineHeight: 24,
                      ),
                    ),
                    SizedBox(height: 24.w),
                    Text(
                      AppText.details,
                      style: manrope(16, weight: FontWeight.w700, lineHeight: 24),
                    ),
                    SizedBox(height: 12.w),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 18.w,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Text(
                        product.details ?? '',
                        style: manrope(
                          16,
                          color: AppColors.neutral600,
                          lineHeight: 24,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.w),
                    _InfoCard(
                      title: AppText.productInfo,
                      rows: [
                        (AppText.condition, conditionLabel),
                        (AppText.usingFor, product.usingFor ?? '2 months'),
                      ],
                    ),
                    SizedBox(height: 24.w),
                    _InfoCard(
                      title: AppText.sellerInformation,
                      rows: [
                        (AppText.condition, conditionLabel),
                        (AppText.usingFor, product.usingFor ?? '2 months'),
                      ],
                    ),
                    SizedBox(height: 24.w),
                    _SellerCard(product: product),
                    SizedBox(height: 24.w),
                    Center(
                      child: GestureDetector(
                        onTap: controller.messageSeller,
                        child: Container(
                          height: 44.w,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            AppText.messageToSeller,
                            style: manrope(
                              16,
                              weight: FontWeight.w600,
                              color: Colors.white,
                              lineHeight: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.rows});

  final String title;
  final List<(String, String)> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: manrope(16, weight: FontWeight.w700, lineHeight: 24),
          ),
          SizedBox(height: 12.w),
          for (var i = 0; i < rows.length; i++)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
              decoration: BoxDecoration(
                border: i == 0
                    ? const Border(bottom: BorderSide(color: AppColors.neutral300))
                    : null,
              ),
              child: Row(
                children: [
                  Text(
                    rows[i].$1,
                    style: manrope(14, weight: FontWeight.w600, lineHeight: 20),
                  ),
                  const Spacer(),
                  Text(
                    rows[i].$2,
                    style: manrope(
                      14,
                      weight: FontWeight.w500,
                      color: AppColors.neutral500,
                      lineHeight: 20,
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

class _SellerCard extends StatelessWidget {
  const _SellerCard({required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final avatar = product.sellerAvatar;
    if (avatar == null) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppText.sellerInformation,
            style: manrope(16, weight: FontWeight.w700, lineHeight: 24),
          ),
          SizedBox(height: 12.w),
          Padding(
            padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 16.w),
            child: GestureDetector(
              onTap: () => ProfileNavigation.open(product.sellerName ?? ''),
              behavior: HitTestBehavior.opaque,
              child: Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    avatar,
                    width: 60.w,
                    height: 60.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.sellerName ?? '',
                      style: manrope(14, weight: FontWeight.w600, lineHeight: 20),
                    ),
                    SizedBox(height: 4.w),
                    Text(
                      product.memberSince ?? '',
                      style: manrope(
                        12,
                        weight: FontWeight.w500,
                        color: AppColors.primary,
                        lineHeight: 16,
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
    );
  }
}
