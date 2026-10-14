import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:brofile/features/profile/data/models/profile_models.dart';
import 'package:brofile/features/profile/presentation/widgets/business_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class BusinessCatalogDetailsScreen extends StatelessWidget {
  const BusinessCatalogDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final details = Get.arguments as BusinessCatalogDetails;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: Column(
          children: [
            PleasureSubHeader(title: details.header, onBack: Get.back),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 32.w),
                child: BusinessCatalogDetailsView(details: details),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BusinessCatalogDetailsView extends StatelessWidget {
  const BusinessCatalogDetailsView({super.key, required this.details});

  final BusinessCatalogDetails details;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.asset(
            details.image,
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
                details.name,
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
                details.tag,
                style: manrope(12, weight: FontWeight.w500, color: AppColors.orange, lineHeight: 16),
              ),
            ),
          ],
        ),
        if (details.subtitle.isNotEmpty) ...[
          SizedBox(height: 4.w),
          Text(
            details.subtitle,
            style: manrope(14, weight: FontWeight.w600, color: AppColors.neutral600, lineHeight: 20),
          ),
        ],
        SizedBox(height: 16.w),
        Text(
          details.price,
          style: manrope(16, weight: FontWeight.w700, color: AppColors.orange, lineHeight: 24),
        ),
        if (details.stock != null) ...[
          SizedBox(height: 8.w),
          Row(
            children: [
              SvgPicture.asset(IconPath.bizCheck, width: 16.w, height: 16.w),
              SizedBox(width: 12.w),
              Text(
                details.stock!,
                style: manrope(16, color: AppColors.gray900, lineHeight: 24),
              ),
            ],
          ),
        ],
        SizedBox(height: 24.w),
        Text(
          details.sectionTitle,
          style: manrope(16, weight: FontWeight.w700, lineHeight: 24),
        ),
        SizedBox(height: 12.w),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Text(
            details.body,
            style: manrope(16, color: AppColors.neutral600, lineHeight: 24),
          ),
        ),
        if (details.info.isNotEmpty) ...[
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
                  AppText.information,
                  style: manrope(16, weight: FontWeight.w700, lineHeight: 24),
                ),
                SizedBox(height: 12.w),
                for (var i = 0; i < details.info.length; i++)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.w),
                    decoration: BoxDecoration(
                      border: i == details.info.length - 1
                          ? null
                          : const Border(bottom: BorderSide(color: AppColors.neutral300)),
                    ),
                    child: Row(
                      children: [
                        Text(
                          details.info[i].label,
                          style: manrope(14, weight: FontWeight.w600, lineHeight: 20),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            details.info[i].value,
                            textAlign: TextAlign.right,
                            style: manrope(
                              14,
                              weight: FontWeight.w500,
                              color: AppColors.neutral500,
                              lineHeight: 20,
                            ),
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
        BusinessSaveButton(
          label: details.cta,
          onTap: () => AppHelperFunctions.showSnackBar(AppText.comingSoon),
        ),
      ],
    );
  }
}
