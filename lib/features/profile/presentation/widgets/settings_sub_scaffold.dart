import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SettingsSubScaffold extends StatelessWidget {
  const SettingsSubScaffold({
    super.key,
    required this.title,
    required this.child,
    this.showClose = false,
  });

  final String title;
  final Widget child;
  final bool showClose;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: Column(
          children: [
            PleasureSubHeader(title: title, onBack: Get.back, showClose: showClose),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: ColoredBox(
        color: Colors.white,
        child: Column(children: children),
      ),
    );
  }
}

class SettingsSearchField extends StatelessWidget {
  const SettingsSearchField({
    super.key,
    required this.controller,
    required this.hint,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          SvgPicture.asset(IconPath.searchField, width: 18.w, height: 18.w),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              cursorColor: AppColors.primary,
              style: manrope(14, color: AppColors.textGray800),
              decoration: InputDecoration(
                isDense: true,
                hintText: hint,
                hintStyle: manrope(14, color: const Color(0xFFB0B0B0)),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsOutlineButton extends StatelessWidget {
  const SettingsOutlineButton({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: const Color(0xFF1F5C1F)),
        ),
        child: Text(
          label,
          style: manrope(13, weight: FontWeight.w700, color: const Color(0xFF1F5C1F), lineHeight: 20),
        ),
      ),
    );
  }
}

class SettingsEndCap extends StatelessWidget {
  const SettingsEndCap({super.key, required this.caption});

  final String caption;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 44.w,
          height: 44.w,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              SvgPicture.asset(IconPath.profileUsers, width: 44.w, height: 44.w),
              Positioned(
                right: -2.w,
                bottom: -2.w,
                child: Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: const BoxDecoration(color: Color(0xFFE0E0E0), shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Icon(Icons.close, size: 10.w, color: AppColors.neutral500),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.w),
        Text(AppText.thatsAll, style: manrope(15, weight: FontWeight.w700, color: const Color(0xFF1A1A1A), lineHeight: 22)),
        SizedBox(height: 4.w),
        Text(caption, style: manrope(13, weight: FontWeight.w500, color: const Color(0xFFA0A0A0), lineHeight: 20)),
      ],
    );
  }
}
