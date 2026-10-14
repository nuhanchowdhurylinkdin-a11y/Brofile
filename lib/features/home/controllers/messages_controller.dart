import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/features/home/data/models/inbox_models.dart';
import 'package:brofile/routes/app_routes.dart';
import 'package:get/get.dart';

class MessagesController extends GetxController {
  final selectedCategory = InboxCategory.all.obs;

  final conversations = <ConversationModel>[
    ConversationModel(
      id: 'sarah',
      name: AppText.sarahKhan,
      preview: AppText.soundsGreatSeeYou,
      timeAgo: AppText.twoMinAgo,
      category: InboxCategory.pleasure,
      avatar: ImagePath.msgSarah,
      chatAvatar: ImagePath.chatSarah,
      isOnline: true,
      unread: 2,
    ),
    ConversationModel(
      id: 'greenleaf',
      name: AppText.greenleafName,
      preview: AppText.offerPrivateSessions,
      timeAgo: AppText.thirtyFiveMinAgo,
      category: InboxCategory.business,
      avatar: ImagePath.bizLogoGreenleaf,
      avatarBackground: AppColors.studioAvatarBg,
      unread: 1,
    ),
    ConversationModel(
      id: 'rafiul',
      name: AppText.rafiulAhmed,
      preview: AppText.perfectIWillJoin,
      timeAgo: AppText.oneHourAgo,
      category: InboxCategory.community,
      avatar: ImagePath.msgRafiul,
      isOnline: true,
    ),
    ConversationModel(
      id: 'coffee',
      name: AppText.coffeeLoversBd,
      preview: AppText.letsMeetFriday,
      previewPrefix: AppText.nusratPrefix,
      timeAgo: AppText.twoHoursAgo,
      category: InboxCategory.community,
      avatar: ImagePath.msgCoffee,
      unread: 3,
    ),
    ConversationModel(
      id: 'layla',
      name: AppText.laylaRahman,
      preview: AppText.thanksForAccepting,
      timeAgo: AppText.threeHoursAgo,
      category: InboxCategory.community,
      avatar: ImagePath.msgLayla,
    ),
    ConversationModel(
      id: 'alex',
      name: AppText.alexJohnson,
      preview: AppText.bottleStillAvailable,
      timeAgo: AppText.fiveHoursAgo,
      category: InboxCategory.recycle,
      avatar: ImagePath.msgAlex,
    ),
    ConversationModel(
      id: 'yoga',
      name: AppText.morningYogaFlow,
      preview: AppText.classTomorrowReminder,
      timeAgo: AppText.oneDayAgo,
      category: InboxCategory.pleasure,
      iconAsset: IconPath.msgCalendar,
      avatarBackground: AppColors.eventIconBg,
      avatarRadius: 24,
    ),
  ];

  static const filters = [
    InboxCategory.all,
    InboxCategory.community,
    InboxCategory.pleasure,
    InboxCategory.business,
    InboxCategory.recycle,
  ];

  String labelFor(InboxCategory category) {
    switch (category) {
      case InboxCategory.all:
        return AppText.all;
      case InboxCategory.community:
        return AppText.navCommunity;
      case InboxCategory.pleasure:
        return AppText.pleasure;
      case InboxCategory.business:
        return AppText.business;
      case InboxCategory.recycle:
        return AppText.recycle;
    }
  }

  List<ConversationModel> get visible {
    final tab = selectedCategory.value;
    if (tab == InboxCategory.all) return conversations;
    return conversations.where((item) => item.category == tab).toList();
  }

  void selectCategory(InboxCategory category) => selectedCategory.value = category;

  void openChat(ConversationModel conversation) {
    conversation.unread.value = 0;
    Get.toNamed(AppRoute.chatScreen, arguments: conversation);
  }
}
