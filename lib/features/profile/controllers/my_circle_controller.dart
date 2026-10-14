import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/features/profile/data/models/profile_models.dart';
import 'package:brofile/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum CircleFilter { all, family, relatives, friends }

class MyCircleController extends GetxController {
  static const familyRelations = [
    'Father',
    'Mother',
    'Brother',
    'Sister',
    'Husband',
    'Wife',
    'Son',
    'Daughter',
    'Other Family Member',
  ];
  static const relativeRelations = [
    'Uncle',
    'Aunt',
    'Cousin',
    'Nephew',
    'Niece',
    'Other Relative',
  ];
  static const friendRelations = [
    'College Friend',
    'School Friend',
    'University Friend',
    'Work Friend',
    'Neighbor',
    'Other Friend',
  ];

  final searchController = TextEditingController();
  final query = ''.obs;
  final filter = CircleFilter.all.obs;
  final expandRelatives = false.obs;
  final expandFriends = false.obs;
  final sheetOpen = false.obs;
  final sheetGroup = Rxn<CircleGroup>();
  final sheetRelation = ''.obs;
  final members = <CircleMember>[].obs;
  final suggestions = <CircleMember>[].obs;
  final selectedIds = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    members.assignAll([
      CircleMember(id: 'sarah-khan', name: 'Sarah Khan', image: ImagePath.avatarSarah, relation: 'Mother', group: CircleGroup.family),
      CircleMember(id: 'james-khan', name: 'James Khan', image: ImagePath.friendJamesLee, relation: 'Father', group: CircleGroup.family),
      CircleMember(id: 'rifat-khan', name: 'Rifat Khan', image: ImagePath.personMike, relation: 'Brother', group: CircleGroup.family),
      CircleMember(id: 'tanzila-khan', name: 'Tanzila Khan', image: ImagePath.personAlexa, relation: 'Sister', group: CircleGroup.family),
      CircleMember(id: 'ayesha-khan', name: 'Ayesha Khan', image: ImagePath.avatarAlisa, relation: 'Wife', group: CircleGroup.family),
      CircleMember(id: 'rayyan-khan', name: 'Rayyan Khan', image: ImagePath.person4, relation: 'Son', group: CircleGroup.family),
      CircleMember(id: 'arif-khan', name: 'Arif Khan', image: ImagePath.avatarWilliam, relation: 'Uncle', group: CircleGroup.relatives),
      CircleMember(id: 'farzana', name: 'Farzana', image: ImagePath.circleFarzana, relation: 'Cousin', group: CircleGroup.relatives),
      CircleMember(id: 'nusrat-jahan', name: 'Nusrat Jahan', image: ImagePath.circleNusrat, relation: 'Aunt', group: CircleGroup.relatives),
      CircleMember(id: 'sabbir-khan', name: 'Sabbir khan', image: ImagePath.inviteVivian, relation: 'Cousin', group: CircleGroup.relatives),
      CircleMember(id: 'alex-morgan', name: 'Alex Morgan', image: ImagePath.personAlexa2, relation: 'College Friend', group: CircleGroup.friends),
      CircleMember(id: 'noah-ahmed', name: 'Noah Ahmed', image: ImagePath.circleFarzana, relation: 'School Friend', group: CircleGroup.friends),
      CircleMember(id: 'mehedi-hasan', name: 'Mehedi Hasan', image: ImagePath.circleNusrat, relation: 'University Friend', group: CircleGroup.friends),
      CircleMember(id: 'hasibul-islam', name: 'Hasibul Islam', image: ImagePath.inviteVivian, relation: 'Work Friend', group: CircleGroup.friends),
      CircleMember(id: 'mike-ross', name: 'Mike Ross', image: ImagePath.friendMikeRoss, relation: 'Work Friend', group: CircleGroup.friends),
      CircleMember(id: 'james-lee', name: 'James Lee', image: ImagePath.personJohn, relation: 'College Friend', group: CircleGroup.friends),
      CircleMember(id: 'ryan', name: 'Ryan Cole', image: ImagePath.commenterRyan, relation: 'School Friend', group: CircleGroup.friends),
      CircleMember(id: 'flora', name: 'Flora Sen', image: ImagePath.commenterFlora, relation: 'Neighbor', group: CircleGroup.friends),
    ]);
    suggestions.assignAll([
      CircleMember(id: 'liam', name: 'Liam', image: ImagePath.inviteLiam, relation: '', group: CircleGroup.friends, handle: '@william', online: true),
      CircleMember(id: 'olivia', name: 'Olivia', image: ImagePath.inviteOlivia, relation: '', group: CircleGroup.friends, handle: '@william'),
      CircleMember(id: 'noah', name: 'Noah', image: ImagePath.inviteNoah, relation: '', group: CircleGroup.friends, handle: '@william'),
      CircleMember(id: 'emma', name: 'Emma', image: ImagePath.inviteEmma, relation: '', group: CircleGroup.friends, handle: '@william'),
      CircleMember(id: 'vivian', name: 'Vivian', image: ImagePath.inviteVivian, relation: '', group: CircleGroup.friends, handle: '@william'),
    ]);
  }

  List<CircleMember> inGroup(CircleGroup group) =>
      members.where((member) => member.group == group).toList();

  List<CircleMember> visibleInGroup(CircleGroup group) {
    final all = inGroup(group);
    if (group == CircleGroup.friends && !expandFriends.value) {
      return all.take(4).toList();
    }
    if (group == CircleGroup.relatives && !expandRelatives.value) {
      return all;
    }
    return all;
  }

  bool get showFamily =>
      filter.value == CircleFilter.all || filter.value == CircleFilter.family;
  bool get showRelatives =>
      filter.value == CircleFilter.all || filter.value == CircleFilter.relatives;
  bool get showFriends =>
      filter.value == CircleFilter.all || filter.value == CircleFilter.friends;

  List<CircleMember> get filteredSuggestions {
    final q = query.value.toLowerCase();
    return suggestions.where((person) {
      if (q.isEmpty) return true;
      return person.name.toLowerCase().contains(q) || person.handle.toLowerCase().contains(q);
    }).toList();
  }

  void selectFilter(CircleFilter value) => filter.value = value;

  void toggleSeeAll(CircleGroup group) {
    if (group == CircleGroup.friends) {
      expandFriends.toggle();
      return;
    }
    if (group == CircleGroup.relatives) expandRelatives.toggle();
  }

  void openAdd() {
    selectedIds.clear();
    sheetOpen.value = false;
    sheetRelation.value = '';
    Get.toNamed(AppRoute.addToCircleScreen);
  }

  void onSearchChanged(String value) => query.value = value.trim();

  void toggleSuggestion(CircleMember person) {
    if (selectedIds.contains(person.id)) {
      selectedIds.remove(person.id);
    } else {
      selectedIds.add(person.id);
    }
    selectedIds.refresh();
  }

  bool isSelected(String id) => selectedIds.contains(id);

  void openSheet() {
    if (selectedIds.isEmpty) {
      AppHelperFunctions.showSnackBar(AppText.selectSomeoneToAdd);
      return;
    }
    sheetGroup.value = null;
    sheetRelation.value = '';
    sheetOpen.value = true;
  }

  void closeSheet() => sheetOpen.value = false;

  void selectSheetGroup(CircleGroup group) {
    sheetGroup.value = group;
    sheetRelation.value = '';
  }

  List<String> get sheetRelations {
    switch (sheetGroup.value) {
      case CircleGroup.family:
        return familyRelations;
      case CircleGroup.relatives:
        return relativeRelations;
      case CircleGroup.friends:
        return friendRelations;
      case null:
        return const [];
    }
  }

  void selectRelation(String relation) {
    final group = sheetGroup.value;
    if (group == null) return;
    sheetRelation.value = relation;
    final picked = suggestions.where((person) => selectedIds.contains(person.id)).toList();
    for (final person in picked) {
      members.add(
        CircleMember(
          id: '${person.id}-${DateTime.now().millisecondsSinceEpoch}',
          name: person.name,
          image: person.image,
          relation: relation,
          group: group,
          handle: person.handle,
          online: person.online,
        ),
      );
      suggestions.removeWhere((item) => item.id == person.id);
    }
    selectedIds.clear();
    sheetOpen.value = false;
    Get.back();
    AppHelperFunctions.showSnackBar(AppText.addedToCircle);
  }

  void message(CircleMember member) =>
      AppHelperFunctions.showSnackBar('${AppText.message} ${member.name}');

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
