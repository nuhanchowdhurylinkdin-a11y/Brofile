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

class EmploymentEntry {
  EmploymentEntry({
    required this.title,
    required this.company,
    required this.period,
    this.location = '',
    this.type = '',
    this.startDate = '',
    this.endDate = '',
    this.current = false,
    this.logo,
  });

  String title;
  String company;
  String period;
  String location;
  String type;
  String startDate;
  String endDate;
  bool current;
  final String? logo;
}

class EducationEntry {
  EducationEntry({
    required this.course,
    required this.institute,
    required this.period,
    this.location = '',
    this.startDate = '',
    this.endDate = '',
    this.current = false,
  });

  String course;
  String institute;
  String period;
  String location;
  String startDate;
  String endDate;
  bool current;
}

class BlockedUser {
  BlockedUser({
    required this.id,
    required this.name,
    required this.handle,
    required this.image,
  });

  final String id;
  final String name;
  final String handle;
  final String image;
}

class HiddenCommunity {
  HiddenCommunity({
    required this.id,
    required this.name,
    required this.members,
    required this.image,
  });

  final String id;
  final String name;
  final String members;
  final String image;
}

class HelpArticle {
  const HelpArticle({required this.question, required this.answer});

  final String question;
  final String answer;
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

enum CircleGroup { family, relatives, friends }

class CircleMember {
  CircleMember({
    required this.id,
    required this.name,
    required this.image,
    required this.relation,
    required this.group,
    this.handle = '',
    this.online = true,
  });

  final String id;
  final String name;
  final String image;
  final String relation;
  final CircleGroup group;
  final String handle;
  final bool online;
}

enum AspirationKind { project, hope, dream }

enum AspirationStatus { inProgress, planning, ideaStage }

enum BusinessProfileTab { posts, products, services, events, about }

class BusinessOffer {
  const BusinessOffer({required this.title, required this.subtitle});

  final String title;
  final String subtitle;
}

class BusinessInstructor {
  const BusinessInstructor({
    required this.name,
    required this.role,
    required this.bio,
    required this.image,
  });

  final String name;
  final String role;
  final String bio;
  final String image;
}

class BusinessHour {
  const BusinessHour({required this.days, required this.hours});

  final String days;
  final String hours;
}

class BusinessInfoRow {
  const BusinessInfoRow({required this.label, required this.value});

  final String label;
  final String value;
}

class BusinessLink {
  const BusinessLink({required this.icon, required this.label});

  final String icon;
  final String label;
}

class BusinessCatalogDetails {
  const BusinessCatalogDetails({
    required this.header,
    required this.name,
    required this.image,
    required this.tag,
    required this.subtitle,
    required this.price,
    required this.sectionTitle,
    required this.body,
    required this.cta,
    this.stock,
    this.info = const [],
  });

  final String header;
  final String name;
  final String image;
  final String tag;
  final String subtitle;
  final String price;
  final String sectionTitle;
  final String body;
  final String cta;
  final String? stock;
  final List<BusinessInfoRow> info;
}

class AspirationItem {
  AspirationItem({
    required this.id,
    required this.kind,
    required this.title,
    required this.icon,
    required this.iconBg,
    this.status,
    this.target = '',
    this.description = '',
    this.notes = '',
  });

  final String id;
  final AspirationKind kind;
  String title;
  String icon;
  int iconBg;
  AspirationStatus? status;
  String target;
  String description;
  String notes;
}
