import 'package:brofile/core/common/widgets/hide_on_scroll.dart';
import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/community/controllers/invite_members_controller.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class InviteMembersScreen extends GetView<InviteMembersController> {
  const InviteMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: HideOnScroll(
          header: PleasureSubHeader(title: AppText.inviteMembers, onBack: Get.back),
          body: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 32.w),
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48.w),
                    child: Text(
                      AppText.invitePeopleToJoin.replaceAll('{name}', controller.communityName),
                      textAlign: TextAlign.center,
                      style: manrope(14, color: AppColors.neutral600, lineHeight: 20),
                    ),
                  ),
                  SizedBox(height: 20.w),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
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
                      ),
                      SizedBox(width: 4.w),
                      GestureDetector(
                        onTap: controller.seeAll,
                        child: Container(
                          width: 50.w,
                          height: 50.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24.r),
                            border: Border.all(color: AppColors.neutral100),
                            boxShadow: const [
                              BoxShadow(color: Color(0x0D0A0D12), offset: Offset(0, 1), blurRadius: 1),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset(IconPath.filter, width: 20.w, height: 20.w),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 28.w),
                  _Section(
                    title: AppText.suggestedForThisCommunity,
                    section: InviteSection.suggested,
                  ),
                  SizedBox(height: 28.w),
                  _Section(title: AppText.communityMatch, section: InviteSection.match),
                  SizedBox(height: 28.w),
                  _Section(title: AppText.friendsAndFamily, section: InviteSection.friends),
                  SizedBox(height: 24.w),
                  Center(
                    child: GestureDetector(
                      onTap: controller.send,
                      child: Container(
                        height: 44.w,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          AppText.sendInvitations,
                          style: manrope(16, weight: FontWeight.w600, color: Colors.white, lineHeight: 24),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}

class _Section extends GetView<InviteMembersController> {
  const _Section({required this.title, required this.section});

  final String title;
  final InviteSection section;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: manrope(16, weight: FontWeight.w700, color: AppColors.textGray800, lineHeight: 24),
              ),
            ),
            GestureDetector(
              onTap: controller.seeAll,
              child: Text(
                AppText.seeAll,
                style: manrope(14, color: AppColors.primary, lineHeight: 20),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.w),
        Obx(() {
          final people = controller.inSection(section);
          return Column(
            children: [
              for (var i = 0; i < people.length; i++) ...[
                if (i > 0) SizedBox(height: 4.w),
                _PersonRow(person: people[i]),
              ],
            ],
          );
        }),
      ],
    );
  }
}

class _PersonRow extends GetView<InviteMembersController> {
  const _PersonRow({required this.person});

  final InviteCandidate person;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selected = person.isSelected.value;
      return GestureDetector(
        onTap: () => controller.toggle(person),
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: manrope(16, weight: FontWeight.w700, color: AppColors.primary, lineHeight: 24),
                    ),
                    SizedBox(height: 4.w),
                    Row(
                      children: [
                        SvgPicture.asset(IconPath.mutual, width: 16.w, height: 16.w),
                        SizedBox(width: 8.w),
                        Text(
                          person.subtitle,
                          style: manrope(12, color: AppColors.neutral500, lineHeight: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
