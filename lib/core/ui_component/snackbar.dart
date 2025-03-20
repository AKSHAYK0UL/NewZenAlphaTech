import 'package:flutter/material.dart';

void buildSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        backgroundColor: const Color.fromARGB(255, 206, 206, 206),
        content: Text(
          message,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        showCloseIcon: true,
        closeIconColor: Colors.black,
      ),
    );
}
