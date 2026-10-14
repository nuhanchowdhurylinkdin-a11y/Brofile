import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/core/utils/helpers/profile_navigation.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/pleasure/data/models/pleasure_models.dart';
import 'package:brofile/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PleasureController extends GetxController {
  final scrollController = ScrollController();
  final searchController = TextEditingController();

  static const List<String> _attendees = [
    ImagePath.person1,
    ImagePath.person3,
    ImagePath.person4,
    ImagePath.person5,
  ];

  final selectedCategory = 0.obs;
  final query = ''.obs;

  static const String _about =
      'Join us for an energizing weekend yoga workshop designed to help you relax, recharge, and reconnect with your body and mind. Perfect for all levels!';

  final startingSoonItems = <ActivityItem>[
    ActivityItem(
      id: 'tura-fishing',
      host: 'Rafiul Islam',
      hostAvatar: ImagePath.person1,
      title: 'Fishing at Tura River this afternoon',
      description: 'Weather looks perfect! Need 3-4 fishing buddies.Bring your own gear.',
      about: _about,
      location: 'Greenleaf Yoga Studio, Miami, Florida',
      distance: '1.2 Km',
      image: ImagePath.activityFishing,
      category: 'Adventure',
      subcategory: 'Fishing',
      attendees: _attendees,
    ),
    ActivityItem(
      id: 'banani-coffee',
      host: 'Sarah Khan',
      hostAvatar: ImagePath.person2,
      title: 'Fishing at Tura River this afternoon',
      description: "Let's catch up over some good coffee and stories.(Fee: \$ 5OO for bait)",
      about: _about,
      location: 'Banani, Dhaka',
      image: ImagePath.activityCoffee,
      imageAlignment: const Alignment(0, 0.21),
      category: 'Social',
      subcategory: 'Coffee',
      attendees: _attendees,
    ),
    ActivityItem(
      id: 'sajek-ride',
      host: 'Alex Morgan',
      hostAvatar: ImagePath.person3,
      title: 'Sajek Ride this Friday',
      description: 'Planning a ride to Sajek. Looking for 2 more riders.Fuel cost split among all.',
      about: _about,
      image: ImagePath.activitySajekRide,
      category: 'Motors',
      subcategory: 'Ride',
      attendees: const [
        ImagePath.person6,
        ImagePath.person3,
        ImagePath.person7,
      ],
      extraAttendees: 0,
      joined: true,
    ),
  ].obs;

  final nearYouItems = <ActivityItem>[
    ActivityItem(
      id: 'gulshan-badminton',
      host: 'Jisan Rahman',
      hostAvatar: ImagePath.person1,
      title: 'Badminton Match at Gulshan Club',
      distance: '1.2 Km',
      location: 'Gulshan Club',
      image: ImagePath.activityFishing,
      category: 'Sports',
      subcategory: 'Badminton',
      about: _about,
      attendees: _attendees,
    ),
    ActivityItem(
      id: 'tura-fishing-near-1',
      host: 'Rafiul Islam',
      hostAvatar: ImagePath.person1,
      title: 'Fishing at Tura River this afternoon',
      location: 'Turag River, Uttara',
      image: ImagePath.activityFishing,
      category: 'Adventure',
      subcategory: 'Fishing',
      about: _about,
      attendees: _attendees,
    ),
    ActivityItem(
      id: 'tura-fishing-near-2',
      host: 'Rafiul Islam',
      hostAvatar: ImagePath.person1,
      title: 'Fishing at Tura River this afternoon',
      location: 'Turag River, Uttara',
      image: ImagePath.activityFishing,
      category: 'Adventure',
      subcategory: 'Fishing',
      about: _about,
      attendees: _attendees,
    ),
  ].obs;

  final friends = const <FriendInterest>[
    FriendInterest(
      name: 'Hasan',
      avatar: ImagePath.person8,
      activity: 'Weekend Hike',
    ),
    FriendInterest(
      name: 'Mehzabin',
      avatar: ImagePath.person1,
      activity: 'Yoga Session',
    ),
    FriendInterest(
      name: 'Rahat',
      avatar: ImagePath.person9,
      activity: 'Car Meet',
    ),
    FriendInterest(
      name: 'sara',
      avatar: ImagePath.person10,
      activity: 'Movie Night',
    ),
  ];

  bool _matches(ActivityItem activity) {
    final category = HomeController.categories[selectedCategory.value];
    if (category != AppText.all && activity.category != category) return false;
    return activity.matchesQuery(query.value);
  }

  List<ActivityItem> get startingSoon {
    startingSoonItems.length;
    return startingSoonItems.where(_matches).toList();
  }

  List<ActivityItem> get nearYou {
    nearYouItems.length;
    return nearYouItems.where(_matches).toList();
  }

  List<FriendInterest> get visibleFriends {
    final q = query.value.toLowerCase();
    if (q.isEmpty) return friends;
    return friends
        .where(
          (f) =>
              f.name.toLowerCase().contains(q) ||
              f.activity.toLowerCase().contains(q),
        )
        .toList();
  }

  void selectCategory(int index) => selectedCategory.value = index;

  void onSearchChanged(String value) => query.value = value.trim();

  void toggleJoin(ActivityItem activity) => activity.isJoined.toggle();

  Future<void> refreshActivities() =>
      Future.delayed(const Duration(milliseconds: 800));

  void scrollToTop() {
    if (!scrollController.hasClients) return;
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  void addActivity(ActivityItem activity) => startingSoonItems.insert(0, activity);

  void openCreate() => Get.toNamed(AppRoute.createPleasureScreen);

  void openFilter() => AppHelperFunctions.showSnackBar(AppText.comingSoon);
  void openSeeAll(String section) =>
      AppHelperFunctions.showSnackBar(AppText.comingSoon);

  void openActivity(ActivityItem activity) {
    Get.toNamed(AppRoute.pleasureDetailsScreen, arguments: activity);
  }
  void openFriend(FriendInterest friend) => ProfileNavigation.open(friend.name);

  @override
  void onClose() {
    scrollController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
