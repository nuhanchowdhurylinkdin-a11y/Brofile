import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BusinessEventDetailsView extends StatelessWidget {
  const BusinessEventDetailsView({super.key, required this.event});

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.asset(
            event.image,
            width: double.infinity,
            height: 219.w,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 28.w),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                event.title,
                style: manrope(16, weight: FontWeight.w700, lineHeight: 24),
              ),
            ),
            SizedBox(width: 16.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.w),
              decoration: BoxDecoration(
                color: AppColors.orangeLight,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                event.tag.isEmpty ? event.category : event.tag,
                style: manrope(12, weight: FontWeight.w500, color: AppColors.orange, lineHeight: 16),
              ),
            ),
          ],
        ),
        if (event.subtitle.isNotEmpty) ...[
          SizedBox(height: 4.w),
          Text(
            event.subtitle,
            style: manrope(14, weight: FontWeight.w600, color: AppColors.neutral600, lineHeight: 20),
          ),
        ],
        if (event.schedule.isNotEmpty || event.time.isNotEmpty) ...[
          SizedBox(height: 4.w),
          Text(
            event.schedule.isEmpty ? event.time : event.schedule,
            style: manrope(14, color: AppColors.neutral600, lineHeight: 20),
          ),
        ],
        SizedBox(height: 4.w),
        Text(
          event.location,
          style: manrope(14, color: AppColors.neutral600, lineHeight: 20),
        ),
        if (event.capacity.isNotEmpty) ...[
          SizedBox(height: 4.w),
          Text(
            event.capacity,
            style: manrope(14, color: AppColors.neutral600, lineHeight: 20),
          ),
        ],
        if (event.price.isNotEmpty) ...[
          SizedBox(height: 16.w),
          Text(
            event.price,
            style: manrope(16, weight: FontWeight.w700, color: AppColors.orange, lineHeight: 24),
          ),
        ],
        if (event.about.isNotEmpty) ...[
          SizedBox(height: 24.w),
          Text(AppText.aboutThisEvent, style: manrope(16, weight: FontWeight.w700, lineHeight: 24)),
          SizedBox(height: 12.w),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Text(
              event.about,
              style: manrope(16, color: AppColors.neutral600, lineHeight: 24),
            ),
          ),
        ],
        if (event.achievements.isNotEmpty) ...[
          SizedBox(height: 24.w),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppText.whatYouWillAchieve,
                  style: manrope(16, weight: FontWeight.w700, lineHeight: 24),
                ),
                SizedBox(height: 12.w),
                for (final item in event.achievements)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
                    child: Row(
                      children: [
                        SvgPicture.asset(IconPath.bizReasonCheck, width: 20.w, height: 20.w),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            item,
                            style: manrope(14, color: AppColors.textGray800, lineHeight: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
        SizedBox(height: 24.w),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => event.isInterested.toggle(),
                child: Obx(() {
                  event.isInterested.value;
                  return Container(
                    height: 44.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: const Color(0x1FFFFFFF), width: 2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(IconPath.bizStar, width: 20.w, height: 20.w),
                        SizedBox(width: 6.w),
                        Text(
                          AppText.interested,
                          style: manrope(16, weight: FontWeight.w600, color: Colors.white, lineHeight: 24),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: GestureDetector(
                onTap: () => AppHelperFunctions.showSnackBar(AppText.comingSoon),
                behavior: HitTestBehavior.opaque,
                child: Center(
                  child: Text(
                    AppText.seeDetails,
                    style: manrope(14, weight: FontWeight.w600, color: AppColors.primary, lineHeight: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
