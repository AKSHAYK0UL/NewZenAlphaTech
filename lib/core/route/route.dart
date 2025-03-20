import 'package:flutter/cupertino.dart';
import 'package:newzenalphatech/presentation/auth/screen/forgotpassword.dart';
import 'package:newzenalphatech/presentation/auth/screen/signin.dart';
import 'package:newzenalphatech/presentation/auth/screen/signup.dart';
import 'package:newzenalphatech/presentation/auth/screen/verification.dart';
import 'package:newzenalphatech/presentation/category/screen/category.dart';
import 'package:newzenalphatech/presentation/dashboard/screen/dashboard.dart';
import 'package:newzenalphatech/presentation/home/screen/home.dart';
import 'package:newzenalphatech/presentation/home/screen/profile.dart';

Map<String, WidgetBuilder> routes = {
  Signup.routeName: (context) => const Signup(),
  Signin.routeName: (context) => const Signin(),
  ForgotPassword.routeName: (context) => const ForgotPassword(),
  Verification.routeName: (context) => const Verification(),
  Home.routeName: (context) => const Home(),
  CategoryScreen.routeName: (context) => const CategoryScreen(),
  DashboardScreen.routeName: (context) => const DashboardScreen(),
  UserInfo.routeName: (context) => const UserInfo(),
};
