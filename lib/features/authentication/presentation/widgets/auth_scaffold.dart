import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'auth_misc.dart';

/// White, scrollable page used by every auth screen.
/// Spacing in the screens is measured from the bottom of the 48px Figma status bar.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.children,
    this.showBackButton = false,
  });

  final List<Widget> children;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (showBackButton)
                  Padding(
                    padding: EdgeInsets.only(left: 16.w, top: 18.h),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: const AuthBackButton(),
                    ),
                  ),
                ...children,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Horizontal inset of the 345px-wide Figma content column.
EdgeInsets get authContentPadding => EdgeInsets.symmetric(horizontal: 41.5.w);
