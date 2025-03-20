import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzenalphatech/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:newzenalphatech/core/enums/auth_enums.dart';
import 'package:newzenalphatech/core/ui_component/snackbar.dart';
import 'package:newzenalphatech/presentation/auth/widget/signintextfield.dart';
import 'package:newzenalphatech/presentation/home/screen/home.dart';

class Signin extends StatefulWidget {
  static const routeName = "/signin";
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
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
                  state.errorSource == AuthEnum.signIn) {
                //show snackbar
                buildSnackbar(context, state.errorMessage);
              }
              if (state is AuthSuccessState &&
                  state.successSource == AuthEnum.signIn) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(Home.routeName, (route) => false);
              }
            },
            child: const SignInTextfield(),
          ),
        ),
      ),
    );
  }
}
