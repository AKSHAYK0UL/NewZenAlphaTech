import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newzenalphatech/bloc/auth_bloc/bloc/auth_bloc.dart';
import 'package:newzenalphatech/core/enums/auth_enums.dart';
import 'package:newzenalphatech/core/ui_component/loadingbutton.dart';
import 'package:newzenalphatech/model/user.dart';
import 'package:newzenalphatech/presentation/auth/screen/signin.dart';

class SignUpTextfield extends StatefulWidget {
  const SignUpTextfield({super.key});

  @override
  State<SignUpTextfield> createState() => _SignUpTextfieldState();
}

class _SignUpTextfieldState extends State<SignUpTextfield> {
  final ValueNotifier<bool> showPassword = ValueNotifier<bool>(true);

  final ValueNotifier<bool> showConfirmPassword = ValueNotifier<bool>(true);

  final _formKey = GlobalKey<FormState>();

  User user = User(name: "", email: "", password: "");

  String? _password;

  void onSignUp(BuildContext context) {
    bool isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    _formKey.currentState!.save();
    FocusManager.instance.primaryFocus?.unfocus();
    context.read<AuthBloc>().add(
          SignUpEvent(user: user),
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
                "Hello! Register to get started",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            SizedBox(
              height: screenSize.height * 0.0333,
            ),
            TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Name";
                }
                return null;
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: screenSize.height * 0.016,
                  vertical: screenSize.height * 0.020,
                ),
                hintText: "Name",
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
              onSaved: (name) {
                user.name = name!;
              },
            ),
            SizedBox(
              height: screenSize.height * 0.024,
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
              height: screenSize.height * 0.024,
            ),
            ValueListenableBuilder(
              valueListenable: showPassword,
              builder: (context, value, _) {
                return TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter password";
                    }
                    if (value.length < 8) {
                      return "Password should be ≥ 8 chars long";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _password = value;
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
                      icon: Icon(
                        value ? Icons.visibility_off : Icons.visibility,
                      ),
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
              height: screenSize.height * 0.024,
            ),
            ValueListenableBuilder(
              valueListenable: showConfirmPassword,
              builder: (context, value, _) {
                return TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Confirm password";
                    }
                    if (_password != value) {
                      return "Confirm Password does not match";
                    }
                    return null;
                  },
                  obscureText: value,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: screenSize.height * 0.016,
                      vertical: screenSize.height * 0.020,
                    ),
                    hintText: "Confirm Password",
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    suffixIcon: IconButton(
                      icon: Icon(
                        value ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        showConfirmPassword.value = !showConfirmPassword.value;
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
                  textInputAction: TextInputAction.done,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(fontSize: screenSize.height * 0.032),
                );
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
                          onSignUp(context);
                        },
                        child: const Text("SignUp"),
                      );
              },
            ),
            SizedBox(
              height: screenSize.height * 0.020,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    Signin.routeName, (route) => false);
              },
              child: Text(
                "Already have an account?",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
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
