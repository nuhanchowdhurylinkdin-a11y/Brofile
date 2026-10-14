import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/helpers/app_platform.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:get/get.dart';

void showPostMenu(PostModel post) {
  final controller = Get.find<HomeController>();
  AppPlatform.showActions([
    PlatformAction(
      label: AppText.hidePost,
      onTap: () => controller.hidePost(post),
    ),
    PlatformAction(
      label: AppText.copyText,
      onTap: () => controller.copyPostText(post),
    ),
    PlatformAction(
      label: AppText.reportPost,
      isDestructive: true,
      onTap: () => controller.reportPost(post),
    ),
  ]);
}
