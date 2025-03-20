import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzenalphatech/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:newzenalphatech/core/enums/auth_enums.dart';
import 'package:newzenalphatech/core/ui_component/loadingbutton.dart';

class ForgotPasswordTextField extends StatefulWidget {
  const ForgotPasswordTextField({super.key});

  @override
  State<ForgotPasswordTextField> createState() =>
      _ForgotPasswordTextFieldState();
}

class _ForgotPasswordTextFieldState extends State<ForgotPasswordTextField> {
  final ValueNotifier<bool> showPassword = ValueNotifier<bool>(true);

  final ValueNotifier<bool> showConfirmPassword = ValueNotifier<bool>(true);

  final _formKey = GlobalKey<FormState>();

  String? _email;

  void onSForgotPassword(BuildContext context) {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    _formKey.currentState!.save();
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<AuthBloc>().add(
          ForgotPasswordEvent(email: _email!),
        );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      margin: EdgeInsets.only(
        top: screenSize.height * 0.0267,
        left: screenSize.height * 0.020,
        right: screenSize.height * 0.020,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: MediaQuery.viewInsetsOf(context).bottom > 0
                  ? 0
                  : screenSize.height * 0.110,
              child: Text(
                "Reset Password",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter email";
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: screenSize.height * 0.016,
                  vertical: screenSize.height * 0.020,
                ),
                hintText: "Email",
                filled: true,
                fillColor: Colors.grey.shade100,
                border: buildOutlineInputBorder(Colors.blueGrey.shade50),
                enabledBorder:
                    buildOutlineInputBorder(Colors.blueGrey.shade100),
                focusedBorder:
                    buildOutlineInputBorder(Colors.blueGrey.shade800),
                errorBorder: buildOutlineInputBorder(Colors.red),
                hintStyle: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: Colors.blueGrey.shade500),
              ),
              textInputAction: TextInputAction.next,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontSize: screenSize.height * 0.032),
              onSaved: (email) {
                _email = email!;
              },
            ),
            SizedBox(
              height: screenSize.height * 0.0400,
            ),
            BlocBuilder<AuthBloc, AuthState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                return state is AuthLoadingState &&
                        state.loadingSource == AuthEnum.signUp
                    ? buildLoadingButton(
                        screenSize.height * 1,
                        screenSize.height * 0.0747,
                      )
                    : ElevatedButton(
                        onPressed: () {
                          onSForgotPassword(context);
                        },
                        child: const Text("Reset"),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}

OutlineInputBorder buildOutlineInputBorder(Color color) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: color, width: 1.5),
  );
}
