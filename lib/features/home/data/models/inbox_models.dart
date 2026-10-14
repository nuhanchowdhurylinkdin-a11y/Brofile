import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum InboxCategory { all, community, pleasure, business, recycle }

enum NotificationBadge { none, comment, like }

class SearchHit {
  const SearchHit({required this.label, this.avatar});

  final String label;
  final String? avatar;
}

class InboxNotification {
  InboxNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.timeAgo,
    required this.category,
    this.avatar,
    this.iconAsset,
    this.iconBackground,
    this.badge = NotificationBadge.none,
    bool unread = false,
  }) : isUnread = unread.obs;

  final String id;
  final String title;
  final String body;
  final String timeAgo;
  final InboxCategory category;
  final String? avatar;
  final String? iconAsset;
  final Color? iconBackground;
  final NotificationBadge badge;
  final RxBool isUnread;
}

class ConversationModel {
  ConversationModel({
    required this.id,
    required this.name,
    required this.preview,
    required this.timeAgo,
    required this.category,
    this.avatar,
    this.iconAsset,
    this.avatarBackground,
    this.avatarRadius,
    this.isOnline = false,
    this.previewPrefix,
    this.chatAvatar,
    int unread = 0,
  }) : unread = unread.obs;

  final String id;
  final String name;
  final String preview;
  final String timeAgo;
  final InboxCategory category;
  final String? avatar;
  final String? chatAvatar;
  final String? iconAsset;
  final Color? avatarBackground;
  final double? avatarRadius;
  final bool isOnline;
  final String? previewPrefix;
  final RxInt unread;
}

class ChatMessage {
  const ChatMessage({
    required this.text,
    required this.time,
    required this.isOutgoing,
  });

  final String text;
  final String time;
  final bool isOutgoing;
}
