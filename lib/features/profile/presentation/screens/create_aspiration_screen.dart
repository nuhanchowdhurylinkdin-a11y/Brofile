import 'package:brofile/core/common/widgets/hide_on_scroll.dart';
import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:brofile/features/profile/controllers/aspirations_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CreateAspirationScreen extends GetView<AspirationsController> {
  const CreateAspirationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: HideOnScroll(
          header: Obx(() => PleasureSubHeader(title: controller.formTitle, onBack: Get.back)),
          body: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 32.w),
                children: [
                  _TitleLabel(label: controller.titleLabel, requiredField: true),
                  SizedBox(height: 12.w),
                  _FilledField(
                    controller: controller.titleController,
                    hint: controller.titleHint,
                  ),
                  if (controller.showStatusField) ...[
                    SizedBox(height: 24.w),
                    const _OptionalLabel(label: AppText.status),
                    SizedBox(height: 12.w),
                    Obx(
                      () => _TappableField(
                        onTap: controller.pickStatus,
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                controller.statusValue,
                                style: manrope(16, color: AppColors.gray900, lineHeight: 24),
                              ),
                            ),
                            SvgPicture.asset(IconPath.chevronDown, width: 20.w, height: 20.w),
                          ],
                        ),
                      ),
                    ),
                  ],
                  SizedBox(height: 24.w),
                  const _OptionalLabel(label: AppText.targetDate),
                  SizedBox(height: 12.w),
                  Obx(
                    () => _TappableField(
                      onTap: controller.pickTarget,
                      child: Row(
                        children: [
                          SvgPicture.asset(IconPath.aspireCalendar),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              controller.targetValue,
                              style: manrope(16, color: AppColors.gray900, lineHeight: 24),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24.w),
                  const _OptionalLabel(label: AppText.description),
                  SizedBox(height: 12.w),
                  _FilledField(
                    controller: controller.descriptionController,
                    hint: controller.descriptionHint,
                    minHeight: 128,
                    fill: Colors.white,
                    hintColor: AppColors.neutral600,
                    alignTop: true,
                  ),
                  SizedBox(height: 24.w),
                  Align(
                    alignment: Alignment.centerRight,
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

class _TitleLabel extends StatelessWidget {
  const _TitleLabel({required this.label, this.requiredField = false});

  final String label;
  final bool requiredField;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: manrope(16, weight: FontWeight.w700, color: AppColors.textGray800, lineHeight: 24)),
        if (requiredField) SvgPicture.asset(IconPath.asterisk),
      ],
    );
  }
}

class _OptionalLabel extends StatelessWidget {
  const _OptionalLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$label ',
            style: manrope(16, weight: FontWeight.w700, color: AppColors.textGray800, lineHeight: 24),
          ),
          TextSpan(
            text: AppText.optionalSuffix,
            style: manrope(16, color: AppColors.textGray800, lineHeight: 24),
          ),
        ],
      ),
    );
  }
}

class _FilledField extends StatelessWidget {
  const _FilledField({
    required this.controller,
    required this.hint,
    this.minHeight = 60,
    this.fill,
    this.hintColor,
    this.alignTop = false,
  });

  final TextEditingController controller;
  final String hint;
  final double minHeight;
  final Color? fill;
  final Color? hintColor;
  final bool alignTop;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: minHeight.w),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.w),
      decoration: BoxDecoration(
        color: fill ?? AppColors.inputFill,
        borderRadius: BorderRadius.circular(14.r),
      ),
      alignment: alignTop ? Alignment.topLeft : Alignment.centerLeft,
      child: TextField(
        controller: controller,
        maxLines: alignTop ? null : 1,
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
          hintStyle: manrope(16, color: hintColor ?? AppColors.gray900, lineHeight: 24),
        ),
      ),
    );
  }
}

class _TappableField extends StatelessWidget {
  const _TappableField({required this.onTap, required this.child});

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.w,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(
          color: AppColors.inputFill,
          borderRadius: BorderRadius.circular(14.r),
        ),
        alignment: Alignment.centerLeft,
        child: child,
      ),
    );
  }
}
