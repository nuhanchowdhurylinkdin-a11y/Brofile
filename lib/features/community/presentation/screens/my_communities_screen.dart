import 'package:brofile/core/common/widgets/hide_on_scroll.dart';
import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/community/controllers/community_controller.dart';
import 'package:brofile/features/community/data/models/community_models.dart';
import 'package:brofile/features/community/presentation/widgets/community_cards.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyCommunitiesScreen extends GetView<CommunityController> {
  const MyCommunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: HideOnScroll(
          header: PleasureSubHeader(title: AppText.myCommunities, onBack: Get.back),
          body: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 32.w),
                children: [
                  GestureDetector(
                    onTap: controller.openCreate,
                    child: Container(
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            IconPath.profilePlus,
                            width: 20.w,
                            height: 20.w,
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            AppText.createCommunity,
                            style: manrope(16, weight: FontWeight.w600, color: Colors.white, lineHeight: 24),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24.w),
                  Text(
                    AppText.ownedCommunities,
                    style: manrope(18, weight: FontWeight.w700, color: const Color(0xFF252B37), lineHeight: 20),
                  ),
                  SizedBox(height: 16.w),
                  Obx(() {
                    final owned = controller.profileOwned;
                    return Column(
                      children: [
                        for (var i = 0; i < owned.length; i++) ...[
                          if (i > 0) SizedBox(height: 12.w),
                          OwnedCommunityCard(
                            community: owned[i],
                            onTap: () => controller.openCommunity(owned[i]),
                          ),
                        ],
                      ],
                    );
                  }),
                  SizedBox(height: 24.w),
                  Text(
                    AppText.joinedCommunities,
                    style: manrope(18, weight: FontWeight.w700, color: const Color(0xFF252B37), lineHeight: 20),
                  ),
                  SizedBox(height: 16.w),
                  _JoinedGrid(communities: controller.profileJoined),
                ],
              ),
        ),
      ),
    );
  }
}

class _JoinedGrid extends GetView<CommunityController> {
  const _JoinedGrid({required this.communities});

  final List<CommunityItem> communities;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < communities.length; i += 2) ...[
          if (i > 0) SizedBox(height: 8.w),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: JoinedCommunityCard(
                  community: communities[i],
                  onTap: () => controller.openCommunity(communities[i]),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: i + 1 < communities.length
                    ? JoinedCommunityCard(
                        community: communities[i + 1],
                        onTap: () => controller.openCommunity(communities[i + 1]),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
