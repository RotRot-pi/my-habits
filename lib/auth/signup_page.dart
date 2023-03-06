//Create register screen that contains column , the column have 'create account text' ,4 textfilds with rounded border , register button(use elevated button) in the bottom of the textfield , use material design 2 best practice

import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


import '../services/services.dart';
import '../utils/utils.dart';
import '../widgets/auth screen widgets/auth_screen_widgets.dart';



class SignUpPage extends ConsumerStatefulWidget {
  // Create a text controller and use it to retrieve the current value of the TextField.

  const SignUpPage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SignUpPageState();
}

class SignUpPageState extends ConsumerState<SignUpPage> {
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController userNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TapGestureRecognizer _tapGestureRecognizer;
  @override
  void initState() {
    userNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    _tapGestureRecognizer = TapGestureRecognizer()..onTap = handleTap;
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  handleTap() {
    context.go(Routes.logInPagePath);
  }

  goToOnboarding() {
    context.go(Routes.onboardingPagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const AuthBackGroundImage(),
          const BlurEffect(),
          Container(
            padding: const EdgeInsets.all(40),
            child: Form(
              key: formState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Changed from 4 separate TextFields to 2 with a ternary operator for obscureText property
                  const Spacer(
                    flex: 1,
                  ),
                  Text(
                    'Create \nAccount', // Changed font size and weight for better visibility

                    style: MyFonts.headline2(ColorPalett.textSecondary4),
                    // TextStyle(
                    //   fontSize: 28,
                    //   fontWeight: FontWeight.bold,
                    //   color: const Color(0xFFE22697).withAlpha(210),
                    // ),
                  ),

                  // addVerticalSpace(10),
                  const Spacer(
                    flex: 1,
                  ),
                  UserNameTextField(
                    controller: userNameController,
                    hint: 'Name',
                  ),

                  addVerticalSpace(10),

                  EmailTextField(
                    controller: emailController,
                    hint: 'Email',
                  ),
                  addVerticalSpace(10),

                  // Added ternary operator to check if email or password is entered
                  PasswordTextField(
                    controller: passwordController,
                    hint: 'Password',
                  ),
                  addVerticalSpace(10),

                  // Added ternary operator to check if email or password is entered
                  ConfirmPasswordTextField(
                    controller: confirmPasswordController,
                    password: passwordController,
                    hint: 'Confirm Password',
                  ), // Added ternary operator to check if email or password is entered
                  const Spacer(
                    flex: 1,
                  ),
                  // addVerticalSpace(10),
                  AuthButton(
                      text: 'REGISTER',
                      onPressed: () {
                        ref
                            .read(authenticationProvider)
                            .createAccountWithEmailAndPassword(context,
                                formState: formState,
                                username: userNameController.text.trim(),
                                email: emailController.text.trim(),
                                password: passwordController.text.trim());
                        log('create accont on sign up page');
                        ref.read(appStateManagerProvider.notifier).isLoggedIn();
                        log('appstatemanager isloggedin');
                        // ref.read(appStateManagerProvider.notifier).isLogout();
                      }),

                  const Spacer(
                    flex: 1,
                  ),
                  addVerticalSpace(20),
                  CustomAuthRichText(
                    tapGestureRecognizer: _tapGestureRecognizer,
                    text1: 'Do you have an account? ',
                    text2: 'Log in',
                  ),
                  const Spacer(
                    flex: 3,
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
