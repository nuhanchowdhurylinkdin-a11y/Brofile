import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:get/get.dart';

class RecycleProductDetailsController extends GetxController {
  late final ProductModel product;

  @override
  void onInit() {
    product = Get.arguments as ProductModel;
    super.onInit();
  }

  void close() => Get.back();

  void toggleFavorite() => product.isFavorite.toggle();

  void messageSeller() => AppHelperFunctions.showSnackBar(AppText.comingSoon);
}
