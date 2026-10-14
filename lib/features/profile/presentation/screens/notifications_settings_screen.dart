import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/profile/controllers/settings_controller.dart';
import 'package:brofile/features/profile/presentation/widgets/settings_sub_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NotificationsSettingsScreen extends GetView<SettingsController> {
  const NotificationsSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSubScaffold(
      title: AppText.notifications,
      child: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 32.w),
        children: [
          Text(
            AppText.pushNotifications,
            style: manrope(16, weight: FontWeight.w700, color: AppColors.textGray800, lineHeight: 24),
          ),
          SizedBox(height: 12.w),
          SettingsCard(
            children: [
              _ToggleRow(AppText.newMessages, controller.newMessages, first: true),
              _ToggleRow(AppText.communityUpdates, controller.communityUpdates),
              _ToggleRow(AppText.activityInvitations, controller.activityInvitations),
              _ToggleRow(AppText.businessUpdates, controller.businessUpdates),
              _ToggleRow(AppText.commentsAndReplies, controller.commentsAndReplies),
              _ToggleRow(AppText.newFollowers, controller.newFollowers),
              _ToggleRow(AppText.reportUpdates, controller.reportUpdates, last: true),
            ],
          ),
        ],
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow(this.label, this.value, {this.first = false, this.last = false});

  final String label;
  final RxBool value;
  final bool first;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: first ? Radius.circular(16.r) : Radius.zero,
          bottom: last ? Radius.circular(16.r) : Radius.zero,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: manrope(15, weight: FontWeight.w600, color: const Color(0xFF1A1A1A), lineHeight: 22),
            ),
          ),
          Obx(
            () => Switch.adaptive(
              value: value.value,
              onChanged: (enabled) => value.value = enabled,
              activeTrackColor: const Color(0xFF1F5C1F),
              inactiveTrackColor: const Color(0xFFD1D1D6),
              thumbColor: const WidgetStatePropertyAll(Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
