import 'package:brofile/core/services/storage_service.dart';
import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/features/profile/data/models/profile_models.dart';
import 'package:brofile/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsController extends GetxController {
  static const languages = [
    AppText.english,
    AppText.bengali,
    AppText.spanish,
    AppText.french,
  ];

  static const privacyOptions = [
    AppText.privacyPublic,
    AppText.privacyCommunities,
    AppText.circle,
    AppText.onlyMe,
  ];

  static const faqs = [
    HelpArticle(question: AppText.faqCreateBusiness, answer: AppText.faqCreateBusinessAnswer),
    HelpArticle(question: AppText.faqCreateCommunity, answer: AppText.faqCreateCommunityAnswer),
    HelpArticle(question: AppText.faqReportPost, answer: AppText.faqReportPostAnswer),
    HelpArticle(question: AppText.faqEditProfile, answer: AppText.faqEditProfileAnswer),
    HelpArticle(question: AppText.faqManagePrivacy, answer: AppText.faqManagePrivacyAnswer),
    HelpArticle(question: AppText.faqDeleteAccount, answer: AppText.faqDeleteAccountAnswer),
  ];

  final language = AppText.english.obs;
  final privacy = <String, String>{
    AppText.whoCanSeeAbout: AppText.circle,
    AppText.whoCanSeeHobbies: AppText.circle,
    AppText.whoCanSeeCommunities: AppText.circle,
    AppText.whoCanSeeBusiness: AppText.circle,
    AppText.whoCanSeeActivities: AppText.circle,
    AppText.whoCanSeeAspirations: AppText.circle,
    AppText.whoCanSeeCircle: AppText.circle,
  }.obs;

  final newMessages = true.obs;
  final communityUpdates = true.obs;
  final activityInvitations = true.obs;
  final businessUpdates = false.obs;
  final commentsAndReplies = true.obs;
  final newFollowers = true.obs;
  final reportUpdates = true.obs;

  final blockedQuery = ''.obs;
  final helpQuery = ''.obs;
  final expandedFaq = Rxn<int>();

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final blockedSearchController = TextEditingController();
  final helpSearchController = TextEditingController();
  final subjectController = TextEditingController();
  final messageController = TextEditingController();

  final hideCurrentPassword = true.obs;
  final hideNewPassword = true.obs;
  final hideConfirmPassword = true.obs;
  final passwordDraft = ''.obs;

  final blockedUsers = <BlockedUser>[
    BlockedUser(id: '1', name: 'John Smith', handle: '@johnsmith', image: ImagePath.blockedJohn),
    BlockedUser(id: '2', name: 'Sarah Lee', handle: '@sarahlee', image: ImagePath.blockedSarah),
    BlockedUser(id: '3', name: 'Mike Brown', handle: '@mikebrown', image: ImagePath.blockedMike),
    BlockedUser(id: '4', name: 'Emily Davis', handle: '@emilydavis', image: ImagePath.blockedEmily),
  ].obs;

  final hiddenCommunities = <HiddenCommunity>[
    HiddenCommunity(id: '1', name: 'Photography Club', members: '20 ${AppText.membersLabel}', image: ImagePath.hiddenPhotography),
    HiddenCommunity(id: '2', name: 'Fishing Lovers', members: '85 ${AppText.membersLabel}', image: ImagePath.hiddenFishing),
    HiddenCommunity(id: '3', name: 'Coffee Enthusiasts', members: '145 ${AppText.membersLabel}', image: ImagePath.hiddenCoffee),
    HiddenCommunity(id: '4', name: 'Travel & Adventure', members: '98 ${AppText.membersLabel}', image: ImagePath.hiddenTravel),
  ].obs;

  List<BlockedUser> get filteredBlockedUsers {
    final query = blockedQuery.value.trim().toLowerCase();
    if (query.isEmpty) return blockedUsers;
    return blockedUsers
        .where((user) => user.name.toLowerCase().contains(query) || user.handle.toLowerCase().contains(query))
        .toList();
  }

  List<HelpArticle> get filteredFaqs {
    final query = helpQuery.value.trim().toLowerCase();
    if (query.isEmpty) return faqs;
    return faqs
        .where((item) => item.question.toLowerCase().contains(query) || item.answer.toLowerCase().contains(query))
        .toList();
  }

  bool get hasEightChars => passwordDraft.value.length >= 8;
  bool get hasUppercase => passwordDraft.value.contains(RegExp(r'[A-Z]'));
  bool get hasNumber => passwordDraft.value.contains(RegExp(r'[0-9]'));

  void comingSoon() => AppHelperFunctions.showSnackBar(AppText.comingSoon);

  void openChangePassword() => Get.toNamed(AppRoute.changePasswordScreen);
  void openNotifications() => Get.toNamed(AppRoute.notificationsSettingsScreen);
  void openBlockedUsers() => Get.toNamed(AppRoute.blockedUsersScreen);
  void openHiddenCommunities() => Get.toNamed(AppRoute.hiddenCommunitiesScreen);
  void openHelpCenter() => Get.toNamed(AppRoute.helpCenterScreen);
  void openContactUs() => Get.toNamed(AppRoute.contactUsScreen);
  void openPrivacyPolicy() => Get.toNamed(AppRoute.privacyPolicyScreen);
  void openAboutBrofile() => Get.toNamed(AppRoute.aboutBrofileScreen);

  Future<void> pickLanguage() async {
    final selected = await _pickOption(languages);
    if (selected != null) language.value = selected;
  }

  Future<void> pickPrivacy(String key) async {
    final selected = await _pickOption(privacyOptions);
    if (selected == null) return;
    privacy[key] = selected;
    privacy.refresh();
  }

  void unblockUser(BlockedUser user) {
    blockedUsers.removeWhere((item) => item.id == user.id);
  }

  void showCommunity(HiddenCommunity community) {
    hiddenCommunities.removeWhere((item) => item.id == community.id);
  }

  void toggleFaq(int index) {
    expandedFaq.value = expandedFaq.value == index ? null : index;
  }

  void onNewPasswordChanged(String value) => passwordDraft.value = value;

  void savePassword() {
    if (currentPasswordController.text.isEmpty) {
      AppHelperFunctions.showSnackBar(AppText.passwordRequired);
      return;
    }
    if (!hasEightChars || !hasUppercase || !hasNumber) {
      AppHelperFunctions.showSnackBar(AppText.passwordRequired);
      return;
    }
    if (newPasswordController.text != confirmPasswordController.text) {
      AppHelperFunctions.showSnackBar(AppText.passwordsDoNotMatch);
      return;
    }
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    passwordDraft.value = '';
    Get.back();
    AppHelperFunctions.showSnackBar(AppText.passwordChanged);
  }

  void sendMessage() {
    if (subjectController.text.trim().isEmpty) {
      AppHelperFunctions.showSnackBar(AppText.subjectRequired);
      return;
    }
    if (messageController.text.trim().isEmpty) {
      AppHelperFunctions.showSnackBar(AppText.messageRequired);
      return;
    }
    subjectController.clear();
    messageController.clear();
    Get.back();
    AppHelperFunctions.showSnackBar(AppText.messageSent);
  }

  Future<void> openSupportEmail() async {
    final uri = Uri(scheme: 'mailto', path: AppText.supportEmailAddress);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
      return;
    }
    AppHelperFunctions.showSnackBar(AppText.supportEmailAddress);
  }

  Future<void> logOut() async {
    await StorageService.logoutUser();
    Get.offAllNamed(AppRoute.signInScreen);
  }

  Future<String?> _pickOption(List<String> options) {
    return Get.bottomSheet<String>(
      Material(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: SafeArea(
          top: false,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: Get.height * 0.55),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.neutral200,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      final option = options[index];
                      return ListTile(
                        title: Text(option),
                        onTap: () => Get.back(result: option),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    blockedSearchController.dispose();
    helpSearchController.dispose();
    subjectController.dispose();
    messageController.dispose();
    super.onClose();
  }
}
