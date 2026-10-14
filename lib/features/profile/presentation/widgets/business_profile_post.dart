import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/features/home/presentation/widgets/comments_sheet.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BusinessProfilePost extends StatelessWidget {
  const BusinessProfilePost({
    super.key,
    required this.post,
    required this.child,
  });

  final PostModel post;
  final Widget child;

  HomeController get _home => Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: _Header(post: post),
        ),
        SizedBox(height: 12.w),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: child,
        ),
        SizedBox(height: 12.w),
        _Reactions(post: post, onReact: _home.react, onComment: () => showCommentsSheet(post)),
        SizedBox(height: 12.w),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: _Caption(text: post.text),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 24.w),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.neutral200)),
      ),
      child: Row(
        children: [
          Container(
            width: 68.w,
            padding: EdgeInsets.all(2.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFDB5F1E), width: 1.5),
            ),
            child: SizedBox.square(
              dimension: 64.w,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipOval(
                    child: Image.asset(post.avatar, width: 64.w, height: 64.w, fit: BoxFit.cover),
                  ),
                  Positioned(
                    right: -2.w,
                    bottom: -2.w,
                    child: Container(
                      width: 16.w,
                      height: 16.w,
                      decoration: BoxDecoration(
                        color: AppColors.online,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 16.w),
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
                        style: manrope(16, weight: FontWeight.w700, color: AppColors.primary, lineHeight: 24),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    TrimmedText(
                      post.timeAgo,
                      style: manrope(8, color: AppColors.neutral400, lineHeight: 16),
                    ),
                  ],
                ),
                SizedBox(height: 4.w),
                TrimmedText(
                  AppText.greenleafHandle,
                  style: manrope(12, color: AppColors.neutral500, lineHeight: 16),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => AppHelperFunctions.showSnackBar(AppText.comingSoon),
            child: SizedBox.square(
              dimension: 24.w,
              child: Center(child: SvgPicture.asset(IconPath.bizSave)),
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: () => AppHelperFunctions.showSnackBar(AppText.comingSoon),
            child: SizedBox.square(
              dimension: 24.w,
              child: Center(child: SvgPicture.asset(IconPath.bizNotify)),
            ),
          ),
        ],
      ),
    );
  }
}

class _Reactions extends StatelessWidget {
  const _Reactions({
    required this.post,
    required this.onReact,
    required this.onComment,
  });

  final PostModel post;
  final void Function(Reactable item, Reaction reaction) onReact;
  final VoidCallback onComment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
      decoration: const BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: AppColors.neutral200)),
      ),
      child: Obx(() {
        final reaction = post.reaction.value;
        return Row(
          children: [
            _CountButton(
              icon: IconPath.like,
              count: post.likes.value,
              active: reaction == Reaction.like,
              onTap: () => onReact(post, Reaction.like),
            ),
            SizedBox(width: 8.w),
            _CountButton(
              icon: IconPath.dislike,
              count: post.dislikes.value,
              active: reaction == Reaction.dislike,
              onTap: () => onReact(post, Reaction.dislike),
            ),
            SizedBox(width: 8.w),
            _CountButton(
              icon: IconPath.comment,
              count: post.commentCount,
              onTap: onComment,
            ),
          ],
        );
      }),
    );
  }
}

class _CountButton extends StatelessWidget {
  const _CountButton({
    required this.icon,
    required this.count,
    required this.onTap,
    this.active = false,
  });

  final String icon;
  final int count;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.primary : AppColors.neutral400;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            width: 24.w,
            height: 24.w,
            colorFilter: active ? const ColorFilter.mode(AppColors.primary, BlendMode.srcIn) : null,
          ),
          SizedBox(width: 4.w),
          Container(
            width: 40.w,
            height: 24.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.neutral200),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: TrimmedText('$count', style: manrope(12, color: color, lineHeight: 16)),
          ),
        ],
      ),
    );
  }
}

class _Caption extends StatelessWidget {
  const _Caption({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              AppText.greenleafHandle,
              style: manrope(12, weight: FontWeight.w700, color: AppColors.primary, lineHeight: 18),
            ),
            SizedBox(width: 8.w),
            Text(
              AppText.fitnessHash,
              style: manrope(12, weight: FontWeight.w600, color: const Color(0xFF2E90FA), lineHeight: 18),
            ),
          ],
        ),
        SizedBox(height: 8.w),
        Text(
          text,
          style: manrope(12, color: AppColors.neutral600, lineHeight: 18),
        ),
      ],
    );
  }
}

class BusinessEmbeddedProduct extends StatelessWidget {
  const BusinessEmbeddedProduct({
    super.key,
    required this.product,
    required this.onView,
  });

  final ProductModel product;
  final VoidCallback onView;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(product.image, width: 120.w, fit: BoxFit.cover),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: manrope(16, weight: FontWeight.w700, lineHeight: 24)),
                  SizedBox(height: 4.w),
                  Text(
                    product.subtitle ?? '',
                    style: manrope(12, color: AppColors.neutral600, lineHeight: 16),
                  ),
                  SizedBox(height: 8.w),
                  Text(
                    AppText.inStock40,
                    style: manrope(12, color: AppColors.primary, lineHeight: 16),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        product.price,
                        style: manrope(18, weight: FontWeight.w700, color: AppColors.orange, lineHeight: 20),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: onView,
                        child: Row(
                          children: [
                            Text(
                              AppText.viewProduct,
                              style: manrope(12, weight: FontWeight.w600, color: AppColors.primary, lineHeight: 18),
                            ),
                            SizedBox(width: 4.w),
                            SvgPicture.asset(IconPath.viewDetailsArrow, width: 14.w, height: 14.w),
                          ],
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
    );
  }
}
