import 'dart:io';

import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/features/community/controllers/create_community_controller.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CreateCommunityScreen extends GetView<CreateCommunityController> {
  const CreateCommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: Column(
          children: [
            PleasureSubHeader(title: AppText.createCommunity, onBack: Get.back),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 32.w),
                children: [
                  const _CoverPicker(),
                  SizedBox(height: 28.w),
                  _RequiredLabel(AppText.communityName),
                  SizedBox(height: 12.w),
                  _FilledBox(
                    height: 60.w,
                    child: TextField(
                      controller: controller.nameController,
                      style: manrope(16, color: AppColors.gray900, lineHeight: 24),
                      cursorColor: AppColors.primary,
                      decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 28.w),
                  _RequiredLabel(AppText.shortDescription),
                  SizedBox(height: 12.w),
                  _FilledBox(
                    height: 128.w,
                    fill: Colors.white,
                    child: TextField(
                      controller: controller.descriptionController,
                      maxLines: null,
                      expands: true,
                      textAlignVertical: TextAlignVertical.top,
                      style: manrope(16, color: AppColors.neutral600, lineHeight: 24),
                      cursorColor: AppColors.primary,
                      decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 28.w),
                  _RequiredLabel(AppText.category),
                  SizedBox(height: 12.w),
                  Obx(
                    () => _ChipRow(
                      options: controller.categoryOptions,
                      selected: controller.category.value,
                      onTap: controller.selectCategory,
                    ),
                  ),
                  SizedBox(height: 28.w),
                  _RequiredLabel(AppText.communitySubCategory),
                  SizedBox(height: 12.w),
                  Obx(
                    () => _ChipRow(
                      options: controller.subcategoryOptions,
                      selected: controller.subcategory.value,
                      onTap: controller.selectSubcategory,
                    ),
                  ),
                  SizedBox(height: 28.w),
                  _RequiredLabel(AppText.privacyLabel),
                  SizedBox(height: 12.w),
                  const _PrivacyRow(),
                  SizedBox(height: 28.w),
                  _OptionalLabel(AppText.communityRules),
                  SizedBox(height: 12.w),
                  const _RulesField(),
                  SizedBox(height: 28.w),
                  _OptionalLabel(AppText.locationLabel),
                  SizedBox(height: 12.w),
                  Obx(
                    () => _SelectRow(
                      leading: SvgPicture.asset(IconPath.locationMarker, width: 18.w, height: 18.w),
                      value: controller.location.value,
                      onTap: controller.pickLocation,
                    ),
                  ),
                  SizedBox(height: 28.w),
                  _OptionalLabel(AppText.communitySize),
                  SizedBox(height: 12.w),
                  const _SizeOptions(),
                  SizedBox(height: 28.w),
                  Text(
                    AppText.whoCanPostQuestion,
                    style: manrope(18, weight: FontWeight.w700, color: AppColors.textGray800, lineHeight: 20),
                  ),
                  SizedBox(height: 12.w),
                  Obx(
                    () => _SelectRow(
                      value: controller.whoCanPost.value,
                      onTap: controller.pickWhoCanPost,
                    ),
                  ),
                  SizedBox(height: 28.w),
                  Text(
                    AppText.whoCanInviteNewMembers,
                    style: manrope(18, weight: FontWeight.w700, color: AppColors.textGray800, lineHeight: 20),
                  ),
                  SizedBox(height: 12.w),
                  Obx(
                    () => _SelectRow(
                      value: controller.whoCanInvite.value,
                      onTap: controller.pickWhoCanInvite,
                    ),
                  ),
                  SizedBox(height: 24.w),
                  Center(
                    child: GestureDetector(
                      onTap: controller.create,
                      child: Container(
                        height: 44.w,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          AppText.createCommunity,
                          style: manrope(16, weight: FontWeight.w600, color: Colors.white, lineHeight: 24),
                        ),
                      ),
                    ),
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

class _CoverPicker extends GetView<CreateCommunityController> {
  const _CoverPicker();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.pickCover,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: SizedBox(
          height: 193.w,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Obx(() {
                final path = controller.coverPath.value;
                if (path != null) {
                  return Image.file(File(path), fit: BoxFit.cover);
                }
                return Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    ImagePath.createCoverPlaceholder,
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.repeat,
                  ),
                );
              }),
              Center(
                child: Container(
                  width: 52.w,
                  height: 52.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.neutral200),
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(IconPath.addPhotoCamera, width: 24.w, height: 24.w),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RequiredLabel extends StatelessWidget {
  const _RequiredLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: manrope(18, weight: FontWeight.w700, color: AppColors.textGray800, lineHeight: 20),
        ),
        SvgPicture.asset(IconPath.asterisk, width: 10.w, height: 10.w),
      ],
    );
  }
}

class _OptionalLabel extends StatelessWidget {
  const _OptionalLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: label,
            style: manrope(18, weight: FontWeight.w700, color: AppColors.textGray800, lineHeight: 20),
          ),
          TextSpan(
            text: AppText.optionalSuffix,
            style: manrope(18, color: AppColors.neutral500, lineHeight: 28),
          ),
        ],
      ),
    );
  }
}

class _ChipRow extends StatelessWidget {
  const _ChipRow({required this.options, required this.selected, required this.onTap});

  final List<String> options;
  final String selected;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < options.length; i++) ...[
            if (i > 0) SizedBox(width: 6.w),
            GestureDetector(
              onTap: () => onTap(options[i]),
              child: Container(
                height: 43.w,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: options[i] == selected ? AppColors.primary : Colors.white,
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(color: AppColors.neutral100),
                ),
                alignment: Alignment.center,
                child: Text(
                  options[i],
                  style: manrope(
                    14,
                    color: options[i] == selected ? Colors.white : AppColors.neutral500,
                    lineHeight: 20,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PrivacyRow extends GetView<CreateCommunityController> {
  const _PrivacyRow();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: _PrivacyCard(
              selected: controller.isPublic.value,
              icon: IconPath.globe,
              title: AppText.publicLabel,
              onTap: () => controller.selectPrivacy(true),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: _PrivacyCard(
              selected: !controller.isPublic.value,
              icon: IconPath.lockPrivacy,
              title: AppText.privateLabel,
              onTap: () => controller.selectPrivacy(false),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrivacyCard extends StatelessWidget {
  const _PrivacyCard({
    required this.selected,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final bool selected;
  final String icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: selected ? AppColors.inputFill : AppColors.neutral100,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: selected ? AppColors.primary : AppColors.neutral400),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SvgPicture.asset(icon, width: 24.w, height: 24.w),
                SizedBox(width: 8.w),
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
                  selected ? IconPath.checkFilled : IconPath.radioEmpty,
                  width: 16.w,
                  height: 16.w,
                ),
              ],
            ),
            SizedBox(height: 8.w),
            Text(
              AppText.anyoneCanFind,
              style: manrope(12, color: AppColors.neutral700, lineHeight: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class _RulesField extends GetView<CreateCommunityController> {
  const _RulesField();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 162.w,
      padding: EdgeInsets.fromLTRB(24.w, 18.w, 24.w, 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          Expanded(
            child: TextField(
              controller: controller.rulesController,
              maxLength: CreateCommunityController.maxRules,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              style: manrope(14, color: AppColors.neutral600, lineHeight: 20),
              cursorColor: AppColors.primary,
              decoration: const InputDecoration(
                isDense: true,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                counterText: '',
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Obx(
              () => Text(
                '${controller.rulesLength.value}/${CreateCommunityController.maxRules}',
                style: manrope(14, color: AppColors.neutral500, lineHeight: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SizeOptions extends GetView<CreateCommunityController> {
  const _SizeOptions();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          _SizeRow(
            label: AppText.unlimited,
            selected: controller.unlimitedSize.value,
            onTap: () => controller.selectSize(true),
          ),
          SizedBox(height: 8.w),
          _SizeRow(
            label: AppText.upTo500Members,
            selected: !controller.unlimitedSize.value,
            onTap: () => controller.selectSize(false),
          ),
        ],
      ),
    );
  }
}

class _SizeRow extends StatelessWidget {
  const _SizeRow({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.w,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(
          color: selected ? AppColors.inputFill : AppColors.neutral100,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: manrope(
                  14,
                  weight: FontWeight.w500,
                  color: selected ? AppColors.primary : AppColors.neutral700,
                  lineHeight: 20,
                ),
              ),
            ),
            SvgPicture.asset(
              selected ? IconPath.checkFilled : IconPath.radioEmpty,
              width: 16.w,
              height: 16.w,
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectRow extends StatelessWidget {
  const _SelectRow({required this.value, required this.onTap, this.leading});

  final String value;
  final VoidCallback onTap;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: _FilledBox(
        height: 60.w,
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              SizedBox(width: 8.w),
            ],
            Expanded(
              child: Text(value, style: manrope(16, color: AppColors.gray900, lineHeight: 24)),
            ),
            SvgPicture.asset(IconPath.chevronDown, width: 20.w, height: 20.w),
          ],
        ),
      ),
    );
  }
}

class _FilledBox extends StatelessWidget {
  const _FilledBox({required this.height, required this.child, this.fill});

  final double height;
  final Widget child;
  final Color? fill;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.w),
      decoration: BoxDecoration(
        color: fill ?? AppColors.inputFill,
        borderRadius: BorderRadius.circular(14.r),
      ),
      alignment: Alignment.centerLeft,
      child: child,
    );
  }
}
