import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/features/home/controllers/home_controller.dart';
import 'package:brofile/features/home/data/models/home_models.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PhotoAlbumSection extends GetView<HomeController> {
  const PhotoAlbumSection({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final albums = controller.photoAlbums;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: HomeSectionHeader(title: title),
        ),
        SizedBox(height: 16.w),
        SizedBox(
          height: 154.w,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: albums.length,
            separatorBuilder: (_, _) => SizedBox(width: 8.w),
            itemBuilder: (_, index) => _AlbumTile(
              album: albums[index],
              onTap: () => _openViewer(albums[index]),
            ),
          ),
        ),
      ],
    );
  }

  void _openViewer(PhotoAlbum album) {
    Get.dialog(
      GestureDetector(
        onTap: Get.back,
        child: Container(
          color: Colors.black,
          alignment: Alignment.center,
          child: InteractiveViewer(
            child: Image.asset(album.image, fit: BoxFit.contain),
          ),
        ),
      ),
      barrierColor: Colors.black,
      useSafeArea: false,
    );
  }
}

class _AlbumTile extends StatelessWidget {
  const _AlbumTile({required this.album, required this.onTap});

  final PhotoAlbum album;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.r),
        child: SizedBox(
          width: 124.w,
          height: 154.w,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(album.image, fit: BoxFit.cover),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, AppColors.albumShade],
                    stops: [0.55, 1],
                  ),
                ),
              ),
              Positioned(
                left: 12.w,
                bottom: 12.w,
                child: TrimmedText(
                  album.handle,
                  style: manrope(12, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
