import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/core/utils/helpers/profile_navigation.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final scrollController = ScrollController();
  final trendingPageController = PageController();

  static const List<String> categories = [
    AppText.all,
    'Adventure',
    'Fitness',
    'Sports',
    'Creative',
    'Entertainment',
    'Travel',
    'Learning',
    'Tech',
    'Motors',
    'Lifestyle',
    'Social',
  ];

  final selectedCategory = 0.obs;
  final trendingIndex = 0.obs;
  final hiddenPostIds = <String>{}.obs;

  final people = <SuggestedPerson>[
    SuggestedPerson(name: 'Alexa Morgan', image: ImagePath.personAlexa, mutualFriends: 12),
    SuggestedPerson(name: 'Mike Taylor', image: ImagePath.personMike, mutualFriends: 8),
    SuggestedPerson(name: 'John Doe', image: ImagePath.personJohn, mutualFriends: 15),
    SuggestedPerson(name: 'Alexa Morgan', image: ImagePath.personAlexa2, mutualFriends: 12),
  ];

  final friendActivities = const <FriendActivity>[
    FriendActivity(
      name: 'Sarah Khan',
      avatar: ImagePath.friendSarahKhan,
      action: 'is going to Camping in ',
      highlight: 'Sajek',
      timeAgo: '2 hrs ago',
      thumbnail: ImagePath.activitySajek,
    ),
    FriendActivity(
      name: 'Mike Ross',
      avatar: ImagePath.friendMikeRoss,
      action: 'posted a photo',
      timeAgo: '2 hrs ago',
      thumbnail: ImagePath.activityPhoto,
    ),
    FriendActivity(
      name: 'James Lee',
      avatar: ImagePath.friendJamesLee,
      action: 'joined Mountain Love',
      timeAgo: '2 hrs ago',
    ),
  ];

  final trendingTrips = const <TrendingTrip>[
    TrendingTrip(
      title: 'Weekend Trek to Sundarban',
      dates: 'May 24 - May 25 • 2 Days',
      location: 'Sundarban',
      image: ImagePath.trendingSundarban,
    ),
    TrendingTrip(
      title: 'Camping Night at Sajek',
      dates: 'Jun 07 - Jun 08 • 2 Days',
      location: 'Sajek Valley',
      image: ImagePath.activitySajek,
    ),
    TrendingTrip(
      title: 'Hill Hike in Bandarban',
      dates: 'Jun 14 - Jun 16 • 3 Days',
      location: 'Bandarban',
      image: ImagePath.postHike1,
    ),
  ];

  final communities = <CommunityModel>[
    CommunityModel(name: 'Hikers United', image: ImagePath.communityHikers, members: '12K'),
    CommunityModel(name: 'Camping Life', image: ImagePath.communityCamping, members: '12K'),
    CommunityModel(name: 'Backpackers', image: ImagePath.communityBackpackers, members: '12K'),
  ];

  final recommendedGear = <ProductModel>[
    ProductModel(name: 'Pro Fishing Rod Set', image: ImagePath.gearFishingRod, price: r'$89.99'),
    ProductModel(
      name: 'Camping Tent',
      subtitle: '(4 person)',
      image: ImagePath.gearTent,
      price: r'$129.99',
    ),
    ProductModel(
      name: 'Smart Watch',
      subtitle: '(Series 6)',
      image: ImagePath.gearWatch,
      price: r'$199.99',
      rating: 4.8,
    ),
    ProductModel(
      name: 'Wireless Headphones',
      image: ImagePath.gearHeadphones,
      price: r'$59.99',
      rating: 4.8,
    ),
    ProductModel(
      name: 'Travel Backpack',
      image: ImagePath.gearBackpack,
      price: r'$89.99',
      rating: 4.8,
    ),
  ];

  final recyclerItems = <ProductModel>[
    ProductModel(
      name: 'Canon eos 2000',
      image: ImagePath.recyclerCamera,
      price: r'$350',
      condition: ProductCondition.likeNew,
    ),
    ProductModel(
      name: 'Sofa set',
      image: ImagePath.recyclerSofa,
      price: r'$80',
      condition: ProductCondition.good,
    ),
    ProductModel(
      name: 'Smart Watch',
      subtitle: '(Series 6)',
      image: ImagePath.gearWatch,
      price: r'$199.99',
      rating: 4.8,
    ),
    ProductModel(
      name: 'Wireless Headphones',
      image: ImagePath.gearHeadphones,
      price: r'$59.99',
      rating: 4.8,
    ),
    ProductModel(
      name: 'Travel Backpack',
      image: ImagePath.gearBackpack,
      price: r'$89.99',
      rating: 4.8,
    ),
  ];

  final photoAlbums = const <PhotoAlbum>[
    PhotoAlbum(handle: '@William', image: ImagePath.albumWilliam),
    PhotoAlbum(handle: '@Sara', image: ImagePath.albumSara),
    PhotoAlbum(handle: '@Adam', image: ImagePath.albumAdam),
    PhotoAlbum(handle: '@Lisa', image: ImagePath.albumLisa),
    PhotoAlbum(handle: '@Emily', image: ImagePath.albumEmily),
  ];

  final event = EventModel(
    day: '24',
    month: 'MAY',
    title: 'Weekend Yoga Workshop',
    time: 'Friday, 7:00 PM',
    location: 'Greenleaf Yoga Studio. Miami',
    image: ImagePath.eventYoga,
    attendees: const [ImagePath.attendee1, ImagePath.attendee2, ImagePath.attendee3],
    extraAttendees: 5,
  );

  late final List<FeedEntry> _feed = _buildFeed();

  List<FeedEntry> get feed => _feed;

  static const String _postText =
      'Just wrapped up an incredible hike through Redwood National Park! '
      'The scenery was stunning and the trails pushed me to my limits. '
      'Perfect for thrill-seekers! #Adventure';

  PostModel _post(
    int id,
    String author,
    String avatar,
    PostLayout layout,
    List<String> images, {
    bool isCard = false,
  }) {
    return PostModel(
      id: 'post_$id',
      author: author,
      avatar: avatar,
      timeAgo: '35m',
      category: 'Adventure',
      subcategory: 'Hiking',
      images: images,
      layout: layout,
      text: _postText,
      likes: 120,
      dislikes: 24,
      baseCommentCount: 12,
      isCard: isCard,
      comments: _mockComments('post_$id'),
    );
  }

  static const String _commentText =
      'Conquered the rocky terrain of Zion National Park! '
      'Unforgettable experience with stunning views.';

  List<CommentModel> _mockComments(String postId) {
    CommentModel comment(
      String id,
      String author,
      String avatar, {
      String text = _commentText,
      List<CommentModel> replies = const [],
    }) {
      return CommentModel(
        id: '${postId}_$id',
        author: author,
        avatar: avatar,
        text: text,
        likes: 120,
        dislikes: 24,
        replies: replies,
      );
    }

    const ryan = 'Ryan Cooper';
    return [
      comment('c1', 'Alex Parker', ImagePath.commenterAlex, replies: [
        comment('c1_r1', ryan, ImagePath.commenterRyan),
      ]),
      comment('c2', 'Flora Parker', ImagePath.commenterFlora, replies: [
        comment('c2_r1', ryan, ImagePath.commenterRyan),
        comment('c2_r2', ryan, ImagePath.commenterRyan, text: 'Thank you!'),
      ]),
    ];
  }

  List<FeedEntry> _buildFeed() {
    const twoImages = [ImagePath.postHike1, ImagePath.postHike2];
    const oneImage = [ImagePath.postGroup];
    const stack = [ImagePath.stackCenter, ImagePath.stackRight, ImagePath.stackLeft];
    const william = ImagePath.avatarWilliam;
    const sarah = ImagePath.avatarSarah;
    const alex = ImagePath.avatarAlex;
    const alisa = ImagePath.avatarAlisa;

    return [
      const SectionEntry(HomeSection.categories),
      const SectionEntry(HomeSection.people),
      PostEntry(_post(1, 'William', william, PostLayout.double, twoImages)),
      PostEntry(_post(2, 'Sarah', sarah, PostLayout.stack, stack, isCard: true)),
      PostEntry(_post(3, 'William', william, PostLayout.single, oneImage)),
      const SectionEntry(HomeSection.friends),
      const SectionEntry(HomeSection.trending),
      PostEntry(_post(4, 'Alex', alex, PostLayout.single, oneImage)),
      PostEntry(_post(5, 'Alisa', alisa, PostLayout.double, twoImages)),
      const SectionEntry(HomeSection.communities),
      PostEntry(_post(6, 'Alisa', alisa, PostLayout.double, twoImages)),
      PostEntry(_post(7, 'Alex', alex, PostLayout.single, oneImage)),
      const SectionEntry(HomeSection.recommendedGear),
      PostEntry(_post(8, 'Sarah', sarah, PostLayout.stack, stack, isCard: true)),
      const SectionEntry(HomeSection.photoAlbums),
      PostEntry(_post(9, 'William', william, PostLayout.single, oneImage)),
      PostEntry(_post(10, 'William', william, PostLayout.double, twoImages)),
      const SectionEntry(HomeSection.recycler),
      const SectionEntry(HomeSection.gears),
      PostEntry(_post(11, 'Sarah', sarah, PostLayout.stack, stack, isCard: true)),
      PostEntry(_post(12, 'William', william, PostLayout.double, twoImages)),
      const SectionEntry(HomeSection.events),
    ];
  }

  /// Feed after applying the selected category and hidden posts.
  /// Reads reactive state, so call it inside an `Obx`.
  List<FeedEntry> get visibleFeed {
    final index = selectedCategory.value;
    final category = categories[index];
    final hidden = hiddenPostIds.toSet();

    bool isVisible(PostModel post) =>
        !hidden.contains(post.id) && (index == 0 || post.category == category);

    final entries = _feed
        .where((entry) => entry is! PostEntry || isVisible(entry.post))
        .toList();

    final hasPosts = entries.any((entry) => entry is PostEntry);
    if (!hasPosts) {
      entries.insert(2, const SectionEntry(HomeSection.emptyPosts));
    }
    return entries;
  }

  void selectCategory(int index) => selectedCategory.value = index;

  void selectCategoryByName(String name) {
    final index = categories.indexOf(name);
    if (index != -1) selectCategory(index);
  }

  void toggleFollow(SuggestedPerson person) => person.isFollowing.toggle();

  /// Like and dislike are mutually exclusive; tapping the active one clears it.
  void react(Reactable item, Reaction reaction) {
    final previous = item.reaction.value;
    if (previous == Reaction.like) item.likes.value--;
    if (previous == Reaction.dislike) item.dislikes.value--;

    if (previous == reaction) {
      item.reaction.value = Reaction.none;
      return;
    }

    if (reaction == Reaction.like) item.likes.value++;
    if (reaction == Reaction.dislike) item.dislikes.value++;
    item.reaction.value = reaction;
  }

  void toggleExpanded(PostModel post) => post.isExpanded.toggle();

  void nextStackImage(PostModel post) =>
      post.stackIndex.value = (post.stackIndex.value + 1) % post.images.length;

  void hidePost(PostModel post) {
    hiddenPostIds.add(post.id);
    AppHelperFunctions.showSnackBar(AppText.postHidden);
  }

  void reportPost(PostModel post) => AppHelperFunctions.showSnackBar(AppText.postReported);

  Future<void> copyPostText(PostModel post) async {
    await Clipboard.setData(ClipboardData(text: post.text));
    AppHelperFunctions.showSnackBar(AppText.textCopied);
  }

  void onTrendingPageChanged(int index) => trendingIndex.value = index;

  void goToTrendingPage(int index) {
    trendingPageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void toggleJoin(CommunityModel community) => community.isJoined.toggle();

  void toggleFavorite(ProductModel product) => product.isFavorite.toggle();

  void toggleInterested(EventModel event) => event.isInterested.toggle();

  void openSearch() => Get.toNamed(AppRoute.searchScreen);
  void openMessages() => Get.toNamed(AppRoute.messagesScreen);
  void openNotifications() => Get.toNamed(AppRoute.notificationsInboxScreen);
  void openSeeAll(String section) => AppHelperFunctions.showSnackBar(AppText.comingSoon);
  void openProfile(String name) => ProfileNavigation.open(name);
  void openDetails(String title) => AppHelperFunctions.showSnackBar(AppText.comingSoon);

  Future<void> refreshFeed() async {
    // TODO: fetch the feed from the API.
    await Future.delayed(const Duration(milliseconds: 800));
    hiddenPostIds.clear();
  }

  void scrollToTop() {
    if (!scrollController.hasClients) return;
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  @override
  void onClose() {
    scrollController.dispose();
    trendingPageController.dispose();
    super.onClose();
  }
}
