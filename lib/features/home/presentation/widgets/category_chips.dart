import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoryChips extends GetView<HomeController> {
  const CategoryChips({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43.w,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: HomeController.categories.length,
        separatorBuilder: (_, _) => SizedBox(width: 6.w),
        itemBuilder: (_, index) => Obx(
          () => _CategoryChip(
            label: HomeController.categories[index],
            isSelected: controller.selectedCategory.value == index,
            onTap: () => controller.selectCategory(index),
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          border: Border.all(color: AppColors.neutral100),
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Text(
          label,
          style: manrope(
            14,
            color: isSelected ? Colors.white : AppColors.neutral500,
            lineHeight: 20,
          ),
        ),
      ),
    );
  }
}
