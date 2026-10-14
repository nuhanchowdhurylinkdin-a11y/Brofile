import 'dart:io';

import 'package:brofile/core/common/widgets/hide_on_scroll.dart';
import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/features/discover/controllers/create_product_controller.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CreateProductScreen extends GetView<CreateProductController> {
  const CreateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: HideOnScroll(
          header: PleasureSubHeader(
            title: AppText.createNewProduct,
            onBack: controller.close,
          ),
          body: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const _AddPhotoField(),
                    SizedBox(height: 28.w),
                    Text(
                      AppText.basicInformation,
                      style: manrope(
                        18,
                        weight: FontWeight.w500,
                        color: AppColors.neutral600,
                        lineHeight: 28,
                      ),
                    ),
                    SizedBox(height: 16.w),
                    _LabeledField(
                      label: AppText.productName,
                      child: _InputBox(
                        controller: controller.nameController,
                        hint: AppText.enterProductName,
                      ),
                    ),
                    SizedBox(height: 16.w),
                    Row(
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
                    _LabeledField(
                      label: AppText.recycleCategory,
                      child: Obx(
                        () => _SelectBox(
                          value: controller.recycleType.value,
                          onTap: controller.pickRecycleType,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.w),
                    _LabeledField(
                      label: AppText.price,
                      child: _InputBox(controller: controller.priceController),
                    ),
                    SizedBox(height: 24.w),
                    _LabeledField(
                      label: AppText.details,
                      child: const _DetailsBox(),
                    ),
                    SizedBox(height: 24.w),
                    const _InfoSection(),
                    SizedBox(height: 24.w),
                    Center(
                      child: GestureDetector(
                        onTap: controller.post,
                        child: Container(
                          height: 46.w,
                          padding: EdgeInsets.symmetric(horizontal: 60.w),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            AppText.post,
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
      ),
    );
  }
}

class _AddPhotoField extends GetView<CreateProductController> {
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
                      SizedBox(height: 12.w),
                      Text(
                        AppText.addPhoto,
                        style: manrope(
                          16,
                          weight: FontWeight.w600,
                          color: AppColors.gray900,
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

class _InfoSection extends GetView<CreateProductController> {
  const _InfoSection();

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
          Text(
            AppText.information,
            style: manrope(16, weight: FontWeight.w700, lineHeight: 24),
          ),
          SizedBox(height: 12.w),
          Obx(
            () => Column(
              spacing: 12.w,
              children: [
                for (var i = 0; i < controller.infoRows.length; i++)
                  _InfoRow(index: i, field: controller.infoRows[i]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends GetView<CreateProductController> {
  const _InfoRow({required this.index, required this.field});

  final int index;
  final ProductInfoField field;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              _SoftField(
                controller: field.keyController,
                style: manrope(14, lineHeight: 20),
              ),
              SizedBox(height: 4.w),
              _SoftField(
                controller: field.valueController,
                height: 44,
                style: manrope(12, color: AppColors.neutral600, lineHeight: 16),
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Padding(
          padding: EdgeInsets.only(top: 10.w),
          child: GestureDetector(
            onTap: () => controller.removeInfo(index),
            child: SvgPicture.asset(IconPath.trash, width: 20.w, height: 20.w),
          ),
        ),
      ],
    );
  }
}

class _SoftField extends StatelessWidget {
  const _SoftField({
    required this.controller,
    required this.style,
    this.height,
  });

  final TextEditingController controller;
  final TextStyle style;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (height ?? 44).w,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.neutral300),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: TextField(
        controller: controller,
        style: style,
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
          style: manrope(16, weight: FontWeight.w700, lineHeight: 24),
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
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          hintText: hint,
          hintStyle: manrope(16, color: AppColors.neutral400, lineHeight: 24),
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

class _DetailsBox extends GetView<CreateProductController> {
  const _DetailsBox();

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
              controller: controller.detailsController,
              maxLength: CreateProductController.maxDescription,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              style: manrope(16, color: AppColors.neutral600, lineHeight: 24),
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
                '${controller.detailsLength.value}/${CreateProductController.maxDescription}',
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
