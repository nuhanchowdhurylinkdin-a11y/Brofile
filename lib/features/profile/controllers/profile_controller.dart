import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/core/utils/helpers/profile_navigation.dart';
import 'package:brofile/features/community/controllers/community_controller.dart';
import 'package:brofile/features/community/data/models/community_models.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/features/profile/data/models/profile_models.dart';
import 'package:brofile/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final scrollController = ScrollController();
  final hobbiesScrollController = ScrollController();

  final selectedTab = ProfileTab.about.obs;
  final activityFilter = ProfileActivityFilter.all.obs;
  final interestsExpanded = false.obs;
  final isVisitor = false.obs;
  final isFollowing = false.obs;

  final displayName = 'William'.obs;
  final username = '@William'.obs;
  final headline = 'UX Designer • Outdoor Explorer'.obs;
  final locationLabel = 'New York, USA'.obs;
  final website = 'williamadventures.com'.obs;
  final bio =
      'Passionate outdoor adventurer exploring breathtaking trails and serene nature retreats, sharing unforgettable hiking experiences and tips for fellow nature lovers.'
          .obs;
  final phone = '+012 124 - 2365'.obs;
  final email = 'william.designer@gmail.com'.obs;
  final philosophy =
      '"Leave every place better than you found it."'.obs;
  final skills = <String>[
    'UX Design',
    'UI Design',
    'Research',
    'Figma',
    'Graphic Design',
    'Photography',
  ].obs;
  final jobs = <EmploymentEntry>[
    EmploymentEntry(
      title: 'UX Designer',
      company: 'Servo Digital',
      period: '2023 • Present',
      location: 'New York, USA',
      type: 'Full-time',
      startDate: 'Feb 2023',
      current: true,
    ),
    EmploymentEntry(
      title: 'UI/UX Designer',
      company: 'ABC Studio',
      period: '2021 • 2023',
      location: 'New York, USA',
      type: 'Full-time',
      startDate: 'Jan 2021',
      endDate: 'Jan 2023',
    ),
  ].obs;
  final education = <EducationEntry>[
    EducationEntry(
      course: 'B.Sc. in Computer Science',
      institute: 'University of XYZ',
      period: '2017 - 2021',
      location: 'New York, USA',
      startDate: 'Feb 2017',
      endDate: 'Jan 2021',
    ),
    EducationEntry(
      course: 'B.Sc. in Computer Science',
      institute: 'University of XYZ',
      period: '2017 - 2021',
      location: 'New York, USA',
      startDate: 'Feb 2017',
      endDate: 'Jan 2021',
    ),
  ].obs;
  final links = <String>[
    'www.facebook.com/william',
    'www.twitter.com/william123',
    'www.linkedin.com/in/william',
    'www.instagram.com/william_photos',
  ].obs;

  static const interests = [
    ProfileInterest(label: 'Hiking', icon: IconPath.interestHiking),
    ProfileInterest(label: 'Camping', icon: IconPath.interestCamping),
    ProfileInterest(label: 'Photography', icon: IconPath.interestPhoto),
    ProfileInterest(label: 'Travel', icon: IconPath.interestTravel),
    ProfileInterest(label: 'Bike Riding', icon: IconPath.interestBike),
    ProfileInterest(label: 'Fishing', icon: IconPath.interestFishing),
    ProfileInterest(label: 'Reading', icon: IconPath.interestReading),
    ProfileInterest(label: 'Music', icon: IconPath.interestMusic),
  ];

  final businesses = const [
    ProfileBusiness(
      name: 'GreenLeaf Yoga Studio',
      category: 'Yoga & Wellness',
      logo: ImagePath.bizGreenleaf,
    ),
    ProfileBusiness(
      name: 'PizzaVita',
      category: 'Italian Restaurant',
      logo: ImagePath.bizPizza,
    ),
  ];

  late final List<HobbyCollection> collections = [
    HobbyCollection(
      kind: HobbyCollectionKind.gear,
      title: AppText.myGear,
      addLabel: AppText.addNewGear,
      removeLabel: AppText.removeGear,
      columns: 3,
      collapsedCount: 6,
      items: [
        HobbyItem(id: 'g1', title: 'Nikon D850 DSLR Camera', image: ImagePath.gear1),
        HobbyItem(id: 'g2', title: 'Kawasaki Ninja Motorcycle', image: ImagePath.gear2),
        HobbyItem(id: 'g3', title: 'Parrot Anafi Drone', image: ImagePath.gear3),
        HobbyItem(id: 'g4', title: 'Casio Electric Keyboard', image: ImagePath.gear4),
        HobbyItem(id: 'g5', title: 'Samsung Galaxy Buds Pro', image: ImagePath.gear5),
        HobbyItem(id: 'g6', title: 'Kobo Clara HD E-reader', image: ImagePath.gear6),
        HobbyItem(id: 'g7', title: 'Garmin Fenix 8', image: ImagePath.gear7),
        HobbyItem(id: 'g8', title: 'Osprey Aether Backpack', image: ImagePath.gear8),
        HobbyItem(id: 'g9', title: 'MSR Hubba Hubba Tent', image: ImagePath.gear9),
        HobbyItem(id: 'g10', title: 'Leatherman Wave+', image: ImagePath.gear10),
        HobbyItem(id: 'g11', title: 'MacBook Pro', image: ImagePath.gear11),
        HobbyItem(id: 'g12', title: 'Steam Deck', image: ImagePath.gear12),
      ],
    ),
    HobbyCollection(
      kind: HobbyCollectionKind.albums,
      title: AppText.photoAlbums,
      addLabel: AppText.addNew,
      removeLabel: AppText.removeAlbum,
      columns: 3,
      collapsedCount: 6,
      items: [
        HobbyItem(id: 'a1', title: 'Alpine Escapes', image: ImagePath.hobbyAlbum1, subtitle: '45 photos'),
        HobbyItem(id: 'a2', title: 'River Adventures', image: ImagePath.hobbyAlbum2, subtitle: '15 photos'),
        HobbyItem(
          id: 'a3',
          title: 'Catch & Release',
          image: ImagePath.profileEvent,
          subtitle: '5 photos',
          category: 'Adventure',
          subcategory: 'Fishing',
          description: AppText.catchReleaseBody,
          photos: const [
            ImagePath.profileEvent,
            ImagePath.hobbyAlbum1,
            ImagePath.hobbyAlbum2,
            ImagePath.hobbyAlbum4,
            ImagePath.hobbyAlbum5,
          ],
          likes: 120,
          dislikes: 24,
          comments: 12,
        ),
        HobbyItem(id: 'a4', title: 'Into The Peaks', image: ImagePath.hobbyAlbum4, subtitle: '45 photos'),
        HobbyItem(id: 'a5', title: 'Beyond The Horizon', image: ImagePath.hobbyAlbum5, subtitle: '15 photos'),
        HobbyItem(id: 'a6', title: 'Journey Unscripted', image: ImagePath.hobbyAlbum6, subtitle: '5 photos'),
      ],
    ),
    HobbyCollection(
      kind: HobbyCollectionKind.places,
      title: AppText.myFavoritePlace,
      addLabel: AppText.addPlace,
      removeLabel: AppText.removePlace,
      columns: 3,
      collapsedCount: 6,
      items: [
        HobbyItem(id: 'p1', title: 'Machu Picchu', image: ImagePath.place1),
        HobbyItem(id: 'p2', title: 'Great Barrier Reef', image: ImagePath.place2),
        HobbyItem(id: 'p3', title: 'Bali Island', image: ImagePath.place3),
        HobbyItem(id: 'p4', title: 'Sahara Desert', image: ImagePath.place4),
        HobbyItem(id: 'p5', title: 'Niagara Falls', image: ImagePath.place5),
        HobbyItem(id: 'p6', title: 'Galápagos Islands', image: ImagePath.place6),
      ],
    ),
    HobbyCollection(
      kind: HobbyCollectionKind.music,
      title: AppText.musicILove,
      addLabel: AppText.addMusic,
      removeLabel: AppText.removeMusic,
      columns: 2,
      collapsedCount: 4,
      items: [
        HobbyItem(id: 'm1', title: 'Echoes of Dawn', image: ImagePath.music1, subtitle: 'Luna Harper', meta: 'Midnight Reverie'),
        HobbyItem(id: 'm2', title: 'Starlit Journey', image: ImagePath.music2, subtitle: 'Kai Rivers', meta: 'Celestial Dreams'),
        HobbyItem(id: 'm3', title: 'Whispering Winds', image: ImagePath.music3, subtitle: 'Luna Harper', meta: 'Midnight Reverie'),
        HobbyItem(id: 'm4', title: 'Starlit Journey', image: ImagePath.music4, subtitle: 'Kai Rivers', meta: 'Celestial Dreams'),
      ],
    ),
    HobbyCollection(
      kind: HobbyCollectionKind.books,
      title: AppText.myFavoriteBooks,
      addLabel: AppText.addBook,
      removeLabel: AppText.removeBook,
      columns: 3,
      collapsedCount: 6,
      items: [
        HobbyItem(id: 'b1', title: 'Whispering Shadows', image: ImagePath.book1, subtitle: 'Elena Marlowe'),
        HobbyItem(id: 'b2', title: 'The Last Ember', image: ImagePath.book2, subtitle: 'Jasper Quinn'),
        HobbyItem(id: 'b3', title: 'Echoes of Tomorrow', image: ImagePath.book3, subtitle: 'Maya Sterling'),
        HobbyItem(id: 'b4', title: 'Beneath the Silver Moon', image: ImagePath.book4, subtitle: 'Liam Hart'),
        HobbyItem(id: 'b5', title: 'The Forgotten Path', image: ImagePath.book5, subtitle: 'Elena Marlowe'),
        HobbyItem(id: 'b6', title: 'The Last Ember', image: ImagePath.book6, subtitle: 'Jasper Quinn'),
      ],
    ),
    HobbyCollection(
      kind: HobbyCollectionKind.movies,
      title: AppText.myFavoriteMovies,
      addLabel: AppText.addMovies,
      removeLabel: AppText.removeMovies,
      columns: 3,
      collapsedCount: 6,
      items: [
        HobbyItem(id: 'v1', title: 'Into the Wild', image: ImagePath.movie1, subtitle: 'Sean Penn'),
        HobbyItem(id: 'v2', title: 'Free Solo', image: ImagePath.movie2, subtitle: 'Elizabeth Chai Vasarhelyi & Jimmy Chin'),
        HobbyItem(id: 'v3', title: 'The Way', image: ImagePath.movie3, subtitle: 'Emilio Estevez'),
        HobbyItem(id: 'v4', title: 'The Salt of the Earth', image: ImagePath.movie4, subtitle: 'Wim Wenders & Juliano Ribeiro Salgado'),
        HobbyItem(id: 'v5', title: 'Interstellar', image: ImagePath.movie5, subtitle: 'Christopher Nolan'),
        HobbyItem(id: 'v6', title: 'Life of Pi', image: ImagePath.movie6, subtitle: 'Ang Lee'),
      ],
    ),
  ];

  List<PostModel> get posts {
    final home = Get.find<HomeController>();
    return home.feed
        .whereType<PostEntry>()
        .map((entry) => entry.post)
        .where((post) => post.author == 'William')
        .toList();
  }

  final event = EventModel(
    day: '25',
    month: 'MAR',
    title: 'Morning Trek to Blue Ridge',
    time: 'Join us for a refreshing hike through lush forests and stunning mountain vistas.',
    location: 'Blue Ridge Mountains, Georgia',
    image: ImagePath.catchRelease,
    attendees: const [
      ImagePath.person1,
      ImagePath.person2,
      ImagePath.person3,
      ImagePath.person4,
    ],
    extraAttendees: 5,
  );

  final eventFavorited = false.obs;

  List<CommunityItem> get myCommunities =>
      Get.find<CommunityController>().joinedCommunities;

  static bool get viewingAsVisitor =>
      Get.isRegistered<ProfileController>() && Get.find<ProfileController>().isVisitor.value;

  void enterVisitor() {
    if (isVisitor.value) return;
    isVisitor.value = true;
    selectedTab.value = ProfileTab.about;
    collapseAll();
  }

  void exitVisitor() {
    if (!isVisitor.value) return;
    isVisitor.value = false;
    selectedTab.value = ProfileTab.about;
    collapseAll();
  }

  void toggleFollow() => isFollowing.toggle();

  void message() => AppHelperFunctions.showSnackBar(AppText.comingSoon);

  String publicLabel(String label) {
    if (!isVisitor.value) return label;
    return ProfileNavigation.publicLabel(label);
  }

  void selectTab(ProfileTab tab) {
    if (isVisitor.value) {
      selectedTab.value = tab;
      collapseAll();
      return;
    }
    if (tab == ProfileTab.about) {
      selectedTab.value = ProfileTab.about;
      collapseAll();
      openAboutMe();
      return;
    }
    if (tab == ProfileTab.hobbies) {
      openHobbies();
      return;
    }
    if (tab == ProfileTab.communities) {
      openMyCommunities();
      return;
    }
    selectedTab.value = tab;
    collapseAll();
  }

  void openHobbies() {
    collapseAll();
    Get.toNamed(AppRoute.hobbiesScreen);
  }

  void openAboutMe() => Get.toNamed(AppRoute.aboutMeScreen);

  void openMyCommunities() => Get.toNamed(AppRoute.myCommunitiesScreen);

  void openSettings() => Get.toNamed(AppRoute.settingsScreen);

  void closeHobbies() {
    collapseAll();
    Get.back();
  }

  void selectActivity(ProfileActivityFilter filter) =>
      activityFilter.value = filter;

  void toggleInterests() => interestsExpanded.toggle();

  void toggleCollection(HobbyCollection collection) {
    final opening = !collection.isExpanded.value;
    for (final other in collections) {
      if (other.kind == collection.kind) continue;
      other.isExpanded.value = false;
      other.isRemoving.value = false;
    }
    collection.isExpanded.value = opening;
    if (!opening) collection.isRemoving.value = false;
  }

  void collapseCollection(HobbyCollection collection) {
    collection.isExpanded.value = false;
    collection.isRemoving.value = false;
  }

  void collapseAll() {
    for (final collection in collections) {
      collection.isExpanded.value = false;
      collection.isRemoving.value = false;
    }
    interestsExpanded.value = false;
  }

  void toggleRemoving(HobbyCollection collection) {
    if (!collection.isExpanded.value) collection.isExpanded.value = true;
    collection.isRemoving.toggle();
  }

  void removeItem(HobbyCollection collection, HobbyItem item) {
    collection.items.removeWhere((entry) => entry.id == item.id);
  }

  Future<void> addItem(HobbyCollection collection) async {
    Get.toNamed(AppRoute.addHobbyScreen, arguments: collection);
  }

  void openAlbum(HobbyItem item) =>
      Get.toNamed(AppRoute.albumDetailsScreen, arguments: item);

  void insertHobby(HobbyCollection collection, HobbyItem item) {
    collection.items.insert(0, item);
    collection.isExpanded.value = true;
    collection.isRemoving.value = false;
  }

  void refreshHobbyItems() {
    for (final collection in collections) {
      collection.items.refresh();
    }
  }

  void addBusiness() => AppHelperFunctions.showSnackBar(AppText.comingSoon);

  void openBusiness(ProfileBusiness business) {
    if (business.name.contains('GreenLeaf') || business.name.contains('Pizza')) {
      ProfileNavigation.openBusiness(visitor: isVisitor.value);
      return;
    }
    AppHelperFunctions.showSnackBar(AppText.comingSoon);
  }

  void openMyCircle() => Get.toNamed(AppRoute.myCircleScreen);

  void openAspirations() => Get.toNamed(AppRoute.aspirationsScreen);

  void openDetails(String name) =>
      AppHelperFunctions.showSnackBar(AppText.comingSoon);

  Future<void> refreshProfile() =>
      Future.delayed(const Duration(milliseconds: 800));

  void scrollToTop() {
    if (!scrollController.hasClients) return;
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void onClose() {
    scrollController.dispose();
    hobbiesScrollController.dispose();
    super.onClose();
  }
}
