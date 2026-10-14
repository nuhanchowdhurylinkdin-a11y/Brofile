import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/helpers/app_platform.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileAboutHeader extends GetView<ProfileController> {
  const ProfileAboutHeader({super.key, this.title = AppText.about});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.w, 12.w, 24.w, 12.w),
          child: Row(
            children: [
              AppBackButton(onTap: Get.back),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: manrope(14, weight: FontWeight.w600, color: AppColors.neutral600, lineHeight: 20),
                ),
              ),
              GestureDetector(
                onTap: controller.openSettings,
                behavior: HitTestBehavior.opaque,
                child: SvgPicture.asset(IconPath.profileSettings, width: 24.w, height: 24.w),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
