import 'package:brofile/core/common/widgets/hide_on_scroll.dart';
import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/features/community/presentation/widgets/community_media.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/pleasure/presentation/widgets/pleasure_sub_header.dart';
import 'package:brofile/features/profile/controllers/create_business_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CreateBusinessPostScreen extends GetView<CreateBusinessPostController> {
  const CreateBusinessPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: HideOnScroll(
          header: PleasureSubHeader(
            title: AppText.newBusinessPost,
            onBack: controller.onBack,
            onClose: Get.back,
          ),
          body: const CreateBusinessPostForm(),
        ),
      ),
    );
  }
}

class CreateBusinessPostForm extends GetView<CreateBusinessPostController> {
  const CreateBusinessPostForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.step.value) {
        case BusinessPostStep.gallery:
          return const _GalleryStep();
        case BusinessPostStep.caption:
          return const _CaptionStep();
        case BusinessPostStep.write:
          return const _WriteStep();
      }
    });
  }
}

class _AuthorRow extends GetView<CreateBusinessPostController> {
  const _AuthorRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            ClipOval(
              child: Image.asset(
                ImagePath.avatarWilliam,
                width: 56.w,
                height: 56.w,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              right: -1.w,
              bottom: -1.w,
              child: Container(
                width: 14.w,
                height: 14.w,
                decoration: BoxDecoration(
                  color: AppColors.online,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'William',
                style: manrope(16, weight: FontWeight.w700, color: AppColors.primary, lineHeight: 24),
              ),
              SizedBox(height: 4.w),
              Text('@William', style: manrope(12, color: AppColors.neutral500, lineHeight: 16)),
            ],
          ),
        ),
        GestureDetector(
          onTap: controller.openGallery,
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.neutral200),
            ),
            child: SvgPicture.asset(IconPath.addPhotoCamera, width: 20.w, height: 20.w),
          ),
        ),
      ],
    );
  }
}

class _PrimaryButton extends GetView<CreateBusinessPostController> {
  const _PrimaryButton();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: controller.onPrimaryAction,
        child: Container(
          height: 44.w,
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          decoration: BoxDecoration(
            color: AppColors.orange,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: const Color(0x1FFFFFFF), width: 2),
          ),
          alignment: Alignment.center,
          child: Obx(
            () => Text(
              controller.primaryLabel,
              style: manrope(16, weight: FontWeight.w600, color: Colors.white, lineHeight: 24),
            ),
          ),
        ),
      ),
    );
  }
}

class _WriteStep extends GetView<CreateBusinessPostController> {
  const _WriteStep();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 32.w),
      children: [
        const _AuthorRow(),
        SizedBox(height: 24.w),
        _ThoughtsField(height: 470.w),
        SizedBox(height: 24.w),
        const _PrimaryButton(),
      ],
    );
  }
}

class _GalleryStep extends GetView<CreateBusinessPostController> {
  const _GalleryStep();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 32.w),
      children: [
        const _AuthorRow(),
        SizedBox(height: 24.w),
        Obx(() {
          final images = controller.galleryImages;
          final selected = List<String>.from(controller.selectedImages);
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: images.length + 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 16.w,
              crossAxisSpacing: 20.w,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              if (index == 0) {
                return GestureDetector(
                  onTap: controller.addFromDevice,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.neutral100,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(IconPath.addImage, width: 24.w, height: 24.w),
                  ),
                );
              }
              final path = images[index - 1];
              final selectedIndex = selected.indexOf(path) + 1;
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => controller.toggleImage(path),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CommunityMedia.image(path),
                      Positioned(
                        top: 8.w,
                        right: 8.w,
                        child: Container(
                          width: 20.w,
                          height: 20.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: selectedIndex > 0 ? AppColors.primary : const Color(0x80FFFFFF),
                            borderRadius: BorderRadius.circular(6.r),
                            border: selectedIndex > 0 ? null : Border.all(color: AppColors.neutral300),
                          ),
                          child: selectedIndex > 0
                              ? Text(
                                  '$selectedIndex',
                                  style: manrope(
                                    14,
                                    weight: FontWeight.w600,
                                    color: Colors.white,
                                    lineHeight: 20,
                                  ),
                                )
                              : null,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
        SizedBox(height: 24.w),
        const _PrimaryButton(),
      ],
    );
  }
}

class _CaptionStep extends GetView<CreateBusinessPostController> {
  const _CaptionStep();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 32.w),
      children: [
        const _AuthorRow(),
        SizedBox(height: 24.w),
        Obx(() {
          final images = controller.selectedImages;
          if (images.isEmpty) return const SizedBox.shrink();
          return Row(
            children: [
              for (var i = 0; i < images.take(2).length; i++) ...[
                if (i > 0) SizedBox(width: 20.w),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: SizedBox(
                      height: 221.w,
                      child: CommunityMedia.image(images[i]),
                    ),
                  ),
                ),
              ],
              if (images.length == 1) const Spacer(),
            ],
          );
        }),
        SizedBox(height: 24.w),
        _ThoughtsField(height: 239.w),
        SizedBox(height: 24.w),
        const _PrimaryButton(),
      ],
    );
  }
}

class _ThoughtsField extends GetView<CreateBusinessPostController> {
  const _ThoughtsField({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.neutral200),
      ),
      child: TextField(
        controller: controller.textController,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        cursorColor: AppColors.primary,
        style: manrope(14, weight: FontWeight.w600, color: AppColors.textGray800, lineHeight: 20),
        decoration: InputDecoration(
          hintText: AppText.shareYourThoughts,
          hintStyle: manrope(14, weight: FontWeight.w600, color: AppColors.neutral300, lineHeight: 20),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
