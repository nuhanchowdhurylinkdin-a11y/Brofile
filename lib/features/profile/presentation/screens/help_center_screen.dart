import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/profile/controllers/settings_controller.dart';
import 'package:brofile/features/profile/presentation/widgets/settings_sub_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HelpCenterScreen extends GetView<SettingsController> {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSubScaffold(
      title: AppText.helpCenter,
      child: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 32.w),
        children: [
          SettingsSearchField(
            controller: controller.helpSearchController,
            hint: AppText.searchHelpArticles,
            onChanged: (value) => controller.helpQuery.value = value,
          ),
          SizedBox(height: 20.w),
          Text(
            AppText.frequentlyAskedQuestions,
            style: manrope(15, weight: FontWeight.w700, color: const Color(0xFF1A1A1A), lineHeight: 22),
          ),
          SizedBox(height: 12.w),
          Obx(() {
            final items = controller.filteredFaqs;
            if (items.isEmpty) return const SizedBox.shrink();
            return SettingsCard(
              children: [
                for (var i = 0; i < items.length; i++)
                  _FaqRow(
                    index: i,
                    question: items[i].question,
                    answer: items[i].answer,
                    last: i == items.length - 1,
                  ),
              ],
            );
          }),
          SizedBox(height: 20.w),
          GestureDetector(
            onTap: controller.openContactUs,
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF4EE),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    IconPath.profileContactUs,
                    width: 26.w,
                    height: 26.w,
                    colorFilter: const ColorFilter.mode(Color(0xFF1F5C1F), BlendMode.srcIn),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppText.stillNeedHelp, style: manrope(14, weight: FontWeight.w700, color: const Color(0xFF1A1A1A), lineHeight: 21)),
                        Text(AppText.contactSupportTeam, style: manrope(12, weight: FontWeight.w500, color: const Color(0xFF7A7A7A), lineHeight: 18)),
                      ],
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 3,
                    child: SvgPicture.asset(IconPath.profileChevronRight, width: 18.w, height: 18.w),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FaqRow extends GetView<SettingsController> {
  const _FaqRow({
    required this.index,
    required this.question,
    required this.answer,
    required this.last,
  });

  final int index;
  final String question;
  final String answer;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final open = controller.expandedFaq.value == index;
      return GestureDetector(
        onTap: () => controller.toggleFaq(index),
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            border: last ? null : const Border(bottom: BorderSide(color: Color(0xFFF0F0F0))),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      question,
                      style: manrope(14, weight: FontWeight.w600, color: const Color(0xFF1A1A1A), lineHeight: 19),
                    ),
                  ),
                  Transform.rotate(
                    angle: open ? 3.14159 : 0,
                    child: SvgPicture.asset(IconPath.chevronDown, width: 18.w, height: 18.w),
                  ),
                ],
              ),
              if (open) ...[
                SizedBox(height: 8.w),
                Text(
                  answer,
                  style: manrope(13, color: const Color(0xFF5A5A5A), lineHeight: 20),
                ),
              ],
            ],
          ),
        ),
      );
    });
  }
}
