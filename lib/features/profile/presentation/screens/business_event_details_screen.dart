import 'package:brofile/core/common/widgets/hide_on_scroll.dart';
import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:brofile/features/profile/presentation/widgets/business_event_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BusinessEventDetailsScreen extends StatelessWidget {
  const BusinessEventDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final event = Get.arguments as EventModel;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: HideOnScroll(
          header: PleasureSubHeader(title: AppText.eventDetails, onBack: Get.back),
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 32.w),
            child: BusinessEventDetailsView(event: event),
          ),
        ),
      ),
    );
  }
}
