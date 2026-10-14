import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/features/home/data/models/inbox_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController with GetTickerProviderStateMixin {
  late final TabController tabController;
  final selectedTab = InboxCategory.all.obs;

  final items = <InboxNotification>[
    InboxNotification(
      id: 'shara',
      title: AppText.sharaAhmed,
      body: AppText.commentedOnCamping,
      timeAgo: AppText.twoMinAgo,
      category: InboxCategory.community,
      avatar: ImagePath.notifShara,
      badge: NotificationBadge.comment,
      unread: true,
    ),
    InboxNotification(
      id: 'sunset',
      title: AppText.sunsetBeachCamping,
      body: AppText.fiveShowedInterest,
      timeAgo: AppText.tenMinAgo,
      category: InboxCategory.pleasure,
      iconAsset: IconPath.navCommunity,
      iconBackground: AppColors.communityIconBg,
      unread: true,
    ),
    InboxNotification(
      id: 'greenleaf',
      title: AppText.greenleafName,
      body: AppText.newMessageFromEmma,
      timeAgo: AppText.thirtyMinAgo,
      category: InboxCategory.business,
      avatar: ImagePath.bizLogoGreenleaf,
      badge: NotificationBadge.comment,
      unread: true,
    ),
    InboxNotification(
      id: 'canon',
      title: AppText.canonAlpha,
      body: AppText.alexInterestedItem,
      timeAgo: AppText.oneHourAgo,
      category: InboxCategory.recycle,
      avatar: ImagePath.recyclerCamera,
    ),
    InboxNotification(
      id: 'james',
      title: AppText.jamesMentionedYou,
      body: AppText.likedCampingPost,
      timeAgo: AppText.twoHoursAgo,
      category: InboxCategory.community,
      avatar: ImagePath.notifJames,
      badge: NotificationBadge.like,
    ),
  ];

  List<InboxNotification> get visible {
    final tab = selectedTab.value;
    if (tab == InboxCategory.all) return items;
    return items.where((item) => item.category == tab).toList();
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: InboxCategory.values.length, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) return;
      selectedTab.value = InboxCategory.values[tabController.index];
    });
  }

  void selectTab(int index) {
    selectedTab.value = InboxCategory.values[index];
  }

  void markAllRead() {
    for (final item in items) {
      item.isUnread.value = false;
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
