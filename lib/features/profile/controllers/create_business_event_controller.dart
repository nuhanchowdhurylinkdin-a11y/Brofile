import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/features/discover/controllers/create_product_controller.dart';
import 'package:brofile/features/discover/controllers/discover_controller.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/features/profile/controllers/business_profile_controller.dart';
import 'package:brofile/features/profile/presentation/widgets/business_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateBusinessEventController extends GetxController {
  static const maxShort = 120;
  static const maxFull = 300;
  static const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  static const times = [
    '8.00 am',
    '9.00 am',
    '10.00 am',
    '12.00 pm',
    '4.00 pm',
    '5.00 pm',
    '7:00 PM',
    '8.00 pm',
  ];
  static const _months = [
    'JAN',
    'FEB',
    'MAR',
    'APR',
    'MAY',
    'JUN',
    'JUL',
    'AUG',
    'SEP',
    'OCT',
    'NOV',
    'DEC',
  ];

  final nameController = TextEditingController();
  final priceController = TextEditingController(text: r'$ 0.00');
  final locationController = TextEditingController();
  final shortController = TextEditingController();
  final detailsController = TextEditingController();
  final achievementController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  final photoPath = Rxn<String>();
  final category = 'Fitness'.obs;
  final subcategory = 'Yoga'.obs;
  final date = AppText.eventDayMon.obs;
  final time = AppText.eventTimeEightAm.obs;
  final shortLength = 0.obs;
  final detailsLength = 0.obs;
  final editingIndex = RxnInt();
  final achievements = <String>[
    AppText.certifiedInstructors,
    AppText.ecoEnvironment,
    AppText.smallClassSizes,
    AppText.communityWellness,
  ].obs;

  List<String> get categoryOptions =>
      HomeController.categories.where((label) => label != AppText.all).toList();

  List<String> get subcategoryOptions =>
      CreateProductController.subcategories[category.value] ?? const [];

  @override
  void onInit() {
    super.onInit();
    shortController.addListener(() => shortLength.value = shortController.text.length);
    detailsController.addListener(() => detailsLength.value = detailsController.text.length);
  }

  Future<void> pickPhoto() async {
    final file = await _picker.pickImage(source: ImageSource.gallery, maxWidth: 1080, imageQuality: 85);
    if (file != null) photoPath.value = file.path;
  }

  Future<void> pickCategory() async {
    final selected = await pickFormOption(categoryOptions);
    if (selected == null) return;
    category.value = selected;
    if (!subcategoryOptions.contains(subcategory.value)) {
      subcategory.value = subcategoryOptions.firstOrNull ?? '';
    }
  }

  Future<void> pickSubcategory() async {
    final options = subcategoryOptions;
    if (options.isEmpty) return;
    final selected = await pickFormOption(options);
    if (selected != null) subcategory.value = selected;
  }

  Future<void> pickDate() async {
    final selected = await pickFormOption(days);
    if (selected != null) date.value = selected;
  }

  Future<void> pickTime() async {
    final selected = await pickFormOption(times);
    if (selected != null) time.value = selected;
  }

  void addAchievement() {
    final text = achievementController.text.trim();
    if (text.isEmpty) return;
    final index = editingIndex.value;
    if (index != null && index >= 0 && index < achievements.length) {
      achievements[index] = text;
      achievements.refresh();
      editingIndex.value = null;
    } else {
      achievements.add(text);
    }
    achievementController.clear();
  }

  void editAchievement(int index) {
    if (index < 0 || index >= achievements.length) return;
    achievementController.text = achievements[index];
    editingIndex.value = index;
  }

  void removeAchievement(int index) {
    if (index < 0 || index >= achievements.length) return;
    achievements.removeAt(index);
    if (editingIndex.value == index) {
      editingIndex.value = null;
      achievementController.clear();
    }
  }

  void save() {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      AppHelperFunctions.showSnackBar(AppText.eventTitleRequired);
      return;
    }
    final now = DateTime.now();
    final attendees = Get.isRegistered<DiscoverController>()
        ? Get.find<DiscoverController>().events.first.attendees
        : const <String>[];
    Get.find<BusinessProfileController>().addEvent(
      EventModel(
        day: '${now.day}',
        month: _months[now.month - 1],
        title: name,
        time: '${date.value}, ${time.value}',
        location: locationController.text.trim().isEmpty
            ? AppText.greenleafName
            : locationController.text.trim(),
        image: ImagePath.eventYoga,
        attendees: attendees,
        extraAttendees: 5,
        category: category.value,
        subtitle: shortController.text.trim(),
        tag: '${category.value} > ${subcategory.value}',
        schedule: '${date.value}. ${time.value}',
        price: priceController.text.trim().isEmpty ? r'$ 0.00' : priceController.text.trim(),
        about: detailsController.text.trim(),
        achievements: achievements.toList(),
      ),
    );
    Get.back();
    AppHelperFunctions.showSnackBar(AppText.eventPosted);
  }

  @override
  void onClose() {
    nameController.dispose();
    priceController.dispose();
    locationController.dispose();
    shortController.dispose();
    detailsController.dispose();
    achievementController.dispose();
    super.onClose();
  }
}
