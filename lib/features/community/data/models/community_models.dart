import 'package:get/get.dart';

class CommunityInterest {
  const CommunityInterest({required this.label, required this.icon});

  final String label;
  final String icon;
}

class CommunityItem {
  CommunityItem({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.interest,
    this.members = '18K',
    this.online = 128,
    this.description = '',
    this.tagline = '',
    this.address = '',
    this.memberAvatars = const [],
    this.extraMembers = 5,
    this.owned = false,
    this.about = '',
    this.createdOn = '',
    this.visibilityLabel = '',
    this.joinPolicy = '',
    this.highlightPosts = '1K',
    this.highlightFollowers = '12K',
    this.highlightFollowing = '10K',
    bool joined = false,
  }) : isJoined = joined.obs;

  final String id;
  final String name;
  final String image;
  final String category;

  /// Label of the [CommunityInterest] this community belongs to.
  final String interest;
  final String members;
  final int online;
  final String description;
  final String tagline;
  final String address;
  final List<String> memberAvatars;
  final int extraMembers;
  final bool owned;
  final String about;
  final String createdOn;
  final String visibilityLabel;
  final String joinPolicy;
  final String highlightPosts;
  final String highlightFollowers;
  final String highlightFollowing;
  final RxBool isJoined;

  String get topicChip => '$category > $interest';

  bool matchesQuery(String query) {
    if (query.isEmpty) return true;
    final q = query.toLowerCase();
    return name.toLowerCase().contains(q) ||
        description.toLowerCase().contains(q) ||
        tagline.toLowerCase().contains(q) ||
        interest.toLowerCase().contains(q);
  }
}

class CommunityMember {
  CommunityMember({
    required this.id,
    required this.name,
    required this.handle,
    required this.image,
    this.isOwner = false,
    this.isOnline = true,
    bool following = false,
  }) : isFollowing = following.obs;

  final String id;
  final String name;
  final String handle;
  final String image;
  final bool isOwner;
  final bool isOnline;
  final RxBool isFollowing;
}

class CommunityActivity {
  const CommunityActivity({
    required this.name,
    required this.image,
    required this.action,
    required this.timeAgo,
    this.isOnline = true,
  });

  final String name;
  final String image;
  final String action;
  final String timeAgo;
  final bool isOnline;
}

class CommunityUserPost {
  const CommunityUserPost({
    required this.text,
    this.imagePath,
    this.imagePaths = const [],
  });

  final String text;
  final String? imagePath;
  final List<String> imagePaths;

  List<String> get images {
    if (imagePaths.isNotEmpty) return imagePaths;
    if (imagePath != null) return [imagePath!];
    return const [];
  }
}
