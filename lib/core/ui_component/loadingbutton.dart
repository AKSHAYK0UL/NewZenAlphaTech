import 'package:flutter/material.dart';

Widget buildLoadingButton(double width, height) {
  return Container(
    padding: EdgeInsets.all(height * 0.180),
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(10),
    ),
    child: const FittedBox(
      fit: BoxFit.contain,
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    ),
  );
}
