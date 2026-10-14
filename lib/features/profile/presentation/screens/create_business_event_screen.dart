import 'package:brofile/core/common/widgets/hide_on_scroll.dart';
import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:brofile/features/profile/controllers/create_business_event_controller.dart';
import 'package:brofile/features/profile/presentation/widgets/business_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CreateBusinessEventScreen extends StatelessWidget {
  const CreateBusinessEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: HideOnScroll(
          header: PleasureSubHeader(title: AppText.createNewEvent, onBack: Get.back),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 32.w),
            child: const CreateBusinessEventForm(),
          ),
        ),
      ),
    );
  }
}

class CreateBusinessEventForm extends GetView<CreateBusinessEventController> {
  const CreateBusinessEventForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BusinessAddPhoto(path: controller.photoPath, onTap: controller.pickPhoto),
        SizedBox(height: 28.w),
        Text(
          AppText.basicInformation,
          style: manrope(18, weight: FontWeight.w500, color: AppColors.neutral600, lineHeight: 28),
        ),
        SizedBox(height: 16.w),
        BusinessLabeledField(
          label: AppText.eventTitle,
          child: BusinessInputBox(
            controller: controller.nameController,
            hint: AppText.enterEventTitle,
          ),
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
        Row(
          children: [
            Expanded(
              child: BusinessLabeledField(
                label: AppText.date,
                child: Obx(
                  () => BusinessSelectBox(
                    value: controller.date.value,
                    onTap: controller.pickDate,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: BusinessLabeledField(
                label: AppText.time,
                child: Obx(
                  () => BusinessSelectBox(
                    value: controller.time.value,
                    onTap: controller.pickTime,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.w),
        BusinessLabeledField(
          label: AppText.entryFee,
          child: BusinessInputBox(controller: controller.priceController),
        ),
        SizedBox(height: 16.w),
        BusinessLabeledField(
          label: AppText.locationLabel,
          child: BusinessInputBox(
            controller: controller.locationController,
            hint: AppText.enterEventLocation,
          ),
        ),
        SizedBox(height: 24.w),
        BusinessLabeledField(
          label: AppText.shortDescription,
          child: BusinessCounterBox(
            controller: controller.shortController,
            counter: controller.shortLength,
            maxLength: CreateBusinessEventController.maxShort,
            hint: AppText.shortDescriptionHint,
          ),
        ),
        SizedBox(height: 24.w),
        BusinessLabeledField(
          label: AppText.fullDescription,
          child: BusinessCounterBox(
            controller: controller.detailsController,
            counter: controller.detailsLength,
            maxLength: CreateBusinessEventController.maxFull,
            hint: AppText.serviceFullDescriptionHint,
            minHeight: 175,
          ),
        ),
        SizedBox(height: 24.w),
        const _AchievementsCard(),
        SizedBox(height: 24.w),
        BusinessSaveButton(label: AppText.save, onTap: controller.save, width: 118),
      ],
    );
  }
}

class _AchievementsCard extends GetView<CreateBusinessEventController> {
  const _AchievementsCard();

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
          Text(AppText.whatYouWillAchieve, style: manrope(16, weight: FontWeight.w700, lineHeight: 24)),
          SizedBox(height: 12.w),
          Row(
            children: [
              Expanded(
                child: BusinessInputBox(
                  controller: controller.achievementController,
                  hint: AppText.privateSessions,
                  height: 48,
                  style: manrope(14, color: AppColors.textGray800, lineHeight: 20),
                ),
              ),
              SizedBox(width: 12.w),
              GestureDetector(
                onTap: controller.addAchievement,
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
                for (var i = 0; i < controller.achievements.length; i++)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
                    child: Row(
                      children: [
                        SvgPicture.asset(IconPath.bizReasonCheck, width: 20.w, height: 20.w),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            controller.achievements[i],
                            style: manrope(14, color: AppColors.textGray800, lineHeight: 20),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => controller.editAchievement(i),
                          child: SvgPicture.asset(IconPath.aspireEdit, width: 24.w, height: 24.w),
                        ),
                        SizedBox(width: 16.w),
                        GestureDetector(
                          onTap: () => controller.removeAchievement(i),
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
