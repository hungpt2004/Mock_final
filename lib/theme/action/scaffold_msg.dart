import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message, {bool isSuccess = true}) {
  final color = isSuccess ? Colors.green : Colors.red;
  final icon = isSuccess ? Icons.check_circle : Icons.error;

  final snackBar = SnackBar(
    content: Row(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 8), // Add some space between the icon and text
        Expanded(child: Text(message, style: const TextStyle(color: Colors.white))),
      ],
    ),
    backgroundColor: color,
    duration: const Duration(seconds: 2), // Set how long the SnackBar will be shown
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
