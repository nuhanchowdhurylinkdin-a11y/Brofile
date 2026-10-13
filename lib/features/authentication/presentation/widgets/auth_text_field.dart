import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.onToggleVisibility,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;

  /// When set, the field is treated as a password field with a visibility toggle.
  final VoidCallback? onToggleVisibility;

  bool get _isPassword => onToggleVisibility != null;

  @override
  Widget build(BuildContext context) {
    const none = InputBorder.none;
    final hintStyle = GoogleFonts.manrope(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      height: 24 / 16,
      color: AppColors.gray900,
    );
    final textStyle = _isPassword && obscureText
        ? GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            height: 24 / 16,
            color: AppColors.gray800,
          )
        : hintStyle;

    return Container(
      height: 60.h,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              obscureText: obscureText,
              obscuringCharacter: '•',
              cursorColor: AppColors.gray800,
              style: textStyle,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: hintStyle,
                isDense: true,
                filled: false,
                contentPadding: EdgeInsets.zero,
                border: none,
                enabledBorder: none,
                focusedBorder: none,
                errorBorder: none,
                focusedErrorBorder: none,
                disabledBorder: none,
              ),
            ),
          ),
          if (_isPassword) ...[
            SizedBox(width: 16.w),
            GestureDetector(
              onTap: onToggleVisibility,
              behavior: HitTestBehavior.opaque,
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: controller,
                builder: (_, value, _) {
                  if (!obscureText) {
                    return Icon(
                      Icons.visibility_outlined,
                      size: 24.r,
                      color: AppColors.gray800,
                    );
                  }
                  return SvgPicture.asset(
                    value.text.isEmpty
                        ? IconPath.visibilityOffHint
                        : IconPath.visibilityOff,
                    width: 24.r,
                    height: 24.r,
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
