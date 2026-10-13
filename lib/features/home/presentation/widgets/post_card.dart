import 'dart:ui' show lerpDouble;

import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/controllers/stack_swipe_controller.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/home/presentation/widgets/post_sheets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PostCard extends GetView<HomeController> {
  const PostCard({super.key, required this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      children: [
        _PostHeader(post: post),
        SizedBox(height: 12.w),
        _PostMedia(post: post),
        SizedBox(height: 12.w),
        _PostReactions(post: post),
        SizedBox(height: 12.w),
        _PostBody(post: post),
      ],
    );

    if (!post.isCard) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: content,
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.neutral100),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: content,
      ),
    );
  }
}

class _PostHeader extends GetView<HomeController> {
  const _PostHeader({required this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 11.w),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.neutral200)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => controller.openProfile(post.author),
            behavior: HitTestBehavior.opaque,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(2.w),
                  child: _OnlineAvatar(image: post.avatar, isOnline: post.isOnline),
                ),
                SizedBox(width: 8.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          post.author,
                          style: manrope(
                            16,
                            weight: FontWeight.w700,
                            color: AppColors.primary,
                            lineHeight: 24,
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
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => showPostMenu(post),
            behavior: HitTestBehavior.opaque,
            child: SvgPicture.asset(IconPath.postMenu, width: 24.w, height: 24.w),
          ),
        ],
      ),
    );
  }
}

class _OnlineAvatar extends StatelessWidget {
  const _OnlineAvatar({required this.image, required this.isOnline});

  final String image;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 40.w,
      child: Stack(
        children: [
          ClipOval(
            child: Image.asset(image, width: 40.w, height: 40.w, fit: BoxFit.cover),
          ),
          if (isOnline)
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
    );
  }
}

class _PostMedia extends StatelessWidget {
  const _PostMedia({required this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return switch (post.layout) {
      PostLayout.single => _RoundedImage(image: post.images.first, height: 221.w),
      PostLayout.double => SizedBox(
          height: 220.w,
          child: Row(
            children: [
              Expanded(child: _RoundedImage(image: post.images[0], height: 220.w)),
              SizedBox(width: 12.w),
              Expanded(child: _RoundedImage(image: post.images[1], height: 220.w)),
            ],
          ),
        ),
      PostLayout.stack => _StackGallery(post: post),
    };
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

/// Three overlapping, tilted photos. Drag the top photo sideways and throw it
/// off either edge, or tap it, to bring the next one forward.
class _StackGallery extends StatelessWidget {
  const _StackGallery({required this.post});

  final PostModel post;

  static const double _tilt = 0.0698; // 4 degrees
  static const double _maxDragTilt = 0.35;

  StackSwipeController get _swipe => Get.isRegistered<StackSwipeController>(tag: post.id)
      ? Get.find<StackSwipeController>(tag: post.id)
      : Get.put(StackSwipeController(post), tag: post.id);

  @override
  Widget build(BuildContext context) {
    final swipe = _swipe;
    final imageWidth = 188.w;
    final imageHeight = 221.w;
    final sideOffset = 42.5.w;
    swipe
      ..swipeDistance = imageWidth * 0.5
      ..flyOutDistance = 1.sw;

    return GestureDetector(
      onTap: swipe.swipeLeft,
      onHorizontalDragUpdate: (details) => swipe.onDragUpdate(details.delta),
      onHorizontalDragEnd: (details) => swipe.onDragEnd(details.primaryVelocity ?? 0),
      child: SizedBox(
        height: 234.w,
        width: double.infinity,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final centerLeft = (constraints.maxWidth - imageWidth) / 2;
            final topSlot = (left: centerLeft, top: 5.w, angle: 0.0);
            final rightSlot = (left: centerLeft + sideOffset, top: 5.5.w, angle: _tilt);
            final leftSlot = (left: centerLeft - sideOffset, top: 5.5.w, angle: -_tilt);

            Widget photo(String image) => ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.asset(
                    image,
                    width: imageWidth,
                    height: imageHeight,
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                  ),
                );

            Widget card({
              required String image,
              required double left,
              required double top,
              required double angle,
              double opacity = 1,
            }) {
              return Positioned(
                left: left,
                top: top,
                child: Opacity(
                  opacity: opacity,
                  child: Transform.rotate(angle: angle, child: photo(image)),
                ),
              );
            }

            return Obx(() {
              final count = post.images.length;
              final index = post.stackIndex.value;
              final drag = swipe.drag.value;
              final p = Curves.easeOut.transform(swipe.progress);
              String imageAt(int offset) => post.images[(index + offset) % count];

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  card(
                    image: imageAt(2),
                    left: lerpDouble(leftSlot.left, rightSlot.left, p)!,
                    top: lerpDouble(leftSlot.top, rightSlot.top, p)!,
                    angle: lerpDouble(leftSlot.angle, rightSlot.angle, p)!,
                    opacity: swipe.backOpacity.value,
                  ),
                  card(
                    image: imageAt(1),
                    left: lerpDouble(rightSlot.left, topSlot.left, p)!,
                    top: lerpDouble(rightSlot.top, topSlot.top, p)!,
                    angle: lerpDouble(rightSlot.angle, topSlot.angle, p)!,
                  ),
                  card(
                    image: imageAt(0),
                    left: topSlot.left + drag.dx,
                    top: topSlot.top + drag.dy,
                    angle: (drag.dx / constraints.maxWidth * _maxDragTilt)
                        .clamp(-_maxDragTilt, _maxDragTilt),
                  ),
                ],
              );
            });
          },
        ),
      ),
    );
  }
}

class _PostReactions extends GetView<HomeController> {
  const _PostReactions({required this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 11.w),
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: AppColors.neutral200),
        ),
      ),
      child: Obx(() {
        final reaction = post.reaction.value;
        return Row(
          children: [
            _ReactionButton(
              icon: IconPath.like,
              count: post.likes.value,
              isActive: reaction == Reaction.like,
              onTap: () => controller.react(post, Reaction.like),
            ),
            SizedBox(width: 8.w),
            _ReactionButton(
              icon: IconPath.dislike,
              count: post.dislikes.value,
              isActive: reaction == Reaction.dislike,
              onTap: () => controller.react(post, Reaction.dislike),
            ),
            SizedBox(width: 8.w),
            _ReactionButton(
              icon: IconPath.comment,
              iconHeight: 21.5,
              count: post.commentCount,
              onTap: () => showCommentsSheet(post),
            ),
          ],
        );
      }),
    );
  }
}

class _ReactionButton extends StatelessWidget {
  const _ReactionButton({
    required this.icon,
    required this.count,
    required this.onTap,
    this.isActive = false,
    this.iconHeight = 20.2,
  });

  final String icon;
  final int count;
  final bool isActive;
  final double iconHeight;
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
                height: iconHeight.w,
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

class _PostBody extends GetView<HomeController> {
  const _PostBody({required this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => controller.selectCategoryByName(post.category),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.w),
            decoration: BoxDecoration(
              color: AppColors.orangeLight,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              post.tag,
              style: manrope(
                12,
                weight: FontWeight.w500,
                color: AppColors.orange,
                lineHeight: 16,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => controller.toggleExpanded(post),
          behavior: HitTestBehavior.opaque,
          child: Obx(() {
            final expanded = post.isExpanded.value;
            return AnimatedSize(
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  post.text,
                  style: manrope(14, color: AppColors.neutral600, lineHeight: 24),
                  maxLines: expanded ? null : 2,
                  overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
