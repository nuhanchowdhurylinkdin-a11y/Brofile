import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:brofile/core/utils/helpers/profile_navigation.dart';
import 'package:brofile/features/profile/controllers/my_circle_controller.dart';
import 'package:brofile/features/profile/controllers/profile_controller.dart';
import 'package:brofile/features/profile/data/models/profile_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyCircleScreen extends GetView<MyCircleController> {
  const MyCircleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: Column(
          children: [
            PleasureSubHeader(
              title: AppText.myCircle,
              subtitle: AppText.peopleClosestToYou,
              onBack: Get.back,
            ),
            Expanded(
              child: Obx(() {
                return ListView(
                  padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 32.w),
                  children: [
                    const _CircleTabs(),
                    SizedBox(height: 28.w),
                    if (controller.showFamily)
                      _GroupBlock(
                        title: '${AppText.family} (${controller.inGroup(CircleGroup.family).length})',
                        members: controller.visibleInGroup(CircleGroup.family),
                      ),
                    if (controller.showRelatives) ...[
                      if (controller.showFamily) SizedBox(height: 28.w),
                      _GroupBlock(
                        title: '${AppText.relatives} (${controller.inGroup(CircleGroup.relatives).length})',
                        members: controller.visibleInGroup(CircleGroup.relatives),
                        showSeeAll: true,
                        group: CircleGroup.relatives,
                      ),
                    ],
                    if (controller.showFriends) ...[
                      if (controller.showFamily || controller.showRelatives) SizedBox(height: 28.w),
                      _GroupBlock(
                        title: '${AppText.friends} (${controller.inGroup(CircleGroup.friends).length})',
                        members: controller.visibleInGroup(CircleGroup.friends),
                        showSeeAll: controller.inGroup(CircleGroup.friends).length > 4,
                        group: CircleGroup.friends,
                      ),
                    ],
                    if (!ProfileController.viewingAsVisitor) ...[
                      SizedBox(height: 24.w),
                      GestureDetector(
                        onTap: controller.openAdd,
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
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleTabs extends GetView<MyCircleController> {
  const _CircleTabs();

  @override
  Widget build(BuildContext context) {
    const items = [
      (CircleFilter.all, AppText.all),
      (CircleFilter.family, AppText.family),
      (CircleFilter.relatives, AppText.relatives),
      (CircleFilter.friends, AppText.friends),
    ];
    return Obx(() {
      final selected = controller.filter.value;
      return DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6))),
        ),
        child: Row(
          children: [
            for (final item in items)
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.selectFilter(item.$1),
                  child: Container(
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
              ),
          ],
        ),
      );
    });
  }
}

class _GroupBlock extends GetView<MyCircleController> {
  const _GroupBlock({
    required this.title,
    required this.members,
    this.showSeeAll = false,
    this.group,
  });

  final String title;
  final List<CircleMember> members;
  final bool showSeeAll;
  final CircleGroup? group;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: manrope(16, weight: FontWeight.w700, color: AppColors.textGray800, lineHeight: 24),
              ),
            ),
            if (showSeeAll && group != null)
              GestureDetector(
                onTap: () => controller.toggleSeeAll(group!),
                child: Text(AppText.seeAll, style: manrope(14, color: AppColors.primary, lineHeight: 20)),
              ),
          ],
        ),
        SizedBox(height: 16.w),
        for (var i = 0; i < members.length; i++) ...[
          if (i > 0) SizedBox(height: 16.w),
          _MemberRow(member: members[i]),
        ],
      ],
    );
  }
}

class _MemberRow extends GetView<MyCircleController> {
  const _MemberRow({required this.member});

  final CircleMember member;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ProfileNavigation.open(member.name),
      behavior: HitTestBehavior.opaque,
      child: Row(
      children: [
        Stack(
          children: [
            ClipOval(
              child: Image.asset(member.image, width: 40.w, height: 40.w, fit: BoxFit.cover),
            ),
            if (member.online)
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
                member.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: manrope(16, weight: FontWeight.w700, color: AppColors.primary, lineHeight: 24),
              ),
              SizedBox(height: 4.w),
              Text(member.relation, style: manrope(12, color: AppColors.neutral500, lineHeight: 16)),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => controller.message(member),
          child: Container(
            width: 102.w,
            padding: EdgeInsets.symmetric(vertical: 8.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.neutral200),
            ),
            alignment: Alignment.center,
            child: Text(
              AppText.message,
              style: manrope(12, weight: FontWeight.w700, color: AppColors.orange, lineHeight: 18),
            ),
          ),
        ),
      ],
    ),
    );
  }
}
