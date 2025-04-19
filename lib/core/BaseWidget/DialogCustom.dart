import 'package:flutter/material.dart';

class Dialogcustom {
  static void show(BuildContext context, String? message,
      {bool isSuccess = true}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          isSuccess ? "Thành công" : "Thất bại",
          style: TextStyle(
              color: isSuccess ? Colors.green : Colors.red,
              fontWeight: FontWeight.w500),
        ),
        content: Text(message!),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
