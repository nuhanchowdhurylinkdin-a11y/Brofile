import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/features/community/controllers/community_details_controller.dart';
import 'package:brofile/features/community/data/models/community_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

enum CommunityNewPostStep { write, gallery, caption }

class CommunityNewPostController extends GetxController {
  final textController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  final step = CommunityNewPostStep.write.obs;
  final extraImages = <String>[].obs;
  final selectedImages = <String>[].obs;

  List<String> get galleryImages => [...extraImages, ...ImagePath.postGallery];

  int selectionIndex(String path) => selectedImages.indexOf(path) + 1;

  bool isSelected(String path) => selectedImages.contains(path);

  void openGallery() => step.value = CommunityNewPostStep.gallery;

  void onBack() {
    switch (step.value) {
      case CommunityNewPostStep.caption:
        step.value = CommunityNewPostStep.gallery;
      case CommunityNewPostStep.gallery:
        step.value = CommunityNewPostStep.write;
      case CommunityNewPostStep.write:
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
      case CommunityNewPostStep.gallery:
        if (selectedImages.isEmpty) {
          AppHelperFunctions.showSnackBar(AppText.selectAPhoto);
          return;
        }
        step.value = CommunityNewPostStep.caption;
        return;
      case CommunityNewPostStep.write:
      case CommunityNewPostStep.caption:
        submit();
    }
  }

  String get primaryLabel {
    if (step.value == CommunityNewPostStep.gallery) {
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
    Get.find<CommunityDetailsController>().addUserPost(
      CommunityUserPost(text: text, imagePaths: selectedImages.toList()),
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
