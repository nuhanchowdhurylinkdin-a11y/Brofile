import 'dart:io';
import 'dart:math' as math;

import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/home/controllers/comments_controller.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> showCommentsSheet(PostModel post) async {
  Get.put(CommentsController(post), tag: post.id);
  await Get.bottomSheet(
    _CommentsSheet(post: post),
    isScrollControlled: true,
    barrierColor: AppColors.sheetScrim,
    backgroundColor: Colors.transparent,
  );
  Get.delete<CommentsController>(tag: post.id);
}

/// Width of the column holding the thread connector, where replies start.
double get _railWidth => 84.w;

class _CommentsSheet extends GetView<CommentsController> {
  const _CommentsSheet({required this.post});

  final PostModel post;

  @override
  String? get tag => post.id;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final keyboard = media.viewInsets.bottom;
    final maxHeight = media.size.height - media.padding.top - keyboard;
    final height = math.min(media.size.height * 868 / 980, maxHeight);

    return Padding(
      padding: EdgeInsets.only(bottom: keyboard),
      child: Container(
        height: height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
        ),
        child: Column(
          children: [
            const _SheetHeader(),
            Expanded(
              child: Obx(() {
                final threads = post.comments.toList();
                if (threads.isEmpty) {
                  return Center(
                    child: Text(
                      AppText.noCommentsYet,
                      style: manrope(14, color: AppColors.neutral500, lineHeight: 20),
                    ),
                  );
                }
                return ListView.separated(
                  controller: controller.scrollController,
                  padding: EdgeInsets.fromLTRB(16.w, 21.w, 16.w, 24.w),
                  itemCount: threads.length,
                  separatorBuilder: (_, _) => SizedBox(height: 24.w),
                  itemBuilder: (_, index) => _CommentThread(
                    postId: post.id,
                    thread: threads[index],
                  ),
                );
              }),
            ),
            _CommentComposer(
              postId: post.id,
              bottomPadding: keyboard > 0 ? 12.w : 62.w,
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetHeader extends StatelessWidget {
  const _SheetHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: Get.back,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 12.w, 20.w, 4.w),
            child: Container(
              width: 40.w,
              height: 4.w,
              decoration: BoxDecoration(
                color: AppColors.neutral300,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
        ),
        Text(
          AppText.comments,
          style: manrope(14, color: AppColors.neutral600, lineHeight: 20),
        ),
        SizedBox(height: 18.w),
        Container(height: 1, color: AppColors.neutral100),
      ],
    );
  }
}

/// A top level comment followed by its replies, joined by a dashed rail.
class _CommentThread extends GetView<CommentsController> {
  const _CommentThread({required this.postId, required this.thread});

  final String postId;
  final CommentModel thread;

  @override
  String? get tag => postId;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final replies = thread.replies.toList();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CommentHeader(postId: postId, comment: thread),
          _Rail(
            lineTop: 4.w,
            continues: replies.isNotEmpty,
            child: Padding(
              padding: EdgeInsets.only(top: 40.w),
              child: _EngagementRow(
                postId: postId,
                comment: thread,
                onReply: () => controller.startReply(thread, thread),
              ),
            ),
          ),
          for (var i = 0; i < replies.length; i++)
            _Rail(
              elbow: (i == 0 ? 49.w : 16.w) + 17.5.w,
              continues: i < replies.length - 1,
              child: Padding(
                padding: EdgeInsets.only(top: i == 0 ? 49.w : 16.w),
                child: _ReplyBody(postId: postId, thread: thread, reply: replies[i]),
              ),
            ),
        ],
      );
    });
  }
}

class _CommentHeader extends GetView<CommentsController> {
  const _CommentHeader({required this.postId, required this.comment});

  final String postId;
  final CommentModel comment;

  @override
  String? get tag => postId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.toggleExpanded(comment),
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(2.w),
            child: _CommentAvatar(
              image: comment.avatar,
              size: 40.w,
              dotSize: 10.w,
              isOnline: comment.isOnline,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24.w,
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          comment.author,
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
                        comment.timeAgo,
                        style: manrope(7.74, color: AppColors.neutral400),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.w),
                Obx(
                  () => comment.isExpanded.value
                      ? _CommentText(comment.text)
                      : TrimmedText(
                          comment.text,
                          style: manrope(12, color: AppColors.neutral600),
                        ),
                ),
                if (comment.imagePath != null) _AttachedImage(path: comment.imagePath!),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReplyBody extends GetView<CommentsController> {
  const _ReplyBody({required this.postId, required this.thread, required this.reply});

  final String postId;
  final CommentModel thread;
  final CommentModel reply;

  @override
  String? get tag => postId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => controller.toggleExpanded(reply),
          behavior: HitTestBehavior.opaque,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _CommentAvatar(
                image: reply.avatar,
                size: 32.w,
                dotSize: 8.w,
                isOnline: reply.isOnline,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 40.w),
                  child: Obx(
                    () => _CommentText(
                      reply.text,
                      maxLines: reply.isExpanded.value ? null : 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (reply.imagePath != null)
          Padding(
            padding: EdgeInsets.only(left: 40.w),
            child: _AttachedImage(path: reply.imagePath!),
          ),
        SizedBox(height: 16.w),
        _EngagementRow(
          postId: postId,
          comment: reply,
          onReply: () => controller.startReply(thread, reply),
        ),
      ],
    );
  }
}

/// Multi line comment text whose first line is trimmed to the cap height.
class _CommentText extends StatelessWidget {
  const _CommentText(this.text, {this.maxLines});

  final String text;
  final int? maxLines;

  // Distance from the top of an 18px line to the cap top of 12px Manrope.
  static const double _capOffset = 4.96;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -_capOffset.w),
      child: Text(
        text,
        maxLines: maxLines,
        overflow: maxLines == null ? TextOverflow.visible : TextOverflow.ellipsis,
        style: manrope(12, color: AppColors.neutral600, lineHeight: 18),
      ),
    );
  }
}

class _AttachedImage extends StatelessWidget {
  const _AttachedImage({required this.path});

  final String path;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Image.file(File(path), width: 160.w, height: 120.w, fit: BoxFit.cover),
      ),
    );
  }
}

class _CommentAvatar extends StatelessWidget {
  const _CommentAvatar({
    required this.image,
    required this.size,
    required this.dotSize,
    required this.isOnline,
  });

  final String image;
  final double size;
  final double dotSize;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: Stack(
        children: [
          ClipOval(
            child: Image.asset(image, width: size, height: size, fit: BoxFit.cover),
          ),
          if (isOnline)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: dotSize,
                height: dotSize,
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

class _EngagementRow extends GetView<CommentsController> {
  const _EngagementRow({
    required this.postId,
    required this.comment,
    required this.onReply,
  });

  final String postId;
  final CommentModel comment;
  final VoidCallback onReply;

  @override
  String? get tag => postId;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final reaction = comment.reaction.value;
      return Row(
        children: [
          _ReactionCount(
            icon: IconPath.like,
            count: comment.likes.value,
            isActive: reaction == Reaction.like,
            onTap: () => controller.react(comment, Reaction.like),
          ),
          SizedBox(width: 8.w),
          _ReactionCount(
            icon: IconPath.dislike,
            count: comment.dislikes.value,
            isActive: reaction == Reaction.dislike,
            onTap: () => controller.react(comment, Reaction.dislike),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: onReply,
            behavior: HitTestBehavior.opaque,
            child: Text(
              AppText.reply,
              style: manrope(
                12,
                weight: FontWeight.w700,
                color: AppColors.followBlue,
                lineHeight: 18,
              ),
            ),
          ),
        ],
      );
    });
  }
}

class _ReactionCount extends StatelessWidget {
  const _ReactionCount({
    required this.icon,
    required this.count,
    required this.isActive,
    required this.onTap,
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
          Container(
            width: 40.w,
            height: 24.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: isActive ? AppColors.primary : AppColors.neutral200),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: TrimmedText('$count', style: manrope(12, color: color)),
          ),
        ],
      ),
    );
  }
}

/// Left column of a thread row that draws the dashed connector.
class _Rail extends StatelessWidget {
  const _Rail({
    required this.child,
    this.lineTop = 0,
    this.elbow,
    this.continues = false,
  });

  final Widget child;

  /// Where the vertical line starts within this row.
  final double lineTop;

  /// Height at which the line turns right towards a reply avatar.
  final double? elbow;

  /// Whether the line carries on to the bottom of this row.
  final bool continues;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: _railWidth,
            child: CustomPaint(
              painter: _RailPainter(
                x: 24.5.w,
                endX: 76.5.w,
                top: lineTop,
                elbow: elbow,
                continues: continues,
              ),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _RailPainter extends CustomPainter {
  _RailPainter({
    required this.x,
    required this.endX,
    required this.top,
    required this.elbow,
    required this.continues,
  });

  final double x;
  final double endX;
  final double top;
  final double? elbow;
  final bool continues;

  static const double _radius = 2;
  static const double _dash = 2;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final turnAt = elbow;

    if (turnAt != null) {
      path
        ..moveTo(x, top)
        ..lineTo(x, turnAt - _radius)
        ..quadraticBezierTo(x, turnAt, x + _radius, turnAt)
        ..lineTo(endX, turnAt);
      if (continues) {
        path
          ..moveTo(x, turnAt - _radius)
          ..lineTo(x, size.height);
      }
    } else if (continues) {
      path
        ..moveTo(x, top)
        ..lineTo(x, size.height);
    } else {
      return;
    }

    final paint = Paint()
      ..color = AppColors.neutral200
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (final metric in path.computeMetrics()) {
      for (var d = 0.0; d < metric.length; d += _dash * 2) {
        canvas.drawPath(metric.extractPath(d, d + _dash), paint);
      }
    }
  }

  @override
  bool shouldRepaint(_RailPainter old) =>
      old.x != x ||
      old.endX != endX ||
      old.top != top ||
      old.elbow != elbow ||
      old.continues != continues;
}

class _CommentComposer extends GetView<CommentsController> {
  const _CommentComposer({required this.postId, required this.bottomPadding});

  final String postId;
  final double bottomPadding;

  @override
  String? get tag => postId;

  @override
  Widget build(BuildContext context) {
    final inputStyle = GoogleFonts.nunito(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      height: 16 / 14,
      color: AppColors.textGray800,
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, bottomPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() {
            final target = controller.replyTarget.value;
            if (target == null) return const SizedBox.shrink();
            return Padding(
              padding: EdgeInsets.only(bottom: 8.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: '${AppText.replyingTo} ',
                        children: [
                          TextSpan(
                            text: target.author,
                            style: manrope(12, weight: FontWeight.w700, color: AppColors.primary),
                          ),
                        ],
                      ),
                      style: manrope(12, color: AppColors.neutral500, lineHeight: 18),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.cancelReply,
                    behavior: HitTestBehavior.opaque,
                    child: Icon(Icons.close_rounded, size: 18.r, color: AppColors.neutral400),
                  ),
                ],
              ),
            );
          }),
          Obx(() {
            final image = controller.attachedImage.value;
            if (image == null) return const SizedBox.shrink();
            return Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: 8.w),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.file(File(image), width: 64.w, height: 64.w, fit: BoxFit.cover),
                    ),
                    Positioned(
                      top: -6.w,
                      right: -6.w,
                      child: GestureDetector(
                        onTap: controller.removeImage,
                        child: Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: const BoxDecoration(
                            color: AppColors.neutral600,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.close_rounded, size: 12.r, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          Container(
            constraints: BoxConstraints(minHeight: 56.w),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.commentInputBorder),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Obx(
              () => TextField(
                controller: controller.textController,
                focusNode: controller.focusNode,
                minLines: 1,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => controller.send(),
                onTap: () => controller.showEmojis.value = false,
                style: inputStyle,
                cursorColor: AppColors.primary,
                decoration: InputDecoration(
                  isCollapsed: true,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 19.w),
                  hintText: controller.replyTarget.value == null
                      ? AppText.addComment
                      : AppText.addReply,
                  hintStyle: inputStyle.copyWith(color: AppColors.neutral400),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.w),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                GestureDetector(
                  onTap: controller.pickImage,
                  behavior: HitTestBehavior.opaque,
                  child: SvgPicture.asset(IconPath.commentImage, width: 24.w, height: 24.w),
                ),
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: controller.toggleEmojis,
                  behavior: HitTestBehavior.opaque,
                  child: Obx(
                    () => SvgPicture.asset(
                      IconPath.commentEmoji,
                      width: 24.w,
                      height: 24.w,
                      colorFilter: ColorFilter.mode(
                        controller.showEmojis.value ? AppColors.primary : AppColors.emojiIcon,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: controller.send,
                  behavior: HitTestBehavior.opaque,
                  child: Transform.rotate(
                    angle: math.pi / 4,
                    child: Obx(
                      () => SvgPicture.asset(
                        controller.canSend ? IconPath.commentSendActive : IconPath.commentSend,
                        width: 24.w,
                        height: 24.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            if (!controller.showEmojis.value) return const SizedBox.shrink();
            return Padding(
              padding: EdgeInsets.only(top: 12.w),
              child: SizedBox(
                height: 36.w,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: CommentsController.quickEmojis.length,
                  separatorBuilder: (_, _) => SizedBox(width: 4.w),
                  itemBuilder: (_, index) {
                    final emoji = CommentsController.quickEmojis[index];
                    return GestureDetector(
                      onTap: () => controller.insertEmoji(emoji),
                      child: Container(
                        width: 36.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.neutral100,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(emoji, style: TextStyle(fontSize: 20.sp)),
                      ),
                    );
                  },
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
