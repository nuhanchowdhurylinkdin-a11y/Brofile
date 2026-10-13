import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/routes/app_routes.dart';
import 'package:brofile/features/discover/data/models/discover_models.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscoverController extends GetxController {
  final scrollController = ScrollController();
  final searchController = TextEditingController();
  final featuredPageController = PageController();
  final selectedCategoryKey = GlobalKey();

  final selectedType = DiscoverType.all.obs;
  final selectedCategory = 0.obs;
  final query = ''.obs;
  final featuredIndex = 0.obs;

  static const types = DiscoverType.values;

  String get title => switch (selectedType.value) {
    DiscoverType.all => AppText.discover,
    DiscoverType.business => AppText.business,
    DiscoverType.products => AppText.products,
    DiscoverType.services => AppText.services,
    DiscoverType.events => AppText.events,
    DiscoverType.recycle => AppText.recycle,
  };

  String get subtitle => switch (selectedType.value) {
    DiscoverType.all => AppText.discoverTagline,
    DiscoverType.business => AppText.businessTagline,
    _ => AppText.discoverCompareExplore,
  };

  final featuredBusinesses = <DiscoverBusiness>[
    DiscoverBusiness(
      id: 'ocean',
      name: 'Ocean Grill Restaurant',
      tagline: 'Fresh Seafood •Best in Town!',
      image: ImagePath.oceanGrill,
      logo: ImagePath.oceanLogo,
      category: 'Lifestyle',
      distance: '1.2 km away',
    ),
    DiscoverBusiness(
      id: 'fitzone',
      name: 'FitZone Gym & Fitness',
      tagline: 'Stronger today. better tomorrow.',
      image: ImagePath.fitzone,
      logo: ImagePath.fitzoneLogo,
      category: 'Fitness',
      distance: '1.5 km away',
      rating: 4.6,
    ),
    DiscoverBusiness(
      id: 'greenleaf',
      name: 'GreenLeaf Yoga',
      tagline: 'Find Your Inner Peace.',
      image: ImagePath.greenleaf,
      logo: ImagePath.greenleafLogo,
      category: 'Fitness',
      distance: '2.0 km away',
      rating: 4.8,
    ),
    DiscoverBusiness(
      id: 'cafe',
      name: 'Green Leaf Cafe',
      tagline: 'Organic delights and cozy vibes',
      image: ImagePath.greenCafe,
      logo: ImagePath.greenCafeLogo,
      category: 'Lifestyle',
      distance: '0.9 km away',
      rating: 4.7,
    ),
  ];

  static const _followerAvatars = [
    ImagePath.person1,
    ImagePath.person2,
    ImagePath.person3,
    ImagePath.person4,
    ImagePath.person5,
  ];

  final featuredCarousel = <DiscoverBusiness>[
    DiscoverBusiness(
      id: 'peakfit',
      name: 'PeakFit Gym',
      tagline:
          'High-energy workouts, motivating atmosphere, and unforgettable achievements.',
      image: ImagePath.featuredPeakfit,
      category: 'Fitness',
      distance: '1.2 km away',
      followers: '18K Followers',
      followerAvatars: _followerAvatars,
      goldBadge: true,
    ),
    DiscoverBusiness(
      id: 'cycle',
      name: 'Cycle Chart',
      tagline: 'Indoor cycling studio with high-energy classes.',
      image: ImagePath.cycleChart,
      logo: ImagePath.cycleChart,
      category: 'Fitness',
      distance: '1.2 km away',
      followers: '9.8K Followers',
      followerAvatars: _followerAvatars,
    ),
    DiscoverBusiness(
      id: 'greenleaf-featured',
      name: 'GreenLeaf Yoga',
      tagline: 'Find your inner peace with guided sessions and community.',
      image: ImagePath.greenleaf,
      logo: ImagePath.greenleafLogo,
      category: 'Fitness',
      distance: '2.0 km away',
      followers: '12.1K Followers',
      followerAvatars: _followerAvatars,
    ),
  ];

  final trendingBusinesses = <DiscoverBusiness>[
    DiscoverBusiness(
      id: 'north-brew',
      name: 'North Brew Coffee',
      tagline: 'Coffee Shop',
      image: ImagePath.northBrewCover,
      logo: ImagePath.northBrewLogo,
      logoBorder: AppColors.logoRingPeach,
      category: 'Lifestyle',
      followers: '12.4K Followers',
    ),
    DiscoverBusiness(
      id: 'peak-performance',
      name: 'Peak Performance Gym',
      tagline: 'Fitness Center',
      image: ImagePath.peakPerformance,
      badgeText: 'Peak Performance Gym',
      category: 'Fitness',
      followers: '12.4K Followers',
    ),
    DiscoverBusiness(
      id: 'peak-performance-peek',
      name: 'Peak Performance Gym',
      tagline: 'Fitness Center',
      image: ImagePath.peakPerformance,
      badgeText: 'Peak Performance Gym',
      category: 'Fitness',
      followers: '12.4K Followers',
    ),
  ];

  final suggestedBusinesses = <DiscoverBusiness>[
    DiscoverBusiness(
      id: 'craft',
      name: 'Cycle Craft',
      tagline: 'Sports Store',
      image: ImagePath.cycleCraft,
      category: 'Lifestyle',
    ),
    DiscoverBusiness(
      id: 'blooms',
      name: 'Bloom & co.',
      tagline: 'Florist',
      image: ImagePath.blooms,
      category: 'Lifestyle',
    ),
  ];

  final nearbyBusinesses = <DiscoverBusiness>[
    DiscoverBusiness(
      id: 'north-brew-near',
      name: 'North Brew Coffee',
      tagline: 'Coffee Shop',
      image: ImagePath.northBrewCover,
      category: 'Lifestyle',
      distance: '1.2 km away',
      followers: '12.4K Followers',
    ),
    DiscoverBusiness(
      id: 'peak-performance-near',
      name: 'Peak Performance Gym',
      tagline: 'Fitness Center',
      image: ImagePath.peakPerformance,
      category: 'Fitness',
      distance: '1.2 km away',
      followers: '12.4K Followers',
    ),
  ];

  final newBusinesses = <DiscoverBusiness>[
    DiscoverBusiness(
      id: 'north-brew-new',
      name: 'North Brew Coffee',
      tagline: 'Coffee Shop',
      image: ImagePath.northBrewCover,
      logo: ImagePath.northBrewLogo,
      logoBorder: AppColors.logoRingPeach,
      category: 'Lifestyle',
      followers: '12.4K Followers',
      isNew: true,
    ),
    DiscoverBusiness(
      id: 'peak-performance-new',
      name: 'Peak Performance Gym',
      tagline: 'Fitness Center',
      image: ImagePath.peakPerformance,
      badgeText: 'Peak Performance Gym',
      category: 'Fitness',
      followers: '12.4K Followers',
      isNew: true,
    ),
    DiscoverBusiness(
      id: 'peak-performance-new-peek',
      name: 'Peak Performance Gym',
      tagline: 'Fitness Center',
      image: ImagePath.peakPerformance,
      badgeText: 'Peak Performance Gym',
      category: 'Fitness',
      followers: '12.4K Followers',
    ),
  ];

  final services = <DiscoverService>[
    DiscoverService(
      id: 'personal-yoga',
      name: 'Personal Yoga Training',
      description: 'One-on-one sessions tailored to your goals and needs.',
      location: 'Greenleaf Yoga Studio. Miami',
      image: ImagePath.svcPersonalYoga,
      category: 'Fitness',
      action: AppText.viewDetails,
    ),
    DiscoverService(
      id: 'group-yoga',
      name: 'Group Yoga Classes',
      description:
          'Join our energizing group classes in a calm and supportive space.',
      location: 'Greenleaf Yoga Studio. Miami',
      image: ImagePath.svcGroupYoga,
      category: 'Fitness',
    ),
    DiscoverService(
      id: 'plumbing',
      name: 'Home Plumbing Services',
      description:
          'Skilled plumbing repairs and installations to keep your home flowing perfectly.',
      location: 'Clearwater Plumbing Experts, Seattle',
      image: ImagePath.svcPlumbing,
      category: 'Lifestyle',
      action: AppText.seeDetails,
    ),
    DiscoverService(
      id: 'electrical',
      name: 'Electrical Repair Services',
      description:
          'Certified electricians handling wiring, lighting, and electrical safety.',
      location: 'BrightSpark Electrical, Denver',
      image: ImagePath.svcElectrical,
      category: 'Lifestyle',
    ),
    DiscoverService(
      id: 'beauty',
      name: 'Beauty Care Services',
      description:
          'Professional skincare and makeup treatments to refresh your look.',
      location: 'Luxe Beauty Lounge, Miami',
      image: ImagePath.svcBeauty,
      category: 'Lifestyle',
    ),
    DiscoverService(
      id: 'wellness',
      name: 'Health & Wellness Services',
      description:
          'Personalized fitness coaching and nutrition plans for a healthier you.',
      location: 'Vitality Health Center, Austin',
      image: ImagePath.svcWellness,
      category: 'Fitness',
    ),
    DiscoverService(
      id: 'language',
      name: 'Language Immersion Services',
      description:
          'Immersive programs to help you quickly learn new languages.',
      location: 'Blue Horizon Arts Center, Seattle',
      image: ImagePath.svcLanguage,
      category: 'Learning',
      action: AppText.learnMore,
    ),
    DiscoverService(
      id: 'catering',
      name: 'Catering & Food Services',
      description:
          'Delicious catering options for events and special occasions.',
      location: 'Savory Bites Catering, Chicago',
      image: ImagePath.svcCatering,
      category: 'Lifestyle',
    ),
    DiscoverService(
      id: 'salon',
      name: 'Hair & Salon Services',
      description: 'Trendy haircuts, coloring, and styling by expert stylists.',
      location: 'Urban Chic Salon, New York',
      image: ImagePath.svcSalon,
      category: 'Lifestyle',
    ),
    DiscoverService(
      id: 'cleaning',
      name: 'Home Cleaning Services',
      description:
          'Reliable cleaning teams to keep your home spotless and fresh.',
      location: 'Sparkle Cleaners, San Francisco',
      image: ImagePath.svcCleaning,
      category: 'Lifestyle',
    ),
  ];

  late final products = <ProductModel>[
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

  late final gridProducts = <ProductModel>[
    ...products,
    ProductModel(
      name: 'Smart Watch',
      subtitle: '(Series 6)',
      image: ImagePath.gearWatch,
      price: r'$199.99',
      rating: 4.8,
    ),
    ProductModel(name: 'Pro Fishing Rod Set', image: ImagePath.gearFishingRod, price: r'$89.99'),
    ProductModel(
      name: 'Wireless Headphones',
      image: ImagePath.gearHeadphones,
      price: r'$59.99',
      rating: 4.8,
    ),
    ProductModel(
      name: 'Camping Tent',
      subtitle: '(4 person)',
      image: ImagePath.gearTent,
      price: r'$129.99',
    ),
    ProductModel(
      name: 'Travel Backpack',
      image: ImagePath.gearBackpack,
      price: r'$89.99',
      rating: 4.8,
    ),
    ProductModel(
      name: 'Smart Watch',
      subtitle: '(Series 6)',
      image: ImagePath.gearWatch,
      price: r'$199.99',
      rating: 4.8,
    ),
    ProductModel(name: 'Pro Fishing Rod Set', image: ImagePath.gearFishingRod, price: r'$89.99'),
  ];

  static const _productDetails =
      'Passionate outdoor adventurer exploring breathtaking trails and serene nature retreats, sharing unforgettable hiking experiences and tips for fellow nature lovers.';

  static const _sellerName = 'Shara ahmed';
  static const _memberSince = 'Member since Jan 2025';

  final recyclerItems = <ProductModel>[
    ProductModel(
      name: 'Sofa set',
      image: ImagePath.recSofa,
      price: r'$350',
      condition: ProductCondition.likeNew,
      category: 'Lifestyle',
      tag: 'Lifestyle > Home',
      recycleType: AppText.sell,
      details: _productDetails,
      usingFor: '2 months',
      sellerName: _sellerName,
      sellerAvatar: ImagePath.sellerShara,
      memberSince: _memberSince,
    ),
    ProductModel(
      name: 'Dining Table Set',
      image: ImagePath.recTable,
      price: r'$80',
      condition: ProductCondition.good,
      category: 'Lifestyle',
      tag: 'Lifestyle > Home',
      recycleType: AppText.sell,
      details: _productDetails,
      usingFor: '2 months',
      sellerName: _sellerName,
      sellerAvatar: ImagePath.sellerShara,
      memberSince: _memberSince,
    ),
    ProductModel(
      name: 'Sony Alpha A6000',
      image: ImagePath.recCamera,
      price: r'$350',
      condition: ProductCondition.likeNew,
      category: 'Creative',
      tag: 'Creative > Photography',
      recycleType: AppText.sell,
      details: _productDetails,
      usingFor: '2 months',
      sellerName: _sellerName,
      sellerAvatar: ImagePath.sellerShara,
      memberSince: _memberSince,
    ),
    ProductModel(
      name: 'Bookshelf',
      image: ImagePath.recTable,
      price: r'$80',
      condition: ProductCondition.good,
      category: 'Lifestyle',
      tag: 'Lifestyle > Home',
      recycleType: AppText.sell,
      details: _productDetails,
      usingFor: '2 months',
      sellerName: _sellerName,
      sellerAvatar: ImagePath.sellerShara,
      memberSince: _memberSince,
    ),
    ProductModel(
      name: 'Apple iPhone 12',
      image: ImagePath.recPhone,
      price: r'$350',
      condition: ProductCondition.likeNew,
      category: 'Tech',
      tag: 'Tech > Phones',
      recycleType: AppText.sell,
      details: _productDetails,
      usingFor: '2 months',
      sellerName: _sellerName,
      sellerAvatar: ImagePath.sellerShara,
      memberSince: _memberSince,
    ),
    ProductModel(
      name: 'Office Chair',
      image: ImagePath.recChair,
      price: r'$80',
      condition: ProductCondition.good,
      category: 'Lifestyle',
      tag: 'Lifestyle > Home',
      recycleType: AppText.sell,
      details: _productDetails,
      usingFor: '2 months',
      sellerName: _sellerName,
      sellerAvatar: ImagePath.sellerShara,
      memberSince: _memberSince,
    ),
    ProductModel(
      name: 'Samsung Galaxy S21',
      image: ImagePath.recSamsung,
      price: r'$350',
      condition: ProductCondition.likeNew,
      category: 'Tech',
      tag: 'Tech > Phones',
      recycleType: AppText.sell,
      details: _productDetails,
      usingFor: '2 months',
      sellerName: _sellerName,
      sellerAvatar: ImagePath.sellerShara,
      memberSince: _memberSince,
    ),
    ProductModel(
      name: 'Coffee Table',
      image: ImagePath.recTable,
      price: r'$80',
      condition: ProductCondition.good,
      category: 'Lifestyle',
      tag: 'Lifestyle > Home',
      recycleType: AppText.sell,
      details: _productDetails,
      usingFor: '2 months',
      sellerName: _sellerName,
      sellerAvatar: ImagePath.sellerShara,
      memberSince: _memberSince,
    ),
    ProductModel(
      name: 'Dell XPS 13 Laptop',
      image: ImagePath.recLaptop,
      price: r'$350',
      condition: ProductCondition.likeNew,
      category: 'Tech',
      tag: 'Tech > Computers',
      recycleType: AppText.sell,
      details: _productDetails,
      usingFor: '2 months',
      sellerName: _sellerName,
      sellerAvatar: ImagePath.sellerShara,
      memberSince: _memberSince,
    ),
    ProductModel(
      name: 'Floor Lamp',
      image: ImagePath.recLamp,
      price: r'$80',
      condition: ProductCondition.good,
      category: 'Lifestyle',
      tag: 'Lifestyle > Home',
      recycleType: AppText.sell,
      details: _productDetails,
      usingFor: '2 months',
      sellerName: _sellerName,
      sellerAvatar: ImagePath.sellerShara,
      memberSince: _memberSince,
    ),
    ProductModel(
      name: 'GoPro HERO9',
      image: ImagePath.recCamera,
      price: r'$350',
      condition: ProductCondition.likeNew,
      category: 'Creative',
      tag: 'Creative > Photography',
      recycleType: AppText.sell,
      details: _productDetails,
      usingFor: '2 months',
      sellerName: _sellerName,
      sellerAvatar: ImagePath.sellerShara,
      memberSince: _memberSince,
    ),
    ProductModel(
      name: 'Recliner Chair',
      image: ImagePath.recChair,
      price: r'$80',
      condition: ProductCondition.good,
      category: 'Lifestyle',
      tag: 'Lifestyle > Home',
      recycleType: AppText.sell,
      details: _productDetails,
      usingFor: '2 months',
      sellerName: _sellerName,
      sellerAvatar: ImagePath.sellerShara,
      memberSince: _memberSince,
    ),
  ].obs;

  static const _eventAttendees = [
    ImagePath.person1,
    ImagePath.person2,
    ImagePath.person3,
    ImagePath.person4,
    ImagePath.person5,
  ];

  final events = <EventModel>[
    EventModel(
      day: '24',
      month: 'MAY',
      title: 'Weekend Yoga Workshop',
      time: 'Friday, 7:00 PM',
      location: 'Greenleaf Yoga Studio. Miami',
      image: ImagePath.eventYoga,
      attendees: _eventAttendees,
      extraAttendees: 5,
      category: 'Fitness',
    ),
    EventModel(
      day: '25',
      month: 'MAY',
      title: 'Sunset Kayaking Adventure',
      time: 'Saturday, 5:00 PM',
      location: 'Bayfront Park, Miami',
      image: ImagePath.eventKayak,
      attendees: _eventAttendees,
      extraAttendees: 5,
      category: 'Adventure',
    ),
    EventModel(
      day: '26',
      month: 'MAY',
      title: 'Farmers Market & Live Music',
      time: 'Sunday, 10:00 AM',
      location: 'Downtown Miami',
      image: ImagePath.eventMarket,
      attendees: _eventAttendees,
      extraAttendees: 3,
      category: 'Lifestyle',
    ),
    EventModel(
      day: '27',
      month: 'MAY',
      title: 'Artisan Coffee Tasting',
      time: 'Saturday, 4:00 PM',
      location: 'Bean & Brew Cafe, Miami',
      image: ImagePath.eventCoffee,
      attendees: _eventAttendees,
      extraAttendees: 12,
      category: 'Lifestyle',
    ),
    EventModel(
      day: '28',
      month: 'MAY',
      title: 'Evening Salsa Dance Class',
      time: 'Tuesday, 7:30 PM',
      location: 'Salsa Studio Miami',
      image: ImagePath.eventSalsa,
      attendees: _eventAttendees,
      extraAttendees: 7,
      category: 'Entertainment',
    ),
    EventModel(
      day: '29',
      month: 'MAY',
      title: 'Guided Nature Hike',
      time: 'Wednesday, 9:00 AM',
      location: 'Everglades National Park',
      image: ImagePath.eventHike,
      attendees: _eventAttendees,
      extraAttendees: 4,
      category: 'Adventure',
    ),
  ];

  EventModel get event => events.first;

  late final artisanPost = DiscoverFeedPost(
    post: PostModel(
      id: 'discover-artisan-1',
      author: 'Artisan coffee',
      avatar: ImagePath.artisanAvatar,
      timeAgo: '35m',
      category: 'Lifestyle',
      subcategory: 'Coffee',
      images: const [ImagePath.artisanCoffee],
      layout: PostLayout.single,
      text:
          'We just launched our new Seasonal Coffee Collection! Made with ethically sourced beans and lots Of love.',
      likes: 120,
      dislikes: 24,
      baseCommentCount: 12,
      isOnline: false,
    ),
  );

  late final artisanPost2 = DiscoverFeedPost(
    post: PostModel(
      id: 'discover-artisan-2',
      author: 'Artisan coffee',
      avatar: ImagePath.artisanAvatar,
      timeAgo: '35m',
      category: 'Lifestyle',
      subcategory: 'Coffee',
      images: const [ImagePath.artisanCoffee],
      layout: PostLayout.single,
      text:
          'We just launched our new Seasonal Coffee Collection! Made with ethically sourced beans and lots Of love.',
      likes: 120,
      dislikes: 24,
      baseCommentCount: 12,
      isOnline: false,
    ),
  );

  late final williamPost = DiscoverFeedPost(
    post: PostModel(
      id: 'discover-william',
      author: 'William',
      avatar: ImagePath.avatarWilliam,
      timeAgo: '35m',
      category: 'Adventure',
      subcategory: 'Hiking',
      images: const [ImagePath.williamHike1, ImagePath.williamHike2],
      layout: PostLayout.double,
      text:
          'Just wrapped up an incredible hike through Redwood National Park! The scenery was stunning and the trails pushed me to my limits. Perfect for thrill-seekers! #Adventure',
      likes: 120,
      dislikes: 24,
      baseCommentCount: 12,
    ),
    hashtag: '#Mountain Lovers',
  );

  bool _inCategory(String category) {
    final label = HomeController.categories[selectedCategory.value];
    if (label == AppText.all) return true;
    return category == label;
  }

  List<DiscoverBusiness> _visibleBusinesses(List<DiscoverBusiness> items) =>
      items.where((b) => _inCategory(b.category) && b.matches(query.value)).toList();

  bool _visiblePost(DiscoverFeedPost feed) {
    final post = feed.post;
    if (!_inCategory(post.category)) return false;
    final q = query.value.toLowerCase();
    if (q.isEmpty) return true;
    return post.author.toLowerCase().contains(q) ||
        post.text.toLowerCase().contains(q) ||
        (feed.hashtag?.toLowerCase().contains(q) ?? false);
  }

  List<DiscoverBusiness> get visibleFeatured => featuredBusinesses
      .where((b) => _inCategory(b.category) && b.matches(query.value))
      .toList();

  List<DiscoverBusiness> get visibleFeaturedCarousel =>
      _visibleBusinesses(featuredCarousel);

  List<DiscoverBusiness> get visibleTrending =>
      _visibleBusinesses(trendingBusinesses);

  List<DiscoverBusiness> get visibleSuggested =>
      _visibleBusinesses(suggestedBusinesses);

  List<DiscoverBusiness> get visibleNearby =>
      _visibleBusinesses(nearbyBusinesses);

  List<DiscoverBusiness> get visibleNew => _visibleBusinesses(newBusinesses);

  bool get artisanVisible => _visiblePost(artisanPost);

  bool get williamVisible => _visiblePost(williamPost);

  bool get businessFeedEmpty =>
      visibleFeaturedCarousel.isEmpty &&
      visibleTrending.isEmpty &&
      !artisanVisible &&
      visibleSuggested.isEmpty &&
      visibleNearby.isEmpty &&
      !williamVisible &&
      visibleNew.isEmpty;

  List<DiscoverService> get hubServices => services
      .take(2)
      .where((s) => _inCategory(s.category) && s.matches(query.value))
      .toList();

  List<DiscoverService> get visibleServices => services
      .where((s) => _inCategory(s.category) && s.matches(query.value))
      .toList();

  List<ProductModel> get visibleProducts {
    final q = query.value.toLowerCase();
    return gridProducts.where((p) {
      if (q.isEmpty) return true;
      return p.name.toLowerCase().contains(q) ||
          (p.subtitle?.toLowerCase().contains(q) ?? false);
    }).toList();
  }

  List<ProductModel> get visibleRecycler {
    final q = query.value.toLowerCase();
    return recyclerItems.where((p) {
      if (p.category != null && !_inCategory(p.category!)) return false;
      if (q.isEmpty) return true;
      return p.name.toLowerCase().contains(q);
    }).toList();
  }

  List<EventModel> get visibleEvents {
    final q = query.value.toLowerCase();
    return events.where((e) {
      if (!_inCategory(e.category)) return false;
      if (q.isEmpty) return true;
      return e.title.toLowerCase().contains(q) ||
          e.location.toLowerCase().contains(q);
    }).toList();
  }

  List<ProductModel> get hubProducts => products.take(2).toList();

  void selectType(DiscoverType type) => selectedType.value = type;

  void selectCategory(int index) => selectedCategory.value = index;

  void onSearchChanged(String value) => query.value = value.trim();

  void toggleFavorite(DiscoverBusiness business) => business.isFavorite.toggle();

  void toggleProductFavorite(ProductModel product) => product.isFavorite.toggle();

  void toggleFollow(DiscoverBusiness business) => business.isFollowing.toggle();

  void toggleInterested([EventModel? item]) =>
      (item ?? event).isInterested.toggle();

  void openFilter() => AppHelperFunctions.showSnackBar(AppText.comingSoon);

  void openDetails(String name) =>
      AppHelperFunctions.showSnackBar(AppText.comingSoon);

  void openRecyclerProduct(ProductModel product) =>
      Get.toNamed(AppRoute.recycleProductDetailsScreen, arguments: product);

  void openCreateProduct() => Get.toNamed(AppRoute.createProductScreen);

  void addRecyclerProduct(ProductModel product) =>
      recyclerItems.insert(0, product);

  void openSeeAll(DiscoverType type) => selectedType.value = type;

  void onFeaturedPageChanged(int index) => featuredIndex.value = index;

  Future<void> refreshDiscover() =>
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
    searchController.dispose();
    featuredPageController.dispose();
    super.onClose();
  }
}
