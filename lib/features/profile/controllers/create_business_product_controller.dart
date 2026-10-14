import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/features/discover/controllers/create_product_controller.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/features/profile/controllers/business_profile_controller.dart';
import 'package:brofile/features/profile/presentation/widgets/business_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateBusinessProductController extends GetxController {
  static const maxShort = 120;
  static const maxFull = 300;

  final nameController = TextEditingController();
  final priceController = TextEditingController(text: r'$ 0.00');
  final shortController = TextEditingController();
  final detailsController = TextEditingController(text: AppText.greenleafProductDetails);
  final ImagePicker _picker = ImagePicker();

  final photoPath = Rxn<String>();
  final category = 'Fitness'.obs;
  final subcategory = 'Yoga'.obs;
  final inStock = true.obs;
  final shortLength = 0.obs;
  final detailsLength = AppText.greenleafProductDetails.length.obs;

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

  void save() {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      AppHelperFunctions.showSnackBar(AppText.productNameRequired);
      return;
    }
    if (Get.isRegistered<BusinessProfileController>()) {
      Get.find<BusinessProfileController>().addProduct(
        ProductModel(
          name: name,
          subtitle: shortController.text.trim(),
          image: ImagePath.bizProductMat,
          price: priceController.text.trim().isEmpty ? r'$ 0.00' : priceController.text.trim(),
          category: category.value,
          tag: '${category.value} > ${subcategory.value}',
          details: detailsController.text.trim(),
        ),
      );
    }
    Get.back();
    AppHelperFunctions.showSnackBar(AppText.productPosted);
  }

  @override
  void onClose() {
    nameController.dispose();
    priceController.dispose();
    shortController.dispose();
    detailsController.dispose();
    super.onClose();
  }
}
