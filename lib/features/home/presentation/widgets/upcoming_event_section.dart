import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UpcomingEventSection extends GetView<HomeController> {
  const UpcomingEventSection({super.key});

  @override
  Widget build(BuildContext context) {
    final event = controller.event;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          HomeSectionHeader(
            title: AppText.upcomingEvents,
            onSeeAll: () => controller.openSeeAll(AppText.upcomingEvents),
          ),
          SizedBox(height: 16.w),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.asset(event.image, width: 160.w, fit: BoxFit.cover),
                      ),
                      SizedBox(width: 8.w),
                      Expanded(child: _EventInfo(event: event)),
                    ],
                  ),
                ),
                SizedBox(height: 12.w),
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => _InterestedButton(
                          isInterested: event.isInterested.value,
                          onTap: () => controller.toggleInterested(event),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.openDetails(event.title),
                        behavior: HitTestBehavior.opaque,
                        child: SizedBox(
                          height: 36.w,
                          child: Center(
                            child: Text(
                              AppText.seeDetails,
                              style: manrope(
                                14,
                                weight: FontWeight.w600,
                                color: AppColors.primary,
                                lineHeight: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EventInfo extends StatelessWidget {
  const _EventInfo({required this.event});

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 8.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _DateBadge(day: event.day, month: event.month),
              const Spacer(),
              _Attendees(images: event.attendees, extra: event.extraAttendees),
            ],
          ),
          SizedBox(height: 8.w),
          Text(
            event.title,
            style: manrope(14, weight: FontWeight.w700, lineHeight: 20),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.w),
          _IconLine(icon: IconPath.clock, text: event.time),
          SizedBox(height: 8.w),
          _IconLine(icon: IconPath.locationGray, text: event.location),
        ],
      ),
    );
  }
}

class _DateBadge extends StatelessWidget {
  const _DateBadge({required this.day, required this.month});

  final String day;
  final String month;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8.w, 8.w, 8.w, 5.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(8.r)),
        boxShadow: const [
          BoxShadow(color: Color(0x0A000000), offset: Offset(0, 4), blurRadius: 4),
        ],
      ),
      child: Column(
        children: [
          TrimmedText(
            day,
            style: manrope(20, weight: FontWeight.w700, color: AppColors.primary),
          ),
          SizedBox(height: 4.w),
          Text(
            month,
            style: manrope(
              16,
              weight: FontWeight.w600,
              color: AppColors.primary,
              lineHeight: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class _Attendees extends StatelessWidget {
  const _Attendees({required this.images, required this.extra});

  final List<String> images;
  final int extra;

  @override
  Widget build(BuildContext context) {
    final size = 24.w;
    final step = size - 4.w;
    final count = images.length + 1;

    Widget ring(Widget child, {Color? color}) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(color: Colors.white, width: 1.5),
        ),
        child: ClipOval(child: child),
      );
    }

    return SizedBox(
      width: step * (count - 1) + size,
      height: size,
      child: Stack(
        children: [
          for (var i = 0; i < images.length; i++)
            Positioned(
              left: step * i,
              child: ring(Image.asset(images[i], fit: BoxFit.cover)),
            ),
          Positioned(
            left: step * images.length,
            child: ring(
              Center(
                child: Text(
                  '+$extra',
                  style: manrope(
                    12,
                    weight: FontWeight.w600,
                    color: AppColors.neutral500,
                    lineHeight: 18,
                  ),
                ),
              ),
              color: AppColors.neutral100,
            ),
          ),
        ],
      ),
    );
  }
}

class _IconLine extends StatelessWidget {
  const _IconLine({required this.icon, required this.text});

  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon, width: 18.w, height: 18.w),
        SizedBox(width: 8.w),
        Expanded(
          child: TrimmedText(text, style: manrope(12, color: AppColors.neutral500)),
        ),
      ],
    );
  }
}

class _InterestedButton extends StatelessWidget {
  const _InterestedButton({required this.isInterested, required this.onTap});

  final bool isInterested;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = isInterested ? AppColors.primary : Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 36.w,
        decoration: BoxDecoration(
          color: isInterested ? Colors.white : AppColors.primary,
          border: Border.all(color: AppColors.primary),
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isInterested
                ? Icon(Icons.star_rounded, color: AppColors.primary, size: 22.w)
                : SvgPicture.asset(IconPath.star, width: 20.w, height: 20.w),
            SizedBox(width: 6.w),
            Text(
              AppText.interested,
              style: manrope(14, weight: FontWeight.w600, color: foreground, lineHeight: 20),
            ),
          ],
        ),
      ),
    );
  }
}
