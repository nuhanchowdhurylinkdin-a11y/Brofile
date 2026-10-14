import 'dart:io';

import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/core/utils/helpers/app_platform.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FormPairField {
  FormPairField({String key = '', String value = ''})
    : keyController = TextEditingController(text: key),
      valueController = TextEditingController(text: value);

  final TextEditingController keyController;
  final TextEditingController valueController;

  void dispose() {
    keyController.dispose();
    valueController.dispose();
  }
}

Future<String?> pickFormOption(List<String> options) {
  return AppPlatform.showOptions(options);
}

class BusinessLabeledField extends StatelessWidget {
  const BusinessLabeledField({super.key, required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: manrope(16, weight: FontWeight.w700, lineHeight: 24)),
        SizedBox(height: 12.w),
        child,
      ],
    );
  }
}

class BusinessInputBox extends StatelessWidget {
  const BusinessInputBox({
    super.key,
    required this.controller,
    this.hint,
    this.style,
    this.height = 60,
    this.radius = 14,
    this.horizontalPadding = 24,
    this.maxLines = 1,
  });

  final TextEditingController controller;
  final String? hint;
  final TextStyle? style;
  final double height;
  final double radius;
  final double horizontalPadding;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.w,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
      alignment: maxLines == 1 ? Alignment.centerLeft : Alignment.topLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius.r),
        border: Border.all(color: AppColors.neutral300),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: style ?? manrope(16, color: AppColors.gray900, lineHeight: 24),
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
          contentPadding: maxLines == 1 ? EdgeInsets.zero : EdgeInsets.only(top: 12.w),
          hintText: hint,
          hintStyle: manrope(16, color: AppColors.neutral400, lineHeight: 24),
        ),
      ),
    );
  }
}

class BusinessSelectBox extends StatelessWidget {
  const BusinessSelectBox({
    super.key,
    required this.value,
    required this.onTap,
    this.height = 60,
    this.radius = 14,
    this.horizontalPadding = 24,
  });

  final String value;
  final VoidCallback onTap;
  final double height;
  final double radius;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height.w,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius.r),
          border: Border.all(color: AppColors.neutral300),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: manrope(
                  height >= 50 ? 16 : 14,
                  weight: FontWeight.w600,
                  color: AppColors.textGray800,
                  lineHeight: 20,
                ),
              ),
            ),
            SvgPicture.asset(IconPath.chevronDown, width: 20.w, height: 20.w),
          ],
        ),
      ),
    );
  }
}

class BusinessCounterBox extends StatelessWidget {
  const BusinessCounterBox({
    super.key,
    required this.controller,
    required this.counter,
    required this.maxLength,
    this.hint,
    this.minHeight,
  });

  final TextEditingController controller;
  final RxInt counter;
  final int maxLength;
  final String? hint;
  final double? minHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: (minHeight ?? 120).w),
      padding: EdgeInsets.fromLTRB(24.w, 18.w, 24.w, 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Column(
        children: [
          TextField(
            controller: controller,
            maxLength: maxLength,
            maxLines: null,
            minLines: minHeight != null ? 4 : 3,
            style: manrope(16, color: AppColors.neutral600, lineHeight: 24),
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
              counterText: '',
              hintText: hint,
              hintStyle: manrope(16, color: AppColors.neutral600, lineHeight: 24),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Obx(
              () => Text(
                '${counter.value}/$maxLength',
                style: manrope(12, color: AppColors.neutral500, lineHeight: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BusinessAddPhoto extends StatelessWidget {
  const BusinessAddPhoto({super.key, required this.path, required this.onTap});

  final Rxn<String> path;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: SizedBox(
          height: 219.w,
          width: double.infinity,
          child: Obx(() {
            final value = path.value;
            return Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(ImagePath.addPhotoBackground, fit: BoxFit.cover),
                if (value != null)
                  Image.file(
                    File(value),
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const SizedBox.shrink(),
                  ),
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
                        style: manrope(16, weight: FontWeight.w600, color: AppColors.gray900, lineHeight: 24),
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

class BusinessPairRows extends StatelessWidget {
  const BusinessPairRows({
    super.key,
    required this.title,
    required this.rows,
    required this.onRemove,
    this.action,
  });

  final String title;
  final List<FormPairField> rows;
  final ValueChanged<int> onRemove;
  final Widget? action;

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
          Row(
            children: [
              Expanded(
                child: Text(title, style: manrope(16, weight: FontWeight.w700, lineHeight: 24)),
              ),
              ?action,
            ],
          ),
          SizedBox(height: 12.w),
          for (var i = 0; i < rows.length; i++) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      BusinessInputBox(
                        controller: rows[i].keyController,
                        height: 44,
                        style: manrope(14, color: AppColors.textGray800, lineHeight: 20),
                      ),
                      SizedBox(height: 4.w),
                      BusinessInputBox(
                        controller: rows[i].valueController,
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
                    onTap: () => onRemove(i),
                    child: SvgPicture.asset(IconPath.trash, width: 20.w, height: 20.w),
                  ),
                ),
              ],
            ),
            if (i < rows.length - 1) SizedBox(height: 12.w),
          ],
        ],
      ),
    );
  }
}

class BusinessAddNewButton extends StatelessWidget {
  const BusinessAddNewButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(IconPath.profilePlus, width: 20.w, height: 20.w),
          SizedBox(width: 4.w),
          Text(
            AppText.addNewCaps,
            style: manrope(14, weight: FontWeight.w600, color: AppColors.primary, lineHeight: 20),
          ),
        ],
      ),
    );
  }
}

class BusinessSaveButton extends StatelessWidget {
  const BusinessSaveButton({super.key, required this.label, required this.onTap, this.width});

  final String label;
  final VoidCallback onTap;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 44.w,
          width: width?.w,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColors.primary),
            boxShadow: const [
              BoxShadow(color: Color(0x0D0A0D12), offset: Offset(0, 1), blurRadius: 2),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: manrope(16, weight: FontWeight.w600, color: Colors.white, lineHeight: 24),
          ),
        ),
      ),
    );
  }
}
