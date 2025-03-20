import 'package:flutter/material.dart';

class DrawerOptionTitle extends StatelessWidget {
  final Icon icon;
  final String text;
  final String navRoute;
  const DrawerOptionTitle({
    super.key,
    required this.icon,
    required this.text,
    required this.navRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: ListTile(
        tileColor: const Color.fromARGB(255, 222, 226, 228),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: icon,
        ),
        title: Text(text),
        onTap: () {
          Navigator.of(context).pushNamed(navRoute);
        },
      ),
    );
  }
}
