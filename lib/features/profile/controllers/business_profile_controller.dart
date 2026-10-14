import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/features/discover/controllers/discover_controller.dart';
import 'package:brofile/features/discover/data/models/discover_models.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/features/profile/controllers/create_business_event_controller.dart';
import 'package:brofile/features/profile/controllers/create_business_post_controller.dart';
import 'package:brofile/features/profile/controllers/create_business_product_controller.dart';
import 'package:brofile/features/profile/controllers/create_business_service_controller.dart';
import 'package:brofile/features/profile/controllers/edit_business_controller.dart';
import 'package:brofile/features/profile/data/models/profile_models.dart';
import 'package:brofile/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessProfileController extends GetxController with GetTickerProviderStateMixin {
  final scrollController = ScrollController();
  final tab = BusinessProfileTab.posts.obs;
  final bioExpanded = false.obs;
  final isFollowing = true.obs;
  final selectedCategory = 0.obs;
  final studioName = AppText.greenleafName.obs;
  final handle = AppText.greenleafHandle.obs;
  final address = AppText.greenleafAddress.obs;
  final aboutText = AppText.greenleafBio.obs;
  final storyText = AppText.greenleafStory.obs;
  final listedProducts = <ProductModel>[].obs;
  final listedServices = <DiscoverService>[].obs;
  final listedEvents = <EventModel>[].obs;
  final listedPosts = <PostModel>[].obs;
  final isVisitor = false.obs;
  late final TabController tabController;

  late final DiscoverController discover = Get.isRegistered<DiscoverController>()
      ? Get.find<DiscoverController>()
      : Get.put(DiscoverController());

  late final promoPost = _studioPost(
    id: 'biz-summer',
    text: AppText.summerOffer,
    images: [ImagePath.bizPostSummer],
  );

  late final eventPost = _studioPost(
    id: 'biz-workshop',
    text: AppText.workshopCaption,
  );

  late final productPost = _studioPost(
    id: 'biz-mat',
    text: AppText.matCaption,
  );

  late final yogaMat = ProductModel(
    name: AppText.ecoYogaMat,
    subtitle: AppText.ecoYogaMatSubtitle,
    image: ImagePath.bizProductMat,
    price: r'$129.99',
    rating: 4.8,
    category: 'Fitness',
  );

  PostModel _studioPost({
    required String id,
    required String text,
    List<String> images = const [],
  }) {
    return PostModel(
      id: id,
      author: AppText.greenleafName,
      avatar: ImagePath.bizLogoGreenleaf,
      timeAgo: '35m',
      category: 'Fitness',
      subcategory: 'Yoga',
      images: images,
      layout: PostLayout.single,
      text: text,
      likes: 120,
      dislikes: 24,
      baseCommentCount: 12,
    );
  }

  final offers = <BusinessOffer>[
    const BusinessOffer(title: AppText.yogaClasses, subtitle: AppText.yogaClassesDesc),
    const BusinessOffer(title: AppText.wellnessPrograms, subtitle: AppText.wellnessProgramsDesc),
    const BusinessOffer(title: AppText.privateSessions, subtitle: AppText.privateSessionsDesc),
  ].obs;

  final reasons = <String>[
    AppText.certifiedInstructors,
    AppText.ecoEnvironment,
    AppText.smallClassSizes,
    AppText.communityWellness,
  ].obs;

  final instructors = const [
    BusinessInstructor(
      name: AppText.annaGrace,
      role: AppText.yogaInstructor,
      bio: AppText.annaBio,
      image: ImagePath.instructorAnna,
    ),
    BusinessInstructor(
      name: AppText.mikePeterson,
      role: AppText.meditationCoach,
      bio: AppText.mikeBio,
      image: ImagePath.instructorMike,
    ),
    BusinessInstructor(
      name: AppText.sophiaLee,
      role: AppText.wellnessExpert,
      bio: AppText.sophiaBio,
      image: ImagePath.instructorSophia,
    ),
  ];

  final hours = const [
    BusinessHour(days: AppText.mondayFriday, hours: AppText.weekdayHours),
    BusinessHour(days: AppText.saturday, hours: AppText.saturdayHours),
    BusinessHour(days: AppText.sunday, hours: AppText.sundayHours),
  ];

  final socials = const [
    BusinessLink(icon: IconPath.bizInstagram, label: AppText.instagramHandle),
    BusinessLink(icon: IconPath.bizFacebook, label: AppText.facebookHandle),
    BusinessLink(icon: IconPath.bizYoutube, label: AppText.youtubeHandle),
    BusinessLink(icon: IconPath.bizWebsite, label: AppText.greenleafWebsite),
  ];

  final infoRows = const [
    BusinessInfoRow(label: AppText.businessType, value: AppText.privateStudio),
    BusinessInfoRow(label: AppText.yearEstablished, value: AppText.establishedYear),
    BusinessInfoRow(label: AppText.teamSize, value: AppText.teamSizeValue),
    BusinessInfoRow(label: AppText.languagesSpoken, value: AppText.englishSpanish),
    BusinessInfoRow(label: AppText.licenseCertification, value: AppText.yogaAlliance),
  ];

  final contacts = const [
    BusinessLink(icon: IconPath.bizPhone, label: AppText.greenleafPhoneContact),
    BusinessLink(icon: IconPath.aboutMail, label: AppText.greenleafEmail),
    BusinessLink(icon: IconPath.aboutGlobe, label: AppText.greenleafWebsite),
  ];

  late final morningYoga = DiscoverService(
    id: 'morning-flow',
    name: AppText.morningYogaFlow,
    description: AppText.morningYogaTagline,
    location: AppText.greenleafName,
    image: ImagePath.bizServiceYoga,
    category: 'Fitness',
  );

  String get bio {
    if (bioExpanded.value) return '${aboutText.value}${AppText.greenleafBioMore}';
    return aboutText.value;
  }

  List<String> get categories => HomeController.categories;

  bool get _allCategory => selectedCategory.value == 0;

  String get _categoryLabel => categories[selectedCategory.value];

  List<ProductModel> get products {
    final items = [...listedProducts, ...discover.gridProducts];
    if (_allCategory) return items;
    return items.where((p) => p.category == _categoryLabel).toList();
  }

  List<DiscoverService> get services {
    final items = [...listedServices, ...discover.services];
    if (_allCategory) return items;
    return items.where((s) => s.category == _categoryLabel).toList();
  }

  List<EventModel> get events {
    final items = [...listedEvents, ...discover.events];
    if (_allCategory) return items;
    return items.where((e) => e.category == _categoryLabel).toList();
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    isVisitor.value = args is Map && args['visitor'] == true;
    tabController = TabController(length: BusinessProfileTab.values.length, vsync: this);
    tabController.addListener(_onTabChanged);
    listedProducts.add(yogaMat);
    listedServices.add(morningYoga);
  }

  void _onTabChanged() {
    if (tabController.indexIsChanging) return;
    tab.value = BusinessProfileTab.values[tabController.index];
  }

  void selectTab(BusinessProfileTab value) {
    tab.value = value;
    if (tabController.index != value.index) {
      tabController.animateTo(value.index);
    }
  }

  @override
  void onClose() {
    if (Get.isRegistered<CreateBusinessProductController>()) {
      Get.delete<CreateBusinessProductController>(force: true);
    }
    if (Get.isRegistered<CreateBusinessServiceController>()) {
      Get.delete<CreateBusinessServiceController>(force: true);
    }
    if (Get.isRegistered<EditBusinessController>()) {
      Get.delete<EditBusinessController>(force: true);
    }
    if (Get.isRegistered<CreateBusinessEventController>()) {
      Get.delete<CreateBusinessEventController>(force: true);
    }
    if (Get.isRegistered<CreateBusinessPostController>()) {
      Get.delete<CreateBusinessPostController>(force: true);
    }
    tabController.removeListener(_onTabChanged);
    tabController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void selectCategory(int index) => selectedCategory.value = index;

  void toggleBio() => bioExpanded.toggle();

  void toggleFollow() => isFollowing.toggle();

  void openCreate() {
    switch (tab.value) {
      case BusinessProfileTab.products:
        Get.toNamed(AppRoute.createBusinessProductScreen);
      case BusinessProfileTab.services:
        Get.toNamed(AppRoute.createBusinessServiceScreen);
      case BusinessProfileTab.events:
        Get.toNamed(AppRoute.createBusinessEventScreen);
      case BusinessProfileTab.posts:
        Get.toNamed(AppRoute.createBusinessPostScreen);
      case BusinessProfileTab.about:
        AppHelperFunctions.showSnackBar(AppText.comingSoon);
    }
  }

  void message() => AppHelperFunctions.showSnackBar(AppText.comingSoon);

  void editProfile() => Get.toNamed(AppRoute.editBusinessScreen);

  void addProduct(ProductModel product) => listedProducts.insert(0, product);

  void addService(DiscoverService service) => listedServices.insert(0, service);

  void addEvent(EventModel event) => listedEvents.insert(0, event);

  void addPost(PostModel post) => listedPosts.insert(0, post);

  void openProduct(ProductModel product) {
    Get.toNamed(AppRoute.businessCatalogDetailsScreen, arguments: _productDetails(product));
  }

  void openService(DiscoverService service) {
    Get.toNamed(AppRoute.businessCatalogDetailsScreen, arguments: _serviceDetails(service));
  }

  void openEvent(EventModel event) {
    Get.toNamed(AppRoute.businessEventDetailsScreen, arguments: event);
  }

  void openDetails(String name) {
    final product = products.where((item) => item.name == name).firstOrNull;
    if (product != null) {
      openProduct(product);
      return;
    }
    final service = services.where((item) => item.name == name).firstOrNull;
    if (service != null) {
      openService(service);
      return;
    }
    final event = events.where((item) => item.title == name).firstOrNull;
    if (event != null) openEvent(event);
  }

  BusinessCatalogDetails _productDetails(ProductModel product) {
    return BusinessCatalogDetails(
      header: AppText.productDetails,
      name: product.name,
      image: product.image,
      tag: product.tag ?? AppText.fitnessYoga,
      subtitle: product.subtitle ?? AppText.ecoYogaMatSubtitle,
      price: product.price,
      stock: AppText.inStock40,
      sectionTitle: AppText.details,
      body: (product.details != null && product.details!.isNotEmpty)
          ? product.details!
          : AppText.greenleafProductDetails,
      cta: AppText.contactForOrder,
    );
  }

  BusinessCatalogDetails _serviceDetails(DiscoverService service) {
    final isYoga = service.name.toLowerCase().contains('yoga');
    return BusinessCatalogDetails(
      header: AppText.serviceDetails,
      name: service.name,
      image: service.image,
      tag: AppText.fitnessYoga,
      subtitle: isYoga ? AppText.morningYogaTagline : service.description,
      price: r'$ 229',
      sectionTitle: AppText.aboutThisServices,
      body: isYoga ? AppText.morningYogaAbout : service.description,
      cta: AppText.contactForBook,
      info: const [
        BusinessInfoRow(label: AppText.schedule, value: AppText.morningSchedule),
        BusinessInfoRow(label: AppText.groupSize, value: AppText.max15People),
        BusinessInfoRow(label: AppText.locationLabel, value: AppText.greenleafName),
        BusinessInfoRow(label: AppText.whatToBring, value: AppText.yogaMatWaterTowel),
      ],
    );
  }

  void toggleProductFavorite(ProductModel product) =>
      product.isFavorite.toggle();

  void toggleEvent(EventModel event) => event.isInterested.toggle();
}
