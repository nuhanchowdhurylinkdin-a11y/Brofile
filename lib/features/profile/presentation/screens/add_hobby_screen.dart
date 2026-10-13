import 'dart:io';

import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:brofile/features/profile/controllers/add_hobby_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddHobbyScreen extends GetView<AddHobbyController> {
  const AddHobbyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: Column(
          children: [
            PleasureSubHeader(
              title: controller.screenTitle,
              onBack: controller.close,
              showClose: false,
            ),
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _CoverField(),
                    SizedBox(height: 28.w),
                    _LabeledField(
                      label: controller.titleLabel,
                      required: true,
                      child: _InputBox(
                        controller: controller.titleController,
                        hint: controller.titleHint,
                      ),
                    ),
                    SizedBox(height: 16.w),
                    if (controller.isMusic) ...[
                      _LabeledField(
                        label: controller.personLabel,
                        required: true,
                        child: _InputBox(
                          controller: controller.brandController,
                          hint: controller.personHint,
                        ),
                      ),
                      SizedBox(height: 16.w),
                      _LabeledField(
                        label: AppText.album,
                        child: _InputBox(
                          controller: controller.modelController,
                          hint: AppText.enterAlbumName,
                        ),
                      ),
                      SizedBox(height: 16.w),
                      _LabeledField(
                        label: AppText.genre,
                        child: Obx(
                          () => _SelectBox(
                            value: controller.category.value.isEmpty
                                ? AppText.selectGenre
                                : controller.category.value,
                            onTap: controller.pickGenre,
                          ),
                        ),
                      ),
                    ] else if (controller.isBook)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _LabeledField(
                              label: controller.personLabel,
                              required: true,
                              child: _InputBox(
                                controller: controller.brandController,
                                hint: controller.personHint,
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: _LabeledField(
                              label: AppText.genre,
                              child: Obx(
                                () => _SelectBox(
                                  value: controller.category.value.isEmpty
                                      ? AppText.select
                                      : controller.category.value,
                                  onTap: controller.pickGenre,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    else if (controller.isMovie) ...[
                      _LabeledField(
                        label: controller.personLabel,
                        required: true,
                        child: _InputBox(
                          controller: controller.brandController,
                          hint: controller.personHint,
                        ),
                      ),
                      SizedBox(height: 16.w),
                      _LabeledField(
                        label: AppText.genre,
                        child: Obx(
                          () => _SelectBox(
                            value: controller.category.value.isEmpty
                                ? AppText.selectGenre
                                : controller.category.value,
                            onTap: controller.pickGenre,
                          ),
                        ),
                      ),
                    ] else if (controller.isAlbum) ...[
                      _LabeledField(
                        label: AppText.category,
                        required: true,
                        child: Obx(
                          () => _SelectBox(
                            value: controller.category.value.isEmpty
                                ? AppText.selectCategory
                                : controller.category.value,
                            onTap: controller.pickCategory,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.w),
                      _LabeledField(
                        label: AppText.subCategory,
                        child: Obx(
                          () => _SelectBox(
                            value: controller.subcategory.value.isEmpty
                                ? AppText.selectSubCategory
                                : controller.subcategory.value,
                            onTap: controller.pickSubcategory,
                          ),
                        ),
                      ),
                      SizedBox(height: 16.w),
                      _LabeledField(
                        label: AppText.locationLabel,
                        child: _InputBox(
                          controller: controller.locationController,
                          hint: AppText.addLocation,
                        ),
                      ),
                    ] else
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _LabeledField(
                              label: AppText.category,
                              required: true,
                              child: Obx(
                                () => _SelectBox(
                                  value: controller.category.value.isEmpty
                                      ? AppText.selectCategory
                                      : controller.category.value,
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
                                  value: controller.subcategory.value.isEmpty
                                      ? AppText.select
                                      : controller.subcategory.value,
                                  onTap: controller.pickSubcategory,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (controller.isGear) ...[
                      SizedBox(height: 16.w),
                      _LabeledField(
                        label: AppText.brand,
                        child: _InputBox(
                          controller: controller.brandController,
                          hint: AppText.enterBrand,
                        ),
                      ),
                      SizedBox(height: 16.w),
                      _LabeledField(
                        label: AppText.model,
                        child: _InputBox(
                          controller: controller.modelController,
                          hint: AppText.enterModel,
                        ),
                      ),
                    ],
                    SizedBox(height: 24.w),
                    _LabeledField(
                      label: AppText.description,
                      child: const _DescriptionBox(),
                    ),
                    if (controller.isAlbum) ...[
                      SizedBox(height: 24.w),
                      const _AlbumPhotos(),
                    ],
                    SizedBox(height: 24.w),
                    Center(
                      child: GestureDetector(
                        onTap: controller.submit,
                        child: Container(
                          width: controller.usesSave ? 118.w : 175.w,
                          height: 44.w,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(color: AppColors.primary),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            controller.submitLabel,
                            style: manrope(
                              16,
                              weight: FontWeight.w600,
                              color: Colors.white,
                              lineHeight: 24,
                            ),
                          ),
                        ),
                      ),
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

class _CoverField extends GetView<AddHobbyController> {
  const _CoverField();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.pickCover,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: SizedBox(
          height: 219.w,
          width: double.infinity,
          child: Obx(() {
            final path = controller.coverPath.value;
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
                        child: SvgPicture.asset(
                          IconPath.addPhotoCamera,
                          width: 20.w,
                          height: 20.w,
                        ),
                      ),
                      SizedBox(height: 12.w),
                      Text(
                        AppText.addCoverPhotos,
                        style: manrope(
                          16,
                          weight: FontWeight.w600,
                          color: path == null ? AppColors.gray900 : Colors.white,
                          lineHeight: 24,
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

class _AlbumPhotos extends GetView<AddHobbyController> {
  const _AlbumPhotos();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppText.photos,
          style: manrope(16, weight: FontWeight.w700, color: AppColors.textGray800, lineHeight: 24),
        ),
        SizedBox(height: 12.w),
        Obx(() {
          final photos = controller.photos.toList();
          return Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Wrap(
              spacing: 12.w,
              runSpacing: 12.w,
              children: [
                for (final path in photos)
                  _PhotoThumb(
                    path: path,
                    onRemove: () => controller.removePhoto(path),
                  ),
                GestureDetector(
                  onTap: controller.pickPhoto,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: SizedBox(
                      width: 84.w,
                      height: 84.w,
                      child: ColoredBox(
                        color: const Color(0xFFD4D4D4),
                        child: Center(
                          child: SvgPicture.asset(
                            IconPath.profilePlus,
                            width: 32.w,
                            height: 32.w,
                            colorFilter: const ColorFilter.mode(
                              AppColors.neutral600,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class _PhotoThumb extends StatelessWidget {
  const _PhotoThumb({required this.path, required this.onRemove});

  final String path;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 84.w,
      height: 84.w,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: Image.file(File(path), width: 84.w, height: 84.w, fit: BoxFit.cover),
          ),
          Positioned(
            top: 4.w,
            right: 4.w,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 24.w,
                height: 24.w,
                decoration: const BoxDecoration(
                  color: Color(0x80000000),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  IconPath.profileRemove,
                  width: 16.w,
                  height: 16.w,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({
    required this.label,
    required this.child,
    this.required = false,
  });

  final String label;
  final Widget child;
  final bool required;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: label,
                style: manrope(16, weight: FontWeight.w700, color: AppColors.textGray800, lineHeight: 24),
              ),
              if (required)
                TextSpan(
                  text: '*',
                  style: manrope(16, weight: FontWeight.w700, color: const Color(0xFFD92D20), lineHeight: 24),
                ),
            ],
          ),
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
        style: manrope(16, color: AppColors.gray900, lineHeight: 24),
        cursorColor: AppColors.primary,
        decoration: InputDecoration(
          isDense: true,
          filled: false,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          hintText: hint,
          hintStyle: manrope(16, color: AppColors.gray900, lineHeight: 24),
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
                style: manrope(16, color: AppColors.gray900, lineHeight: 24),
              ),
            ),
            SvgPicture.asset(IconPath.chevronDown, width: 20.w, height: 20.w),
          ],
        ),
      ),
    );
  }
}

class _DescriptionBox extends GetView<AddHobbyController> {
  const _DescriptionBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.w,
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
              maxLength: AddHobbyController.maxDescription,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              style: manrope(16, color: AppColors.neutral600, lineHeight: 24),
              cursorColor: AppColors.primary,
              decoration: InputDecoration(
                isDense: true,
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                counterText: '',
                hintText: controller.descriptionHint,
                hintStyle: manrope(16, color: AppColors.neutral600, lineHeight: 24),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Obx(
              () => Text(
                '${controller.descriptionLength.value}/${AddHobbyController.maxDescription}',
                style: manrope(12, color: AppColors.neutral500, lineHeight: 16),
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
