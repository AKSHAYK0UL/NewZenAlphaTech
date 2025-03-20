import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzenalphatech/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:newzenalphatech/core/enums/auth_enums.dart';
import 'package:newzenalphatech/core/ui_component/loadingbutton.dart';
import 'package:newzenalphatech/model/user.dart';
import 'package:newzenalphatech/presentation/auth/screen/forgotpassword.dart';
import 'package:newzenalphatech/presentation/auth/screen/signup.dart';

class SignInTextfield extends StatefulWidget {
  const SignInTextfield({super.key});

  @override
  State<SignInTextfield> createState() => _SignInTextfieldState();
}

class _SignInTextfieldState extends State<SignInTextfield> {
  final ValueNotifier<bool> showPassword = ValueNotifier<bool>(true);

  final _formKey = GlobalKey<FormState>();

  User user =
      User(name: "", email: "", password: ""); //name field will be empty

  void onSignIn(BuildContext context) {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    _formKey.currentState!.save();
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<AuthBloc>().add(
          SignInEvent(user: user),
        );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      margin: EdgeInsets.only(
          top: screenSize.height * 0.0347,
          left: screenSize.height * 0.020,
          right: screenSize.height * 0.020),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: MediaQuery.viewInsetsOf(context).bottom > 0
                  ? 0
                  : screenSize.height * 0.115,
              child: Text(
                "Welcome back! Glad to see you, Again!",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.0427,
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
                user.email = email!;
              },
            ),
            SizedBox(
              height: screenSize.height * 0.0267,
            ),
            ValueListenableBuilder(
              valueListenable: showPassword,
              builder: (context, value, _) {
                return TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter password";
                    }

                    return null;
                  },
                  obscureText: value,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: screenSize.height * 0.016,
                      vertical: screenSize.height * 0.020,
                    ),
                    hintText: "Password",
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    suffixIcon: IconButton(
                      icon:
                          Icon(value ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        showPassword.value = !showPassword.value;
                      },
                    ),
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
                  onSaved: (password) {
                    user.password = password!;
                  },
                );
              },
            ),
            SizedBox(
              height: screenSize.height * 0.0267,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(Signup.routeName);
                  },
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "Register Now",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(ForgotPassword.routeName);
                  },
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "Forgot Password?",
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenSize.height * 0.0400,
            ),
            BlocBuilder<AuthBloc, AuthState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                return state is AuthLoadingState &&
                        state.loadingSource == AuthEnum.signIn
                    ? buildLoadingButton(
                        screenSize.height * 1,
                        screenSize.height * 0.0747,
                      )
                    : ElevatedButton(
                        onPressed: () {
                          onSignIn(context);
                        },
                        child: Text(
                          "SignIn",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(
                                  fontSize: screenSize.height * 0.0213,
                                  color: Colors.white),
                        ),
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
