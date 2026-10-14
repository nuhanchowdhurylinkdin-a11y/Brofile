import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:brofile/features/profile/controllers/my_circle_controller.dart';
import 'package:brofile/features/profile/data/models/profile_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddToCircleScreen extends GetView<MyCircleController> {
  const AddToCircleScreen({super.key});

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
                PleasureSubHeader(title: AppText.addToCircle, onBack: Get.back),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 32.w),
                    children: [
                      Container(
                        height: 50.w,
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.r),
                          border: Border.all(color: AppColors.neutral100),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(IconPath.searchField, width: 20.w, height: 20.w),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: TextField(
                                controller: controller.searchController,
                                onChanged: controller.onSearchChanged,
                                cursorColor: AppColors.primary,
                                style: manrope(12, color: AppColors.textGray800, lineHeight: 16),
                                decoration: InputDecoration(
                                  isDense: true,
                                  hintText: '${AppText.search} ',
                                  hintStyle: manrope(12, color: AppColors.neutral500, lineHeight: 16),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 28.w),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              AppText.suggested,
                              style: manrope(16, weight: FontWeight.w700, color: AppColors.textGray800, lineHeight: 24),
                            ),
                          ),
                          Text(AppText.seeAll, style: manrope(14, color: AppColors.primary, lineHeight: 20)),
                        ],
                      ),
                      SizedBox(height: 16.w),
                      Obx(() {
                        final people = controller.filteredSuggestions;
                        return Column(
                          children: [
                            for (var i = 0; i < people.length; i++) ...[
                              if (i > 0) SizedBox(height: 4.w),
                              _SuggestionRow(person: people[i]),
                            ],
                          ],
                        );
                      }),
                      SizedBox(height: 24.w),
                      GestureDetector(
                        onTap: controller.openSheet,
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
                                AppText.addToCircle,
                                style: manrope(16, weight: FontWeight.w600, color: Colors.white, lineHeight: 24),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Obx(() {
              if (!controller.sheetOpen.value) return const SizedBox.shrink();
              return const _RelationshipSheet();
            }),
          ],
        ),
      ),
    );
  }
}

class _SuggestionRow extends GetView<MyCircleController> {
  const _SuggestionRow({required this.person});

  final CircleMember person;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selected = controller.isSelected(person.id);
      return GestureDetector(
        onTap: () => controller.toggleSuggestion(person),
        child: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: selected ? AppColors.inputFill : Colors.transparent,
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                selected ? IconPath.checkSelected : IconPath.radioEmpty,
                width: selected ? 20.w : 16.w,
                height: selected ? 20.w : 16.w,
              ),
              SizedBox(width: 8.w),
              Stack(
                children: [
                  ClipOval(
                    child: Image.asset(person.image, width: 40.w, height: 40.w, fit: BoxFit.cover),
                  ),
                  if (person.online)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 10.w,
                        height: 10.w,
                        decoration: BoxDecoration(
                          color: AppColors.online,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      person.name,
                      style: manrope(16, weight: FontWeight.w700, color: AppColors.primary, lineHeight: 24),
                    ),
                    SizedBox(height: 4.w),
                    Text(person.handle, style: manrope(12, color: AppColors.neutral500, lineHeight: 16)),
                  ],
                ),
              ),
              if (selected)
                GestureDetector(
                  onTap: controller.openSheet,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Text(
                      AppText.selectCircle,
                      style: manrope(12, color: AppColors.primary, lineHeight: 16),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}

class _RelationshipSheet extends GetView<MyCircleController> {
  const _RelationshipSheet();

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            GestureDetector(
              onTap: controller.closeSheet,
              child: Container(color: const Color(0xCCF9F9F9)),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 561.w,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                  boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 12, offset: Offset(0, -4))],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20.w),
                    Container(
                      width: 40.w,
                      height: 2.w,
                      decoration: BoxDecoration(
                        color: AppColors.neutral300,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    SizedBox(height: 4.w),
                    Text(
                      AppText.relationship,
                      style: manrope(14, color: AppColors.neutral600, lineHeight: 20),
                    ),
                    SizedBox(height: 16.w),
                    const _SheetGroupTabs(),
                    Expanded(
                      child: Obx(() {
                        final relations = controller.sheetRelations;
                        final selected = controller.sheetRelation.value;
                        if (relations.isEmpty) {
                          return Center(
                            child: Text(
                              AppText.selectYourRelationship,
                              style: manrope(14, color: AppColors.neutral600, lineHeight: 20),
                            ),
                          );
                        }
                        return ListView(
                          padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 24.w),
                          children: [
                            for (final relation in relations)
                              GestureDetector(
                                onTap: () => controller.selectRelation(relation),
                                child: Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color: selected == relation ? AppColors.inputFill : Colors.transparent,
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        selected == relation ? IconPath.checkSelected : IconPath.radioEmpty,
                                        width: selected == relation ? 20.w : 16.w,
                                        height: selected == relation ? 20.w : 16.w,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        relation,
                                        style: manrope(
                                          14,
                                          weight: selected == relation ? FontWeight.w600 : FontWeight.w400,
                                          color: selected == relation ? AppColors.primary : AppColors.neutral600,
                                          lineHeight: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetGroupTabs extends GetView<MyCircleController> {
  const _SheetGroupTabs();

  @override
  Widget build(BuildContext context) {
    const items = [
      (CircleGroup.family, AppText.family),
      (CircleGroup.relatives, AppText.relative),
      (CircleGroup.friends, AppText.friend),
    ];
    return Obx(() {
      final selected = controller.sheetGroup.value;
      return DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6))),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (final item in items)
              GestureDetector(
                onTap: () => controller.selectSheetGroup(item.$1),
                child: SizedBox(
                  width: 78.w,
                  height: 44.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        selected == item.$1 ? IconPath.checkSelected : IconPath.radioEmpty,
                        width: selected == item.$1 ? 20.w : 16.w,
                        height: selected == item.$1 ? 20.w : 16.w,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        item.$2,
                        style: manrope(
                          12,
                          weight: selected == item.$1 ? FontWeight.w700 : FontWeight.w400,
                          color: selected == item.$1 ? AppColors.primary : const Color(0xFF6B7280),
                          lineHeight: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}
