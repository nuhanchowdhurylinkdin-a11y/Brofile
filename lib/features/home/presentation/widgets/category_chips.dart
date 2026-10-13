import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoryChips extends StatelessWidget {
  const CategoryChips({
    super.key,
    required this.labels,
    required this.selected,
    required this.onSelected,
    this.selectedColor = AppColors.primary,
    this.spacing = 6,
    this.selectedKey,
  });

  final List<String> labels;
  final RxInt selected;
  final ValueChanged<int> onSelected;
  final Color selectedColor;
  final double spacing;

  /// Attached to the selected chip so its owner can scroll it into view.
  final GlobalKey? selectedKey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 43.w,
      // Built eagerly so the selected chip can always be scrolled into view.
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: spacing.w,
          children: [
            for (var index = 0; index < labels.length; index++)
              Obx(() {
                final isSelected = selected.value == index;
                return Builder(
                  key: isSelected ? selectedKey : null,
                  builder: (chipContext) => _CategoryChip(
                    label: labels[index],
                    isSelected: isSelected,
                    selectedColor: selectedColor,
                    onTap: () {
                      onSelected(index);
                      Scrollable.ensureVisible(
                        chipContext,
                        alignment: 0.5,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOut,
                      );
                    },
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.selectedColor,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final Color selectedColor;
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
          color: isSelected ? selectedColor : Colors.white,
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
