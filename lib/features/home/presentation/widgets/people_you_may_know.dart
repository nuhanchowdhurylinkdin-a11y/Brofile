import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PeopleYouMayKnow extends GetView<HomeController> {
  const PeopleYouMayKnow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: const HomeSectionHeader(title: AppText.peopleYouMayKnow),
        ),
        SizedBox(height: 16.w),
        SizedBox(
          height: 187.w,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: controller.people.length,
            separatorBuilder: (_, _) => SizedBox(width: 4.w),
            itemBuilder: (_, index) {
              final person = controller.people[index];
              return _PersonCard(
                person: person,
                onTap: () => controller.openProfile(person.name),
                onFollow: () => controller.toggleFollow(person),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PersonCard extends StatelessWidget {
  const _PersonCard({
    required this.person,
    required this.onTap,
    required this.onFollow,
  });

  final SuggestedPerson person;
  final VoidCallback onTap;
  final VoidCallback onFollow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 118.w,
        padding: EdgeInsets.all(8.w),
        child: Column(
          children: [
            ClipOval(
              child: Container(
                width: 80.w,
                height: 80.w,
                color: AppColors.avatarNeutral,
                child: Image.asset(person.image, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 8.w),
            Text(
              person.name,
              style: manrope(14, weight: FontWeight.w700, lineHeight: 20),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.w),
            TrimmedText(
              '${person.mutualFriends} ${AppText.mutualFriends}',
              style: manrope(12, color: AppColors.neutral500),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.w),
            Obx(() => _FollowButton(isFollowing: person.isFollowing.value, onTap: onFollow)),
          ],
        ),
      ),
    );
  }
}

class _FollowButton extends StatelessWidget {
  const _FollowButton({required this.isFollowing, required this.onTap});

  final bool isFollowing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        height: 34.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isFollowing ? AppColors.followBlue : Colors.white,
          border: Border.all(
            color: isFollowing ? AppColors.followBlue : AppColors.neutral200,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          isFollowing ? AppText.following : AppText.follow,
          style: manrope(
            12,
            weight: FontWeight.w700,
            color: isFollowing ? Colors.white : AppColors.followBlue,
            lineHeight: 18,
          ),
        ),
      ),
    );
  }
}
