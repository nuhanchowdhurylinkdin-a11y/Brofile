import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/core/utils/helpers/profile_navigation.dart';
import 'package:brofile/features/home/data/models/inbox_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatController extends GetxController {
  static const quickEmojis = [
    '😀', '😂', '😍', '🔥', '👏', '🙌', '👍', '🎉', '😮', '🏔️', '🌲', '❤️',
  ];

  late final ConversationModel conversation;
  final messages = <ChatMessage>[].obs;
  final textController = TextEditingController();
  final showEmojis = false.obs;

  String get avatar => conversation.chatAvatar ?? conversation.avatar ?? '';

  @override
  void onInit() {
    super.onInit();
    conversation = Get.arguments as ConversationModel;
    messages.assignAll(_seed(conversation));
  }

  void send() {
    final text = textController.text.trim();
    if (text.isEmpty) return;
    messages.add(
      ChatMessage(
        text: text,
        time: DateFormat('h:mm a').format(DateTime.now()),
        isOutgoing: true,
      ),
    );
    textController.clear();
    showEmojis.value = false;
  }

  void insertEmoji(String emoji) {
    final selection = textController.selection;
    final text = textController.text;
    final start = selection.isValid ? selection.start : text.length;
    final end = selection.isValid ? selection.end : text.length;
    final next = text.replaceRange(start, end, emoji);
    textController.value = TextEditingValue(
      text: next,
      selection: TextSelection.collapsed(offset: start + emoji.length),
    );
  }

  void toggleEmojis() => showEmojis.toggle();

  void openAttach() => AppHelperFunctions.showSnackBar(AppText.comingSoon);

  void openMore() => AppHelperFunctions.showSnackBar(AppText.comingSoon);

  void openProfile() => ProfileNavigation.open(conversation.name);

  List<ChatMessage> _seed(ConversationModel conversation) {
    if (conversation.id == 'sarah') {
      return const [
        ChatMessage(text: AppText.chatSarahIntro, time: AppText.tenThirtyAm, isOutgoing: false),
        ChatMessage(text: AppText.chatSarahReply1, time: AppText.tenThirtyOneAm, isOutgoing: true),
        ChatMessage(text: AppText.chatSarahBonfire, time: AppText.tenThirtyTwoAm, isOutgoing: false),
        ChatMessage(text: AppText.chatSarahReply2, time: AppText.tenThirtyThreeAm, isOutgoing: true),
        ChatMessage(text: AppText.soundsGreatSeeYou, time: AppText.tenThirtyFourAm, isOutgoing: false),
      ];
    }
    return [
      ChatMessage(text: '${conversation.previewPrefix ?? ''}${conversation.preview}', time: conversation.timeAgo, isOutgoing: false),
    ];
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
