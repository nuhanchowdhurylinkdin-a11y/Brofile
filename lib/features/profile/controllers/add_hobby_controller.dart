import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/core/utils/helpers/app_platform.dart';
import 'package:brofile/features/discover/controllers/create_product_controller.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/profile/controllers/profile_controller.dart';
import 'package:brofile/features/profile/data/models/profile_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddHobbyController extends GetxController {
  static const int maxDescription = 120;

  HobbyCollection get collection => Get.arguments as HobbyCollection;

  HobbyCollectionKind get kind => collection.kind;

  final titleController = TextEditingController();
  final brandController = TextEditingController();
  final modelController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  final coverPath = Rxn<String>();
  final category = ''.obs;
  final subcategory = ''.obs;
  final descriptionLength = 0.obs;
  final photos = <String>[].obs;

  List<String> get categoryOptions => HomeController.categories
      .where((label) => label != AppText.all)
      .toList();

  List<String> get subcategoryOptions =>
      CreateProductController.subcategories[category.value] ?? const [];

  static const musicGenres = [
    'Pop',
    'Rock',
    'Jazz',
    'Hip Hop',
    'Classical',
    'Country',
    'Electronic',
    'R&B',
    'Indie',
    'Folk',
  ];
  static const bookGenres = [
    'Fiction',
    'Non-fiction',
    'Mystery',
    'Romance',
    'Sci-Fi',
    'Fantasy',
    'Biography',
    'History',
    'Self-help',
  ];
  static const movieGenres = [
    'Action',
    'Comedy',
    'Drama',
    'Horror',
    'Romance',
    'Sci-Fi',
    'Thriller',
    'Documentary',
    'Animation',
  ];

  String get screenTitle => switch (kind) {
        HobbyCollectionKind.gear => AppText.addNewMyGear,
        HobbyCollectionKind.albums => AppText.addNewPhotoAlbum,
        HobbyCollectionKind.places => AppText.addNewFavoritePlace,
        HobbyCollectionKind.music => AppText.addNewMusicILove,
        HobbyCollectionKind.books => AppText.addNewFavoriteBooks,
        HobbyCollectionKind.movies => AppText.addNewFavoriteMovies,
      };

  String get titleLabel => switch (kind) {
        HobbyCollectionKind.albums => AppText.albumTitle,
        HobbyCollectionKind.places => AppText.placeName,
        HobbyCollectionKind.music => AppText.songTitle,
        HobbyCollectionKind.books => AppText.bookTitle,
        HobbyCollectionKind.movies => AppText.movieName,
        _ => AppText.titleLabel,
      };

  String get titleHint => switch (kind) {
        HobbyCollectionKind.albums => AppText.enterAlbumTitle,
        HobbyCollectionKind.places => AppText.enterPlaceName,
        HobbyCollectionKind.music => AppText.enterSongTitle,
        HobbyCollectionKind.books => AppText.enterBookTitle,
        HobbyCollectionKind.movies => AppText.enterMovieName,
        _ => AppText.enterTitle,
      };

  String get descriptionHint => switch (kind) {
        HobbyCollectionKind.albums => AppText.albumDescriptionHint,
        HobbyCollectionKind.places => AppText.placeDescriptionHint,
        HobbyCollectionKind.music => AppText.musicDescriptionHint,
        HobbyCollectionKind.books => AppText.bookDescriptionHint,
        HobbyCollectionKind.movies => AppText.movieDescriptionHint,
        _ => AppText.gearDescriptionHint,
      };

  String get personLabel => switch (kind) {
        HobbyCollectionKind.music => AppText.artistSinger,
        HobbyCollectionKind.books => AppText.author,
        HobbyCollectionKind.movies => AppText.director,
        _ => '',
      };

  String get personHint => switch (kind) {
        HobbyCollectionKind.music => AppText.enterArtist,
        HobbyCollectionKind.books => AppText.enterAuthor,
        HobbyCollectionKind.movies => AppText.enterDirector,
        _ => '',
      };

  String get personRequiredMessage => switch (kind) {
        HobbyCollectionKind.music => AppText.artistRequired,
        HobbyCollectionKind.books => AppText.authorRequired,
        HobbyCollectionKind.movies => AppText.directorRequired,
        _ => AppText.titleRequired,
      };

  List<String> get genreOptions => switch (kind) {
        HobbyCollectionKind.music => musicGenres,
        HobbyCollectionKind.books => bookGenres,
        HobbyCollectionKind.movies => movieGenres,
        _ => const [],
      };

  String get submitLabel => usesSave ? AppText.save : AppText.share;

  bool get isGear => kind == HobbyCollectionKind.gear;
  bool get isAlbum => kind == HobbyCollectionKind.albums;
  bool get isPlace => kind == HobbyCollectionKind.places;
  bool get isMusic => kind == HobbyCollectionKind.music;
  bool get isBook => kind == HobbyCollectionKind.books;
  bool get isMovie => kind == HobbyCollectionKind.movies;
  bool get isMedia => isMusic || isBook || isMovie;
  bool get usesSave => isPlace || isMedia;
  bool get requiresCategory => isGear || isAlbum || isPlace;

  @override
  void onInit() {
    super.onInit();
    if (isGear) {
      category.value = 'Fitness';
      subcategory.value = 'Yoga';
    }
    descriptionController.addListener(
      () => descriptionLength.value = descriptionController.text.length,
    );
  }

  Future<void> pickCover() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1080,
      imageQuality: 85,
    );
    if (file != null) coverPath.value = file.path;
  }

  Future<void> pickPhoto() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1080,
      imageQuality: 85,
    );
    if (file != null) photos.add(file.path);
  }

  void removePhoto(String path) => photos.remove(path);

  Future<void> pickCategory() async {
    final selected = await _pickOption(categoryOptions);
    if (selected == null) return;
    category.value = selected;
    if (!subcategoryOptions.contains(subcategory.value)) {
      subcategory.value = '';
    }
  }

  Future<void> pickSubcategory() async {
    final options = subcategoryOptions;
    if (options.isEmpty) return;
    final selected = await _pickOption(options);
    if (selected != null) subcategory.value = selected;
  }

  Future<void> pickGenre() async {
    final selected = await _pickOption(genreOptions);
    if (selected != null) category.value = selected;
  }

  void close() => Get.back();

  void submit() {
    final title = titleController.text.trim();
    if (title.isEmpty) {
      AppHelperFunctions.showSnackBar(AppText.titleRequired);
      return;
    }
    if (requiresCategory && category.value.isEmpty) {
      AppHelperFunctions.showSnackBar(AppText.chooseCategory);
      return;
    }
    final person = brandController.text.trim();
    if (isMedia && person.isEmpty) {
      AppHelperFunctions.showSnackBar(personRequiredMessage);
      return;
    }

    final cover = coverPath.value;
    final fallback = switch (kind) {
      HobbyCollectionKind.gear => ImagePath.gear1,
      HobbyCollectionKind.albums => ImagePath.hobbyAlbum1,
      HobbyCollectionKind.places => ImagePath.place1,
      HobbyCollectionKind.music => ImagePath.music1,
      HobbyCollectionKind.books => ImagePath.book1,
      HobbyCollectionKind.movies => ImagePath.movie1,
    };
    final albumName = modelController.text.trim();

    final item = HobbyItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      image: cover ?? fallback,
      isFile: cover != null,
      subtitle: isAlbum
          ? '${photos.length} ${AppText.photosCount}'
          : (isMedia && person.isNotEmpty ? person : null),
      meta: isMusic && albumName.isNotEmpty ? albumName : null,
      category: category.value.isEmpty ? null : category.value,
      subcategory: subcategory.value.isEmpty ? null : subcategory.value,
      location: locationController.text.trim().isEmpty
          ? null
          : locationController.text.trim(),
      brand: person.isEmpty ? null : person,
      model: albumName.isEmpty ? null : albumName,
      description: descriptionController.text.trim().isEmpty
          ? null
          : descriptionController.text.trim(),
      photos: [
        ?cover,
        ...photos,
      ],
    );

    Get.find<ProfileController>().insertHobby(collection, item);
    Get.back();
    AppHelperFunctions.showSnackBar(AppText.hobbyAdded);
  }

  Future<String?> _pickOption(List<String> options) {
    return AppPlatform.showOptions(options);
  }

  @override
  void onClose() {
    titleController.dispose();
    brandController.dispose();
    modelController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
