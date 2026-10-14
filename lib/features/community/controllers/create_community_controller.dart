import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/core/utils/helpers/app_platform.dart';
import 'package:brofile/features/community/controllers/community_controller.dart';
import 'package:brofile/features/community/data/models/community_models.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateCommunityController extends GetxController {
  static const int maxRules = 300;

  static const Map<String, List<String>> subcategories = {
    'Adventure': [
      'Hiking',
      'Camping',
      'Trekking',
      'Backpacking',
      'Fishing',
      'Road Trips',
      'Kayaking',
      'Canoeing',
      'Rock Climbing',
      'Mountaineering',
      'Overlanding',
    ],
    'Fitness': ['Yoga', 'Gym', 'Running', 'Cycling'],
    'Sports': ['Football', 'Cricket', 'Badminton', 'Tennis'],
    'Creative': ['Art', 'Music', 'Photography', 'Writing'],
    'Entertainment': ['Movie', 'Concert', 'Games'],
    'Travel': ['Trip', 'Staycation', 'Tour'],
    'Learning': ['Workshop', 'Class', 'Meetup'],
    'Tech': ['Hackathon', 'Demo', 'Talk'],
    'Motors': ['Ride', 'Rally', 'Meet'],
    'Lifestyle': ['Coffee', 'Fashion', 'Food'],
    'Social': ['Hangout', 'Party', 'Coffee'],
  };

  static const locations = ['New York', 'Los Angeles', 'London', 'Dhaka', 'Toronto'];
  static const postPolicies = [AppText.everyone, AppText.membersOnly, AppText.adminsOnly];
  static const invitePolicies = [AppText.everyone, AppText.membersOnly, AppText.adminsOnly];

  final nameController = TextEditingController(text: AppText.mountainLoversName);
  final descriptionController = TextEditingController(text: AppText.mountainLoversShortDescription);
  final rulesController = TextEditingController(text: AppText.communityRulesSeed);
  final ImagePicker _picker = ImagePicker();

  final coverPath = Rxn<String>();
  final category = 'Adventure'.obs;
  final subcategory = 'Hiking'.obs;
  final isPublic = true.obs;
  final unlimitedSize = true.obs;
  final location = 'New York'.obs;
  final whoCanPost = AppText.everyone.obs;
  final whoCanInvite = AppText.everyone.obs;
  final rulesLength = 0.obs;

  List<String> get categoryOptions =>
      HomeController.categories.where((label) => label != AppText.all).toList();

  List<String> get subcategoryOptions =>
      subcategories[category.value] ?? const [];

  @override
  void onInit() {
    super.onInit();
    rulesLength.value = rulesController.text.length;
    rulesController.addListener(() => rulesLength.value = rulesController.text.length);
  }

  Future<void> pickCover() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1080,
      imageQuality: 85,
    );
    if (file != null) coverPath.value = file.path;
  }

  void selectCategory(String value) {
    category.value = value;
    final options = subcategoryOptions;
    if (!options.contains(subcategory.value)) {
      subcategory.value = options.isEmpty ? '' : options.first;
    }
  }

  void selectSubcategory(String value) => subcategory.value = value;

  void selectPrivacy(bool publicValue) => isPublic.value = publicValue;

  void selectSize(bool unlimited) => unlimitedSize.value = unlimited;

  Future<void> pickLocation() async {
    final selected = await _pickOption(locations);
    if (selected != null) location.value = selected;
  }

  Future<void> pickWhoCanPost() async {
    final selected = await _pickOption(postPolicies);
    if (selected != null) whoCanPost.value = selected;
  }

  Future<void> pickWhoCanInvite() async {
    final selected = await _pickOption(invitePolicies);
    if (selected != null) whoCanInvite.value = selected;
  }

  void create() {
    final name = nameController.text.trim();
    final description = descriptionController.text.trim();
    if (name.isEmpty) {
      AppHelperFunctions.showSnackBar(AppText.communityNameRequired);
      return;
    }
    if (description.isEmpty) {
      AppHelperFunctions.showSnackBar(AppText.shortDescriptionRequired);
      return;
    }

    Get.find<CommunityController>().addOwned(
      CommunityItem(
        id: 'created-${DateTime.now().millisecondsSinceEpoch}',
        name: name,
        image: coverPath.value ?? ImagePath.mountainCover,
        category: category.value,
        interest: subcategory.value.isEmpty ? category.value : subcategory.value,
        description: description,
        about: rulesController.text.trim(),
        address: location.value,
        createdOn: AppText.createdOnCommunity,
        visibilityLabel: isPublic.value ? AppText.publicCommunity : AppText.privacyGroup,
        joinPolicy: isPublic.value ? AppText.anyoneCanJoin : AppText.membersOnly,
        memberAvatars: const [ImagePath.avatarWilliam],
        owned: true,
        joined: true,
      ),
    );
    Get.back();
    AppHelperFunctions.showSnackBar(AppText.communityCreated);
  }

  Future<String?> _pickOption(List<String> options) {
    return AppPlatform.showOptions(options);
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    rulesController.dispose();
    super.onClose();
  }
}
