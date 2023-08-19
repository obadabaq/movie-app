import 'package:flutter/material.dart';
import 'package:flutter_movies_app/utils/widgets/generic_error_dialog.dart';

class Helpers {
  static showErrorDialog(
    BuildContext context, {
    required String errorMsg,
    required VoidCallback onCancel,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (builder) {
        return GenericErrorDialog(
          errorMsg: errorMsg,
          onCancel: onCancel,
          onConfirm: onConfirm,
        );
      },
    );
  }
}
