import 'package:get/get.dart';

enum ProfileTab { about, hobbies, communities }

enum ProfileActivityFilter { all, community, pleasure, recycle }

enum HobbyCollectionKind { gear, albums, places, music, books, movies }

class ProfileInterest {
  const ProfileInterest({required this.label, required this.icon});

  final String label;
  final String icon;
}

class ProfileBusiness {
  const ProfileBusiness({
    required this.name,
    required this.category,
    required this.logo,
  });

  final String name;
  final String category;
  final String logo;
}

class HobbyItem {
  HobbyItem({
    required this.id,
    required this.title,
    required this.image,
    this.subtitle,
    this.meta,
    this.isFile = false,
    this.category,
    this.subcategory,
    this.location,
    this.brand,
    this.model,
    this.description,
    List<String>? photos,
    int likes = 0,
    int dislikes = 0,
    this.comments = 0,
  })  : photos = (photos ?? const []).obs,
        likes = likes.obs,
        dislikes = dislikes.obs;

  final String id;
  String title;
  String image;
  String? subtitle;
  final String? meta;
  bool isFile;
  String? category;
  String? subcategory;
  String? location;
  String? brand;
  String? model;
  String? description;
  final RxList<String> photos;
  final RxInt likes;
  final RxInt dislikes;
  final int comments;
  final liked = false.obs;
  final disliked = false.obs;
}

class HobbyCollection {
  HobbyCollection({
    required this.kind,
    required this.title,
    required this.addLabel,
    required this.removeLabel,
    required this.columns,
    required this.collapsedCount,
    required List<HobbyItem> items,
  }) : items = items.obs;

  final HobbyCollectionKind kind;
  final String title;
  final String addLabel;
  final String removeLabel;
  final int columns;
  final int collapsedCount;
  final RxList<HobbyItem> items;
  final isExpanded = false.obs;
  final isRemoving = false.obs;
}
