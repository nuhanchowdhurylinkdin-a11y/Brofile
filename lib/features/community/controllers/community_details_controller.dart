import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/features/community/controllers/community_controller.dart';
import 'package:brofile/features/community/data/models/community_models.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum CommunityDetailsTab { posts, members, about, settings }

class CommunityDetailsController extends GetxController {
  late final CommunityItem community;
  final tab = CommunityDetailsTab.posts.obs;
  final memberQuery = ''.obs;
  final searchController = TextEditingController();
  final userPosts = <CommunityUserPost>[].obs;

  final members = <CommunityMember>[
    CommunityMember(
      id: 'william',
      name: 'William',
      handle: '@William',
      image: ImagePath.avatarWilliam,
      isOwner: true,
    ),
    CommunityMember(id: 'eleanor', name: 'Eleanor', handle: '@Eleanor', image: ImagePath.person1, following: true),
    CommunityMember(id: 'maya', name: 'Maya', handle: '@Maya', image: ImagePath.person2),
    CommunityMember(id: 'sofia', name: 'Sofia', handle: '@Sofia', image: ImagePath.person3),
    CommunityMember(id: 'jasper', name: 'Jasper', handle: '@Jasper', image: ImagePath.person4, following: true),
    CommunityMember(id: 'noah', name: 'Noah', handle: '@Noah', image: ImagePath.person5, following: true),
    CommunityMember(id: 'liam', name: 'Liam', handle: '@Liam', image: ImagePath.person6, following: true),
    CommunityMember(id: 'aria', name: 'Aria', handle: '@Aria', image: ImagePath.person7, following: true),
  ];

  final activities = const [
    CommunityActivity(
      name: 'Sophia',
      image: ImagePath.person2,
      action: AppText.activitySharedUpdate,
      timeAgo: '3 hours ago',
    ),
    CommunityActivity(
      name: 'Liam',
      image: ImagePath.person6,
      action: AppText.activityJoinedCommunity,
      timeAgo: '5 hours ago',
    ),
    CommunityActivity(
      name: 'Emma',
      image: ImagePath.person8,
      action: AppText.activityLikedPost,
      timeAgo: '1 hour ago',
    ),
    CommunityActivity(
      name: 'Noah',
      image: ImagePath.person5,
      action: AppText.activityCommentedPost,
      timeAgo: '4 hours ago',
    ),
  ];

  late final List<PostModel> seedPosts = [
    PostModel(
      id: 'c_sarah',
      author: 'Sarah',
      avatar: ImagePath.avatarSarah,
      timeAgo: '35m',
      category: community.category,
      subcategory: community.interest,
      images: const [ImagePath.stackCenter, ImagePath.stackRight, ImagePath.stackLeft],
      layout: PostLayout.stack,
      text: _postText,
      likes: 120,
      dislikes: 24,
      baseCommentCount: 12,
      isCard: true,
    ),
    PostModel(
      id: 'c_william',
      author: 'William',
      avatar: ImagePath.avatarWilliam,
      timeAgo: '35m',
      category: community.category,
      subcategory: community.interest,
      images: const [ImagePath.postGroup],
      layout: PostLayout.single,
      text: _postText,
      likes: 120,
      dislikes: 24,
      baseCommentCount: 12,
    ),
    PostModel(
      id: 'c_alex',
      author: 'Alex',
      avatar: ImagePath.avatarAlex,
      timeAgo: '35m',
      category: community.category,
      subcategory: community.interest,
      images: const [ImagePath.postGroup],
      layout: PostLayout.single,
      text: _postText,
      likes: 120,
      dislikes: 24,
      baseCommentCount: 12,
    ),
    PostModel(
      id: 'c_alisa',
      author: 'Alisa',
      avatar: ImagePath.avatarAlisa,
      timeAgo: '35m',
      category: community.category,
      subcategory: community.interest,
      images: const [ImagePath.postHike1, ImagePath.postHike2],
      layout: PostLayout.double,
      text: _postText,
      likes: 120,
      dislikes: 24,
      baseCommentCount: 12,
    ),
  ];

  static const _postText =
      'Just wrapped up an incredible hike through Redwood National Park! '
      'The scenery was stunning and the trails pushed me to my limits. '
      'Perfect for thrill-seekers! #Adventure';

  CommunityMember get owner => members.firstWhere((member) => member.isOwner);

  List<CommunityMember> get visibleMembers {
    final query = memberQuery.value.trim().toLowerCase();
    final regular = members.where((member) => !member.isOwner);
    if (query.isEmpty) return regular.toList();
    return regular
        .where(
          (member) =>
              member.name.toLowerCase().contains(query) || member.handle.toLowerCase().contains(query),
        )
        .toList();
  }

  @override
  void onInit() {
    community = Get.arguments as CommunityItem;
    super.onInit();
  }

  void selectTab(CommunityDetailsTab value) => tab.value = value;

  void onSearchChanged(String value) => memberQuery.value = value;

  void toggleFollow(CommunityMember member) => member.isFollowing.toggle();

  void openCreatePost() => Get.toNamed(AppRoute.communityNewPostScreen);

  void openInvite() => Get.toNamed(AppRoute.inviteMembersScreen, arguments: community);

  void addUserPost(CommunityUserPost post) => userPosts.insert(0, post);

  void comingSoon() => AppHelperFunctions.showSnackBar(AppText.comingSoon);

  void deleteCommunity() {
    Get.find<CommunityController>().deleteOwned(community);
    Get.back();
    AppHelperFunctions.showSnackBar(AppText.communityDeleted);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
