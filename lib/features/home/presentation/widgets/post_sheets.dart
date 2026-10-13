import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void showPostMenu(PostModel post) {
  final controller = Get.find<HomeController>();

  Widget option(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textGray800, size: 22.r),
      title: Text(label, style: manrope(14, weight: FontWeight.w600)),
      onTap: () {
        Get.back();
        onTap();
      },
    );
  }

  Get.bottomSheet(
    _SheetContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          option(Icons.visibility_off_outlined, AppText.hidePost, () => controller.hidePost(post)),
          option(Icons.copy_rounded, AppText.copyText, () => controller.copyPostText(post)),
          option(Icons.flag_outlined, AppText.reportPost, () => controller.reportPost(post)),
        ],
      ),
    ),
  );
}

class _SheetContainer extends StatelessWidget {
  const _SheetContainer({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.w),
            Container(
              width: 40.w,
              height: 4.w,
              decoration: BoxDecoration(
                color: AppColors.neutral200,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 8.w),
            child,
          ],
        ),
      ),
    );
  }
}
