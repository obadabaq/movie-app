import 'package:flutter/material.dart';

class GenericErrorDialog extends StatelessWidget {
  final String errorMsg;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const GenericErrorDialog({
    Key? key,
    required this.errorMsg,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Error"),
      content: Text(errorMsg),
      actions: [
        MaterialButton(
          onPressed: onCancel,
          child: const Text("cancel"),
        ),
        MaterialButton(
          onPressed: onConfirm,
          child: const Text("Try again"),
        )
      ],
    );
  }
}
