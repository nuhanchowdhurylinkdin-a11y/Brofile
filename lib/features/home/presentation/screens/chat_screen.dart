import 'dart:math' as math;

import 'package:brofile/core/common/widgets/hide_on_scroll.dart';
import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/helpers/app_platform.dart';
import 'package:brofile/features/home/controllers/chat_controller.dart';
import 'package:brofile/features/home/data/models/inbox_models.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final keyboard = MediaQuery.viewInsetsOf(context).bottom;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: HideOnScroll(
          header: const _ChatHeader(),
          body: Obx(() {
            final items = controller.messages.toList();
            return ListView(
              padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 24.w),
              children: [
                const _DateChip(),
                SizedBox(height: 23.w),
                ...[
                  for (var i = 0; i < items.length; i++) ...[
                    if (i > 0) SizedBox(height: 24.w),
                    _Bubble(message: items[i]),
                  ],
                ],
              ],
            );
          }),
          bottom: Padding(
            padding: EdgeInsets.only(bottom: keyboard),
            child: const _Composer(),
          ),
        ),
      ),
    );
  }
}

class _ChatHeader extends GetView<ChatController> {
  const _ChatHeader();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 8.w),
          child: Row(
            children: [
              AppBackButton(onTap: Get.back),
              SizedBox(width: 12.w),
              GestureDetector(
                onTap: controller.openProfile,
                child: const _PeerPhoto(size: 40),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: GestureDetector(
                  onTap: controller.openProfile,
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.conversation.name,
                        style: manrope(16, weight: FontWeight.w700, lineHeight: 20),
                      ),
                      if (controller.conversation.isOnline)
                        Text(
                          AppText.online,
                          style: manrope(
                            12,
                            weight: FontWeight.w600,
                            color: AppColors.primary,
                            lineHeight: 16,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: controller.openMore,
                behavior: HitTestBehavior.opaque,
                child: SvgPicture.asset(IconPath.postMenu, width: 24.w, height: 24.w),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PeerPhoto extends GetView<ChatController> {
  const _PeerPhoto({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    final conversation = controller.conversation;
    final photo = controller.avatar;
    if (photo.isNotEmpty) {
      return ClipOval(
        child: Image.asset(photo, width: size.w, height: size.w, fit: BoxFit.cover),
      );
    }
    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        color: conversation.avatarBackground ?? AppColors.eventIconBg,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: conversation.iconAsset == null
          ? null
          : SvgPicture.asset(conversation.iconAsset!, width: 20.w, height: 20.w),
    );
  }
}

class _DateChip extends StatelessWidget {
  const _DateChip();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.fromLTRB(16.w, 3.w, 16.w, 4.5.w),
        decoration: BoxDecoration(
          color: AppColors.dateChip,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          AppText.today,
          style: manrope(12, weight: FontWeight.w600, color: AppColors.tabMuted, lineHeight: 16.5),
        ),
      ),
    );
  }
}

class _Bubble extends GetView<ChatController> {
  const _Bubble({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    if (message.isOutgoing) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          constraints: BoxConstraints(maxWidth: 304.w),
          padding: EdgeInsets.fromLTRB(14.w, 13.w, 14.w, 14.w),
          decoration: BoxDecoration(
            color: AppColors.chatOutgoing,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
              bottomLeft: Radius.circular(16.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(message.text, style: manrope(14, color: AppColors.chatBody, lineHeight: 22.75)),
              SizedBox(height: 4.w),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(message.time, style: manrope(12, color: AppColors.tabMuted, lineHeight: 15)),
                  SizedBox(width: 4.w),
                  SvgPicture.asset(IconPath.chatRead, width: 14.w, height: 14.w),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _PeerPhoto(size: 40),
        SizedBox(width: 8.w),
        Flexible(
          child: Container(
            padding: EdgeInsets.fromLTRB(14.w, 13.w, 14.w, 14.w),
            decoration: BoxDecoration(
              color: AppColors.neutral100,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
                bottomRight: Radius.circular(16.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(message.text, style: manrope(14, color: AppColors.chatBody, lineHeight: 22.75)),
                SizedBox(height: 4.w),
                Text(message.time, style: manrope(12, color: AppColors.tabMuted, lineHeight: 15)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Composer extends GetView<ChatController> {
  const _Composer();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.surface,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: controller.openAttach,
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.chatOutgoing,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(IconPath.chatPlus, width: 24.w, height: 24.w),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(17.w, 9.w, 8.w, 9.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: AppColors.composerBorder),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller.textController,
                              minLines: 1,
                              maxLines: 4,
                              textInputAction: TextInputAction.send,
                              onSubmitted: (_) => controller.send(),
                              onTap: () => controller.showEmojis.value = false,
                              cursorColor: AppColors.primary,
                              style: manrope(14, color: AppColors.chatBody),
                              onTapOutside: (_) => FocusScope.of(context).unfocus(),
                              decoration: InputDecoration(
                                isDense: true,
                                filled: false,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.w),
                                hintText: AppText.typeAMessage,
                                hintStyle: manrope(14, color: AppColors.tabMuted),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: controller.toggleEmojis,
                            child: SvgPicture.asset(IconPath.commentEmoji, width: 24.w, height: 24.w),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  GestureDetector(
                    onTap: controller.send,
                    child: SizedBox(
                      width: 31.w,
                      height: 31.w,
                      child: Transform.rotate(
                        angle: math.pi / 4,
                        child: SvgPicture.asset(
                          IconPath.commentSendActive,
                          width: 31.w,
                          height: 31.w,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Obx(() {
                if (!controller.showEmojis.value) return const SizedBox.shrink();
                return Padding(
                  padding: EdgeInsets.only(top: 12.w),
                  child: SizedBox(
                    height: 36.w,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: ChatController.quickEmojis.length,
                      separatorBuilder: (_, _) => SizedBox(width: 4.w),
                      itemBuilder: (_, index) {
                        final emoji = ChatController.quickEmojis[index];
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
        ),
      ),
    );
  }
}
