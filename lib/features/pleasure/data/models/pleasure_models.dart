import 'package:flutter/painting.dart';
import 'package:get/get.dart';

class ActivityItem {
  ActivityItem({
    required this.id,
    required this.host,
    required this.hostAvatar,
    required this.title,
    required this.image,
    required this.category,
    required this.attendees,
    this.subcategory = '',
    this.description = '',
    this.about = '',
    this.time = 'Today • 5:30 PM',
    this.location,
    this.distance,
    this.imageAlignment = Alignment.center,
    int extraAttendees = 5,
    bool joined = false,
  }) : isJoined = joined.obs,
       _initiallyJoined = joined,
       _baseExtra = extraAttendees;

  final String id;
  final String host;
  final String hostAvatar;
  final String title;
  final String image;
  final String category;
  final String subcategory;
  final List<String> attendees;
  final String description;
  final String about;
  final String time;
  final String? location;

  String get tag {
    if (subcategory.isEmpty) return category;
    return '$category > $subcategory';
  }

  String get aboutText => about.isEmpty ? description : about;

  bool get isFileImage =>
      image.isNotEmpty && !image.startsWith('assets/');

  /// Shown instead of [location] on cards listed by proximity.
  final String? distance;
  final Alignment imageAlignment;
  final RxBool isJoined;
  final bool _initiallyJoined;
  final int _baseExtra;

  /// Extra attendees beyond the avatars, counting the current user's RSVP.
  int get extraAttendees {
    final delta = isJoined.value == _initiallyJoined
        ? 0
        : (isJoined.value ? 1 : -1);
    return (_baseExtra + delta).clamp(0, 1 << 20);
  }

  bool matchesQuery(String query) {
    if (query.isEmpty) return true;
    final q = query.toLowerCase();
    return title.toLowerCase().contains(q) ||
        host.toLowerCase().contains(q) ||
        description.toLowerCase().contains(q) ||
        (location?.toLowerCase().contains(q) ?? false);
  }
}

class FriendInterest {
  const FriendInterest({
    required this.name,
    required this.avatar,
    required this.activity,
  });

  final String name;
  final String avatar;
  final String activity;
}
