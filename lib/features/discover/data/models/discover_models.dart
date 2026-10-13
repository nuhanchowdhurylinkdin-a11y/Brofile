import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum DiscoverType { all, business, products, services, events, recycle }

class DiscoverBusiness {
  DiscoverBusiness({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    this.logo,
    this.tagline = '',
    this.distance,
    this.rating,
    this.isOpen = true,
    this.likes,
    this.location,
    this.followers = '',
    this.followerAvatars = const [],
    this.logoBorder,
    this.badgeText,
    this.goldBadge = false,
    this.isNew = false,
  });

  final String id;
  final String name;
  final String image;
  final String? logo;
  final String tagline;
  final String category;
  final String? distance;
  final double? rating;
  final bool isOpen;
  final String? likes;
  final String? location;
  final String followers;
  final List<String> followerAvatars;
  final Color? logoBorder;
  final String? badgeText;
  final bool goldBadge;
  final bool isNew;
  final isFavorite = false.obs;
  final isFollowing = false.obs;

  bool matches(String query) {
    if (query.isEmpty) return true;
    final q = query.toLowerCase();
    return name.toLowerCase().contains(q) ||
        tagline.toLowerCase().contains(q) ||
        category.toLowerCase().contains(q);
  }
}

class DiscoverService {
  DiscoverService({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.image,
    required this.category,
    this.action = 'Discover More',
  });

  final String id;
  final String name;
  final String description;
  final String location;
  final String image;
  final String category;
  final String action;

  bool matches(String query) {
    if (query.isEmpty) return true;
    final q = query.toLowerCase();
    return name.toLowerCase().contains(q) ||
        description.toLowerCase().contains(q) ||
        location.toLowerCase().contains(q);
  }
}

class DiscoverPost {
  const DiscoverPost({
    required this.handle,
    required this.avatar,
    required this.timeAgo,
    required this.text,
    required this.image,
    this.likes = '12.6k',
    this.location,
  });

  final String handle;
  final String avatar;
  final String timeAgo;
  final String text;
  final String image;
  final String likes;
  final String? location;
}

class DiscoverFeedPost {
  const DiscoverFeedPost({required this.post, this.hashtag});

  final PostModel post;
  final String? hashtag;
}
