import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/features/pleasure/controllers/pleasure_controller.dart';
import 'package:brofile/features/pleasure/data/models/pleasure_models.dart';
import 'package:get/get.dart';

class PleasureDetailsController extends GetxController {
  ActivityItem get activity => Get.arguments as ActivityItem;

  void close() => Get.back();

  void toggleJoin() => Get.find<PleasureController>().toggleJoin(activity);

  void messageHost() => AppHelperFunctions.showSnackBar(AppText.comingSoon);
}
