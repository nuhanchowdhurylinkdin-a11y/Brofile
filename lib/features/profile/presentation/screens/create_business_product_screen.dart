import 'package:brofile/core/common/widgets/hide_on_scroll.dart';
import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:brofile/features/profile/controllers/create_business_product_controller.dart';
import 'package:brofile/features/profile/presentation/widgets/business_form_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CreateBusinessProductScreen extends StatelessWidget {
  const CreateBusinessProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: HideOnScroll(
          header: PleasureSubHeader(title: AppText.createNewProduct, onBack: Get.back),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 32.w),
            child: const CreateBusinessProductForm(),
          ),
        ),
      ),
    );
  }
}

class CreateBusinessProductForm extends GetView<CreateBusinessProductController> {
  const CreateBusinessProductForm({super.key});

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
          label: AppText.productName,
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
          label: AppText.price,
          child: BusinessInputBox(controller: controller.priceController),
        ),
        SizedBox(height: 24.w),
        BusinessLabeledField(
          label: AppText.shortDescription,
          child: BusinessCounterBox(
            controller: controller.shortController,
            counter: controller.shortLength,
            maxLength: CreateBusinessProductController.maxShort,
            hint: AppText.shortDescriptionHint,
          ),
        ),
        SizedBox(height: 24.w),
        BusinessLabeledField(
          label: AppText.fullDescription,
          child: BusinessCounterBox(
            controller: controller.detailsController,
            counter: controller.detailsLength,
            maxLength: CreateBusinessProductController.maxFull,
            minHeight: 140,
          ),
        ),
        SizedBox(height: 24.w),
        const _StockStatus(),
        SizedBox(height: 24.w),
        BusinessSaveButton(label: AppText.save, onTap: controller.save, width: 118),
      ],
    );
  }
}

class _StockStatus extends GetView<CreateBusinessProductController> {
  const _StockStatus();

  @override
  Widget build(BuildContext context) {
    return BusinessLabeledField(
      label: AppText.stockStatus,
      child: Obx(
        () => Row(
          children: [
            Expanded(
              child: _StockOption(
                label: AppText.inStock,
                selected: controller.inStock.value,
                onTap: () => controller.inStock.value = true,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _StockOption(
                label: AppText.outOfStock,
                selected: !controller.inStock.value,
                onTap: () => controller.inStock.value = false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StockOption extends StatelessWidget {
  const _StockOption({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.w,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.neutral300),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(label, style: manrope(16, color: AppColors.gray900, lineHeight: 24)),
            ),
            SvgPicture.asset(
              selected ? IconPath.bizCheck : IconPath.bizRadio,
              width: 16.w,
              height: 16.w,
            ),
          ],
        ),
      ),
    );
  }
}
