import 'package:brofile/core/utils/constants/colors.dart';
import 'package:brofile/features/home/presentation/widgets/home_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Overlapping member avatars followed by an optional "+N" bubble.
class AvatarGroup extends StatelessWidget {
  const AvatarGroup({super.key, required this.images, this.extra = 0});

  final List<String> images;
  final int extra;

  @override
  Widget build(BuildContext context) {
    final size = 24.w;
    final step = size - 4.w;
    final count = images.length + (extra > 0 ? 1 : 0);

    return SizedBox(
      width: step * (count - 1) + size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (var i = 0; i < images.length; i++)
            Positioned(
              left: step * i,
              child: _Ring(
                size: size,
                child: Image.asset(images[i], fit: BoxFit.cover),
              ),
            ),
          if (extra > 0)
            Positioned(
              left: step * images.length,
              child: _Ring(
                size: size,
                color: AppColors.neutral100,
                borderColor: AppColors.neutral200,
                child: Center(
                  child: Text(
                    '+$extra',
                    style: manrope(
                      12,
                      weight: FontWeight.w600,
                      color: AppColors.neutral500,
                      lineHeight: 18,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _Ring extends StatelessWidget {
  const _Ring({
    required this.size,
    required this.child,
    this.color,
    this.borderColor = const Color(0x14000000),
  });

  final double size;
  final Widget child;
  final Color? color;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: const [BoxShadow(color: Colors.white, spreadRadius: 1.5)],
      ),
      foregroundDecoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 0.5),
      ),
      child: ClipOval(child: child),
    );
  }
}
