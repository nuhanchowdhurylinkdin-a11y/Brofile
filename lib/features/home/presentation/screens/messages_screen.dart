import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/features/home/controllers/messages_controller.dart';
import 'package:brofile/features/home/data/models/inbox_models.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MessagesScreen extends GetView<MessagesController> {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: Column(
          children: [
            PleasureSubHeader(title: AppText.messages, onBack: Get.back),
            const _FilterChips(),
            Expanded(
              child: Obx(() {
                final items = controller.visible;
                return ListView.builder(
                  padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 32.w),
                  itemCount: items.length,
                  itemBuilder: (_, index) => _ConversationTile(conversation: items[index]),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChips extends GetView<MessagesController> {
  const _FilterChips();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86.w,
      child: Obx(() {
        final selected = controller.selectedCategory.value;
        return ListView.separated(
          padding: EdgeInsets.fromLTRB(24.w, 24.w, 24.w, 24.w),
          scrollDirection: Axis.horizontal,
          itemCount: MessagesController.filters.length,
          separatorBuilder: (_, _) => SizedBox(width: 12.w),
          itemBuilder: (_, index) {
            final category = MessagesController.filters[index];
            final isSelected = category == selected;
            return GestureDetector(
              onTap: () => controller.selectCategory(category),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: isSelected ? 20.w : 21.w, vertical: 9.w),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.white,
                  border: isSelected ? null : Border.all(color: AppColors.dateChip),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  controller.labelFor(category),
                  style: manrope(
                    14,
                    weight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? Colors.white : AppColors.tabMuted,
                    lineHeight: 20,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

class _ConversationTile extends GetView<MessagesController> {
  const _ConversationTile({required this.conversation});

  final ConversationModel conversation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.openChat(conversation),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.w),
        child: Row(
          children: [
            _ConversationAvatar(conversation: conversation),
            SizedBox(width: 16.w),
            Expanded(
              child: Obx(() {
                final unread = conversation.unread.value;
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            conversation.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: manrope(16, weight: FontWeight.w700, color: AppColors.inboxName, lineHeight: 24),
                          ),
                        ),
                        Text(
                          conversation.timeAgo,
                          style: manrope(12, color: AppColors.tabMuted, lineHeight: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.w),
                    Row(
                      children: [
                        Expanded(
                          child: conversation.previewPrefix == null
                              ? Text(
                                  conversation.preview,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: manrope(14, color: AppColors.tabMuted, lineHeight: 20),
                                )
                              : Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: conversation.previewPrefix,
                                        style: manrope(14, color: const Color(0xFF4B5563), lineHeight: 20),
                                      ),
                                      TextSpan(
                                        text: conversation.preview,
                                        style: manrope(14, color: AppColors.tabMuted, lineHeight: 20),
                                      ),
                                    ],
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                        ),
                        if (unread > 0) ...[
                          SizedBox(width: 8.w),
                          Container(
                            width: 20.w,
                            height: 20.w,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '$unread',
                              style: manrope(12, color: Colors.white, lineHeight: 16),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConversationAvatar extends StatelessWidget {
  const _ConversationAvatar({required this.conversation});

  final ConversationModel conversation;

  @override
  Widget build(BuildContext context) {
    final radius = (conversation.avatarRadius ?? 999).r;
    Widget child;
    if (conversation.iconAsset != null) {
      child = Container(
        width: 64.w,
        height: 64.w,
        decoration: BoxDecoration(
          color: conversation.avatarBackground ?? AppColors.eventIconBg,
          borderRadius: BorderRadius.circular(radius),
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(conversation.iconAsset!, width: 24.w, height: 24.w),
      );
    } else if (conversation.avatarBackground != null) {
      child = Container(
        width: 64.w,
        height: 64.w,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: conversation.avatarBackground,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: ClipOval(
          child: Image.asset(conversation.avatar!, fit: BoxFit.cover),
        ),
      );
    } else {
      child = ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.asset(conversation.avatar!, width: 64.w, height: 64.w, fit: BoxFit.cover),
      );
    }

    if (!conversation.isOnline) return child;

    return SizedBox(
      width: 64.w,
      height: 64.w,
      child: Stack(
        children: [
          child,
          Positioned(
            right: 4.w,
            bottom: 4.w,
            child: Container(
              width: 14.w,
              height: 14.w,
              decoration: BoxDecoration(
                color: AppColors.inboxOnline,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2.w),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
