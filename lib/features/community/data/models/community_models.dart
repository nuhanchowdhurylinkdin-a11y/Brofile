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
  final RxBool isJoined;

  bool matchesQuery(String query) {
    if (query.isEmpty) return true;
    final q = query.toLowerCase();
    return name.toLowerCase().contains(q) ||
        description.toLowerCase().contains(q) ||
        tagline.toLowerCase().contains(q) ||
        interest.toLowerCase().contains(q);
  }
}
