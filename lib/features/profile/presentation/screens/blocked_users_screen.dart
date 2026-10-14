import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/profile/controllers/settings_controller.dart';
import 'package:brofile/features/profile/data/models/profile_models.dart';
import 'package:brofile/features/profile/presentation/widgets/settings_sub_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BlockedUsersScreen extends GetView<SettingsController> {
  const BlockedUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSubScaffold(
      title: AppText.blockedUsers,
      child: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 32.w),
        children: [
          SettingsSearchField(
            controller: controller.blockedSearchController,
            hint: AppText.searchUser,
            onChanged: (value) => controller.blockedQuery.value = value,
          ),
          SizedBox(height: 16.w),
          Obx(() {
            final users = controller.filteredBlockedUsers;
            if (users.isEmpty) return const SizedBox.shrink();
            return SettingsCard(
              children: [
                for (var i = 0; i < users.length; i++)
                  _BlockedRow(user: users[i], last: i == users.length - 1),
              ],
            );
          }),
          SizedBox(height: 40.w),
          const SettingsEndCap(caption: AppText.noMoreBlockedUsers),
        ],
      ),
    );
  }
}

class _BlockedRow extends GetView<SettingsController> {
  const _BlockedRow({required this.user, required this.last});

  final BlockedUser user;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 14.w, 16.w, 14.w),
      decoration: BoxDecoration(
        border: last ? null : const Border(bottom: BorderSide(color: Color(0xFFF0F0F0))),
      ),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(user.image, width: 48.w, height: 48.w, fit: BoxFit.cover),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.name, style: manrope(15, weight: FontWeight.w700, color: const Color(0xFF1A1A1A), lineHeight: 21)),
                Text(user.handle, style: manrope(13, weight: FontWeight.w500, color: const Color(0xFF9A9A9A), lineHeight: 20)),
              ],
            ),
          ),
          SettingsOutlineButton(label: AppText.unblock, onTap: () => controller.unblockUser(user)),
        ],
      ),
    );
  }
}
