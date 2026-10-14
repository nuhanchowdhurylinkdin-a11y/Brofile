import 'dart:io';

import 'package:brofile/core/common/widgets/hide_on_scroll.dart';
import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:brofile/features/profile/controllers/edit_business_controller.dart';
import 'package:brofile/features/profile/presentation/widgets/business_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class EditBusinessScreen extends StatelessWidget {
  const EditBusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: HideOnScroll(
          header: PleasureSubHeader(title: AppText.editBusinessProfile, onBack: Get.back),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 32.w),
            child: const EditBusinessForm(),
          ),
        ),
      ),
    );
  }
}

class EditBusinessForm extends GetView<EditBusinessController> {
  const EditBusinessForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _CoverEditor(),
        SizedBox(height: 16.w),
        BusinessLabeledField(
          label: AppText.businessName,
          child: BusinessInputBox(controller: controller.nameController),
        ),
        SizedBox(height: 16.w),
        BusinessLabeledField(
          label: AppText.userName,
          child: BusinessInputBox(controller: controller.usernameController),
        ),
        SizedBox(height: 16.w),
        BusinessLabeledField(
          label: AppText.locationLabel,
          child: BusinessInputBox(controller: controller.locationController),
        ),
        SizedBox(height: 16.w),
        Row(
          children: [
            Expanded(
              child: BusinessLabeledField(
                label: AppText.category,
                child: Obx(
                  () => BusinessSelectBox(
                    value: controller.category.value,
                    onTap: controller.pickCategory,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: BusinessLabeledField(
                label: AppText.subCategory,
                child: Obx(
                  () => BusinessSelectBox(
                    value: controller.subcategory.value,
                    onTap: controller.pickSubcategory,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.w),
        BusinessLabeledField(
          label: AppText.aboutBusiness,
          child: BusinessCounterBox(
            controller: controller.aboutController,
            counter: controller.aboutLength,
            maxLength: EditBusinessController.maxLength,
          ),
        ),
        SizedBox(height: 24.w),
        BusinessLabeledField(
          label: AppText.ourStory,
          child: BusinessCounterBox(
            controller: controller.storyController,
            counter: controller.storyLength,
            maxLength: EditBusinessController.maxLength,
          ),
        ),
        SizedBox(height: 24.w),
        const _OfferingsCard(),
        SizedBox(height: 24.w),
        Obx(() {
          final rows = controller.offers.toList();
          return BusinessPairRows(
            title: AppText.whatWeOffer,
            rows: rows,
            onRemove: controller.removeOffer,
          );
        }),
        SizedBox(height: 24.w),
        const _WhyChooseCard(),
        SizedBox(height: 24.w),
        const _InstructorsCard(),
        SizedBox(height: 24.w),
        const _HoursCard(),
        SizedBox(height: 24.w),
        const _SocialsCard(),
        SizedBox(height: 24.w),
        const _InfoCard(),
        SizedBox(height: 24.w),
        const _ContactsCard(),
        SizedBox(height: 24.w),
        BusinessSaveButton(
          label: AppText.saveAndContinue,
          onTap: controller.save,
        ),
      ],
    );
  }
}

class _CoverEditor extends GetView<EditBusinessController> {
  const _CoverEditor();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 238.w,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Obx(() {
              final path = controller.coverPath.value;
              return SizedBox(
                width: double.infinity,
                height: 198.w,
                child: path == null
                    ? Image.asset(ImagePath.bizCoverYoga, fit: BoxFit.cover)
                    : Image.file(File(path), fit: BoxFit.cover),
              );
            }),
          ),
          Positioned(
            right: 12.w,
            top: 12.w,
            child: GestureDetector(
              onTap: controller.pickCover,
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: const Color(0x80000000),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: SvgPicture.asset(IconPath.addPhotoCamera),
              ),
            ),
          ),
          Positioned(
            left: 34.w,
            top: 158.w,
            child: GestureDetector(
              onTap: controller.pickLogo,
              child: Stack(
                children: [
                  ClipOval(
                    child: Obx(() {
                      final path = controller.logoPath.value;
                      return SizedBox(
                        width: 80.w,
                        height: 80.w,
                        child: path == null
                            ? Image.asset(ImagePath.bizLogoGreenleaf, fit: BoxFit.cover)
                            : Image.file(File(path), fit: BoxFit.cover),
                      );
                    }),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDFDFD),
                        border: Border.all(color: AppColors.neutral100),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: SvgPicture.asset(IconPath.addPhotoCamera, width: 16.w, height: 16.w),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OfferingsCard extends GetView<EditBusinessController> {
  const _OfferingsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppText.businessOfferings, style: manrope(16, weight: FontWeight.w700, lineHeight: 24)),
          SizedBox(height: 12.w),
          Obx(
            () => Column(
              children: [
                _OfferingTile(
                  offering: BusinessOffering.products,
                  icon: IconPath.bizOfferingProducts,
                  title: AppText.products,
                  subtitle: AppText.productsOfferingHint,
                  selected: controller.offerings.contains(BusinessOffering.products),
                ),
                SizedBox(height: 12.w),
                _OfferingTile(
                  offering: BusinessOffering.services,
                  icon: IconPath.bizOfferingServices,
                  title: AppText.services,
                  subtitle: AppText.servicesOfferingHint,
                  selected: controller.offerings.contains(BusinessOffering.services),
                ),
                SizedBox(height: 12.w),
                _OfferingTile(
                  offering: BusinessOffering.events,
                  icon: IconPath.bizOfferingEvents,
                  title: AppText.events,
                  subtitle: AppText.eventsOfferingHint,
                  selected: controller.offerings.contains(BusinessOffering.events),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OfferingTile extends GetView<EditBusinessController> {
  const _OfferingTile({
    required this.offering,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
  });

  final BusinessOffering offering;
  final String icon;
  final String title;
  final String subtitle;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.toggleOffering(offering),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: selected ? const Color(0x0D0D5E3C) : AppColors.neutral100,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: selected ? AppColors.primary : AppColors.neutral400),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: selected
                  ? null
                  : const ColorFilter.mode(AppColors.neutral600, BlendMode.srcIn),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: manrope(
                            16,
                            weight: FontWeight.w700,
                            color: selected ? AppColors.primary : AppColors.neutral600,
                            lineHeight: 24,
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        selected ? IconPath.bizCheck : IconPath.bizRadio,
                        width: 16.w,
                        height: 16.w,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.w),
                  Text(
                    subtitle,
                    style: manrope(12, color: AppColors.neutral700, lineHeight: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WhyChooseCard extends GetView<EditBusinessController> {
  const _WhyChooseCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppText.whyChooseUs, style: manrope(16, weight: FontWeight.w700, lineHeight: 24)),
          SizedBox(height: 12.w),
          Row(
            children: [
              Expanded(
                child: BusinessInputBox(
                  controller: controller.reasonController,
                  hint: AppText.privateSessions,
                  height: 48,
                ),
              ),
              SizedBox(width: 12.w),
              GestureDetector(
                onTap: controller.addReason,
                child: Container(
                  height: 44.w,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    AppText.add,
                    style: manrope(16, weight: FontWeight.w600, color: Colors.white, lineHeight: 24),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.w),
          Obx(
            () => Column(
              children: [
                for (var i = 0; i < controller.reasons.length; i++)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
                    child: Row(
                      children: [
                        SvgPicture.asset(IconPath.bizReasonCheck, width: 20.w, height: 20.w),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            controller.reasons[i],
                            style: manrope(14, color: AppColors.textGray800, lineHeight: 20),
                          ),
                        ),
                        SvgPicture.asset(IconPath.profileCoverEdit, width: 24.w, height: 24.w),
                        SizedBox(width: 16.w),
                        GestureDetector(
                          onTap: () => controller.removeReason(i),
                          child: SvgPicture.asset(IconPath.pleasureClose, width: 24.w, height: 24.w),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InstructorsCard extends GetView<EditBusinessController> {
  const _InstructorsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  AppText.meetOurInstructors,
                  style: manrope(16, weight: FontWeight.w700, lineHeight: 24),
                ),
              ),
              BusinessAddNewButton(onTap: controller.addInstructor),
            ],
          ),
          SizedBox(height: 12.w),
          Obx(
            () => Column(
              children: [
                for (var i = 0; i < controller.instructors.length; i++) ...[
                  _InstructorEditor(index: i, draft: controller.instructors[i]),
                  if (i < controller.instructors.length - 1)
                    Divider(height: 1, color: AppColors.neutral300),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InstructorEditor extends GetView<EditBusinessController> {
  const _InstructorEditor({required this.index, required this.draft});

  final int index;
  final BusinessInstructorDraft draft;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60.w,
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipOval(
                      child: Image.asset(draft.image, width: 60.w, height: 60.w, fit: BoxFit.cover),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFDFDFD),
                          border: Border.all(color: AppColors.neutral100),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: SvgPicture.asset(IconPath.addPhotoCamera, width: 16.w, height: 16.w),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.w),
                GestureDetector(
                  onTap: () => controller.removeInstructor(index),
                  child: SvgPicture.asset(IconPath.trash, width: 20.w, height: 20.w),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              children: [
                BusinessInputBox(
                  controller: draft.nameController,
                  height: 44,
                  radius: 4,
                  horizontalPadding: 12,
                  style: manrope(14, weight: FontWeight.w600, lineHeight: 20),
                ),
                SizedBox(height: 4.w),
                BusinessInputBox(
                  controller: draft.roleController,
                  height: 44,
                  radius: 4,
                  horizontalPadding: 12,
                  style: manrope(12, weight: FontWeight.w500, color: AppColors.primary, lineHeight: 16),
                ),
                SizedBox(height: 8.w),
                BusinessInputBox(
                  controller: draft.bioController,
                  height: 44,
                  radius: 4,
                  horizontalPadding: 12,
                  style: manrope(12, color: AppColors.neutral600, lineHeight: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HoursCard extends GetView<EditBusinessController> {
  const _HoursCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(AppText.businessHours, style: manrope(16, weight: FontWeight.w700, lineHeight: 24)),
              ),
              BusinessAddNewButton(onTap: controller.addHour),
            ],
          ),
          SizedBox(height: 12.w),
          Obx(
            () => Column(
              children: [
                for (var i = 0; i < controller.hours.length; i++) ...[
                  _HourEditor(index: i, draft: controller.hours[i]),
                  if (i < controller.hours.length - 1) SizedBox(height: 20.w),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HourEditor extends GetView<EditBusinessController> {
  const _HourEditor({required this.index, required this.draft});

  final int index;
  final BusinessHourDraft draft;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => BusinessSelectBox(
                        value: draft.startDay.value,
                        onTap: () => controller.pickDay(draft.startDay),
                        height: 44,
                        radius: 4,
                        horizontalPadding: 12,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Obx(
                      () => BusinessSelectBox(
                        value: draft.endDay.value,
                        onTap: () => controller.pickDay(draft.endDay),
                        height: 44,
                        radius: 4,
                        horizontalPadding: 12,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.w),
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => BusinessSelectBox(
                        value: draft.startTime.value,
                        onTap: () => controller.pickTime(draft.startTime),
                        height: 44,
                        radius: 4,
                        horizontalPadding: 12,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Obx(
                      () => BusinessSelectBox(
                        value: draft.endTime.value,
                        onTap: () => controller.pickTime(draft.endTime),
                        height: 44,
                        radius: 4,
                        horizontalPadding: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Padding(
          padding: EdgeInsets.only(top: 12.w),
          child: GestureDetector(
            onTap: () => controller.removeHour(index),
            child: SvgPicture.asset(IconPath.trash, width: 20.w, height: 20.w),
          ),
        ),
      ],
    );
  }
}

class _SocialsCard extends GetView<EditBusinessController> {
  const _SocialsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(AppText.connectWithUs, style: manrope(16, weight: FontWeight.w700, lineHeight: 24)),
              ),
              BusinessAddNewButton(onTap: controller.addSocial),
            ],
          ),
          SizedBox(height: 12.w),
          Obx(
            () => Column(
              children: [
                for (var i = 0; i < controller.socials.length; i++)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
                    decoration: BoxDecoration(
                      border: i == controller.socials.length - 1
                          ? null
                          : const Border(bottom: BorderSide(color: AppColors.neutral300)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 44.w,
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.neutral300),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(controller.socials[i].icon, width: 24.w, height: 24.w),
                              SizedBox(width: 12.w),
                              SvgPicture.asset(IconPath.chevronDown, width: 20.w, height: 20.w),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: BusinessInputBox(
                            controller: controller.socials[i].handleController,
                            height: 44,
                            radius: 4,
                            horizontalPadding: 12,
                            style: manrope(14, weight: FontWeight.w600, lineHeight: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends GetView<EditBusinessController> {
  const _InfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppText.businessInfo, style: manrope(16, weight: FontWeight.w700, lineHeight: 24)),
          SizedBox(height: 12.w),
          for (var i = 0; i < controller.info.length; i++)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
              decoration: BoxDecoration(
                border: i == controller.info.length - 1
                    ? null
                    : const Border(bottom: BorderSide(color: AppColors.neutral300)),
              ),
              child: Row(
                children: [
                  Text(
                    controller.info[i].keyController.text,
                    style: manrope(14, weight: FontWeight.w600, lineHeight: 20),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: BusinessInputBox(
                      controller: controller.info[i].valueController,
                      height: 44,
                      radius: 4,
                      horizontalPadding: 12,
                      style: manrope(14, weight: FontWeight.w500, color: AppColors.neutral500, lineHeight: 20),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _ContactsCard extends GetView<EditBusinessController> {
  const _ContactsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppText.contactUsTitle, style: manrope(16, weight: FontWeight.w700, lineHeight: 24)),
          SizedBox(height: 12.w),
          Obx(
            () => Column(
              children: [
                for (var i = 0; i < controller.contacts.length; i++)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
                    decoration: BoxDecoration(
                      border: i == controller.contacts.length - 1
                          ? null
                          : const Border(bottom: BorderSide(color: AppColors.neutral300)),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(controller.contacts[i].icon, width: 18.w, height: 18.w),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: BusinessInputBox(
                            controller: controller.contacts[i].valueController,
                            height: 44,
                            radius: 4,
                            horizontalPadding: 12,
                            style: manrope(14, weight: FontWeight.w500, color: AppColors.neutral500, lineHeight: 20),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        GestureDetector(
                          onTap: () => controller.removeContact(i),
                          child: SvgPicture.asset(IconPath.trash, width: 20.w, height: 20.w),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
