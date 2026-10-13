import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/features/community/data/models/community_models.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum CommunitySection { featured, trending, newThisWeek, nearYou, other }

class CommunityController extends GetxController {
  final scrollController = ScrollController();
  final nearYouPageController = PageController();
  final searchController = TextEditingController();
  final selectedCategoryKey = GlobalKey();

  static const String _lifestyle = 'Lifestyle';

  static const List<CommunityInterest> interests = [
    CommunityInterest(label: 'Cooking', icon: IconPath.interestCooking),
    CommunityInterest(label: 'Baking', icon: IconPath.interestBaking),
    CommunityInterest(label: 'Coffee', icon: IconPath.interestCoffee),
    CommunityInterest(label: 'Tea', icon: IconPath.interestTea),
    CommunityInterest(label: 'Fashion', icon: IconPath.interestFashion),
    CommunityInterest(label: 'Gardening', icon: IconPath.interestGardening),
    CommunityInterest(label: 'Interior', icon: IconPath.interestInterior),
    CommunityInterest(label: 'Grooming', icon: IconPath.interestGrooming),
  ];

  static const List<String> _crowd = [
    ImagePath.person1,
    ImagePath.person2,
    ImagePath.person3,
    ImagePath.person4,
    ImagePath.person5,
  ];
  static const List<String> _smallCrowd = [
    ImagePath.person3,
    ImagePath.person4,
    ImagePath.person5,
  ];

  final selectedCategory = HomeController.categories.indexOf(_lifestyle).obs;
  final selectedInterests = <String>{}.obs;
  final query = ''.obs;
  final nearYouIndex = 0.obs;

  late final Map<CommunitySection, List<CommunityItem>> _sections = {
    CommunitySection.featured: [
      CommunityItem(
        id: 'coffee-lovers',
        name: 'Coffee Lovers',
        image: ImagePath.featuredCoffee,
        category: _lifestyle,
        interest: 'Coffee',
        description: 'A community for coffee enthusiasts. Share, learn and grow together.',
        memberAvatars: _crowd,
      ),
    ],
    CommunitySection.other: [
      CommunityItem(
        id: 'home-barista-club',
        name: 'Home Barista Club',
        image: ImagePath.myBaristaClub,
        category: _lifestyle,
        interest: 'Coffee',
        tagline: 'Trends, Tips & Coffee Style',
        joined: true,
      ),
      CommunityItem(
        id: 'style-and-you',
        name: 'Style & You',
        image: ImagePath.myStyleAndYou,
        category: _lifestyle,
        interest: 'Fashion',
        tagline: 'Fashion, Outfit & Style',
        joined: true,
      ),
    ],
    CommunitySection.trending: [
      CommunityItem(
        id: 'tea-culture',
        name: 'Tea Culture',
        image: ImagePath.trendingTeaCulture,
        category: _lifestyle,
        interest: 'Tea',
        tagline: 'Brews, Blends & Rituals',
        memberAvatars: _smallCrowd,
      ),
      CommunityItem(
        id: 'diy-crafts-hub',
        name: 'DIY & Crafts Hub',
        image: ImagePath.trendingDiyCrafts,
        category: _lifestyle,
        interest: 'Interior',
        tagline: 'Make, Fix & Decorate',
        memberAvatars: _smallCrowd,
      ),
      CommunityItem(
        id: 'plant-parents',
        name: 'Plant Parents',
        image: ImagePath.trendingPlantParents,
        category: _lifestyle,
        interest: 'Gardening',
        tagline: 'Grow, Care & Share',
        memberAvatars: _smallCrowd,
      ),
    ],
    CommunitySection.newThisWeek: [
      CommunityItem(
        id: 'minimal-living',
        name: 'Minimal Living',
        image: ImagePath.newMinimalLiving,
        category: _lifestyle,
        interest: 'Interior',
        members: '2.5K',
        tagline: 'Less Stuff, More Life',
      ),
      CommunityItem(
        id: 'coffee-roasters',
        name: 'Coffee Roasters',
        image: ImagePath.newCoffeeRoasters,
        category: _lifestyle,
        interest: 'Coffee',
        members: '2.5K',
        tagline: 'Beans, Roasts & Profiles',
      ),
      CommunityItem(
        id: 'art-and-doodles',
        name: 'Art & Doodles',
        image: ImagePath.newArtDoodles,
        category: _lifestyle,
        interest: 'Interior',
        members: '2.5K',
        tagline: 'Sketch, Paint & Create',
      ),
    ],
    CommunitySection.nearYou: [
      CommunityItem(
        id: 'diy-crafts-springfield',
        name: 'DIY & Crafts Hub',
        image: ImagePath.nearDiyCrafts,
        category: _lifestyle,
        interest: 'Interior',
        online: 8,
        address: '123 Elm Street, Springfield, IL 62704',
        memberAvatars: _crowd,
      ),
      CommunityItem(
        id: 'urban-gardeners',
        name: 'Urban Gardeners',
        image: ImagePath.trendingPlantParents,
        category: _lifestyle,
        interest: 'Gardening',
        online: 14,
        address: '48 Oak Avenue, Springfield, IL 62701',
        memberAvatars: _crowd,
      ),
      CommunityItem(
        id: 'morning-brew-crew',
        name: 'Morning Brew Crew',
        image: ImagePath.featuredCoffee,
        category: _lifestyle,
        interest: 'Coffee',
        online: 5,
        address: '9 Maple Road, Springfield, IL 62702',
        memberAvatars: _crowd,
      ),
    ],
  };

  String get selectedCategoryLabel =>
      HomeController.categories[selectedCategory.value];

  bool get showsInterests => selectedCategoryLabel == _lifestyle;

  String get trendingTitle => selectedCategory.value == 0
      ? AppText.trending
      : '${AppText.trending} $selectedCategoryLabel';

  bool _matches(CommunityItem community) {
    final category = selectedCategoryLabel;
    if (category != AppText.all && community.category != category) return false;
    if (showsInterests &&
        selectedInterests.isNotEmpty &&
        !selectedInterests.contains(community.interest)) {
      return false;
    }
    return community.matchesQuery(query.value);
  }

  List<CommunityItem> section(CommunitySection section) =>
      _sections[section]!.where(_matches).toList();

  List<CommunityItem> get myCommunities => _sections.values
      .expand((items) => items)
      .where((community) => community.isJoined.value && _matches(community))
      .toList();

  bool get hasResults =>
      CommunitySection.values
          .where((s) => s != CommunitySection.other)
          .any((s) => section(s).isNotEmpty) ||
      myCommunities.isNotEmpty;

  @override
  void onReady() {
    super.onReady();
    WidgetsBinding.instance.addPostFrameCallback((_) => _revealSelectedCategory());
  }

  void _revealSelectedCategory() {
    final context = selectedCategoryKey.currentContext;
    if (context != null) Scrollable.ensureVisible(context, alignment: 0.5);
  }

  void selectCategory(int index) {
    selectedCategory.value = index;
    _resetCarousel();
  }

  void toggleInterest(String label) {
    if (!selectedInterests.remove(label)) selectedInterests.add(label);
    _resetCarousel();
  }

  void onSearchChanged(String value) {
    query.value = value.trim();
    _resetCarousel();
  }

  void _resetCarousel() {
    nearYouIndex.value = 0;
    if (nearYouPageController.hasClients) nearYouPageController.jumpToPage(0);
  }

  void onNearYouChanged(int index) => nearYouIndex.value = index;

  void toggleJoin(CommunityItem community) => community.isJoined.toggle();

  Future<void> refreshCommunities() =>
      Future.delayed(const Duration(milliseconds: 800));

  void scrollToTop() {
    if (!scrollController.hasClients) return;
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  void openCreate() => AppHelperFunctions.showSnackBar(AppText.comingSoon);
  void openFilter() => AppHelperFunctions.showSnackBar(AppText.comingSoon);
  void openSeeAll(String section) =>
      AppHelperFunctions.showSnackBar(AppText.comingSoon);
  void openCommunity(CommunityItem community) =>
      AppHelperFunctions.showSnackBar(AppText.comingSoon);

  @override
  void onClose() {
    scrollController.dispose();
    nearYouPageController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
