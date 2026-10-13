import 'dart:ui';

import 'package:brofile/core/utils/constants/app_texts.dart';
import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'onboarding_text.dart';

// Offsets mirror the 428x926 Figma frames, which include the 48px status bar.

class OnboardingFirstPage extends StatelessWidget {
  const OnboardingFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 127.h),
        SizedBox(
          width: 357.r,
          height: 357.r,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 93.r,
                top: 98.r,
                // flutter_svg ignores SVG filters, so the asset's blur is applied here.
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 17.r, sigmaY: 17.r),
                  child: SvgPicture.asset(
                    ImagePath.onboarding1Glow,
                    width: 172.r,
                    height: 172.r,
                  ),
                ),
              ),
              Positioned(
                left: 62.r,
                top: 67.r,
                child: Image.asset(
                  ImagePath.onboarding1RingOuter,
                  width: 235.r,
                  height: 235.r,
                ),
              ),
              Positioned(
                left: 110.r,
                top: 115.r,
                child: Image.asset(
                  ImagePath.onboarding1RingInner,
                  width: 139.r,
                  height: 139.r,
                ),
              ),
              Positioned.fill(
                child: SvgPicture.asset(
                  ImagePath.onboarding1,
                  width: 357.r,
                  height: 357.r,
                ),
              ),
              Positioned(
                left: 63.83.r,
                top: 215.33.r,
                child: SvgPicture.asset(
                  ImagePath.onboarding1Vector,
                  width: 19.378.r,
                  height: 12.072.r,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.r),
        const OnboardingText(
          title: AppText.onboarding1Title,
          description: AppText.onboarding1Description,
        ),
      ],
    );
  }
}

class OnboardingSecondPage extends StatelessWidget {
  const OnboardingSecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 45.h),
        SizedBox(
          height: 676.r,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const _OnboardingSpacer(),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 578.r,
                child: SvgPicture.asset(
                  ImagePath.onboarding2Background,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
              Positioned(
                top: 217.545.r,
                left: 0,
                right: 0,
                child: const Center(child: _EventCard()),
              ),
              Positioned(
                top: 562.r,
                left: 0,
                right: 0,
                child: const OnboardingText(
                  title: AppText.onboarding2Title,
                  description: AppText.onboarding2Description,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OnboardingThirdPage extends StatelessWidget {
  const OnboardingThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 45.h),
        Stack(
          clipBehavior: Clip.none,
          children: [
            const _OnboardingSpacer(),
            Column(
              children: [
                SizedBox(height: 82.r),
                SvgPicture.asset(
                  ImagePath.onboarding3,
                  width: 326.r,
                  height: 326.r,
                ),
                SizedBox(height: 51.r),
                const OnboardingText(
                  title: AppText.onboarding3Title,
                  description: AppText.onboarding3Description,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 330.909.r,
      height: 263.817.r,
      child: Stack(
        children: [
          // Card drop shadow from the asset's SVG filter, which flutter_svg ignores.
          Positioned(
            left: 9.455.r,
            top: 9.455.r,
            width: 312.r,
            height: 244.909.r,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.455.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.13),
                    blurRadius: 7.32.r,
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: SvgPicture.asset(ImagePath.onboarding2Card),
          ),
        ],
      ),
    );
  }
}

class _OnboardingSpacer extends StatelessWidget {
  const _OnboardingSpacer();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 564.r,
      left: 0,
      right: 0,
      height: 14.r,
      child: Image.asset(ImagePath.onboardingSpacer, fit: BoxFit.fill),
    );
  }
}
