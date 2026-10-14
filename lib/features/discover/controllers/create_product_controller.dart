import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/core/utils/helpers/app_platform.dart';
import 'package:brofile/features/discover/controllers/discover_controller.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductInfoField {
  ProductInfoField({String key = '', String value = ''})
    : keyController = TextEditingController(text: key),
      valueController = TextEditingController(text: value);

  final TextEditingController keyController;
  final TextEditingController valueController;

  void dispose() {
    keyController.dispose();
    valueController.dispose();
  }
}

class CreateProductController extends GetxController {
  static const int maxDescription = 300;
  static const recycleTypes = [AppText.sell, AppText.donate, AppText.swap];

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
    'Lifestyle': ['Coffee', 'Fashion', 'Home'],
    'Social': ['Hangout', 'Party', 'Coffee'],
  };

  final nameController = TextEditingController();
  final priceController = TextEditingController(text: r'$ 0.00');
  final detailsController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  final photoPath = Rxn<String>();
  final category = 'Fitness'.obs;
  final subcategory = 'Yoga'.obs;
  final recycleType = AppText.sell.obs;
  final detailsLength = 0.obs;
  final infoRows = <ProductInfoField>[].obs;

  List<String> get categoryOptions => HomeController.categories
      .where((label) => label != AppText.all)
      .toList();

  List<String> get subcategoryOptions =>
      subcategories[category.value] ?? const [];

  @override
  void onInit() {
    super.onInit();
    detailsController.addListener(
      () => detailsLength.value = detailsController.text.length,
    );
    infoRows.addAll([
      ProductInfoField(key: AppText.condition, value: AppText.likeNew),
      ProductInfoField(key: AppText.usingFor, value: '2 months'),
    ]);
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
      subcategory.value = subcategoryOptions.firstOrNull ?? '';
    }
  }

  Future<void> pickSubcategory() async {
    final options = subcategoryOptions;
    if (options.isEmpty) return;
    final selected = await _pickOption(options);
    if (selected != null) subcategory.value = selected;
  }

  Future<void> pickRecycleType() async {
    final selected = await _pickOption(recycleTypes);
    if (selected != null) recycleType.value = selected;
  }

  void removeInfo(int index) {
    if (index < 0 || index >= infoRows.length) return;
    infoRows[index].dispose();
    infoRows.removeAt(index);
  }

  void close() => Get.back();

  void post() {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      AppHelperFunctions.showSnackBar(AppText.productNameRequired);
      return;
    }

    final conditionLabel = infoRows
        .where((row) => row.keyController.text.trim() == AppText.condition)
        .map((row) => row.valueController.text.trim())
        .firstOrNull;
    final usingFor = infoRows
        .where((row) => row.keyController.text.trim() == AppText.usingFor)
        .map((row) => row.valueController.text.trim())
        .firstOrNull;

    Get.find<DiscoverController>().addRecyclerProduct(
      ProductModel(
        name: name,
        image: ImagePath.recCamera,
        price: priceController.text.trim().isEmpty
            ? r'$ 0.00'
            : priceController.text.trim(),
        condition: conditionLabel == AppText.likeNew
            ? ProductCondition.likeNew
            : ProductCondition.good,
        category: category.value,
        tag: '${category.value} > ${subcategory.value}',
        recycleType: recycleType.value,
        details: detailsController.text.trim(),
        usingFor: usingFor,
        sellerName: 'William',
        sellerAvatar: ImagePath.avatarWilliam,
        memberSince: 'Member since Jan 2025',
      ),
    );
    Get.back();
    AppHelperFunctions.showSnackBar(AppText.productPosted);
  }

  Future<String?> _pickOption(List<String> options) {
    return AppPlatform.showOptions(options);
  }

  @override
  void onClose() {
    nameController.dispose();
    priceController.dispose();
    detailsController.dispose();
    for (final row in infoRows) {
      row.dispose();
    }
    super.onClose();
  }
}
