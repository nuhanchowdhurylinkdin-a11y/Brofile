import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/profile/controllers/profile_controller.dart';
import 'package:brofile/features/profile/data/models/profile_models.dart';
import 'package:brofile/features/profile/presentation/widgets/hobby_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProfileHobbiesBody extends GetView<ProfileController> {
  const ProfileHobbiesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              Container(
                width: 64.w,
                height: 64.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                ),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        ImagePath.avatarWilliam,
                        fit: BoxFit.cover,
                        width: 64.w,
                        height: 64.w,
                      ),
                    ),
                    Positioned(
                      right: -2.w,
                      bottom: -2.w,
                      child: Container(
                        width: 16.w,
                        height: 16.w,
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
              SizedBox(width: 20.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'William',
                    style: manrope(16, weight: FontWeight.w600, color: AppColors.primary, lineHeight: 24),
                  ),
                  SizedBox(height: 4.w),
                  Text(
                    '@William',
                    style: manrope(12, color: AppColors.neutral500, lineHeight: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 28.w),
        const _InterestSection(),
        SizedBox(height: 28.w),
        for (final collection in controller.collections) ...[
          HobbyCollectionView(collection: collection),
          SizedBox(height: 28.w),
        ],
      ],
    );
  }
}

class _InterestSection extends GetView<ProfileController> {
  const _InterestSection();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final expanded = controller.interestsExpanded.value;
      final all = ProfileController.interests;
      final visible = expanded ? all : all.take(6).toList();
      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    controller.publicLabel(AppText.myInterest),
                    style: manrope(18, weight: FontWeight.w700, lineHeight: 20),
                  ),
                ),
                GestureDetector(
                  onTap: controller.toggleInterests,
                  child: Text(
                    expanded ? AppText.back : AppText.seeAll,
                    style: manrope(12, color: AppColors.primary, lineHeight: 16),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.w),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Wrap(
              spacing: 12.w,
              runSpacing: 12.w,
              children: [
                for (final interest in visible) _InterestChip(interest: interest),
                if (expanded && !controller.isVisitor.value)
                  GestureDetector(
                    onTap: controller.addBusiness,
                    child: const _InterestChip(
                      interest: ProfileInterest(
                        label: AppText.more,
                        icon: IconPath.addSquare,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

class _InterestChip extends StatelessWidget {
  const _InterestChip({required this.interest});

  final ProfileInterest interest;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 124.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
      decoration: BoxDecoration(
        color: AppColors.neutral200,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            interest.icon,
            width: 18.w,
            height: 18.w,
          ),
          SizedBox(width: 4.w),
          Flexible(
            child: Text(
              interest.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: manrope(12, weight: FontWeight.w500, color: const Color(0xFF181D27), lineHeight: 16),
            ),
          ),
        ],
      ),
    );
  }
}
