import 'package:flutter/material.dart';

Widget buildUserInfo(
    {required BuildContext context,
    required String title,
    required String data,
    required Size screenSize}) {
  return Container(
    margin: EdgeInsets.symmetric(
        horizontal: screenSize.height * 0.0197,
        vertical: screenSize.height * 0.0091),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SizedBox(
          height: screenSize.height * 0.0027,
        ),
        Text(data),
        const Divider(
          color: Colors.black,
          thickness: 1.5,
        ),
      ],
    ),
  );
}
