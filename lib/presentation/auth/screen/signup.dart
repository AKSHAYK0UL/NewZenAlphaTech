import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzenalphatech/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:newzenalphatech/core/enums/auth_enums.dart';
import 'package:newzenalphatech/core/ui_component/snackbar.dart';
import 'package:newzenalphatech/presentation/auth/screen/verification.dart';
import 'package:newzenalphatech/presentation/auth/widget/signuptextfield.dart';

class Signup extends StatefulWidget {
  static const routeName = "/signup";

  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) => previous != current,
            listener: (context, state) {
              if (state is AuthErrorState &&
                  state.errorSource == AuthEnum.signUp) {
                //show snackbar
                buildSnackbar(context, state.errorMessage);
              }
              if (state is AuthSuccessState &&
                  state.successSource == AuthEnum.signUp) {
                //Naviagate to verification screen
                Navigator.of(context).pushNamed(Verification.routeName);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 25,
                  ),
                ),
                const SignUpTextfield(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
