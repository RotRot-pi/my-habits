import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../utils/colors/app_colors.dart';
import '../../utils/themes/text_theme.dart';

class BlurEffect extends StatelessWidget {
  const BlurEffect({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          color: Colors.black.withOpacity(0),
        ),
      ),
    );
  }
}

class AuthBackGroundImage extends StatelessWidget {
  const AuthBackGroundImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.55,
      child: Image.asset(
        'assets/images/white-purple-circles.png',
        fit: BoxFit.fitHeight,
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);
  final String text;
  final onPressed;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(ColorPalett.textSecondary3),
            fixedSize: MaterialStateProperty.all<Size>(
                Size.fromWidth(constrains.maxWidth)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ))),
        child: Text(text),
      );
    });
  }
}

class UserNameTextField extends StatelessWidget {
  const UserNameTextField({
    Key? key,
    required this.controller,
    required this.hint,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: TextFormField(
        keyboardType: TextInputType.name,
        showCursor: true,
        cursorColor: ColorPalett.textSecondary3,
        cursorWidth: 0.8,
        cursorRadius: const Radius.circular(18),
        controller: controller,
        validator: (value) {
          if (value!.trim().length < 4) {
            return 'use at least 4 character name';
          }
          if (value.trim().length > 12) {
            return 'use less than 12 character name';
          }
          return null;
        },
        decoration: InputDecoration(hintText: hint),
      ),
    );
  }
}

// InputDecoration textFieldDecoration(String hint) {
//   return InputDecoration(
//       hintText: hint,
//       hintStyle: const TextStyle(
//         fontSize: 14,
//         fontWeight: FontWeight.bold,
//       ),
//       enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(20),
//           borderSide:
//               const BorderSide(color: ColorPalett.textSecondary3, width: 1.4)),
//       focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(20),
//           borderSide:
//               const BorderSide(color: ColorPalett.textSecondary3, width: 1.4)),
//       contentPadding: const EdgeInsets.symmetric(
//         vertical: 12,
//         horizontal: 16,
//       ));
// }

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    Key? key,
    required this.controller,
    required this.hint,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30,
        child: TextFormField(
          key: const Key('EmailFormField'),
          keyboardType: TextInputType.emailAddress,
          showCursor: true,
          cursorColor: ColorPalett.textSecondary3,
          cursorWidth: 0.8,
          cursorRadius: const Radius.circular(18),
          controller: controller,
          validator: (value) {
            if (!value!.trim().contains('@') || !value.trim().contains('.')) {
              return 'enter a correct email please';
            }
          },
          decoration: InputDecoration(hintText: hint),
        ));
  }
}

class PasswordTextField extends StatelessWidget {
  PasswordTextField({
    Key? key,
    required this.controller,
    required this.hint,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final ValueNotifier<bool> shows = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30,
        child: ValueListenableBuilder(
            valueListenable: shows,
            builder: (context, valueListenable, child) {
              return TextFormField(
                showCursor: true,
                cursorColor: ColorPalett.textSecondary3,
                cursorWidth: 0.8,
                cursorRadius: const Radius.circular(18),
                controller: controller,
                validator: (value) {
                  if (value!.trim().length < 8) {
                    return 'use at least 8 character password';
                  }
                  if (value.trim().length > 20) {
                    return 'use less than 20 character password';
                  }
                  return null;
                },
                obscureText: shows.value,
                decoration: InputDecoration(
                    hintText: hint,
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (shows.value == false) {
                          debugPrint('value:${shows.value}');
                          shows.value = true;
                        } else if (shows.value == true) {
                          debugPrint('value2:${shows.value}');
                          shows.value = false;
                        }
                      },
                      icon: shows.value
                          ? const Icon(
                              Icons.visibility,
                              color: Colors.black,
                              size: 16,
                            )
                          : const Icon(
                              Icons.visibility_off,
                              color: Colors.black,
                              size: 16,
                            ),
                    )),
              );
            }));
  }
}

class ConfirmPasswordTextField extends StatelessWidget {
  ConfirmPasswordTextField({
    Key? key,
    required this.controller,
    required this.hint,
    required this.password,
  }) : super(key: key);

  final TextEditingController controller;
  final TextEditingController password;
  final String hint;

  final ValueNotifier<bool> shows = ValueNotifier<bool>(true);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 30,
        child: ValueListenableBuilder(
          valueListenable: shows,
          builder: (context, value, child) {
            return TextFormField(
              showCursor: true,
              cursorColor: ColorPalett.textSecondary3,
              cursorWidth: 0.8,
              cursorRadius: const Radius.circular(18),
              controller: controller,
              validator: (value) {
                if (value!.trim() != password.text.trim()) {
                  debugPrint('value:$value \npassword:$password');
                  return 'please confirme your password';
                }
                return null;
              },
              obscureText: shows.value,
              decoration: InputDecoration(
                  hintText: hint,
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (shows.value == false) {
                        debugPrint('value:${shows.value}');
                        shows.value = true;
                      } else if (shows.value == true) {
                        debugPrint('value2:${shows.value}');
                        shows.value = false;
                      }
                    },
                    icon: shows.value == true
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  )),
            );
          },
        ));
  }
}

class CustomAuthRichText extends StatelessWidget {
  const CustomAuthRichText({
    Key? key,
    required TapGestureRecognizer tapGestureRecognizer,
    required this.text1,
    required this.text2,
  })  : _tapGestureRecognizer = tapGestureRecognizer,
        super(key: key);

  final TapGestureRecognizer _tapGestureRecognizer;
  final String text1;
  final String text2;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
            text: text1,
            style: MyFonts.body2(ColorPalett.textPrimary1),
            children: [
              TextSpan(
                  text: text2,
                  style: MyFonts.body2(ColorPalett.textPrimary2),
                  recognizer: _tapGestureRecognizer)
            ]),
      ),
    );
  }
}
