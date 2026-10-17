import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract final class NotebookColors {
  static const paper = Color(0xFFF3EBDD);
  static const paperDeep = Color(0xFFE6D9C6);
  static const ink = Color(0xFF2C211C);
}

SystemUiOverlayStyle notebookOverlay(Color background) {
  return SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: background,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}
