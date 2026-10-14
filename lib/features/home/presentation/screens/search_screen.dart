import 'package:brofile/core/common/widgets/search_filter_bar.dart';
import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/home/controllers/home_search_controller.dart';
import 'package:brofile/features/home/data/models/inbox_models.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SearchScreen extends GetView<HomeSearchController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: Column(
          children: [
            PleasureSubHeader(title: AppText.search, onBack: Get.back),
            SearchFilterBar(
              controller: controller.textController,
              focusNode: controller.focusNode,
              onChanged: controller.onQuery,
              onFilter: controller.openFilter,
            ),
            Expanded(
              child: Obx(() {
                controller.query.value;
                controller.focused.value;
                if (controller.showSuggestions) {
                  return _SuggestionList(hits: controller.hits);
                }
                return const _IdleSearch();
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _IdleSearch extends GetView<HomeSearchController> {
  const _IdleSearch();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(16.w, 28.w, 16.w, 32.w),
      children: [
        Text(
          AppText.recentSearch,
          style: manrope(16, weight: FontWeight.w700, lineHeight: 24),
        ),
        SizedBox(height: 12.w),
        ...HomeSearchController.recents.map(
          (term) => _RecentRow(label: term, onTap: () => controller.apply(term)),
        ),
        SizedBox(height: 16.w),
        Text(
          AppText.searchBy,
          style: manrope(16, weight: FontWeight.w700, lineHeight: 24),
        ),
        SizedBox(height: 12.w),
        ...HomeSearchController.tags.map(
          (tag) => _TagRow(label: tag, onTap: () => controller.apply(tag)),
        ),
      ],
    );
  }
}

class _SuggestionList extends GetView<HomeSearchController> {
  const _SuggestionList({required this.hits});

  final List<SearchHit> hits;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(16.w, 28.w, 16.w, 32.w),
      itemCount: hits.length,
      separatorBuilder: (_, _) => SizedBox(height: 12.w),
      itemBuilder: (_, index) {
        final hit = hits[index];
        return GestureDetector(
          onTap: () {
            if (hit.avatar != null) {
              controller.openPerson(hit.label);
            } else {
              controller.apply(hit.label);
            }
          },
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              if (hit.avatar != null) ...[
                ClipOval(
                  child: Image.asset(hit.avatar!, width: 20.w, height: 20.w, fit: BoxFit.cover),
                ),
                SizedBox(width: 4.w),
              ],
              Text(
                hit.label,
                style: manrope(12, color: AppColors.neutral700, lineHeight: 16),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RecentRow extends StatelessWidget {
  const _RecentRow({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.w),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Row(
          children: [
            SvgPicture.asset(IconPath.clock, width: 20.w, height: 20.w),
            SizedBox(width: 8.w),
            Text(label, style: manrope(14, color: AppColors.neutral500, lineHeight: 20)),
          ],
        ),
      ),
    );
  }
}

class _TagRow extends StatelessWidget {
  const _TagRow({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.w),
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Text(label, style: manrope(14, color: AppColors.neutral500, lineHeight: 20)),
      ),
    );
  }
}
