import 'dart:ui';

import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeHeader extends GetView<HomeController> {
  const HomeHeader({super.key, this.onLogoTap});

  /// Defaults to scrolling the home feed to the top.
  final VoidCallback? onLogoTap;

  /// Height below the status bar.
  static double get contentHeight => 54.w;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: topInset + contentHeight,
          color: AppColors.headerBackground,
          padding: EdgeInsets.fromLTRB(16.w, topInset + 8.w, 16.w, 0),
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              GestureDetector(
                onTap: onLogoTap ?? controller.scrollToTop,
                child: SvgPicture.asset(
                  IconPath.brofileLogo,
                  width: 132.w,
                  height: 36.667.w,
                ),
              ),
              const Spacer(),
              _HeaderIcon(
                asset: IconPath.search,
                width: 24,
                height: 24,
                onTap: controller.openSearch,
              ),
              SizedBox(width: 24.w),
              _HeaderIcon(
                asset: IconPath.chat,
                width: 21.5,
                height: 21.56,
                onTap: controller.openMessages,
              ),
              SizedBox(width: 24.w),
              _HeaderIcon(
                asset: IconPath.notification,
                width: 19.31,
                height: 21.65,
                onTap: controller.openNotifications,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({
    required this.asset,
    required this.width,
    required this.height,
    required this.onTap,
  });

  final String asset;
  final double width;
  final double height;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox.square(
        dimension: 24.w,
        child: Center(
          child: SvgPicture.asset(asset, width: width.w, height: height.w),
        ),
      ),
    );
  }
}
