import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void showPostMenu(PostModel post) {
  final controller = Get.find<HomeController>();

  Widget option(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textGray800, size: 22.r),
      title: Text(label, style: manrope(14, weight: FontWeight.w600)),
      onTap: () {
        Get.back();
        onTap();
      },
    );
  }

  Get.bottomSheet(
    _SheetContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          option(Icons.visibility_off_outlined, AppText.hidePost, () => controller.hidePost(post)),
          option(Icons.copy_rounded, AppText.copyText, () => controller.copyPostText(post)),
          option(Icons.flag_outlined, AppText.reportPost, () => controller.reportPost(post)),
        ],
      ),
    ),
  );
}

void showCommentsSheet(PostModel post) {
  Get.bottomSheet(
    _CommentsSheet(post: post),
    isScrollControlled: true,
  );
}

class _SheetContainer extends StatelessWidget {
  const _SheetContainer({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.w),
            Container(
              width: 40.w,
              height: 4.w,
              decoration: BoxDecoration(
                color: AppColors.neutral200,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 8.w),
            child,
          ],
        ),
      ),
    );
  }
}

class _CommentsSheet extends GetView<HomeController> {
  const _CommentsSheet({required this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: keyboardInset),
      child: _SheetContainer(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 0.6.sh),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
                child: Obx(
                  () => Text(
                    '${AppText.comments} (${post.commentCount})',
                    style: manrope(16, weight: FontWeight.w700, lineHeight: 24),
                  ),
                ),
              ),
              Flexible(
                child: Obx(() {
                  if (post.comments.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.w),
                      child: Text(
                        AppText.noCommentsYet,
                        style: manrope(14, color: AppColors.neutral500, lineHeight: 20),
                      ),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
                    itemCount: post.comments.length,
                    separatorBuilder: (_, _) => SizedBox(height: 12.w),
                    itemBuilder: (_, index) {
                      final comment = post.comments[index];
                      return Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${comment.author}  ',
                              style: manrope(14, weight: FontWeight.w700),
                            ),
                            TextSpan(
                              text: comment.text,
                              style: manrope(14, color: AppColors.neutral600),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 8.w, 8.w, 12.w),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.commentController,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => controller.addComment(post),
                        style: manrope(14),
                        decoration: InputDecoration(
                          hintText: AppText.writeComment,
                          hintStyle: manrope(14, color: AppColors.neutral400),
                          filled: true,
                          fillColor: AppColors.surface,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.w,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.r),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.r),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24.r),
                            borderSide: const BorderSide(color: AppColors.primary),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => controller.addComment(post),
                      icon: Icon(Icons.send_rounded, color: AppColors.primary, size: 24.r),
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
