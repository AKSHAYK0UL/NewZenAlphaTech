import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_mail/open_mail.dart';
import 'package:newzenalphatech/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:newzenalphatech/core/enums/auth_enums.dart';
import 'package:newzenalphatech/core/ui_component/snackbar.dart';
import 'package:newzenalphatech/presentation/auth/widget/forgotpasswordtextfield.dart';

class ForgotPassword extends StatefulWidget {
  static const routeName = "/forgot";

  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  void showPasswordSentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Reset Password',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        content: Text(
          'Reset password link has been sent to your Email.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Close',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await OpenMail.openMailApp();
            },
            child: Text(
              'Open Mail',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ],
      ),
    );
  }

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
                  state.errorSource == AuthEnum.forgot) {
                //show snackbar
                buildSnackbar(context, state.errorMessage);
              }
              if (state is AuthSuccessState &&
                  state.successSource == AuthEnum.forgot) {
                //show dialog
                showPasswordSentDialog(context);
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
                const ForgotPasswordTextField(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
