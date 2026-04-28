import 'package:flutter/material.dart';

class AppMessenger {
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static void showError(String message) {
    final messenger = scaffoldMessengerKey.currentState;
    if (messenger == null || message.trim().isEmpty) {
      return;
    }

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message), behavior: SnackBarBehavior.floating));
  }
}
