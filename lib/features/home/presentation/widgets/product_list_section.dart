import 'dart:ui';

import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductListSection extends GetView<HomeController> {
  const ProductListSection({super.key, required this.title, required this.products});

  final String title;
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: HomeSectionHeader(
            title: title,
            onSeeAll: () => controller.openSeeAll(title),
          ),
        ),
        SizedBox(height: 16.w),
        SizedBox(
          height: 201.w,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: products.length,
            separatorBuilder: (_, _) => SizedBox(width: 20.w),
            itemBuilder: (_, index) => _ProductCard(
              product: products[index],
              onTap: () => controller.openDetails(products[index].name),
              onFavorite: () => controller.toggleFavorite(products[index]),
            ),
          ),
        ),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.product,
    required this.onTap,
    required this.onFavorite,
  });

  final ProductModel product;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 188.w,
        height: 201.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: const [BoxShadow(color: Color(0x1A000000), blurRadius: 5)],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Stack(
            children: [
              Image.asset(
                product.image,
                width: 188.w,
                height: 139.w,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 12.w,
                right: 12.w,
                child: _FavoriteButton(product: product, onTap: onFavorite),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _ProductInfo(product: product),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({required this.product, required this.onTap});

  final ProductModel product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 34.w,
            height: 34.w,
            color: Colors.black.withValues(alpha: 0.5),
            alignment: Alignment.center,
            child: Obx(
              () => product.isFavorite.value
                  ? Icon(Icons.favorite_rounded, color: AppColors.orange, size: 20.w)
                  : SvgPicture.asset(IconPath.heart, width: 18.w, height: 18.w),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductInfo extends StatelessWidget {
  const _ProductInfo({required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
                    style: manrope(12, color: AppColors.neutral500, lineHeight: 20),
                  ),
              ],
            ),
            strutStyle: StrutStyle(fontSize: 14.sp, height: 20 / 14, forceStrutHeight: true),
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
                    SvgPicture.asset(IconPath.ratingStar, width: 18.w, height: 18.w),
                    SizedBox(width: 8.w),
                    Text(
                      product.rating!.toStringAsFixed(1),
                      style: manrope(16, color: Colors.black, lineHeight: 24),
                    ),
                  ],
                ),
            ],
          ),
        ],
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
