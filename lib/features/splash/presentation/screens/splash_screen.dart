import 'package:brofile/core/utils/constants/image_path.dart';
import 'package:brofile/features/splash/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Fixed logical size so the logo lines up with the native splash image.
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SvgPicture.asset(
            ImagePath.splashLogo,
            width: 278,
            height: 77.222,
          ),
        ),
      ),
    );
  }
}
