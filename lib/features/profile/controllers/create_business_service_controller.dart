import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/features/discover/controllers/create_product_controller.dart';
import 'package:brofile/features/discover/data/models/discover_models.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/profile/controllers/business_profile_controller.dart';
import 'package:brofile/features/profile/presentation/widgets/business_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateBusinessServiceController extends GetxController {
  static const maxShort = 120;
  static const maxFull = 300;

  final nameController = TextEditingController();
  final priceController = TextEditingController(text: r'$ 0.00');
  final shortController = TextEditingController();
  final detailsController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  final photoPath = Rxn<String>();
  final category = 'Fitness'.obs;
  final subcategory = 'Yoga'.obs;
  final shortLength = 0.obs;
  final detailsLength = 0.obs;
  final infoRows = <FormPairField>[].obs;

  List<String> get categoryOptions =>
      HomeController.categories.where((label) => label != AppText.all).toList();

  List<String> get subcategoryOptions =>
      CreateProductController.subcategories[category.value] ?? const [];

  @override
  void onInit() {
    super.onInit();
    shortController.addListener(() => shortLength.value = shortController.text.length);
    detailsController.addListener(() => detailsLength.value = detailsController.text.length);
    infoRows.addAll([
      FormPairField(key: AppText.schedule, value: AppText.morningSchedule),
      FormPairField(key: AppText.groupSize, value: AppText.max15People),
      FormPairField(key: AppText.locationLabel, value: AppText.greenleafName),
      FormPairField(key: AppText.whatToBring, value: AppText.yogaMatWaterTowel),
    ]);
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

  void removeInfo(int index) {
    if (index < 0 || index >= infoRows.length) return;
    infoRows[index].dispose();
    infoRows.removeAt(index);
  }

  void save() {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      AppHelperFunctions.showSnackBar(AppText.serviceNameRequired);
      return;
    }
    if (Get.isRegistered<BusinessProfileController>()) {
      Get.find<BusinessProfileController>().addService(
        DiscoverService(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: name,
          description: shortController.text.trim().isEmpty
              ? detailsController.text.trim()
              : shortController.text.trim(),
          location: AppText.greenleafName,
          image: ImagePath.bizServiceYoga,
          category: category.value,
        ),
      );
    }
    Get.back();
    AppHelperFunctions.showSnackBar(AppText.servicePosted);
  }

  @override
  void onClose() {
    nameController.dispose();
    priceController.dispose();
    shortController.dispose();
    detailsController.dispose();
    for (final row in infoRows) {
      row.dispose();
    }
    super.onClose();
  }
}
