import 'package:brofile/core/common/widgets/avatar_group.dart';
import 'package:brofile/core/utils/helpers/profile_navigation.dart';
import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/community/controllers/community_details_controller.dart';
import 'package:brofile/features/community/data/models/community_models.dart';
import 'package:brofile/features/community/presentation/widgets/community_cards.dart';
import 'package:brofile/features/community/presentation/widgets/community_media.dart';
import 'package:brofile/features/community/presentation/widgets/member_stats.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/home/presentation/widgets/post_card.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:brofile/features/profile/presentation/widgets/settings_sub_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CommunityDetailsScreen extends GetView<CommunityDetailsController> {
  const CommunityDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: Column(
          children: [
            PleasureSubHeader(title: '', onBack: Get.back, showClose: false),
            Expanded(
              child: Obx(() {
                final tab = controller.tab.value;
                return ListView(
                  padding: EdgeInsets.only(top: 8.w, bottom: 32.w),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: const _CommunityHero(),
                    ),
                    SizedBox(height: 16.w),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: const _ActionButtons(),
                    ),
                    SizedBox(height: 16.w),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: const _DetailsTabs(),
                    ),
                    SizedBox(height: 16.w),
                    if (tab == CommunityDetailsTab.posts)
                      const _PostsTab()
                    else
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: switch (tab) {
                          CommunityDetailsTab.members => const _MembersTab(),
                          CommunityDetailsTab.about => const _AboutTab(),
                          CommunityDetailsTab.settings => const _SettingsTab(),
                          CommunityDetailsTab.posts => const SizedBox.shrink(),
                        },
                      ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommunityHero extends GetView<CommunityDetailsController> {
  const _CommunityHero();

  @override
  Widget build(BuildContext context) {
    final community = controller.community;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.asset(community.image, width: double.infinity, height: 193.w, fit: BoxFit.cover),
        ),
        SizedBox(height: 16.w),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Wrap(
                spacing: 8.w,
                runSpacing: 6.w,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    community.name,
                    style: manrope(20, weight: FontWeight.w700, color: Colors.black, lineHeight: 24),
                  ),
                  if (community.owned)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.w),
                      decoration: BoxDecoration(
                        color: const Color(0x1A1570EF),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        AppText.owner,
                        style: manrope(12, color: const Color(0xFF2970FF), lineHeight: 16),
                      ),
                    ),
                ],
              ),
            ),
            AvatarGroup(images: community.memberAvatars, extra: community.extraMembers),
          ],
        ),
        SizedBox(height: 8.w),
        MemberStats(
          members: community.members,
          online: community.online,
          style: manrope(14, color: const Color(0xFF414651)),
        ),
        SizedBox(height: 8.w),
        CommunityTopicChip(community.topicChip),
        SizedBox(height: 12.w),
        Text(
          community.description,
          style: manrope(14, color: const Color(0xFF535862), lineHeight: 20),
        ),
      ],
    );
  }
}

class _ActionButtons extends GetView<CommunityDetailsController> {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _PillButton(
            label: AppText.createPost,
            icon: IconPath.profileCoverEdit,
            filled: true,
            onTap: controller.openCreatePost,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _PillButton(
            label: AppText.inviteMembers,
            icon: IconPath.profilePlus,
            filled: false,
            onTap: controller.openInvite,
          ),
        ),
      ],
    );
  }
}

class _PillButton extends StatelessWidget {
  const _PillButton({
    required this.label,
    required this.icon,
    required this.filled,
    required this.onTap,
  });

  final String label;
  final String icon;
  final bool filled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44.w,
        decoration: BoxDecoration(
          color: filled ? AppColors.primary : const Color(0xFFD5D7DA),
          borderRadius: BorderRadius.circular(20.r),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              width: 20.w,
              height: 20.w,
              colorFilter: ColorFilter.mode(
                filled ? Colors.white : const Color(0xFF414651),
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: manrope(
                16,
                weight: FontWeight.w600,
                color: filled ? Colors.white : const Color(0xFF414651),
                lineHeight: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailsTabs extends GetView<CommunityDetailsController> {
  const _DetailsTabs();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final current = controller.tab.value;
      return Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6))),
        ),
        child: Row(
          children: [
            _TabLink(AppText.postsTab, CommunityDetailsTab.posts, current),
            _TabLink(AppText.membersTitle, CommunityDetailsTab.members, current),
            _TabLink(AppText.aboutTab, CommunityDetailsTab.about, current),
            _TabLink(AppText.settingsTab, CommunityDetailsTab.settings, current),
          ],
        ),
      );
    });
  }
}

class _TabLink extends GetView<CommunityDetailsController> {
  const _TabLink(this.label, this.value, this.current);

  final String label;
  final CommunityDetailsTab value;
  final CommunityDetailsTab current;

  @override
  Widget build(BuildContext context) {
    final selected = value == current;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.selectTab(value),
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: 44.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: selected ? const Color(0xFF1B4332) : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            label,
            style: manrope(
              12,
              color: selected ? const Color(0xFF1B4332) : const Color(0xFF6B7280),
              lineHeight: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class _PostsTab extends GetView<CommunityDetailsController> {
  const _PostsTab();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final locals = controller.userPosts;
      return Column(
        children: [
          for (final post in locals) ...[
            _UserPostCard(post: post),
            SizedBox(height: 16.w),
          ],
          for (final post in controller.seedPosts) ...[
            PostCard(post: post),
            SizedBox(height: 16.w),
          ],
        ],
      );
    });
  }
}

class _UserPostCard extends StatelessWidget {
  const _UserPostCard({required this.post});

  final CommunityUserPost post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('William', style: manrope(16, weight: FontWeight.w700, color: AppColors.primary, lineHeight: 24)),
          SizedBox(height: 8.w),
          if (post.images.isNotEmpty) ...[
            if (post.images.length == 1)
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: SizedBox(
                  width: double.infinity,
                  height: 220.w,
                  child: CommunityMedia.image(post.images.first),
                ),
              )
            else
              Row(
                children: [
                  for (var i = 0; i < post.images.take(2).length; i++) ...[
                    if (i > 0) SizedBox(width: 12.w),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: SizedBox(
                          height: 180.w,
                          child: CommunityMedia.image(post.images[i]),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            SizedBox(height: 8.w),
          ],
          Text(post.text, style: manrope(14, color: AppColors.textGray800, lineHeight: 20)),
        ],
      ),
    );
  }
}

class _MembersTab extends GetView<CommunityDetailsController> {
  const _MembersTab();

  @override
  Widget build(BuildContext context) {
    final owner = controller.owner;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: SettingsSearchField(
                controller: controller.searchController,
                hint: AppText.search,
                onChanged: controller.onSearchChanged,
              ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: controller.comingSoon,
              child: Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(IconPath.filter, width: 20.w, height: 20.w),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.w),
        Text(AppText.owner, style: manrope(16, weight: FontWeight.w700, color: const Color(0xFF1A1A1A), lineHeight: 24)),
        SizedBox(height: 12.w),
        _MemberRow(member: owner, showFollow: false),
        SizedBox(height: 20.w),
        Row(
          children: [
            Expanded(
              child: Text(AppText.membersTitle, style: manrope(16, weight: FontWeight.w700, color: const Color(0xFF1A1A1A), lineHeight: 24)),
            ),
            GestureDetector(
              onTap: controller.comingSoon,
              child: Text(AppText.seeAll, style: manrope(14, color: AppColors.primary, lineHeight: 20)),
            ),
          ],
        ),
        SizedBox(height: 12.w),
        Obx(() {
          final members = controller.visibleMembers;
          return Column(
            children: [
              for (final member in members) _MemberRow(member: member),
            ],
          );
        }),
      ],
    );
  }
}

class _MemberRow extends GetView<CommunityDetailsController> {
  const _MemberRow({required this.member, this.showFollow = true});

  final CommunityMember member;
  final bool showFollow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => ProfileNavigation.open(member.name),
            child: Stack(
            clipBehavior: Clip.none,
            children: [
              ClipOval(
                child: Image.asset(member.image, width: 48.w, height: 48.w, fit: BoxFit.cover),
              ),
              if (member.isOnline)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      color: AppColors.online,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                ),
            ],
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: GestureDetector(
              onTap: () => ProfileNavigation.open(member.name),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(member.name, style: manrope(15, weight: FontWeight.w700, color: AppColors.primary, lineHeight: 22)),
                  Text(member.handle, style: manrope(13, color: const Color(0xFF9A9A9A), lineHeight: 20)),
                ],
              ),
            ),
          ),
          if (showFollow)
            Obx(() {
              final following = member.isFollowing.value;
              return GestureDetector(
                onTap: () => controller.toggleFollow(member),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: AppColors.followBlue),
                  ),
                  child: Text(
                    following ? AppText.following : AppText.follow,
                    style: manrope(13, weight: FontWeight.w700, color: AppColors.followBlue, lineHeight: 20),
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}

class _AboutTab extends GetView<CommunityDetailsController> {
  const _AboutTab();

  @override
  Widget build(BuildContext context) {
    final community = controller.community;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppText.aboutThisCommunity, style: manrope(16, weight: FontWeight.w700, color: const Color(0xFF252B37), lineHeight: 24)),
              SizedBox(height: 8.w),
              Text(
                community.about.isEmpty ? community.description : community.about,
                style: manrope(14, color: const Color(0xFF535862), lineHeight: 20),
              ),
              SizedBox(height: 12.w),
              _AboutMeta(IconPath.profileCalendar, community.createdOn.isEmpty ? AppText.createdOnCommunity : community.createdOn),
              SizedBox(height: 8.w),
              _AboutMeta(IconPath.aboutGlobe, community.visibilityLabel.isEmpty ? AppText.publicCommunity : community.visibilityLabel),
              SizedBox(height: 8.w),
              _AboutMeta(IconPath.profileUsers, community.joinPolicy.isEmpty ? AppText.anyoneCanJoin : community.joinPolicy),
              SizedBox(height: 8.w),
              _AboutMeta(IconPath.profileHobbies, community.topicChip),
            ],
          ),
        ),
        SizedBox(height: 12.w),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppText.communityHighlights, style: manrope(16, weight: FontWeight.w700, color: const Color(0xFF252B37), lineHeight: 24)),
              SizedBox(height: 16.w),
              Row(
                children: [
                  _Highlight(community.highlightPosts, AppText.highlightsPost),
                  _divider(),
                  _Highlight(community.highlightFollowers, AppText.followers),
                  _divider(),
                  _Highlight(community.highlightFollowing, AppText.following),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20.w),
        Row(
          children: [
            Expanded(
              child: Text(AppText.recentActivity, style: manrope(16, weight: FontWeight.w700, color: const Color(0xFF1A1A1A), lineHeight: 24)),
            ),
            GestureDetector(
              onTap: controller.comingSoon,
              child: Text(AppText.seeAll, style: manrope(14, color: AppColors.primary, lineHeight: 20)),
            ),
          ],
        ),
        SizedBox(height: 12.w),
        for (final activity in controller.activities) _ActivityRow(activity: activity),
      ],
    );
  }

  Widget _divider() {
    return Container(width: 1, height: 32.w, color: const Color(0xFFE9EAEB));
  }
}

class _AboutMeta extends StatelessWidget {
  const _AboutMeta(this.icon, this.label);

  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon, width: 18.w, height: 18.w),
        SizedBox(width: 8.w),
        Expanded(child: Text(label, style: manrope(14, color: const Color(0xFF535862), lineHeight: 20))),
      ],
    );
  }
}

class _Highlight extends StatelessWidget {
  const _Highlight(this.value, this.label);

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: manrope(16, weight: FontWeight.w700, color: const Color(0xFF1A1A1A), lineHeight: 24)),
          Text(label, style: manrope(12, color: const Color(0xFF717680), lineHeight: 16)),
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({required this.activity});

  final CommunityActivity activity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.w),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipOval(
                child: Image.asset(activity.image, width: 40.w, height: 40.w, fit: BoxFit.cover),
              ),
              if (activity.isOnline)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: BoxDecoration(
                      color: AppColors.online,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: activity.name,
                        style: manrope(14, weight: FontWeight.w700, color: AppColors.primary, lineHeight: 20),
                      ),
                      TextSpan(
                        text: ' ${activity.action}',
                        style: manrope(14, color: const Color(0xFF535862), lineHeight: 20),
                      ),
                    ],
                  ),
                ),
                Text(activity.timeAgo, style: manrope(12, color: const Color(0xFFA0A0A0), lineHeight: 18)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTab extends GetView<CommunityDetailsController> {
  const _SettingsTab();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _SettingsGroup(
          title: AppText.manageCommunity,
          rows: [
            _SettingsItem(icon: IconPath.profileCoverEdit, label: AppText.editCommunityInfo, onTap: controller.comingSoon),
            _SettingsItem(icon: IconPath.profileSettings, label: AppText.editCommunitySettings, onTap: controller.comingSoon),
          ],
        ),
        SizedBox(height: 12.w),
        _SettingsGroup(
          title: AppText.privacyGroup,
          rows: [
            _SettingsItem(icon: IconPath.profileLock, label: AppText.privacySettings, onTap: controller.comingSoon),
            _SettingsItem(icon: IconPath.whoCanPost, label: AppText.whoCanPost, onTap: controller.comingSoon),
          ],
        ),
        SizedBox(height: 24.w),
        GestureDetector(
          onTap: controller.deleteCommunity,
          child: Container(
            height: 44.w,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: const Color(0xFFD92D20)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  IconPath.trash,
                  width: 20.w,
                  height: 20.w,
                  colorFilter: const ColorFilter.mode(Color(0xFFD92D20), BlendMode.srcIn),
                ),
                SizedBox(width: 6.w),
                Text(
                  AppText.deleteCommunity,
                  style: manrope(16, weight: FontWeight.w600, color: const Color(0xFFD92D20), lineHeight: 24),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.title, required this.rows});

  final String title;
  final List<_SettingsItem> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: manrope(16, weight: FontWeight.w700, color: const Color(0xFF252B37), lineHeight: 24)),
          SizedBox(height: 12.w),
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) SizedBox(height: 12.w),
            rows[i],
          ],
        ],
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  const _SettingsItem({required this.icon, required this.label, required this.onTap});

  final String icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          SvgPicture.asset(icon, width: 20.w, height: 20.w),
          SizedBox(width: 8.w),
          Expanded(child: Text(label, style: manrope(14, color: const Color(0xFF414651), lineHeight: 20))),
          RotatedBox(
            quarterTurns: 3,
            child: SvgPicture.asset(IconPath.profileChevronRight, width: 20.w, height: 20.w),
          ),
        ],
      ),
    );
  }
}
