import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:newzenalphatech/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:newzenalphatech/core/helper/convert_to_ist.dart';
import 'package:newzenalphatech/presentation/home/widget/userdatatitle.dart';

class UserInfo extends StatelessWidget {
  static const routeName = "/userinfo";
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final currentUser = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account Detail",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Are You Sure?"),
                  content: const Text("Are you sure you want to Sign Out?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("No"),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(SignOutEvent());
                      },
                      child: const Text("Yes"),
                    )
                  ],
                ),
              );
            },
            icon: Icon(
              Icons.logout,
              color: Colors.red,
              size: screenSize.height * 0.0329,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(screenSize.height * 0.166),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: screenSize.height * 0.166,
                    child: Lottie.asset(
                      "assets/userinfo.json",
                      repeat: false,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Card(
              elevation: screenSize.height * 0.00200,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenSize.height * 0.0131),
              ),
              margin: EdgeInsets.only(
                left: screenSize.height * 0.0110,
                right: screenSize.height * 0.0110,
                bottom: screenSize.height * 0.0110,
              ),
              color: Colors.blueGrey.shade100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildUserInfo(
                    context: context,
                    title: "Name",
                    data: currentUser.displayName!,
                    screenSize: screenSize,
                  ),
                  buildUserInfo(
                    context: context,
                    title: "Email",
                    data: currentUser.email!,
                    screenSize: screenSize,
                  ),
                  buildUserInfo(
                    context: context,
                    title: "Register On",
                    data: convertUkToIst(currentUser.metadata.creationTime!),
                    screenSize: screenSize,
                  ),
                  buildUserInfo(
                    context: context,
                    title: "Last Sign-In On",
                    data: convertUkToIst(currentUser.metadata.lastSignInTime!),
                    screenSize: screenSize,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
