import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/features/community/data/models/community_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum InviteSection { suggested, match, friends }

class InviteCandidate {
  InviteCandidate({
    required this.id,
    required this.name,
    required this.image,
    required this.subtitle,
    required this.section,
    this.online = false,
    bool selected = false,
  }) : isSelected = selected.obs;

  final String id;
  final String name;
  final String image;
  final String subtitle;
  final InviteSection section;
  final bool online;
  final RxBool isSelected;
}

class InviteMembersController extends GetxController {
  final searchController = TextEditingController();
  final query = ''.obs;
  late final String communityName;

  final people = <InviteCandidate>[
    InviteCandidate(
      id: 'liam',
      name: 'Liam',
      image: ImagePath.inviteLiam,
      subtitle: AppText.mutualConnections,
      section: InviteSection.suggested,
      online: true,
      selected: true,
    ),
    InviteCandidate(
      id: 'olivia',
      name: 'Olivia',
      image: ImagePath.inviteOlivia,
      subtitle: AppText.mutualConnections,
      section: InviteSection.suggested,
      selected: true,
    ),
    InviteCandidate(
      id: 'noah',
      name: 'Noah',
      image: ImagePath.inviteNoah,
      subtitle: AppText.mutualConnections,
      section: InviteSection.suggested,
    ),
    InviteCandidate(
      id: 'emma',
      name: 'Emma',
      image: ImagePath.inviteEmma,
      subtitle: AppText.mutualConnections,
      section: InviteSection.suggested,
    ),
    InviteCandidate(
      id: 'vivian',
      name: 'Vivian',
      image: ImagePath.inviteVivian,
      subtitle: AppText.mutualConnections,
      section: InviteSection.suggested,
    ),
    InviteCandidate(
      id: 'aiden',
      name: 'Aiden',
      image: ImagePath.inviteAiden,
      subtitle: AppText.interestMatch,
      section: InviteSection.match,
      online: true,
      selected: true,
    ),
    InviteCandidate(
      id: 'sophia',
      name: 'Sophia',
      image: ImagePath.inviteSophia,
      subtitle: AppText.interestMatch,
      section: InviteSection.match,
    ),
    InviteCandidate(
      id: 'mason',
      name: 'Mason',
      image: ImagePath.inviteMason,
      subtitle: AppText.interestMatch,
      section: InviteSection.match,
    ),
    InviteCandidate(
      id: 'ethan',
      name: 'Ethan',
      image: ImagePath.inviteEthan,
      subtitle: AppText.mutualConnections,
      section: InviteSection.friends,
    ),
    InviteCandidate(
      id: 'isabella',
      name: 'Isabella',
      image: ImagePath.inviteIsabella,
      subtitle: AppText.mutualConnections,
      section: InviteSection.friends,
    ),
  ];

  @override
  void onInit() {
    final arg = Get.arguments;
    communityName = arg is CommunityItem ? arg.name : AppText.mountainLoversName;
    super.onInit();
  }

  void onSearchChanged(String value) => query.value = value.trim();

  List<InviteCandidate> inSection(InviteSection section) {
    final q = query.value.toLowerCase();
    return people.where((person) {
      if (person.section != section) return false;
      if (q.isEmpty) return true;
      return person.name.toLowerCase().contains(q);
    }).toList();
  }

  void toggle(InviteCandidate person) => person.isSelected.toggle();

  void seeAll() => AppHelperFunctions.showSnackBar(AppText.comingSoon);

  void send() {
    final selected = people.where((person) => person.isSelected.value).length;
    if (selected == 0) {
      AppHelperFunctions.showSnackBar(AppText.selectPeopleToInvite);
      return;
    }
    Get.back();
    AppHelperFunctions.showSnackBar(AppText.invitationsSent);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
