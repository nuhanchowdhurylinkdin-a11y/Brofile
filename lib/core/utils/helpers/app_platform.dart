import 'dart:io';

import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PlatformAction {
  const PlatformAction({
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool isDestructive;
}

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, required this.onTap, this.size = 24});

  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return AppPlatform.backButton(context: context, onTap: onTap, size: size);
  }
}

/// Native chrome that differs on iOS and Android: back, refresh, sheets, pickers, dialogs.
class AppPlatform {
  AppPlatform._();

  static bool get isIOS {
    if (defaultTargetPlatform == TargetPlatform.iOS) return true;
    return !kIsWeb && Platform.isIOS;
  }

  static bool get isAndroid {
    if (defaultTargetPlatform == TargetPlatform.android) return true;
    return !kIsWeb && Platform.isAndroid;
  }

  static bool get isCupertino {
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return true;
      default:
        return false;
    }
  }

  static bool isCupertinoOf(BuildContext context) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return true;
      default:
        return false;
    }
  }

  static Widget backButton({
    required BuildContext context,
    required VoidCallback onTap,
    double size = 24,
  }) {
    final ios = isCupertinoOf(context);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Icon(
        ios ? CupertinoIcons.back : Icons.arrow_back,
        size: size.w,
        color: ios ? AppColors.neutral600 : AppColors.gray900,
      ),
    );
  }

  static const _cupertinoTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    primaryContrastingColor: Colors.white,
    textTheme: CupertinoTextThemeData(primaryColor: AppColors.primary),
  );

  static const _actionStyle = TextStyle(
    inherit: false,
    fontFamily: 'CupertinoSystemDisplay',
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
  );

  static Widget _themedCupertino(Widget child) {
    return CupertinoTheme(data: _cupertinoTheme, child: child);
  }

  static Widget pullToRefresh({
    required Future<void> Function() onRefresh,
    required Widget child,
    double edgeOffset = 0,
    Color color = AppColors.primary,
  }) {
    return RefreshIndicator.adaptive(
      color: color,
      edgeOffset: edgeOffset,
      onRefresh: onRefresh,
      child: child,
    );
  }

  static Future<String?> showOptions(List<String> options, {String? title}) async {
    final context = Get.context!;
    if (isCupertino) {
      return showCupertinoModalPopup<String>(
        context: context,
        builder: (ctx) => _themedCupertino(
          CupertinoActionSheet(
            title: title == null ? null : Text(title),
            actions: [
              for (final option in options)
                CupertinoActionSheetAction(
                  onPressed: () => Navigator.pop(ctx, option),
                  child: Text(option, style: _actionStyle),
                ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(ctx),
              child: const Text(AppText.cancel, style: _actionStyle),
            ),
          ),
        ),
      );
    }

    return Get.bottomSheet<String>(
      Material(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: SafeArea(
          top: false,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: Get.height * 0.55),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.neutral200,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                  ),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: options.length,
                    itemBuilder: (_, index) {
                      final option = options[index];
                      return ListTile(
                        title: Text(
                          option,
                          style: const TextStyle(color: AppColors.textGray800),
                        ),
                        onTap: () => Get.back(result: option),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Future<void> showActions(List<PlatformAction> actions) async {
    final context = Get.context!;
    if (isCupertino) {
      await showCupertinoModalPopup<void>(
        context: context,
        builder: (ctx) => _themedCupertino(
          CupertinoActionSheet(
            actions: [
              for (final action in actions)
                CupertinoActionSheetAction(
                  isDestructiveAction: action.isDestructive,
                  onPressed: () {
                    Navigator.pop(ctx);
                    action.onTap();
                  },
                  child: Text(
                    action.label,
                    style: _actionStyle.copyWith(
                      color: action.isDestructive ? AppColors.error : AppColors.primary,
                    ),
                  ),
                ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(ctx),
              child: const Text(AppText.cancel, style: _actionStyle),
            ),
          ),
        ),
      );
      return;
    }

    await Get.bottomSheet<void>(
      Material(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.neutral200,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 8),
              for (final action in actions)
                ListTile(
                  title: Text(
                    action.label,
                    style: TextStyle(
                      color: action.isDestructive ? AppColors.error : AppColors.textGray800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    Get.back();
                    action.onTap();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<void> showAlert({
    required String title,
    required String message,
    String confirmLabel = AppText.ok,
  }) {
    final context = Get.context!;
    if (isCupertino) {
      return showCupertinoDialog<void>(
        context: context,
        builder: (ctx) => _themedCupertino(
          CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(ctx),
                child: Text(
                  confirmLabel,
                  style: const TextStyle(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
  }

  static Future<DateTime?> pickDate({
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
  }) async {
    final context = Get.context!;
    final initial = _clampDate(initialDate, firstDate, lastDate);
    if (isCupertino) {
      DateTime selected = initial;
      return showCupertinoModalPopup<DateTime>(
        context: context,
        builder: (ctx) => _themedCupertino(
          _CupertinoPickerSheet(
            onCancel: () => Navigator.pop(ctx),
            onDone: () => Navigator.pop(ctx, selected),
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: initial,
              minimumDate: firstDate,
              maximumDate: lastDate,
              onDateTimeChanged: (value) => selected = value,
            ),
          ),
        ),
      );
    }

    return showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: _materialPickerTheme,
    );
  }

  static Future<TimeOfDay?> pickTime({TimeOfDay? initialTime}) async {
    final context = Get.context!;
    final initial = initialTime ?? TimeOfDay.now();
    if (isCupertino) {
      final now = DateTime.now();
      DateTime selected = DateTime(now.year, now.month, now.day, initial.hour, initial.minute);
      final picked = await showCupertinoModalPopup<DateTime>(
        context: context,
        builder: (ctx) => _themedCupertino(
          _CupertinoPickerSheet(
            onCancel: () => Navigator.pop(ctx),
            onDone: () => Navigator.pop(ctx, selected),
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDateTime: selected,
              use24hFormat: MediaQuery.alwaysUse24HourFormatOf(ctx),
              onDateTimeChanged: (value) => selected = value,
            ),
          ),
        ),
      );
      if (picked == null) return null;
      return TimeOfDay(hour: picked.hour, minute: picked.minute);
    }

    return showTimePicker(
      context: context,
      initialTime: initial,
      builder: _materialPickerTheme,
    );
  }

  static DateTime _clampDate(DateTime value, DateTime min, DateTime max) {
    if (value.isBefore(min)) return min;
    if (value.isAfter(max)) return max;
    return value;
  }

  static Widget _materialPickerTheme(BuildContext context, Widget? child) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.light(primary: AppColors.primary),
      ),
      child: child!,
    );
  }
}

class _CupertinoPickerSheet extends StatelessWidget {
  const _CupertinoPickerSheet({
    required this.child,
    required this.onCancel,
    required this.onDone,
  });

  final Widget child;
  final VoidCallback onCancel;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 280,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    onPressed: onCancel,
                    child: const Text(AppText.cancel),
                  ),
                  CupertinoButton(
                    onPressed: onDone,
                    child: const Text(AppText.done),
                  ),
                ],
              ),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
