import 'package:flutter/material.dart';

message(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Text(
        message,
        style: TextStyle(
            fontSize: 16, color: Theme.of(context).scaffoldBackgroundColor),
        textAlign: TextAlign.right,
      )));
}
