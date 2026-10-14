import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/profile/controllers/business_profile_controller.dart';
import 'package:brofile/features/profile/data/models/profile_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BusinessProfileAbout extends GetView<BusinessProfileController> {
  const BusinessProfileAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppText.ourStory,
            style: manrope(16, weight: FontWeight.w700, lineHeight: 24),
          ),
          SizedBox(height: 12.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Obx(
              () => Text(
                controller.storyText.value,
                style: manrope(16, color: AppColors.neutral600, lineHeight: 24),
              ),
            ),
          ),
          SizedBox(height: 16.w),
          Obx(
            () => _SectionCard(
              title: AppText.whatWeOffer,
              children: [
                for (var i = 0; i < controller.offers.length; i++)
                  _OfferRow(
                    offer: controller.offers[i],
                    showDivider: i < controller.offers.length - 1,
                  ),
              ],
            ),
          ),
          SizedBox(height: 16.w),
          Obx(
            () => _SectionCard(
              title: AppText.whyChooseUs,
              children: [
                for (final reason in controller.reasons)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.w),
                    child: Row(
                      children: [
                        SvgPicture.asset(IconPath.bizCheck, width: 20.w, height: 20.w),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(reason, style: manrope(14, lineHeight: 20)),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 16.w),
          _SectionCard(
            title: AppText.meetOurInstructors,
            children: [
              for (var i = 0; i < controller.instructors.length; i++)
                _InstructorRow(
                  instructor: controller.instructors[i],
                  showDivider: i < controller.instructors.length - 1,
                ),
            ],
          ),
          SizedBox(height: 16.w),
          _SectionCard(
            title: AppText.businessHours,
            children: [
              for (var i = 0; i < controller.hours.length; i++)
                _InfoRow(
                  label: controller.hours[i].days,
                  value: controller.hours[i].hours,
                  labelWeight: FontWeight.w400,
                  showDivider: i < controller.hours.length - 1,
                ),
            ],
          ),
          SizedBox(height: 16.w),
          _SectionCard(
            title: AppText.connectWithUs,
            children: [
              for (var i = 0; i < controller.socials.length; i++)
                _IconLabelRow(
                  item: controller.socials[i],
                  showDivider: i < controller.socials.length - 1,
                ),
            ],
          ),
          SizedBox(height: 16.w),
          _SectionCard(
            title: AppText.businessInfo,
            children: [
              for (var i = 0; i < controller.infoRows.length; i++)
                _InfoRow(
                  label: controller.infoRows[i].label,
                  value: controller.infoRows[i].value,
                  showDivider: i < controller.infoRows.length - 1,
                ),
            ],
          ),
          SizedBox(height: 16.w),
          _SectionCard(
            title: AppText.contactUsTitle,
            children: [
              for (var i = 0; i < controller.contacts.length; i++)
                _IconLabelRow(
                  item: controller.contacts[i],
                  bold: true,
                  showDivider: i < controller.contacts.length - 1,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: manrope(16, weight: FontWeight.w700, lineHeight: 24)),
          SizedBox(height: 12.w),
          ...children,
        ],
      ),
    );
  }
}

class _OfferRow extends StatelessWidget {
  const _OfferRow({required this.offer, required this.showDivider});

  final BusinessOffer offer;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(bottom: BorderSide(color: AppColors.neutral300))
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(offer.title, style: manrope(14, lineHeight: 20)),
          SizedBox(height: 8.w),
          Text(offer.subtitle, style: manrope(12, color: AppColors.neutral600, lineHeight: 16)),
        ],
      ),
    );
  }
}

class _InstructorRow extends StatelessWidget {
  const _InstructorRow({required this.instructor, required this.showDivider});

  final BusinessInstructor instructor;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(bottom: BorderSide(color: AppColors.neutral300))
            : null,
      ),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(instructor.image, width: 60.w, height: 60.w, fit: BoxFit.cover),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(instructor.name, style: manrope(14, weight: FontWeight.w600, lineHeight: 20)),
                SizedBox(height: 4.w),
                Text(
                  instructor.role,
                  style: manrope(12, weight: FontWeight.w500, color: AppColors.primary, lineHeight: 16),
                ),
                SizedBox(height: 8.w),
                Text(
                  instructor.bio,
                  style: manrope(12, color: AppColors.neutral600, lineHeight: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    required this.showDivider,
    this.labelWeight = FontWeight.w600,
  });

  final String label;
  final String value;
  final bool showDivider;
  final FontWeight labelWeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(bottom: BorderSide(color: AppColors.neutral300))
            : null,
      ),
      child: Row(
        children: [
          Expanded(child: Text(label, style: manrope(14, weight: labelWeight, lineHeight: 20))),
          Text(
            value,
            style: manrope(14, weight: FontWeight.w500, color: AppColors.neutral500, lineHeight: 20),
          ),
        ],
      ),
    );
  }
}

class _IconLabelRow extends StatelessWidget {
  const _IconLabelRow({
    required this.item,
    required this.showDivider,
    this.bold = false,
  });

  final BusinessLink item;
  final bool showDivider;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(bottom: BorderSide(color: AppColors.neutral300))
            : null,
      ),
      child: Row(
        children: [
          SvgPicture.asset(item.icon, width: bold ? 18.w : 24.w, height: bold ? 18.w : 24.w),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              item.label,
              style: manrope(14, weight: bold ? FontWeight.w600 : FontWeight.w400, lineHeight: 20),
            ),
          ),
        ],
      ),
    );
  }
}
