import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/profile/controllers/settings_controller.dart';
import 'package:brofile/features/profile/data/models/profile_models.dart';
import 'package:brofile/features/profile/presentation/widgets/settings_sub_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HiddenCommunitiesScreen extends GetView<SettingsController> {
  const HiddenCommunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSubScaffold(
      title: AppText.hiddenCommunities,
      child: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 32.w),
        children: [
          Obx(() {
            final items = controller.hiddenCommunities;
            if (items.isEmpty) return const SizedBox.shrink();
            return SettingsCard(
              children: [
                for (var i = 0; i < items.length; i++)
                  _HiddenRow(community: items[i], last: i == items.length - 1),
              ],
            );
          }),
          SizedBox(height: 40.w),
          const SettingsEndCap(caption: AppText.noMoreHiddenCommunities),
        ],
      ),
    );
  }
}

class _HiddenRow extends GetView<SettingsController> {
  const _HiddenRow({required this.community, required this.last});

  final HiddenCommunity community;
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
          ClipRRect(
            borderRadius: BorderRadius.circular(14.r),
            child: Image.asset(community.image, width: 52.w, height: 52.w, fit: BoxFit.cover),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(community.name, style: manrope(15, weight: FontWeight.w700, color: const Color(0xFF1A1A1A), lineHeight: 21)),
                Text(community.members, style: manrope(13, weight: FontWeight.w500, color: const Color(0xFF9A9A9A), lineHeight: 20)),
              ],
            ),
          ),
          SettingsOutlineButton(
            label: AppText.showAgain,
            onTap: () => controller.showCommunity(community),
          ),
        ],
      ),
    );
  }
}
