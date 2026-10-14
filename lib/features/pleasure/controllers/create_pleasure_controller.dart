import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/core/utils/helpers/app_platform.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/pleasure/controllers/pleasure_controller.dart';
import 'package:brofile/features/pleasure/data/models/pleasure_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreatePleasureController extends GetxController {
  static const int maxDescription = 300;

  static const Map<String, List<String>> subcategories = {
    'Adventure': ['Fishing', 'Hiking', 'Camping'],
    'Fitness': ['Yoga', 'Gym', 'Running'],
    'Sports': ['Badminton', 'Football', 'Cricket'],
    'Creative': ['Art', 'Music', 'Photography'],
    'Entertainment': ['Movie', 'Concert', 'Games'],
    'Travel': ['Trip', 'Staycation', 'Tour'],
    'Learning': ['Workshop', 'Class', 'Meetup'],
    'Tech': ['Hackathon', 'Demo', 'Talk'],
    'Motors': ['Ride', 'Rally', 'Meet'],
    'Lifestyle': ['Coffee', 'Fashion', 'Food'],
    'Social': ['Hangout', 'Party', 'Coffee'],
  };

  final titleController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  final photoPath = Rxn<String>();
  final category = ''.obs;
  final subcategory = ''.obs;
  final date = Rxn<DateTime>();
  final time = Rxn<TimeOfDay>();
  final descriptionLength = 0.obs;

  List<String> get categoryOptions => HomeController.categories
      .where((label) => label != AppText.all)
      .toList();

  List<String> get subcategoryOptions =>
      subcategories[category.value] ?? const [];

  String get dateLabel {
    final value = date.value;
    if (value == null) return '';
    return DateFormat('EEE').format(value);
  }

  String get timeLabel {
    final value = time.value;
    if (value == null) return '';
    return DateFormat('h.mm a')
        .format(DateTime(2000, 1, 1, value.hour, value.minute))
        .toLowerCase();
  }

  @override
  void onInit() {
    super.onInit();
    descriptionController.addListener(
      () => descriptionLength.value = descriptionController.text.length,
    );
  }

  Future<void> pickPhoto() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1080,
      imageQuality: 85,
    );
    if (file != null) photoPath.value = file.path;
  }

  Future<void> pickCategory() async {
    final selected = await _pickOption(categoryOptions);
    if (selected == null) return;
    category.value = selected;
    if (!subcategoryOptions.contains(subcategory.value)) {
      subcategory.value = '';
    }
  }

  Future<void> pickSubcategory() async {
    if (category.value.isEmpty) {
      AppHelperFunctions.showSnackBar(AppText.chooseCategory);
      return;
    }
    final options = subcategoryOptions;
    if (options.isEmpty) return;
    final selected = await _pickOption(options);
    if (selected != null) subcategory.value = selected;
  }

  Future<void> pickDate() async {
    final picked = await AppPlatform.pickDate(
      initialDate: date.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) date.value = picked;
  }

  Future<void> pickTime() async {
    final picked = await AppPlatform.pickTime(initialTime: time.value ?? TimeOfDay.now());
    if (picked != null) time.value = picked;
  }

  void close() => Get.back();

  void save() {
    final title = titleController.text.trim();
    if (title.isEmpty) {
      AppHelperFunctions.showSnackBar(AppText.pleasureTitleRequired);
      return;
    }
    if (category.value.isEmpty) {
      AppHelperFunctions.showSnackBar(AppText.chooseCategory);
      return;
    }

    final location = locationController.text.trim();
    final about = descriptionController.text.trim();
    Get.find<PleasureController>().addActivity(
      ActivityItem(
        id: 'created-${DateTime.now().millisecondsSinceEpoch}',
        host: 'William',
        hostAvatar: ImagePath.avatarWilliam,
        title: title,
        image: photoPath.value ?? ImagePath.activityFishing,
        category: category.value,
        subcategory: subcategory.value,
        attendees: const [ImagePath.avatarWilliam],
        description: about,
        about: about,
        time: _whenLabel(),
        location: location.isEmpty ? null : location,
        extraAttendees: 0,
        joined: true,
      ),
    );
    Get.back();
    AppHelperFunctions.showSnackBar(AppText.pleasureSaved);
  }

  String _whenLabel() {
    final pickedDate = date.value;
    final pickedTime = time.value;
    final dateLabel = pickedDate == null || _isToday(pickedDate)
        ? 'Today'
        : DateFormat('EEE').format(pickedDate);
    if (pickedTime == null) {
      return pickedDate == null ? 'Today • 5:30 PM' : dateLabel;
    }
    return '$dateLabel • $timeLabel';
  }

  bool _isToday(DateTime value) {
    final now = DateTime.now();
    return value.year == now.year &&
        value.month == now.month &&
        value.day == now.day;
  }

  Future<String?> _pickOption(List<String> options) {
    return AppPlatform.showOptions(options);
  }

  @override
  void onClose() {
    titleController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
