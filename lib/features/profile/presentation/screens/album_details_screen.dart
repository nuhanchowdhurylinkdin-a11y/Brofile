import 'dart:io';

import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/core/utils/helpers/app_helper.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/profile/controllers/album_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AlbumDetailsScreen extends GetView<AlbumDetailsController> {
  const AlbumDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: Column(
          children: [
            const _AlbumHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 32.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _Cover(),
                    SizedBox(height: 16.w),
                    if (controller.tag.isNotEmpty)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.w),
                        decoration: BoxDecoration(
                          color: AppColors.orangeLight,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          controller.tag,
                          style: manrope(12, weight: FontWeight.w500, color: AppColors.orange, lineHeight: 16),
                        ),
                      ),
                    SizedBox(height: 16.w),
                    const _Meta(),
                    SizedBox(height: 16.w),
                    const _PhotoMosaic(),
                    SizedBox(height: 24.w),
                    const _PhotoActions(),
                    if (controller.album.description != null &&
                        controller.album.description!.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 24.w),
                        child: Text(
                          controller.album.description!,
                          style: manrope(16, color: AppColors.neutral600, lineHeight: 24),
                        ),
                      ),
                    SizedBox(height: 24.w),
                    const _Reactions(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AlbumHeader extends GetView<AlbumDetailsController> {
  const _AlbumHeader();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 8.w, 16.w, 8.w),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32.r),
            border: Border.all(color: AppColors.neutral200),
          ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: controller.close,
                  behavior: HitTestBehavior.opaque,
                  child: SvgPicture.asset(
                    IconPath.pleasureBack,
                    width: 24.w,
                    height: 24.w,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        AppText.photoAlbum,
                        textAlign: TextAlign.center,
                        style: manrope(14, weight: FontWeight.w600, color: AppColors.neutral600, lineHeight: 20),
                      ),
                      Text(
                        controller.album.title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: manrope(16, weight: FontWeight.w600, color: AppColors.primary, lineHeight: 24),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => AppHelperFunctions.showSnackBar(AppText.comingSoon),
                  behavior: HitTestBehavior.opaque,
                  child: SvgPicture.asset(
                    IconPath.postMenu,
                    width: 24.w,
                    height: 24.w,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}

class _Cover extends GetView<AlbumDetailsController> {
  const _Cover();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.coverTick.value;
      return ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: SizedBox(
          width: double.infinity,
          height: 184.w,
          child: Stack(
            fit: StackFit.expand,
            children: [
              _HobbyImage(path: controller.album.image, isFile: controller.album.isFile),
              Positioned(
                top: 12.w,
                right: 12.w,
                child: GestureDetector(
                  onTap: controller.pickCover,
                  child: Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: const BoxDecoration(
                      color: Color(0x99000000),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      IconPath.profileCoverEdit,
                      width: 16.w,
                      height: 16.w,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _Meta extends GetView<AlbumDetailsController> {
  const _Meta();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final photos = controller.album.photos;
      final count = photos.isEmpty ? 1 : photos.length;
      final location = controller.album.location;
      return Column(
        children: [
          _MetaRow(
            icon: IconPath.profileAlbum,
            label: '$count ${AppText.photosCount}',
          ),
          SizedBox(height: 12.w),
          _MetaRow(icon: IconPath.profileCalendar, label: AppText.date),
          SizedBox(height: 12.w),
          _MetaRow(
            icon: IconPath.profileMarker,
            label: (location == null || location.isEmpty)
                ? AppText.locationLabel
                : location,
          ),
        ],
      );
    });
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.icon, required this.label});

  final String icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon, width: 18.w, height: 18.w),
        SizedBox(width: 8.w),
        Text(label, style: manrope(14, color: AppColors.neutral500, lineHeight: 20)),
      ],
    );
  }
}

class _PhotoMosaic extends GetView<AlbumDetailsController> {
  const _PhotoMosaic();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final removing = controller.removing.value;
      final photos = controller.album.photos.toList();
      final gallery = photos.isEmpty ? [controller.album.image] : photos;
      final gap = 8.w;
      final col = (396.w - gap * 2) / 3;
      final featured = gallery.first;
      final rest = gallery.length > 1 ? gallery.sublist(1) : const <String>[];

      Widget tile(String path) => _PhotoTile(
            path: path,
            removing: removing && photos.isNotEmpty,
            onTap: () {
              if (removing && photos.isNotEmpty) controller.removePhoto(path);
            },
          );

      if (rest.isEmpty) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: SizedBox(height: 184.w, width: double.infinity, child: tile(featured)),
        );
      }

      final rows = <List<String>>[];
      for (var i = 0; i < rest.length; i += 2) {
        rows.add(rest.sublist(i, i + 2 > rest.length ? rest.length : i + 2));
      }

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: col,
            height: col * 2 + gap,
            child: tile(featured),
          ),
          SizedBox(width: gap),
          Expanded(
            child: Column(
              children: [
                for (var r = 0; r < rows.length; r++) ...[
                  if (r > 0) SizedBox(height: gap),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(height: col, child: tile(rows[r].first)),
                      ),
                      SizedBox(width: gap),
                      Expanded(
                        child: rows[r].length > 1
                            ? SizedBox(height: col, child: tile(rows[r][1]))
                            : SizedBox(height: col),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      );
    });
  }
}

class _PhotoTile extends StatelessWidget {
  const _PhotoTile({
    required this.path,
    required this.removing,
    required this.onTap,
  });

  final String path;
  final bool removing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            _HobbyImage(path: path, isFile: !path.startsWith('assets/')),
            if (removing)
              Positioned(
                top: 6.w,
                right: 6.w,
                child: Container(
                  width: 22.w,
                  height: 22.w,
                  decoration: const BoxDecoration(
                    color: Color(0x99000000),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    IconPath.profileRemove,
                    width: 12.w,
                    height: 12.w,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PhotoActions extends GetView<AlbumDetailsController> {
  const _PhotoActions();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: controller.addPhoto,
            child: Container(
              height: 44.w,
              decoration: BoxDecoration(
                color: AppColors.orange,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    IconPath.profileAdd,
                    width: 20.w,
                    height: 20.w,
                    colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  ),
                  SizedBox(width: 6.w),
                  Flexible(
                    child: Text(
                      AppText.addNewPhoto,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: manrope(16, weight: FontWeight.w600, color: Colors.white, lineHeight: 24),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: GestureDetector(
            onTap: controller.toggleRemoving,
            child: Obx(() {
              final on = controller.removing.value;
              return Container(
                height: 44.w,
                decoration: BoxDecoration(
                  color: on ? AppColors.primaryContainer : Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: AppColors.primary),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      IconPath.profileRemove,
                      width: 20.w,
                      height: 20.w,
                      colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                    ),
                    SizedBox(width: 6.w),
                    Flexible(
                      child: Text(
                        AppText.removePhoto,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: manrope(16, weight: FontWeight.w600, color: AppColors.primary, lineHeight: 24),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _Reactions extends GetView<AlbumDetailsController> {
  const _Reactions();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final album = controller.album;
      album.likes.value;
      album.dislikes.value;
      album.liked.value;
      album.disliked.value;
      return Row(
        children: [
          _Reaction(
            icon: IconPath.like,
            count: album.likes.value,
            active: album.liked.value,
            onTap: controller.toggleLike,
          ),
          SizedBox(width: 8.w),
          _Reaction(
            icon: IconPath.dislike,
            count: album.dislikes.value,
            active: album.disliked.value,
            onTap: controller.toggleDislike,
          ),
          SizedBox(width: 8.w),
          _Reaction(
            icon: IconPath.comment,
            count: album.comments,
            onTap: () => AppHelperFunctions.showSnackBar(AppText.comingSoon),
          ),
        ],
      );
    });
  }
}

class _Reaction extends StatelessWidget {
  const _Reaction({
    required this.icon,
    required this.count,
    required this.onTap,
    this.active = false,
  });

  final String icon;
  final int count;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.primary : AppColors.neutral400;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          SvgPicture.asset(
            icon,
            height: 20.w,
            colorFilter: active
                ? const ColorFilter.mode(AppColors.primary, BlendMode.srcIn)
                : null,
          ),
          SizedBox(width: 4.w),
          Text('$count', style: manrope(12, color: color, lineHeight: 16)),
        ],
      ),
    );
  }
}

class _HobbyImage extends StatelessWidget {
  const _HobbyImage({required this.path, required this.isFile});

  final String path;
  final bool isFile;

  @override
  Widget build(BuildContext context) {
    if (!isFile && path.startsWith('assets/')) {
      return Image.asset(path, fit: BoxFit.cover);
    }
    return Image.file(File(path), fit: BoxFit.cover);
  }
}
