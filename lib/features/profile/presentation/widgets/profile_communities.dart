import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/features/community/controllers/community_controller.dart';
import 'package:brofile/features/community/presentation/widgets/community_cards.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileCommunitiesBody extends GetView<ProfileController> {
  const ProfileCommunitiesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final community = Get.find<CommunityController>();
    return Obx(() {
      final items = controller.myCommunities;
      if (items.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.w),
          child: Text(
            AppText.noDiscoverResults,
            textAlign: TextAlign.center,
            style: manrope(14, color: AppColors.neutral500, lineHeight: 20),
          ),
        );
      }
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            for (var i = 0; i < items.length; i += 2) ...[
              if (i > 0) SizedBox(height: 12.w),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: MyCommunityCard(
                      community: items[i],
                      onTap: () => community.openCommunity(items[i]),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: i + 1 < items.length
                        ? MyCommunityCard(
                            community: items[i + 1],
                            onTap: () => community.openCommunity(items[i + 1]),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ],
          ],
        ),
      );
    });
  }
}
