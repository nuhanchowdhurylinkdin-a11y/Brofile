import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:brofile/features/profile/controllers/aspirations_controller.dart';
import 'package:brofile/features/profile/controllers/profile_controller.dart';
import 'package:brofile/features/profile/data/models/profile_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AspirationsScreen extends GetView<AspirationsController> {
  const AspirationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: Stack(
          children: [
            Column(
              children: [
                PleasureSubHeader(title: AppText.aspirations, onBack: Get.back),
                Expanded(
                  child: Obx(() {
                    final list = controller.visible;
                    return ListView(
                      padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 32.w),
                      children: [
                        const _AspirationTabs(),
                        SizedBox(height: 28.w),
                        Text(
                          controller.sectionTitle,
                          style: manrope(16, weight: FontWeight.w700, color: AppColors.textGray800, lineHeight: 24),
                        ),
                        SizedBox(height: 16.w),
                        for (final item in list) ...[
                          _AspirationCard(item: item),
                          SizedBox(height: 8.w),
                        ],
                        if (!ProfileController.viewingAsVisitor) ...[
                          SizedBox(height: 16.w),
                          GestureDetector(
                            onTap: controller.openCreate,
                            child: Container(
                              height: 44.w,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(IconPath.plusWhite, width: 20.w, height: 20.w),
                                  SizedBox(width: 6.w),
                                  Text(
                                    controller.addLabel,
                                    style: manrope(16, weight: FontWeight.w600, color: Colors.white, lineHeight: 24),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    );
                  }),
                ),
              ],
            ),
            const _AspirationDetailsOverlay(),
          ],
        ),
      ),
    );
  }
}

class _AspirationTabs extends GetView<AspirationsController> {
  const _AspirationTabs();

  @override
  Widget build(BuildContext context) {
    const items = [
      (AspirationKind.project, AppText.projectsTab),
      (AspirationKind.hope, AppText.hopes),
      (AspirationKind.dream, AppText.dreams),
    ];
    return Obx(() {
      final selected = controller.tab.value;
      return DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final item in items)
              GestureDetector(
                onTap: () => controller.selectTab(item.$1),
                child: Container(
                  width: 78.w,
                  height: 44.w,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: selected == item.$1 ? const Color(0xFF1B4332) : Colors.transparent,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text(
                    item.$2,
                    style: manrope(
                      12,
                      color: selected == item.$1 ? const Color(0xFF1B4332) : const Color(0xFF6B7280),
                      lineHeight: 16,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}

class _AspirationCard extends GetView<AspirationsController> {
  const _AspirationCard({required this.item});

  final AspirationItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.openDetails(item),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            _IconTile(icon: item.icon, background: Color(item.iconBg)),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: manrope(16, weight: FontWeight.w700, color: AppColors.textGray800, lineHeight: 24),
                  ),
                  if (item.status != null) ...[
                    SizedBox(height: 4.w),
                    _StatusChip(status: item.status!),
                  ],
                  SizedBox(height: 8.w),
                  _TargetRow(target: item.target),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AspirationDetailsOverlay extends GetView<AspirationsController> {
  const _AspirationDetailsOverlay();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final item = controller.selected.value;
      if (item == null) return const SizedBox.shrink();
      return GestureDetector(
        onTap: controller.closeDetails,
        child: ColoredBox(
          color: const Color(0xCCF9F9F9),
          child: Center(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 396.w,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: const [BoxShadow(color: Color(0x14000000), blurRadius: 6)],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DecoratedBox(
                      decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide(color: AppColors.neutral300)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Row(
                          children: [
                            _IconTile(icon: item.icon, background: Color(item.iconBg)),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: manrope(16, weight: FontWeight.w700, color: AppColors.textGray800, lineHeight: 24),
                                  ),
                                  SizedBox(height: 8.w),
                                  _TargetRow(target: item.target),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: controller.closeDetails,
                              child: SvgPicture.asset(IconPath.pleasureClose, width: 24.w, height: 24.w),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (item.description.isNotEmpty)
                      _DetailBlock(
                        label: AppText.descriptionLabel,
                        child: Text(
                          item.description,
                          style: manrope(14, color: AppColors.neutral500, lineHeight: 20),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                border: Border(right: BorderSide(color: AppColors.neutral300)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(right: 8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppText.statusLabel,
                                      style: manrope(14, weight: FontWeight.w600, color: Colors.black, lineHeight: 20),
                                    ),
                                    SizedBox(height: 4.w),
                                    if (item.status != null) _StatusChip(status: item.status!),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 8.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppText.targetLabel,
                                    style: manrope(14, weight: FontWeight.w600, color: Colors.black, lineHeight: 20),
                                  ),
                                  SizedBox(height: 4.w),
                                  _TargetRow(target: item.target, showPrefix: false),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (item.notes.isNotEmpty)
                      DecoratedBox(
                        decoration: const BoxDecoration(
                          border: Border(top: BorderSide(color: AppColors.neutral300)),
                        ),
                        child: _DetailBlock(
                          label: AppText.notesLabel,
                          child: Text(
                            item.notes,
                            style: manrope(14, color: AppColors.neutral500, lineHeight: 20),
                          ),
                        ),
                      ),
                    if (!ProfileController.viewingAsVisitor) ...[
                    SizedBox(height: 24.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: controller.editSelected,
                          child: Container(
                            width: 118.w,
                            height: 44.w,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(IconPath.aspireEdit),
                                SizedBox(width: 6.w),
                                Text(
                                  AppText.edit,
                                  style: manrope(16, weight: FontWeight.w600, color: Colors.white, lineHeight: 24),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        GestureDetector(
                          onTap: controller.deleteSelected,
                          child: Container(
                            width: 118.w,
                            height: 44.w,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFEE4E2),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(IconPath.aspireTrash),
                                SizedBox(width: 6.w),
                                Text(
                                  AppText.delete,
                                  style: manrope(16, weight: FontWeight.w600, color: const Color(0xFFF04438), lineHeight: 24),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _DetailBlock extends StatelessWidget {
  const _DetailBlock({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.neutral300)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(label, style: manrope(14, weight: FontWeight.w600, color: Colors.black, lineHeight: 20)),
            SizedBox(height: 4.w),
            child,
          ],
        ),
      ),
    );
  }
}

class _IconTile extends StatelessWidget {
  const _IconTile({required this.icon, required this.background});

  final String icon;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: SizedBox(
        width: 40,
        height: 40,
        child: Center(child: SvgPicture.asset(icon)),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final AspirationStatus status;

  @override
  Widget build(BuildContext context) {
    final (bg, fg, label) = switch (status) {
      AspirationStatus.inProgress => (const Color(0xFFDCFAE6), const Color(0xFF067647), AppText.inProgress),
      AspirationStatus.planning => (const Color(0xFFEFF4FF), const Color(0xFF004EEB), AppText.planning),
      AspirationStatus.ideaStage => (const Color(0xFFFFFAEB), const Color(0xFFF79009), AppText.ideaStage),
    };
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(label, style: manrope(12, color: fg, lineHeight: 16)),
    );
  }
}

class _TargetRow extends StatelessWidget {
  const _TargetRow({required this.target, this.showPrefix = true});

  final String target;
  final bool showPrefix;

  @override
  Widget build(BuildContext context) {
    final label = target.isEmpty ? AppText.noTargetDate : target;
    return Row(
      children: [
        SvgPicture.asset(IconPath.aspireCalendar),
        SizedBox(width: 4.w),
        Flexible(
          child: Text(
            showPrefix ? '${AppText.targetPrefix}$label' : label,
            style: manrope(14, color: AppColors.neutral500, lineHeight: 20),
          ),
        ),
      ],
    );
  }
}
