//Create register screen that contains column , the column have 'create account text' ,4 textfilds with rounded border , register button(use elevated button) in the bottom of the textfield , use material design 2 best practice

import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../services/providers/providers.dart';
import '../widgets/auth screen widgets/auth_screen_widgets.dart';
import '../services/settings/routes/routes_constants.dart';
import '../utils/utils.dart';

//TODO: save the password with sharedPrefrences
final valueprovider = StateProvider<bool>(((ref) => false));

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends ConsumerState<LoginPage> {
  // Create a text controller and use it to retrieve the current value of the TextField.
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late TapGestureRecognizer _switchGestureRecognizer;
  late TapGestureRecognizer _resetGestureRecognizer;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _switchGestureRecognizer = TapGestureRecognizer()..onTap = handleSwitch;
    _resetGestureRecognizer = TapGestureRecognizer()..onTap = handleReset;
    super.initState();
  }

  handleSwitch() {
    context.go(Routes.signUpPagePath);
  }

  handleReset() {
    ref
        .read(authenticationProvider)
        .resetPassword(emailController.text.trim(), formState, context);
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
                    flex: 3,
                  ),
                  Text(
                    'Hello again!', // Changed font size and weight for better visibility

                    style: MyFonts.headline2(ColorPalett.textSecondary4),
                    // TextStyle(
                    //   fontSize: 28,
                    //   fontWeight: FontWeight.bold,
                    //   color: const Color(0xFFE22697).withAlpha(210),
                    // ),
                  ),

                  //addVerticalSpace(10),
                  const Spacer(
                    flex: 2,
                  ),

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: ref.watch(valueprovider),
                            onChanged: (value) =>
                                ref.read(valueprovider.notifier).state = value!,
                            checkColor: ColorPalett.textSecondary1,
                            fillColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.disabled)) {
                                  return ColorPalett.textSecondary1;
                                }
                                 return ColorPalett.textPrimary2.withAlpha(150);
                              },
                            ),
                            shape: const CircleBorder(
                              side: BorderSide(
                                  color: ColorPalett.textSecondary3,
                                  width: 0.2),
                            ),
                          ),
                          Text(
                            'Remember Password',
                            style: MyFonts.text(ColorPalett.textPrimary1),
                          ),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Forgot?',
                          style: MyFonts.text(ColorPalett.textPrimary2),
                          recognizer: _resetGestureRecognizer,
                        ),
                      )
                    ],
                  ),
                  // Added ternary operator to check if email or password is entered
                  const Spacer(
                    flex: 1,
                  ),
                  //addVerticalSpace(10),
                  AuthButton(
                      text: 'SIGN IN',
                      onPressed: () {
                        ref
                            .read(authenticationProvider)
                            .logInWithEmailAndPassword(context,
                                formState: formState,
                                email: emailController.text.trim(),
                                password: passwordController.text.trim());
                        log('log in in login page');
                        ref.read(appStateManagerProvider.notifier).isLoggedIn();
                        log('appstatemanger isloggedin');
                      }),
                  const Spacer(
                    flex: 1,
                  ),
                  const OrDivider(),
                  const Spacer(
                    flex: 1,
                  ),
                  const GoogleElevatedButton(),
                  addVerticalSpace(20),
                  CustomAuthRichText(
                    tapGestureRecognizer: _switchGestureRecognizer,
                    text1: "Don't have an account? ",
                    text2: 'Sign up',
                  ),

                  const Spacer(
                    flex: 1,
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

class GoogleElevatedButton extends ConsumerWidget {
  const GoogleElevatedButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton(
      style: ButtonStyle(
        side: MaterialStateProperty.all<BorderSide>(
            const BorderSide(color: ColorPalett.textSecondary3, width: 1.3)),
        backgroundColor:
            MaterialStateProperty.all<Color>(Colors.white.withAlpha(10)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
      ),
      onPressed: () async {
        final user =
            await ref.read(authenticationProvider).handleSignInWithGoogle();
        log('login with google');
        ref.read(appStateManagerProvider.notifier).isLoggedInWithGoogle(user);
        log('appstatemanager with google');
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 24,
              child: Image.asset(
                'assets/images/google-logo.png',
                fit: BoxFit.cover,
              )),
          addHorizantalSpace(18),
          Text(
            'Login with Google ',
            style: MyFonts.buttonText(ColorPalett.textPrimary1),
          )
        ],
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  const OrDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          flex: 3,
          child: Divider(
            thickness: 0.2,
            color: ColorPalett.textPrimary2,
          ),
        ),
        Expanded(
          child: Text(
            'or',
            textAlign: TextAlign.center,
            style: MyFonts.text(ColorPalett.textSecondary3),
          ),
        ),
        const Expanded(
          flex: 3,
          child: Divider(
            thickness: 0.2,
            color: ColorPalett.textPrimary2,
          ),
        ),
      ],
    );
  }
}
