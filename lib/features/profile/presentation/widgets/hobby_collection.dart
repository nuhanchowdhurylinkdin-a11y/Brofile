import 'dart:io';

import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/core/utils/constants/icon_path.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:brofile/features/profile/controllers/profile_controller.dart';
import 'package:brofile/features/profile/data/models/profile_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HobbyCollectionView extends GetView<ProfileController> {
  const HobbyCollectionView({super.key, required this.collection});

  final HobbyCollection collection;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final expanded = collection.isExpanded.value;
      final removing = collection.isRemoving.value;
      final items = expanded
          ? collection.items.toList()
          : collection.items.take(collection.collapsedCount).toList();

      return Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    collection.title,
                    style: manrope(18, weight: FontWeight.w700, lineHeight: 20),
                  ),
                ),
                GestureDetector(
                  onTap: () => expanded
                      ? controller.collapseCollection(collection)
                      : controller.toggleCollection(collection),
                  child: Text(
                    expanded ? AppText.back : AppText.seeAll,
                    style: manrope(12, color: AppColors.primary, lineHeight: 16),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.w),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: collection.kind == HobbyCollectionKind.music
                ? _MusicList(items: items, removing: removing, collection: collection)
                : _TileGrid(
                    items: items,
                    columns: collection.columns,
                    collection: collection,
                    removing: removing,
                  ),
          ),
          if (expanded) ...[
            SizedBox(height: 24.w),
            _ActionRow(collection: collection),
          ],
        ],
      );
    });
  }
}

class _TileGrid extends GetView<ProfileController> {
  const _TileGrid({
    required this.items,
    required this.columns,
    required this.collection,
    required this.removing,
  });

  final List<HobbyItem> items;
  final int columns;
  final HobbyCollection collection;
  final bool removing;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < items.length; i += columns) ...[
          if (i > 0) SizedBox(height: 8.w),
          Row(
            children: [
              for (var c = 0; c < columns; c++) ...[
                if (c > 0) SizedBox(width: 8.w),
                Expanded(
                  child: i + c < items.length
                      ? _MediaTile(
                          item: items[i + c],
                          collection: collection,
                          removing: removing,
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ],
          ),
        ],
      ],
    );
  }
}

class _MediaTile extends GetView<ProfileController> {
  const _MediaTile({
    required this.item,
    required this.collection,
    required this.removing,
  });

  final HobbyItem item;
  final HobbyCollection collection;
  final bool removing;

  @override
  Widget build(BuildContext context) {
    final showAuthor = collection.kind == HobbyCollectionKind.books ||
        collection.kind == HobbyCollectionKind.movies;

    return GestureDetector(
      onTap: () {
        if (removing) {
          controller.removeItem(collection, item);
          return;
        }
        if (collection.kind == HobbyCollectionKind.albums) {
          controller.openAlbum(item);
        }
      },
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: SizedBox(
                    height: 101.w,
                    width: double.infinity,
                    child: item.isFile
                        ? Image.file(File(item.image), fit: BoxFit.cover)
                        : Image.asset(item.image, fit: BoxFit.cover),
                  ),
                ),
                if (removing)
                  Positioned(
                    top: 4.w,
                    right: 4.w,
                    child: Container(
                      width: 22.w,
                      height: 22.w,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        IconPath.profileRemove,
                        width: 12.w,
                        height: 12.w,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 4.w),
            Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: manrope(12, weight: FontWeight.w700, color: AppColors.neutral700, lineHeight: 18),
            ),
            if (item.subtitle != null) ...[
              SizedBox(height: 4.w),
              if (collection.kind == HobbyCollectionKind.movies)
                Row(
                  children: [
                    SvgPicture.asset(IconPath.profilePlay, width: 14.w, height: 14.w),
                    SizedBox(width: 4.w),
                    Expanded(
                      child: Text(
                        item.subtitle!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: manrope(12, color: AppColors.neutral700, lineHeight: 16),
                      ),
                    ),
                  ],
                )
              else
                Text(
                  item.subtitle!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: manrope(12, color: AppColors.neutral700, lineHeight: 16),
                ),
            ],
            if (showAuthor && item.subtitle == null) const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class _MusicList extends GetView<ProfileController> {
  const _MusicList({
    required this.items,
    required this.removing,
    required this.collection,
  });

  final List<HobbyItem> items;
  final bool removing;
  final HobbyCollection collection;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < items.length; i += 2) ...[
          if (i > 0) SizedBox(height: 12.w),
          Row(
            children: [
              Expanded(child: _MusicCard(item: items[i], collection: collection, removing: removing)),
              SizedBox(width: 12.w),
              Expanded(
                child: i + 1 < items.length
                    ? _MusicCard(item: items[i + 1], collection: collection, removing: removing)
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _MusicCard extends GetView<ProfileController> {
  const _MusicCard({
    required this.item,
    required this.collection,
    required this.removing,
  });

  final HobbyItem item;
  final HobbyCollection collection;
  final bool removing;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: removing ? () => controller.removeItem(collection, item) : null,
      child: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: SizedBox(
                    width: 52.w,
                    height: 52.w,
                    child: item.isFile
                        ? Image.file(File(item.image), fit: BoxFit.cover)
                        : Image.asset(item.image, fit: BoxFit.cover),
                  ),
                ),
                if (removing)
                  Positioned(
                    top: 2.w,
                    right: 2.w,
                    child: Container(
                      width: 18.w,
                      height: 18.w,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        IconPath.profileRemove,
                        width: 10.w,
                        height: 10.w,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: manrope(12, weight: FontWeight.w700, color: AppColors.neutral700, lineHeight: 18),
                  ),
                  if (item.subtitle != null) ...[
                    SizedBox(height: 8.w),
                    Row(
                      children: [
                        SvgPicture.asset(IconPath.profileMic, width: 14.w, height: 14.w),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            item.subtitle!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: manrope(12, color: AppColors.neutral700, lineHeight: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (item.meta != null) ...[
                    SizedBox(height: 8.w),
                    Row(
                      children: [
                        SvgPicture.asset(IconPath.profileAlbum, width: 14.w, height: 14.w),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            item.meta!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: manrope(12, color: AppColors.neutral700, lineHeight: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionRow extends GetView<ProfileController> {
  const _ActionRow({required this.collection});

  final HobbyCollection collection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => controller.addItem(collection),
              child: Container(
                height: 44.w,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: AppColors.primary),
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
                        collection.addLabel,
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
              onTap: () => controller.toggleRemoving(collection),
              child: Obx(() {
                final on = collection.isRemoving.value;
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
                          collection.removeLabel,
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
      ),
    );
  }
}
