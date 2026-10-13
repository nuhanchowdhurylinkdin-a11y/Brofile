import 'dart:ui';

import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/features/main_nav/controllers/main_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBottomNavBar extends GetView<MainNavController> {
  const AppBottomNavBar({super.key});

  static const _items = [
    _NavItem(NavTab.home, AppText.navHome, IconPath.navHome, IconPath.navHomeFilled, 24.84, 24.4),
    _NavItem(NavTab.community, AppText.navCommunity, IconPath.navCommunity, null, 28, 28),
    _NavItem(NavTab.pleasure, AppText.navPleasure, IconPath.navPleasure, null, 23.67, 24.83),
    _NavItem(NavTab.discover, AppText.navDiscover, IconPath.navDiscover, null, 28, 28),
    _NavItem(NavTab.profile, AppText.navProfile, null, null, 28, 28),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final barHeight = 100.w;
    final extraBottom = (bottomInset - 25.w).clamp(0.0, double.infinity);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: barHeight + extraBottom,
          color: AppColors.navBackground,
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, extraBottom),
          child: Obx(() {
            final current = controller.currentTab.value;
            return Row(
              children: [
                for (final item in _items)
                  Expanded(
                    child: _NavButton(
                      item: item,
                      isActive: item.tab == current,
                      onTap: () => controller.changeTab(item.tab),
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

class _NavItem {
  const _NavItem(this.tab, this.label, this.icon, this.activeIcon, this.width, this.height);

  final NavTab tab;
  final String label;

  /// `null` renders the user's avatar instead of an icon.
  final String? icon;
  final String? activeIcon;
  final double width;
  final double height;
}

class _NavButton extends StatelessWidget {
  const _NavButton({required this.item, required this.isActive, required this.onTap});

  final _NavItem item;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.navActive : AppColors.neutral500;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox.square(dimension: 28.w, child: Center(child: _icon())),
          SizedBox(height: 11.w),
          Text(
            item.label,
            maxLines: 1,
            style: GoogleFonts.manrope(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: color,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _icon() {
    if (item.icon == null) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 28.w,
        height: 28.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: isActive ? Border.all(color: AppColors.navActive, width: 1.5) : null,
          image: const DecorationImage(
            image: AssetImage(ImagePath.avatarWilliam),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    if (isActive && item.activeIcon != null) {
      return SvgPicture.asset(item.activeIcon!, width: item.width.w, height: item.height.w);
    }

    return SvgPicture.asset(
      item.icon!,
      width: item.width.w,
      height: item.height.w,
      colorFilter: isActive
          ? const ColorFilter.mode(AppColors.navActive, BlendMode.srcIn)
          : null,
    );
  }
}
