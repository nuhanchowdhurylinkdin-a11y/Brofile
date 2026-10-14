import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/features/discover/controllers/create_product_controller.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/profile/controllers/business_profile_controller.dart';
import 'package:brofile/features/profile/data/models/profile_models.dart';
import 'package:brofile/features/profile/presentation/widgets/business_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

enum BusinessOffering { products, services, events }

class BusinessHourDraft {
  BusinessHourDraft({
    required this.startDay,
    required this.endDay,
    required this.startTime,
    required this.endTime,
  });

  final RxString startDay;
  final RxString endDay;
  final RxString startTime;
  final RxString endTime;
}

class BusinessSocialDraft {
  BusinessSocialDraft({required this.icon, required String handle})
    : handleController = TextEditingController(text: handle);

  String icon;
  final TextEditingController handleController;

  void dispose() => handleController.dispose();
}

class BusinessInstructorDraft {
  BusinessInstructorDraft({
    required this.image,
    required String name,
    required String role,
    required String bio,
  }) : nameController = TextEditingController(text: name),
       roleController = TextEditingController(text: role),
       bioController = TextEditingController(text: bio);

  String image;
  final TextEditingController nameController;
  final TextEditingController roleController;
  final TextEditingController bioController;

  void dispose() {
    nameController.dispose();
    roleController.dispose();
    bioController.dispose();
  }
}

class BusinessContactDraft {
  BusinessContactDraft({required this.icon, required String value})
    : valueController = TextEditingController(text: value);

  final String icon;
  final TextEditingController valueController;

  void dispose() => valueController.dispose();
}

class EditBusinessController extends GetxController {
  static const maxLength = 300;
  static const days = [
    AppText.monday,
    'Tuesday',
    'Wednesday',
    'Thursday',
    AppText.friday,
    AppText.saturday,
    AppText.sunday,
    '-',
  ];
  static const times = [AppText.sixAm, '7:00 AM', '8:00 AM', AppText.ninePm, '-'];

  final nameController = TextEditingController(text: AppText.greenleafName);
  final usernameController = TextEditingController(text: '@william');
  final locationController = TextEditingController(text: AppText.greenleafAddress);
  final aboutController = TextEditingController(text: AppText.greenleafProductDetails);
  final storyController = TextEditingController(text: AppText.greenleafStory);
  final reasonController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  final aboutLength = AppText.greenleafProductDetails.length.obs;
  final storyLength = AppText.greenleafStory.length.obs;
  final category = 'Fitness'.obs;
  final subcategory = 'Yoga'.obs;
  final coverPath = Rxn<String>();
  final logoPath = Rxn<String>();
  final offerings = <BusinessOffering>[BusinessOffering.products].obs;
  final offers = <FormPairField>[].obs;
  final reasons = <String>[
    AppText.certifiedInstructors,
    AppText.ecoEnvironment,
    AppText.smallClassSizes,
    AppText.communityWellness,
  ].obs;
  final instructors = <BusinessInstructorDraft>[].obs;
  final hours = <BusinessHourDraft>[].obs;
  final socials = <BusinessSocialDraft>[].obs;
  final info = <FormPairField>[].obs;
  final contacts = <BusinessContactDraft>[].obs;

  List<String> get categoryOptions =>
      HomeController.categories.where((label) => label != AppText.all).toList();

  List<String> get subcategoryOptions =>
      CreateProductController.subcategories[category.value] ?? const [];

  @override
  void onInit() {
    super.onInit();
    aboutController.addListener(() => aboutLength.value = aboutController.text.length);
    storyController.addListener(() => storyLength.value = storyController.text.length);
    offers.addAll([
      FormPairField(key: AppText.yogaClasses, value: AppText.yogaClassesDesc),
      FormPairField(key: AppText.wellnessPrograms, value: AppText.wellnessProgramsDesc),
      FormPairField(key: AppText.privateSessions, value: AppText.privateSessionsDesc),
    ]);
    instructors.addAll([
      BusinessInstructorDraft(
        image: ImagePath.instructorAnna,
        name: AppText.annaGrace,
        role: AppText.yogaInstructor,
        bio: AppText.annaBio,
      ),
      BusinessInstructorDraft(
        image: ImagePath.instructorMike,
        name: AppText.mikePeterson,
        role: AppText.meditationCoach,
        bio: AppText.mikeBio,
      ),
      BusinessInstructorDraft(
        image: ImagePath.instructorSophia,
        name: AppText.sophiaLee,
        role: AppText.wellnessExpert,
        bio: AppText.sophiaBio,
      ),
    ]);
    hours.addAll([
      BusinessHourDraft(
        startDay: AppText.monday.obs,
        endDay: AppText.friday.obs,
        startTime: AppText.sixAm.obs,
        endTime: AppText.ninePm.obs,
      ),
      BusinessHourDraft(
        startDay: AppText.saturday.obs,
        endDay: '-'.obs,
        startTime: AppText.sixAm.obs,
        endTime: AppText.ninePm.obs,
      ),
      BusinessHourDraft(
        startDay: AppText.sunday.obs,
        endDay: '-'.obs,
        startTime: AppText.sixAm.obs,
        endTime: AppText.ninePm.obs,
      ),
    ]);
    socials.addAll([
      BusinessSocialDraft(icon: IconPath.bizInstagram, handle: AppText.instagramHandle),
      BusinessSocialDraft(icon: IconPath.bizFacebook, handle: AppText.facebookHandle),
      BusinessSocialDraft(icon: IconPath.bizYoutube, handle: AppText.youtubeHandle),
      BusinessSocialDraft(icon: IconPath.bizWebsite, handle: AppText.greenleafWebsite),
    ]);
    info.addAll([
      FormPairField(key: AppText.businessType, value: AppText.privateStudio),
      FormPairField(key: AppText.yearEstablished, value: AppText.establishedYear),
      FormPairField(key: AppText.teamSize, value: AppText.teamSizeValue),
      FormPairField(key: AppText.languagesSpoken, value: AppText.englishSpanish),
      FormPairField(key: AppText.licenseCertification, value: AppText.yogaAlliance),
    ]);
    contacts.addAll([
      BusinessContactDraft(icon: IconPath.bizPhone, value: AppText.greenleafPhoneContact),
      BusinessContactDraft(icon: IconPath.aboutMail, value: AppText.greenleafEmail),
      BusinessContactDraft(icon: IconPath.aboutGlobe, value: AppText.greenleafWebsite),
    ]);
  }

  Future<void> pickCover() async {
    final file = await _picker.pickImage(source: ImageSource.gallery, maxWidth: 1080, imageQuality: 85);
    if (file != null) coverPath.value = file.path;
  }

  Future<void> pickLogo() async {
    final file = await _picker.pickImage(source: ImageSource.gallery, maxWidth: 400, imageQuality: 85);
    if (file != null) logoPath.value = file.path;
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

  void toggleOffering(BusinessOffering value) {
    if (offerings.contains(value)) {
      offerings.remove(value);
    } else {
      offerings.add(value);
    }
  }

  void removeOffer(int index) {
    if (index < 0 || index >= offers.length) return;
    offers[index].dispose();
    offers.removeAt(index);
  }

  void addReason() {
    final text = reasonController.text.trim();
    if (text.isEmpty) return;
    reasons.add(text);
    reasonController.clear();
  }

  void removeReason(int index) {
    if (index < 0 || index >= reasons.length) return;
    reasons.removeAt(index);
  }

  void addInstructor() {
    instructors.add(
      BusinessInstructorDraft(image: ImagePath.instructorAnna, name: '', role: '', bio: ''),
    );
  }

  void removeInstructor(int index) {
    if (index < 0 || index >= instructors.length) return;
    instructors[index].dispose();
    instructors.removeAt(index);
  }

  void addHour() {
    hours.add(
      BusinessHourDraft(
        startDay: AppText.monday.obs,
        endDay: AppText.friday.obs,
        startTime: AppText.sixAm.obs,
        endTime: AppText.ninePm.obs,
      ),
    );
  }

  void removeHour(int index) {
    if (index < 0 || index >= hours.length) return;
    hours.removeAt(index);
  }

  Future<void> pickDay(RxString target) async {
    final selected = await pickFormOption(days);
    if (selected != null) target.value = selected;
  }

  Future<void> pickTime(RxString target) async {
    final selected = await pickFormOption(times);
    if (selected != null) target.value = selected;
  }

  void addSocial() {
    socials.add(BusinessSocialDraft(icon: IconPath.bizInstagram, handle: ''));
  }

  void removeContact(int index) {
    if (index < 0 || index >= contacts.length) return;
    contacts[index].dispose();
    contacts.removeAt(index);
  }

  void save() {
    if (!Get.isRegistered<BusinessProfileController>()) return;
    final profile = Get.find<BusinessProfileController>();
    profile.studioName.value = nameController.text.trim().isEmpty
        ? AppText.greenleafName
        : nameController.text.trim();
    profile.handle.value = usernameController.text.trim();
    profile.address.value = locationController.text.trim();
    profile.aboutText.value = aboutController.text.trim();
    profile.storyText.value = storyController.text.trim();
    profile.offers.assignAll(
      offers
          .map(
            (row) => BusinessOffer(
              title: row.keyController.text.trim(),
              subtitle: row.valueController.text.trim(),
            ),
          )
          .where((offer) => offer.title.isNotEmpty)
          .toList(),
    );
    profile.reasons.assignAll(reasons);
    Get.back();
    AppHelperFunctions.showSnackBar(AppText.businessUpdated);
  }

  @override
  void onClose() {
    nameController.dispose();
    usernameController.dispose();
    locationController.dispose();
    aboutController.dispose();
    storyController.dispose();
    reasonController.dispose();
    for (final row in offers) {
      row.dispose();
    }
    for (final instructor in instructors) {
      instructor.dispose();
    }
    for (final social in socials) {
      social.dispose();
    }
    for (final row in info) {
      row.dispose();
    }
    for (final contact in contacts) {
      contact.dispose();
    }
    super.onClose();
  }
}
