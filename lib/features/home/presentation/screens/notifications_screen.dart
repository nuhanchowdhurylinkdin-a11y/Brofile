import 'package:brofile/core/common/widgets/hide_on_scroll.dart';
import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/home/controllers/notifications_controller.dart';
import 'package:brofile/features/home/data/models/inbox_models.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NotificationsScreen extends GetView<NotificationsController> {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: HideOnScroll(
          header: PleasureSubHeader(title: AppText.notifications, onBack: Get.back),
          pinned: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const _NotificationTabs(),
          ),
          body: Obx(() {
            final items = controller.visible;
            return ListView(
              padding: EdgeInsets.fromLTRB(16.w, 28.w, 16.w, 32.w),
              children: [
                Row(
                  children: [
                    Text(
                      AppText.today,
                      style: manrope(14, weight: FontWeight.w600, lineHeight: 20),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: controller.markAllRead,
                      child: Text(
                        AppText.markAllAsRead,
                        style: manrope(
                          14,
                          weight: FontWeight.w500,
                          color: AppColors.primary,
                          lineHeight: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 28.w),
                ...items.map((item) => _NotificationTile(item: item)),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _NotificationTabs extends GetView<NotificationsController> {
  const _NotificationTabs();

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller.tabController,
      onTap: controller.selectTab,
      isScrollable: false,
      tabAlignment: TabAlignment.fill,
      labelPadding: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      splashFactory: NoSplash.splashFactory,
      labelColor: AppColors.tabSelected,
      unselectedLabelColor: AppColors.tabMuted,
      labelStyle: manrope(12, lineHeight: 16),
      unselectedLabelStyle: manrope(12, lineHeight: 16),
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: AppColors.tabSelected, width: 2.w),
        insets: EdgeInsets.zero,
      ),
      dividerColor: AppColors.dateChip,
      tabs: [
        Tab(text: AppText.all, height: 44.w),
        Tab(text: AppText.navCommunity, height: 44.w),
        Tab(text: AppText.pleasure, height: 44.w),
        Tab(text: AppText.business, height: 44.w),
        Tab(text: AppText.recycle, height: 44.w),
      ],
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.item});

  final InboxNotification item;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final unread = item.isUnread.value;
      return Container(
        padding: EdgeInsets.fromLTRB(0, 8.w, 0, 16.w),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.neutral200)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _NotificationAvatar(item: item),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: manrope(
                            14,
                            weight: unread ? FontWeight.w700 : FontWeight.w500,
                            lineHeight: 20,
                          ),
                        ),
                        SizedBox(height: 4.w),
                        Text(
                          item.body,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: manrope(14, color: AppColors.neutral500, lineHeight: 20),
                        ),
                        SizedBox(height: 16.w),
                        Text(
                          item.timeAgo,
                          style: manrope(14, color: AppColors.neutral500, lineHeight: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (unread) ...[
              SizedBox(width: 8.w),
              Container(
                width: 8.w,
                height: 8.w,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      );
    });
  }
}

class _NotificationAvatar extends StatelessWidget {
  const _NotificationAvatar({required this.item});

  final InboxNotification item;

  @override
  Widget build(BuildContext context) {
    Widget avatar;
    if (item.iconAsset != null) {
      avatar = Container(
        width: 60.w,
        height: 60.w,
        decoration: BoxDecoration(
          color: item.iconBackground ?? AppColors.communityIconBg,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          item.iconAsset!,
          width: 28.w,
          height: 28.w,
          colorFilter: const ColorFilter.mode(AppColors.tabSelected, BlendMode.srcIn),
        ),
      );
    } else {
      avatar = ClipOval(
        child: Image.asset(item.avatar!, width: 60.w, height: 60.w, fit: BoxFit.cover),
      );
    }

    if (item.badge == NotificationBadge.none) return avatar;

    return SizedBox(
      width: 60.w,
      height: 60.w,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          Positioned(
            left: 38.w,
            top: 38.w,
            child: Container(
              width: 22.w,
              height: 22.w,
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                item.badge == NotificationBadge.like ? IconPath.like : IconPath.comment,
                width: 12.w,
                height: 12.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
