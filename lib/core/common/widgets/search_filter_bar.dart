import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchFilterBar extends StatelessWidget {
  const SearchFilterBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onFilter,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onFilter;

  @override
  Widget build(BuildContext context) {
    final border = BoxDecoration(
      color: Colors.white,
      border: Border.all(color: AppColors.neutral100),
      borderRadius: BorderRadius.circular(30.r),
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50.w,
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              decoration: border,
              child: Row(
                children: [
                  SvgPicture.asset(
                    IconPath.searchField,
                    width: 20.w,
                    height: 20.w,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onChanged: onChanged,
                      textInputAction: TextInputAction.search,
                      cursorColor: AppColors.primary,
                      style: manrope(12, color: AppColors.textGray800),
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
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
                        hintText: AppText.search,
                        hintStyle: manrope(12, color: AppColors.neutral500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 4.w),
          GestureDetector(
            onTap: onFilter,
            child: Container(
              width: 50.w,
              height: 50.w,
              alignment: Alignment.center,
              decoration: border.copyWith(
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: SvgPicture.asset(
                IconPath.filter,
                width: 20.w,
                height: 20.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
