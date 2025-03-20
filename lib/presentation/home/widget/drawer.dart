import 'package:flutter/material.dart';
import 'package:newzenalphatech/presentation/category/screen/category.dart';
import 'package:newzenalphatech/presentation/dashboard/screen/dashboard.dart';
import 'package:newzenalphatech/presentation/home/screen/profile.dart';
import 'package:newzenalphatech/presentation/home/widget/drawer_option_title.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Options"),
          ),
          const DrawerOptionTitle(
            icon: Icon(Icons.person),
            text: "Profile",
            navRoute: UserInfo.routeName,
          ),
          const DrawerOptionTitle(
            icon: Icon(Icons.data_usage),
            text: "Usage Chart",
            navRoute: DashboardScreen.routeName,
          ),
          const DrawerOptionTitle(
            icon: Icon(Icons.category),
            text: "Category",
            navRoute: CategoryScreen.routeName,
          ),
        ],
      ),
    );
  }
}
