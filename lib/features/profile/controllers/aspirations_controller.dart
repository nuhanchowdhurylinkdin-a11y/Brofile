import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/core/utils/helpers/profile_navigation.dart';
import 'package:brofile/features/profile/controllers/profile_controller.dart';
import 'package:brofile/features/profile/data/models/profile_models.dart';
import 'package:brofile/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AspirationsController extends GetxController {
  static const statuses = [
    AppText.inProgress,
    AppText.planning,
    AppText.ideaStage,
  ];

  final tab = AspirationKind.project.obs;
  final items = <AspirationItem>[].obs;
  final selected = Rxn<AspirationItem>();
  final formStatus = Rxn<AspirationStatus>();
  final formTarget = ''.obs;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  String? _editingId;
  final _monthYear = DateFormat('MMM yyyy');

  @override
  void onInit() {
    super.onInit();
    items.assignAll([
      AspirationItem(
        id: 'photo-progress',
        kind: AspirationKind.project,
        title: AppText.photographyStudio,
        icon: IconPath.aspireCamera,
        iconBg: 0xFFDCFAE6,
        status: AspirationStatus.inProgress,
        target: 'Dec 2026',
        description: AppText.photographyStudioDesc,
        notes: AppText.photographyStudioNotes,
      ),
      AspirationItem(
        id: 'photo-planning',
        kind: AspirationKind.project,
        title: AppText.photographyStudio,
        icon: IconPath.aspirePen,
        iconBg: 0xFFF4EBFF,
        status: AspirationStatus.planning,
        target: 'Dec 2026',
      ),
      AspirationItem(
        id: 'photo-idea',
        kind: AspirationKind.project,
        title: AppText.photographyStudio,
        icon: IconPath.aspireCoffee,
        iconBg: 0xFFFEF0C7,
        status: AspirationStatus.ideaStage,
        target: 'Dec 2026',
      ),
      AspirationItem(
        id: 'healthy-family',
        kind: AspirationKind.hope,
        title: AppText.healthyFamily,
        icon: IconPath.aspireFamily,
        iconBg: 0xFFFEF3F2,
      ),
      AspirationItem(
        id: 'better-lifestyle',
        kind: AspirationKind.hope,
        title: AppText.betterLifestyle,
        icon: IconPath.aspireLifestyle,
        iconBg: 0xFFECFDF3,
      ),
      AspirationItem(
        id: 'own-home',
        kind: AspirationKind.hope,
        title: AppText.ownAHome,
        icon: IconPath.aspireHome,
        iconBg: 0xFFEFF4FF,
        target: 'Dec 2030',
      ),
      AspirationItem(
        id: 'financial-freedom',
        kind: AspirationKind.hope,
        title: AppText.financialFreedom,
        icon: IconPath.aspireFinance,
        iconBg: 0xFFFAFAFA,
        target: 'Dec 2032',
      ),
      AspirationItem(
        id: 'visit-japan',
        kind: AspirationKind.dream,
        title: AppText.visitJapan,
        icon: IconPath.aspirePlane,
        iconBg: 0xFFEFF1F5,
        target: 'Jan 2027',
      ),
      AspirationItem(
        id: 'everest',
        kind: AspirationKind.dream,
        title: AppText.everestTrek,
        icon: IconPath.aspireCamp,
        iconBg: 0xFFFEF0C7,
        target: 'Jan 2028',
      ),
      AspirationItem(
        id: 'ride-california',
        kind: AspirationKind.dream,
        title: AppText.rideCalifornia,
        icon: IconPath.aspireBike,
        iconBg: 0xFFEFF4FF,
      ),
      AspirationItem(
        id: 'northern-lights',
        kind: AspirationKind.dream,
        title: AppText.northernLights,
        icon: IconPath.aspireLights,
        iconBg: 0xFFFFF1F3,
        target: 'Aug 2029',
      ),
    ]);
  }

  List<AspirationItem> get visible => items.where((item) => item.kind == tab.value).toList();

  String get sectionTitle {
    final count = visible.length;
    final raw = switch (tab.value) {
      AspirationKind.project => AppText.myProjects,
      AspirationKind.hope => AppText.myHopes,
      AspirationKind.dream => AppText.myDreams,
    };
    final title = ProfileController.viewingAsVisitor
        ? ProfileNavigation.publicLabel(raw)
        : raw;
    return '$title ($count)';
  }

  String get addLabel => switch (tab.value) {
        AspirationKind.project => AppText.addNewProject,
        AspirationKind.hope => AppText.addNewHope,
        AspirationKind.dream => AppText.addNewDream,
      };

  String get formTitle => switch (tab.value) {
        AspirationKind.project => AppText.addProject,
        AspirationKind.hope => AppText.addHope,
        AspirationKind.dream => AppText.addDream,
      };

  String get titleLabel => switch (tab.value) {
        AspirationKind.project => AppText.projectTitle,
        AspirationKind.hope => AppText.hopeTitle,
        AspirationKind.dream => AppText.dreamTitle,
      };

  String get titleHint => switch (tab.value) {
        AspirationKind.project => AppText.projectTitleHint,
        AspirationKind.hope => AppText.hopeTitleHint,
        AspirationKind.dream => AppText.dreamTitleHint,
      };

  String get descriptionHint => switch (tab.value) {
        AspirationKind.project => AppText.writeMoreAboutProject,
        AspirationKind.hope => AppText.writeMoreAboutHope,
        AspirationKind.dream => AppText.writeMoreAboutDream,
      };

  bool get showStatusField => tab.value == AspirationKind.project;

  String get statusValue => switch (formStatus.value) {
        AspirationStatus.inProgress => AppText.inProgress,
        AspirationStatus.planning => AppText.planning,
        AspirationStatus.ideaStage => AppText.ideaStage,
        null => AppText.selectStatus,
      };

  String get targetValue => formTarget.value.isEmpty ? AppText.selectDate : formTarget.value;

  void selectTab(AspirationKind kind) => tab.value = kind;

  void openDetails(AspirationItem item) => selected.value = item;

  void closeDetails() => selected.value = null;

  void openCreate({AspirationItem? item}) {
    _editingId = item?.id;
    if (item != null) tab.value = item.kind;
    titleController.text = item?.title ?? '';
    descriptionController.text = item?.description ?? '';
    formStatus.value = item?.status;
    formTarget.value = item?.target ?? '';
    Get.toNamed(AppRoute.createAspirationScreen);
  }

  void editSelected() {
    final item = selected.value;
    if (item == null) return;
    closeDetails();
    openCreate(item: item);
  }

  void deleteSelected() {
    final item = selected.value;
    if (item == null) return;
    items.removeWhere((entry) => entry.id == item.id);
    closeDetails();
  }

  Future<void> pickStatus() async {
    final picked = await Get.bottomSheet<String>(
      Material(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE9EAEB),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              for (final option in statuses)
                ListTile(
                  title: Text(option),
                  onTap: () => Get.back(result: option),
                ),
            ],
          ),
        ),
      ),
    );
    if (picked == AppText.inProgress) formStatus.value = AspirationStatus.inProgress;
    if (picked == AppText.planning) formStatus.value = AspirationStatus.planning;
    if (picked == AppText.ideaStage) formStatus.value = AspirationStatus.ideaStage;
  }

  Future<void> pickTarget() async {
    DateTime initial = DateTime.now();
    if (formTarget.value.isNotEmpty) {
      try {
        initial = _monthYear.parse(formTarget.value);
      } catch (_) {}
    }
    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: initial,
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 20),
    );
    if (picked != null) formTarget.value = _monthYear.format(picked);
  }

  void save() {
    final title = titleController.text.trim();
    if (title.isEmpty) {
      AppHelperFunctions.showSnackBar(AppText.titleRequired);
      return;
    }
    AspirationItem? existing;
    if (_editingId != null) {
      for (final item in items) {
        if (item.id == _editingId) existing = item;
      }
    }
    if (existing != null) {
      existing.title = title;
      existing.description = descriptionController.text.trim();
      existing.status = showStatusField ? formStatus.value : existing.status;
      existing.target = formTarget.value;
      items.refresh();
    } else {
      items.add(
        AspirationItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          kind: tab.value,
          title: title,
          icon: _defaultIcon,
          iconBg: _defaultIconBg,
          status: showStatusField ? formStatus.value : null,
          target: formTarget.value,
          description: descriptionController.text.trim(),
        ),
      );
    }
    Get.back();
    AppHelperFunctions.showSnackBar(AppText.aspirationSaved);
  }

  String get _defaultIcon => switch (tab.value) {
        AspirationKind.project => IconPath.aspireCamera,
        AspirationKind.hope => IconPath.aspireFamily,
        AspirationKind.dream => IconPath.aspirePlane,
      };

  int get _defaultIconBg => switch (tab.value) {
        AspirationKind.project => 0xFFDCFAE6,
        AspirationKind.hope => 0xFFFEF3F2,
        AspirationKind.dream => 0xFFEFF1F5,
      };

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
