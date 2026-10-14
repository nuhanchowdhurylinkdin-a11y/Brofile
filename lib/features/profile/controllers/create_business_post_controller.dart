import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/features/profile/controllers/business_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

enum BusinessPostStep { write, gallery, caption }

class CreateBusinessPostController extends GetxController {
  final textController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  final step = BusinessPostStep.write.obs;
  final extraImages = <String>[].obs;
  final selectedImages = <String>[].obs;

  List<String> get galleryImages => [...extraImages, ...ImagePath.postGallery];

  void openGallery() => step.value = BusinessPostStep.gallery;

  void onBack() {
    switch (step.value) {
      case BusinessPostStep.caption:
        step.value = BusinessPostStep.gallery;
      case BusinessPostStep.gallery:
        step.value = BusinessPostStep.write;
      case BusinessPostStep.write:
        Get.back();
    }
  }

  void toggleImage(String path) {
    if (selectedImages.contains(path)) {
      selectedImages.remove(path);
      return;
    }
    selectedImages.add(path);
  }

  Future<void> addFromDevice() async {
    final files = await _picker.pickMultiImage();
    if (files.isEmpty) return;
    for (final file in files.reversed) {
      extraImages.remove(file.path);
      extraImages.insert(0, file.path);
      if (!selectedImages.contains(file.path)) selectedImages.add(file.path);
    }
  }

  void onPrimaryAction() {
    switch (step.value) {
      case BusinessPostStep.gallery:
        if (selectedImages.isEmpty) {
          AppHelperFunctions.showSnackBar(AppText.selectAPhoto);
          return;
        }
        step.value = BusinessPostStep.caption;
        return;
      case BusinessPostStep.write:
      case BusinessPostStep.caption:
        submit();
    }
  }

  String get primaryLabel {
    if (step.value == BusinessPostStep.gallery) {
      return selectedImages.isEmpty ? AppText.select : AppText.next;
    }
    return AppText.post;
  }

  void submit() {
    final text = textController.text.trim();
    if (text.isEmpty && selectedImages.isEmpty) {
      AppHelperFunctions.showSnackBar(AppText.postRequired);
      return;
    }
    final profile = Get.find<BusinessProfileController>();
    final images = selectedImages.toList();
    profile.addPost(
      PostModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        author: profile.studioName.value,
        avatar: ImagePath.bizLogoGreenleaf,
        timeAgo: 'now',
        category: 'Fitness',
        subcategory: 'Yoga',
        images: images,
        layout: images.length >= 2 ? PostLayout.double : PostLayout.single,
        text: text,
      ),
    );
    Get.back();
    AppHelperFunctions.showSnackBar(AppText.postPublished);
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
