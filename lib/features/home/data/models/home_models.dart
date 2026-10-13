import 'package:get/get.dart';

enum Reaction { none, like, dislike }

enum PostLayout { single, double, stack }

/// Anything that can be liked or disliked.
abstract interface class Reactable {
  RxInt get likes;
  RxInt get dislikes;
  Rx<Reaction> get reaction;
}

class CommentModel implements Reactable {
  CommentModel({
    required this.id,
    required this.author,
    required this.avatar,
    required this.text,
    this.timeAgo = '35m',
    this.imagePath,
    this.isOnline = true,
    int likes = 0,
    int dislikes = 0,
    List<CommentModel> replies = const [],
  })  : likes = likes.obs,
        dislikes = dislikes.obs,
        replies = replies.obs;

  final String id;
  final String author;
  final String avatar;
  final String text;
  final String timeAgo;

  /// Local path of a photo attached from the gallery.
  final String? imagePath;
  final bool isOnline;

  @override
  final RxInt likes;
  @override
  final RxInt dislikes;
  @override
  final reaction = Reaction.none.obs;
  final RxList<CommentModel> replies;
  final isExpanded = false.obs;
}

class PostModel implements Reactable {
  PostModel({
    required this.id,
    required this.author,
    required this.avatar,
    required this.timeAgo,
    required this.category,
    required this.subcategory,
    required this.images,
    required this.layout,
    required this.text,
    int likes = 0,
    int dislikes = 0,
    this.baseCommentCount = 0,
    this.isOnline = true,
    this.isCard = false,
    List<CommentModel> comments = const [],
  })  : likes = likes.obs,
        dislikes = dislikes.obs,
        comments = comments.obs;

  final String id;
  final String author;
  final String avatar;
  final String timeAgo;
  final String category;
  final String subcategory;
  final List<String> images;
  final PostLayout layout;
  final String text;
  final int baseCommentCount;
  final bool isOnline;

  /// Posts drawn inside a bordered card (the stacked gallery posts).
  final bool isCard;

  @override
  final RxInt likes;
  @override
  final RxInt dislikes;
  @override
  final reaction = Reaction.none.obs;
  final RxList<CommentModel> comments;
  final addedComments = 0.obs;
  final isExpanded = false.obs;
  final stackIndex = 0.obs;

  String get tag => '$category > $subcategory';

  /// Reads reactive state, so call it inside an `Obx`.
  int get commentCount => baseCommentCount + addedComments.value;
}

class SuggestedPerson {
  SuggestedPerson({
    required this.name,
    required this.image,
    required this.mutualFriends,
  });

  final String name;
  final String image;
  final int mutualFriends;
  final isFollowing = false.obs;
}

class FriendActivity {
  const FriendActivity({
    required this.name,
    required this.avatar,
    required this.action,
    required this.timeAgo,
    this.highlight,
    this.thumbnail,
  });

  final String name;
  final String avatar;
  final String action;

  /// Bold trailing part of the sentence, e.g. the place name.
  final String? highlight;
  final String timeAgo;
  final String? thumbnail;
}

class TrendingTrip {
  const TrendingTrip({
    required this.title,
    required this.dates,
    required this.location,
    required this.image,
  });

  final String title;
  final String dates;
  final String location;
  final String image;
}

class CommunityModel {
  CommunityModel({
    required this.name,
    required this.image,
    required this.members,
  });

  final String name;
  final String image;
  final String members;
  final isJoined = false.obs;
}

enum ProductCondition { likeNew, good }

class ProductModel {
  ProductModel({
    required this.name,
    required this.image,
    required this.price,
    this.subtitle,
    this.rating,
    this.condition,
  });

  final String name;
  final String? subtitle;
  final String image;
  final String price;
  final double? rating;
  final ProductCondition? condition;
  final isFavorite = false.obs;
}

class PhotoAlbum {
  const PhotoAlbum({required this.handle, required this.image});

  final String handle;
  final String image;
}

class EventModel {
  EventModel({
    required this.day,
    required this.month,
    required this.title,
    required this.time,
    required this.location,
    required this.image,
    required this.attendees,
    required this.extraAttendees,
  });

  final String day;
  final String month;
  final String title;
  final String time;
  final String location;
  final String image;
  final List<String> attendees;
  final int extraAttendees;
  final isInterested = false.obs;
}

enum HomeSection {
  categories,
  people,
  friends,
  trending,
  communities,
  recommendedGear,
  photoAlbums,
  recycler,
  gears,
  events,
  emptyPosts,
}

sealed class FeedEntry {
  const FeedEntry();
}

class SectionEntry extends FeedEntry {
  const SectionEntry(this.section);

  final HomeSection section;
}

class PostEntry extends FeedEntry {
  const PostEntry(this.post);

  final PostModel post;
}
