import 'package:brofile/core/common/widgets/hide_on_scroll.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/helpers/app_platform.dart';
import 'package:brofile/features/home/presentation/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Scrollable tab body whose [HomeHeader] hides on scroll down and slides back up.
class TabScrollView extends StatelessWidget {
  const TabScrollView({
    super.key,
    required this.scrollController,
    required this.onRefresh,
    required this.onLogoTap,
    required this.children,
    this.background = AppColors.surface,
  });

  final ScrollController scrollController;
  final Future<void> Function() onRefresh;
  final VoidCallback onLogoTap;
  final List<Widget> children;
  final Color background;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.paddingOf(context);
    final headerBottom = padding.top + HomeHeader.contentHeight;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Material(
        color: background,
        child: Stack(
          children: [
            AppPlatform.pullToRefresh(
              edgeOffset: headerBottom,
              onRefresh: onRefresh,
              child: ListView(
                controller: scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.only(
                  top: headerBottom + 17.w,
                  bottom: padding.bottom + 100.w,
                ),
                children: children,
              ),
            ),
            SlidingHomeHeader(
              scrollController: scrollController,
              onLogoTap: onLogoTap,
            ),
          ],
        ),
      ),
    );
  }
}
