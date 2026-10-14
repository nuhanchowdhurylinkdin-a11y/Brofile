import 'dart:io';

import 'package:brofile/core/common/widgets/hide_on_scroll.dart';
import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/pleasure/controllers/create_pleasure_controller.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CreatePleasureScreen extends GetView<CreatePleasureController> {
  const CreatePleasureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: HideOnScroll(
          header: PleasureSubHeader(
            title: AppText.createNewPleasure,
            onBack: controller.close,
          ),
          body: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _AddPhotoField(),
                    SizedBox(height: 16.w),
                    _LabeledField(
                      label: AppText.pleasureTitle,
                      child: _InputBox(controller: controller.titleController),
                    ),
                    SizedBox(height: 16.w),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _LabeledField(
                            label: AppText.category,
                            child: Obx(
                              () => _SelectBox(
                                value: controller.category.value,
                                onTap: controller.pickCategory,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: _LabeledField(
                            label: AppText.subCategory,
                            child: Obx(
                              () => _SelectBox(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _LabeledField(
                            label: AppText.date,
                            child: Obx(
                              () => _SelectBox(
                                value: controller.dateLabel,
                                onTap: controller.pickDate,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: _LabeledField(
                            label: AppText.time,
                            child: Obx(
                              () => _SelectBox(
                                value: controller.timeLabel,
                                onTap: controller.pickTime,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.w),
                    _LabeledField(
                      label: AppText.locationLabel,
                      child: _InputBox(
                        controller: controller.locationController,
                        hint: AppText.enterEventLocation,
                      ),
                    ),
                    SizedBox(height: 16.w),
                    _LabeledField(
                      label: AppText.fullDescription,
                      child: const _DescriptionBox(),
                    ),
                    SizedBox(height: 24.w),
                    Center(
                      child: GestureDetector(
                        onTap: controller.save,
                        child: Container(
                          width: 118.w,
                          height: 44.w,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            AppText.save,
                            style: manrope(
                              16,
                              weight: FontWeight.w600,
                              color: Colors.white,
                              lineHeight: 22,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}

class _AddPhotoField extends GetView<CreatePleasureController> {
  const _AddPhotoField();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.pickPhoto,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: SizedBox(
          height: 219.w,
          width: double.infinity,
          child: Obx(() {
            final path = controller.photoPath.value;
            return Stack(
              fit: StackFit.expand,
              children: [
                if (path == null)
                  Image.asset(ImagePath.addPhotoBackground, fit: BoxFit.cover)
                else
                  Image.file(File(path), fit: BoxFit.cover),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: const Color(0x80000000),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: SvgPicture.asset(IconPath.addPhotoCamera),
                      ),
                      SizedBox(height: 8.w),
                      Text(
                        AppText.addPhoto,
                        style: manrope(
                          16,
                          weight: FontWeight.w600,
                          color: path == null
                              ? AppColors.gray900
                              : Colors.white,
                          lineHeight: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: manrope(16, weight: FontWeight.w700, lineHeight: 22),
        ),
        SizedBox(height: 12.w),
        child,
      ],
    );
  }
}

class _InputBox extends StatelessWidget {
  const _InputBox({required this.controller, this.hint});

  final TextEditingController controller;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return _FieldShell(
      child: TextField(
        controller: controller,
        style: manrope(16, color: AppColors.gray900, lineHeight: 22),
        cursorColor: AppColors.primary,
        decoration: InputDecoration(
          isDense: true,
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          hintText: hint,
          hintStyle: manrope(16, color: AppColors.neutral400, lineHeight: 22),
        ),
      ),
    );
  }
}

class _SelectBox extends StatelessWidget {
  const _SelectBox({required this.value, required this.onTap});

  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: _FieldShell(
        child: Row(
          children: [
            Expanded(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: manrope(16, color: AppColors.gray900, lineHeight: 22),
              ),
            ),
            SvgPicture.asset(
              IconPath.chevronDown,
              width: 20.w,
              height: 20.w,
            ),
          ],
        ),
      ),
    );
  }
}

class _DescriptionBox extends GetView<CreatePleasureController> {
  const _DescriptionBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175.w,
      padding: EdgeInsets.fromLTRB(24.w, 18.w, 24.w, 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          Expanded(
            child: TextField(
              controller: controller.descriptionController,
              maxLength: CreatePleasureController.maxDescription,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              style: manrope(16, color: AppColors.gray900, lineHeight: 22),
              cursorColor: AppColors.primary,
              decoration: const InputDecoration(
                isDense: true,
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                counterText: '',
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Obx(
              () => Text(
                '${controller.descriptionLength.value}/${CreatePleasureController.maxDescription}',
                style: manrope(
                  12,
                  color: AppColors.neutral500,
                  lineHeight: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldShell extends StatelessWidget {
  const _FieldShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.w,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.neutral300),
      ),
      child: child,
    );
  }
}
