import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/core/utils/helpers/profile_navigation.dart';
import 'package:brofile/features/home/data/models/inbox_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeSearchController extends GetxController {
  final textController = TextEditingController();
  final focusNode = FocusNode();
  final query = ''.obs;
  final focused = false.obs;

  static const recents = [
    AppText.culinaryClub,
    AppText.pitchPioneers,
    AppText.travelBackpack,
    AppText.gym,
  ];

  static const tags = [
    AppText.tagSoccer,
    AppText.tagSoftball,
    AppText.tagHiking,
    AppText.tagNovels,
  ];

  static const people = [
    SearchHit(label: AppText.handleHenri, avatar: ImagePath.searchHenri),
  ];

  static const extraTags = [
    SearchHit(label: AppText.tagHikings),
  ];

  @override
  void onInit() {
    super.onInit();
    focusNode.addListener(() => focused.value = focusNode.hasFocus);
  }

  void onQuery(String value) => query.value = value;

  bool get showSuggestions => focused.value || query.value.trim().isNotEmpty;

  void apply(String value) {
    textController
      ..text = value
      ..selection = TextSelection.collapsed(offset: value.length);
    query.value = value;
  }

  void openPerson(String handle) {
    ProfileNavigation.open(handle.replaceFirst('@', ''));
  }

  void openFilter() => AppHelperFunctions.showSnackBar(AppText.comingSoon);

  List<SearchHit> get hits {
    final q = query.value.trim().toLowerCase();
    if (q.isEmpty) {
      return const [
        SearchHit(label: AppText.tagHikings),
        ...people,
      ];
    }
    final matches = <SearchHit>[
      ...extraTags,
      ...tags.map((tag) => SearchHit(label: tag)),
      ...people,
      ...recents.map((label) => SearchHit(label: label)),
    ];
    return matches.where((hit) => hit.label.toLowerCase().contains(q)).toList();
  }

  @override
  void onClose() {
    focusNode.dispose();
    textController.dispose();
    super.onClose();
  }
}
