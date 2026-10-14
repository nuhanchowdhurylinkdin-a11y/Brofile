import 'dart:io';

import 'package:flutter/material.dart';

class CommunityMedia {
  static Widget image(
    String path, {
    BoxFit fit = BoxFit.cover,
    double? width,
    double? height,
  }) {
    if (path.startsWith('assets/')) {
      return Image.asset(path, fit: fit, width: width, height: height);
    }
    return Image.file(File(path), fit: fit, width: width, height: height);
  }
}
