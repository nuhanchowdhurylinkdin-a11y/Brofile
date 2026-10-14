import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/features/profile/controllers/profile_controller.dart';
import 'package:brofile/features/profile/data/models/profile_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum AboutSection {
  identity,
  about,
  contact,
  employment,
  education,
  skills,
  philosophy,
  links,
}

class JobForm {
  JobForm({
    String title = '',
    String company = '',
    String location = '',
    String type = 'Full-time',
    String startDate = '',
    String endDate = '',
    bool current = false,
  })  : title = TextEditingController(text: title),
        company = TextEditingController(text: company),
        location = TextEditingController(text: location),
        type = type.obs,
        startDate = startDate.obs,
        endDate = endDate.obs,
        current = current.obs;

  final TextEditingController title;
  final TextEditingController company;
  final TextEditingController location;
  final RxString type;
  final RxString startDate;
  final RxString endDate;
  final RxBool current;

  void dispose() {
    title.dispose();
    company.dispose();
    location.dispose();
  }
}

class EducationForm {
  EducationForm({
    String course = '',
    String institute = '',
    String location = '',
    String startDate = '',
    String endDate = '',
    bool current = false,
  })  : course = TextEditingController(text: course),
        institute = TextEditingController(text: institute),
        location = TextEditingController(text: location),
        startDate = startDate.obs,
        endDate = endDate.obs,
        current = current.obs;

  final TextEditingController course;
  final TextEditingController institute;
  final TextEditingController location;
  final RxString startDate;
  final RxString endDate;
  final RxBool current;

  void dispose() {
    course.dispose();
    institute.dispose();
    location.dispose();
  }
}

class EditAboutController extends GetxController {
  static const int maxAbout = 120;
  static final _monthYear = DateFormat('MMM yyyy');
  static const employmentTypes = [
    'Full-time',
    'Part-time',
    'Contract',
    'Freelance',
    'Internship',
  ];

  final profile = Get.find<ProfileController>();
  final editingSection = Rxn<AboutSection>();

  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final headlineController = TextEditingController();
  final locationController = TextEditingController();
  final websiteController = TextEditingController();
  final aboutController = TextEditingController();
  final philosophyController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final skillInputController = TextEditingController();

  final aboutLength = 0.obs;
  final skills = <String>[].obs;
  final jobs = <JobForm>[].obs;
  final education = <EducationForm>[].obs;
  final links = <TextEditingController>[].obs;

  bool isEditing(AboutSection section) => editingSection.value == section;

  @override
  void onInit() {
    super.onInit();
    aboutController.addListener(() => aboutLength.value = aboutController.text.length);
  }

  void toggleSection(AboutSection section) {
    if (editingSection.value == section) {
      cancel();
      return;
    }
    _load(section);
    editingSection.value = section;
  }

  void cancel() {
    _clearDrafts();
    editingSection.value = null;
  }

  void save() {
    switch (editingSection.value) {
      case AboutSection.identity:
        _saveIdentity();
      case AboutSection.about:
        profile.bio.value = aboutController.text.trim();
      case AboutSection.contact:
        profile.phone.value = phoneController.text.trim();
        profile.email.value = emailController.text.trim();
      case AboutSection.employment:
        profile.jobs.assignAll([
          for (final job in jobs)
            if (job.title.text.trim().isNotEmpty || job.company.text.trim().isNotEmpty)
              EmploymentEntry(
                title: job.title.text.trim(),
                company: job.company.text.trim(),
                period: _period(job.startDate.value, job.endDate.value, job.current.value),
                location: job.location.text.trim(),
                type: job.type.value,
                startDate: job.startDate.value,
                endDate: job.endDate.value,
                current: job.current.value,
              ),
        ]);
      case AboutSection.education:
        profile.education.assignAll([
          for (final item in education)
            if (item.course.text.trim().isNotEmpty || item.institute.text.trim().isNotEmpty)
              EducationEntry(
                course: item.course.text.trim(),
                institute: item.institute.text.trim(),
                period: _period(
                  item.startDate.value,
                  item.endDate.value,
                  item.current.value,
                  separator: ' - ',
                ),
                location: item.location.text.trim(),
                startDate: item.startDate.value,
                endDate: item.endDate.value,
                current: item.current.value,
              ),
        ]);
      case AboutSection.skills:
        addSkill();
        profile.skills.assignAll(skills);
      case AboutSection.philosophy:
        profile.philosophy.value = philosophyController.text.trim();
      case AboutSection.links:
        profile.links.assignAll([
          for (final link in links)
            if (link.text.trim().isNotEmpty) link.text.trim(),
        ]);
      case null:
        return;
    }
    cancel();
    AppHelperFunctions.showSnackBar(AppText.profileSaved);
  }

  void addSkill() {
    final value = skillInputController.text.trim();
    if (value.isEmpty || skills.contains(value)) return;
    skills.add(value);
    skillInputController.clear();
  }

  void removeSkill(String skill) => skills.remove(skill);

  void addJob() => jobs.add(JobForm(location: profile.locationLabel.value));

  void addEducation() => education.add(EducationForm(location: profile.locationLabel.value));

  void addLink() => links.add(TextEditingController());

  Future<void> pickEmploymentType(JobForm job) async {
    final selected = await _pickOption(employmentTypes);
    if (selected != null) job.type.value = selected;
  }

  Future<void> pickJobStart(JobForm job) async {
    final year = await _pickMonthYear(job.startDate.value);
    if (year != null) job.startDate.value = year;
  }

  Future<void> pickJobEnd(JobForm job) async {
    if (job.current.value) return;
    final year = await _pickMonthYear(job.endDate.value);
    if (year != null) job.endDate.value = year;
  }

  void toggleJobCurrent(JobForm job) {
    job.current.toggle();
    if (job.current.value) job.endDate.value = '';
  }

  Future<void> pickEducationStart(EducationForm item) async {
    final year = await _pickMonthYear(item.startDate.value);
    if (year != null) item.startDate.value = year;
  }

  Future<void> pickEducationEnd(EducationForm item) async {
    if (item.current.value) return;
    final year = await _pickMonthYear(item.endDate.value);
    if (year != null) item.endDate.value = year;
  }

  void toggleEducationCurrent(EducationForm item) {
    item.current.toggle();
    if (item.current.value) item.endDate.value = '';
  }

  void _saveIdentity() {
    final name = nameController.text.trim();
    if (name.isNotEmpty) profile.displayName.value = name;
    final username = usernameController.text.trim();
    if (username.isNotEmpty) {
      profile.username.value = username.startsWith('@') ? username : '@$username';
    }
    profile.headline.value = headlineController.text.trim();
    profile.locationLabel.value = locationController.text.trim();
    profile.website.value = websiteController.text.trim();
  }

  void _load(AboutSection section) {
    _clearDrafts();
    switch (section) {
      case AboutSection.identity:
        nameController.text = profile.displayName.value;
        usernameController.text = profile.username.value;
        headlineController.text = profile.headline.value;
        locationController.text = profile.locationLabel.value;
        websiteController.text = profile.website.value;
      case AboutSection.about:
        aboutController.text = profile.bio.value;
        aboutLength.value = aboutController.text.length;
      case AboutSection.contact:
        phoneController.text = profile.phone.value;
        emailController.text = profile.email.value;
      case AboutSection.employment:
        jobs.assignAll([
          for (final job in profile.jobs)
            JobForm(
              title: job.title,
              company: job.company,
              location: job.location,
              type: job.type.isEmpty ? 'Full-time' : job.type,
              startDate: job.startDate,
              endDate: job.endDate,
              current: job.current,
            ),
        ]);
        if (jobs.isEmpty) addJob();
      case AboutSection.education:
        education.assignAll([
          for (final item in profile.education)
            EducationForm(
              course: item.course,
              institute: item.institute,
              location: item.location,
              startDate: item.startDate,
              endDate: item.endDate,
              current: item.current,
            ),
        ]);
        if (education.isEmpty) addEducation();
      case AboutSection.skills:
        skills.assignAll(profile.skills);
        skillInputController.clear();
      case AboutSection.philosophy:
        philosophyController.text = profile.philosophy.value;
      case AboutSection.links:
        links.assignAll([
          for (final link in profile.links) TextEditingController(text: link),
        ]);
        if (links.isEmpty) addLink();
    }
  }

  void _clearDrafts() {
    for (final job in jobs) {
      job.dispose();
    }
    jobs.clear();
    for (final item in education) {
      item.dispose();
    }
    education.clear();
    for (final link in links) {
      link.dispose();
    }
    links.clear();
    skills.clear();
    skillInputController.clear();
  }

  String _period(String start, String end, bool current, {String separator = ' • '}) {
    final right = current || end.isEmpty ? AppText.present : end;
    if (start.isEmpty) return right;
    return '$start$separator$right';
  }

  Future<String?> _pickMonthYear(String current) async {
    DateTime initial = DateTime.now();
    if (current.isNotEmpty) {
      try {
        initial = _monthYear.parse(current);
      } catch (_) {
        final year = int.tryParse(current);
        if (year != null) initial = DateTime(year);
      }
    }
    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: initial,
      firstDate: DateTime(1970),
      lastDate: DateTime(DateTime.now().year + 6),
    );
    return picked == null ? null : _monthYear.format(picked);
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
    _clearDrafts();
    nameController.dispose();
    usernameController.dispose();
    headlineController.dispose();
    locationController.dispose();
    websiteController.dispose();
    aboutController.dispose();
    philosophyController.dispose();
    phoneController.dispose();
    emailController.dispose();
    skillInputController.dispose();
    super.onClose();
  }
}
