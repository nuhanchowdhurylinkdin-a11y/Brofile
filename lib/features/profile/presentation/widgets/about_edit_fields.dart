import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/profile/controllers/edit_about_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AboutSaveBar extends GetView<EditAboutController> {
  const AboutSaveBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: controller.cancel,
            child: Text(
              AppText.cancel,
              style: manrope(14, weight: FontWeight.w600, color: AppColors.neutral600, lineHeight: 20),
            ),
          ),
          const Spacer(),
          GestureDetector(
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
                style: manrope(16, weight: FontWeight.w600, color: Colors.white, lineHeight: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AboutLabeledField extends StatelessWidget {
  const AboutLabeledField({super.key, required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: manrope(16, weight: FontWeight.w700, color: AppColors.textGray800, lineHeight: 24),
        ),
        SizedBox(height: 12.w),
        child,
      ],
    );
  }
}

class AboutInputBox extends StatelessWidget {
  const AboutInputBox({
    super.key,
    required this.controller,
    this.keyboardType,
    this.onSubmitted,
    this.hint,
  });

  final TextEditingController controller;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onSubmitted;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return _FieldShell(
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        onSubmitted: onSubmitted,
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
          hintStyle: manrope(16, color: AppColors.neutral500, lineHeight: 24),
        ),
      ),
    );
  }
}

class AboutSelectBox extends StatelessWidget {
  const AboutSelectBox({super.key, required this.value, required this.onTap});

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

class AboutAddAction extends StatelessWidget {
  const AboutAddAction({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Text(
        label,
        style: manrope(14, weight: FontWeight.w600, color: AppColors.orange, lineHeight: 20),
      ),
    );
  }
}

class AboutJobFields extends GetView<EditAboutController> {
  const AboutJobFields({super.key, required this.form});

  final JobForm form;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AboutLabeledField(label: AppText.jobTitle, child: AboutInputBox(controller: form.title)),
        SizedBox(height: 16.w),
        AboutLabeledField(label: AppText.company, child: AboutInputBox(controller: form.company)),
        SizedBox(height: 16.w),
        AboutLabeledField(label: AppText.locationLabel, child: AboutInputBox(controller: form.location)),
        SizedBox(height: 16.w),
        AboutLabeledField(
          label: AppText.employmentType,
          child: Obx(
            () => AboutSelectBox(
              value: form.type.value,
              onTap: () => controller.pickEmploymentType(form),
            ),
          ),
        ),
        SizedBox(height: 16.w),
        AboutLabeledField(
          label: AppText.startDate,
          child: Obx(
            () => AboutSelectBox(
              value: form.startDate.value.isEmpty ? AppText.select : form.startDate.value,
              onTap: () => controller.pickJobStart(form),
            ),
          ),
        ),
        SizedBox(height: 16.w),
        AboutLabeledField(
          label: AppText.endDate,
          child: Obx(
            () => _EndDateRow(
              value: form.current.value
                  ? AppText.present
                  : form.endDate.value.isEmpty
                      ? AppText.select
                      : form.endDate.value,
              onPick: () => controller.pickJobEnd(form),
              checked: form.current.value,
              checkLabel: AppText.currentlyWorkHere,
              onCheck: () => controller.toggleJobCurrent(form),
            ),
          ),
        ),
      ],
    );
  }
}

class AboutEducationFields extends GetView<EditAboutController> {
  const AboutEducationFields({super.key, required this.form});

  final EducationForm form;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AboutLabeledField(label: AppText.courseTitle, child: AboutInputBox(controller: form.course)),
        SizedBox(height: 16.w),
        AboutLabeledField(label: AppText.instituteName, child: AboutInputBox(controller: form.institute)),
        SizedBox(height: 16.w),
        AboutLabeledField(label: AppText.locationLabel, child: AboutInputBox(controller: form.location)),
        SizedBox(height: 16.w),
        AboutLabeledField(
          label: AppText.startDate,
          child: Obx(
            () => AboutSelectBox(
              value: form.startDate.value.isEmpty ? AppText.select : form.startDate.value,
              onTap: () => controller.pickEducationStart(form),
            ),
          ),
        ),
        SizedBox(height: 16.w),
        AboutLabeledField(
          label: AppText.endDate,
          child: Obx(
            () => _EndDateRow(
              value: form.current.value
                  ? AppText.present
                  : form.endDate.value.isEmpty
                      ? AppText.select
                      : form.endDate.value,
              onPick: () => controller.pickEducationEnd(form),
              checked: form.current.value,
              checkLabel: AppText.stillAStudent,
              onCheck: () => controller.toggleEducationCurrent(form),
            ),
          ),
        ),
      ],
    );
  }
}

class AboutBioBox extends GetView<EditAboutController> {
  const AboutBioBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.w,
      padding: EdgeInsets.fromLTRB(24.w, 18.w, 24.w, 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.neutral300),
      ),
      child: Column(
        children: [
          Expanded(
            child: TextField(
              controller: controller.aboutController,
              maxLength: EditAboutController.maxAbout,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              style: manrope(16, color: AppColors.gray900, lineHeight: 24),
              cursorColor: AppColors.primary,
              decoration: const InputDecoration(
                isDense: true,
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                counterText: '',
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Obx(
              () => Text(
                '${controller.aboutLength.value}/${EditAboutController.maxAbout}',
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

class _EndDateRow extends StatelessWidget {
  const _EndDateRow({
    required this.value,
    required this.onPick,
    required this.checked,
    required this.checkLabel,
    required this.onCheck,
  });

  final String value;
  final VoidCallback onPick;
  final bool checked;
  final String checkLabel;
  final VoidCallback onCheck;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: AboutSelectBox(value: value, onTap: onPick)),
        SizedBox(width: 12.w),
        GestureDetector(
          onTap: onCheck,
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  color: checked ? AppColors.joined : Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(color: checked ? AppColors.joined : AppColors.neutral300),
                ),
                child: checked ? Icon(Icons.check, size: 14.w, color: Colors.white) : null,
              ),
              SizedBox(width: 8.w),
              Text(
                checkLabel,
                style: manrope(14, color: AppColors.neutral600, lineHeight: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
