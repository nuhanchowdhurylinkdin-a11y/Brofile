import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/features/profile/controllers/profile_controller.dart';
import 'package:brofile/features/profile/data/models/profile_models.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AlbumDetailsController extends GetxController {
  HobbyItem get album => Get.arguments as HobbyItem;

  final ImagePicker _picker = ImagePicker();
  final removing = false.obs;
  final coverTick = 0.obs;

  String get tag {
    final category = album.category;
    final subcategory = album.subcategory;
    if (category == null || category.isEmpty) return '';
    if (subcategory == null || subcategory.isEmpty) return category;
    return '$category > $subcategory';
  }

  void close() => Get.back();

  void toggleRemoving() => removing.toggle();

  Future<void> pickCover() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1080,
      imageQuality: 85,
    );
    if (file == null) return;
    album.image = file.path;
    album.isFile = true;
    coverTick.value++;
    _refreshTiles();
  }

  Future<void> addPhoto() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1080,
      imageQuality: 85,
    );
    if (file == null) return;
    album.photos.add(file.path);
    album.subtitle = '${album.photos.length} ${AppText.photosCount}';
    _refreshTiles();
  }

  void removePhoto(String path) {
    album.photos.remove(path);
    album.subtitle = '${album.photos.length} ${AppText.photosCount}';
    _refreshTiles();
  }

  void _refreshTiles() {
    if (Get.isRegistered<ProfileController>()) {
      Get.find<ProfileController>().refreshHobbyItems();
    }
  }

  void toggleLike() {
    if (album.liked.value) {
      album.liked.value = false;
      album.likes.value--;
      return;
    }
    album.liked.value = true;
    album.likes.value++;
    if (album.disliked.value) {
      album.disliked.value = false;
      album.dislikes.value--;
    }
  }

  void toggleDislike() {
    if (album.disliked.value) {
      album.disliked.value = false;
      album.dislikes.value--;
      return;
    }
    album.disliked.value = true;
    album.dislikes.value++;
    if (album.liked.value) {
      album.liked.value = false;
      album.likes.value--;
    }
  }
}
