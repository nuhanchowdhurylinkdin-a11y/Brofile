import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:brofile/features/profile/controllers/create_business_service_controller.dart';
import 'package:brofile/features/profile/presentation/widgets/business_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateBusinessServiceScreen extends StatelessWidget {
  const CreateBusinessServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: Column(
          children: [
            PleasureSubHeader(title: AppText.createNewService, onBack: Get.back),
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 32.w),
                child: const CreateBusinessServiceForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreateBusinessServiceForm extends GetView<CreateBusinessServiceController> {
  const CreateBusinessServiceForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BusinessAddPhoto(path: controller.photoPath, onTap: controller.pickPhoto),
        SizedBox(height: 28.w),
        Text(
          AppText.basicInformation,
          style: manrope(18, weight: FontWeight.w500, color: AppColors.neutral600, lineHeight: 28),
        ),
        SizedBox(height: 16.w),
        BusinessLabeledField(
          label: AppText.serviceName,
          child: BusinessInputBox(
            controller: controller.nameController,
            hint: AppText.enterProductName,
          ),
        ),
        SizedBox(height: 16.w),
        Row(
          children: [
            Expanded(
              child: BusinessLabeledField(
                label: AppText.category,
                child: Obx(
                  () => BusinessSelectBox(
                    value: controller.category.value,
                    onTap: controller.pickCategory,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: BusinessLabeledField(
                label: AppText.subCategory,
                child: Obx(
                  () => BusinessSelectBox(
                    value: controller.subcategory.value,
                    onTap: controller.pickSubcategory,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.w),
        BusinessLabeledField(
          label: AppText.feeCharge,
          child: BusinessInputBox(controller: controller.priceController),
        ),
        SizedBox(height: 24.w),
        BusinessLabeledField(
          label: AppText.shortDescription,
          child: BusinessCounterBox(
            controller: controller.shortController,
            counter: controller.shortLength,
            maxLength: CreateBusinessServiceController.maxShort,
            hint: AppText.shortDescriptionHint,
          ),
        ),
        SizedBox(height: 24.w),
        BusinessLabeledField(
          label: AppText.fullDescription,
          child: BusinessCounterBox(
            controller: controller.detailsController,
            counter: controller.detailsLength,
            maxLength: CreateBusinessServiceController.maxFull,
            hint: AppText.serviceFullDescriptionHint,
            minHeight: 175,
          ),
        ),
        SizedBox(height: 24.w),
        Obx(() {
          final rows = controller.infoRows.toList();
          return BusinessPairRows(
            title: AppText.information,
            rows: rows,
            onRemove: controller.removeInfo,
          );
        }),
        SizedBox(height: 24.w),
        BusinessSaveButton(label: AppText.save, onTap: controller.save, width: 118),
      ],
    );
  }
}
