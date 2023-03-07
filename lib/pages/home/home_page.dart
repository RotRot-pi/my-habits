import 'dart:developer';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_habits/utils/colors/app_colors.dart';
import 'package:my_habits/utils/constants/constants.dart';
import 'package:my_habits/utils/themes/text_theme.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorPalett.pagePrimary1,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              addVerticalSpace(screen.height * 0.15),
              SizedBox(
                height: screen.height * 0.3,
                child: Center(
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      color: ColorPalett.pagePrimary1,
                      shape: BoxShape.circle,
                      boxShadow: [
                        const BoxShadow(
                          offset: Offset(-4, -4),
                          color: ColorPalett.pagePrimary3,
                          spreadRadius: 3,
                          blurRadius: 8,
                          inset: true,
                        ),
                        BoxShadow(
                          offset: const Offset(3, 3),
                          color: ColorPalett.pageSecondary1.withAlpha(200),
         
                          blurRadius: 5,
                          inset: true,
                        ),
                        BoxShadow(
                          offset: const Offset(-1, -1),
                          color: ColorPalett.pageSecondary1.withAlpha(200),
                          spreadRadius: 0,
                          blurRadius: 2,
                        ),
                        const BoxShadow(
                          offset: Offset(1, 1),
                          color: ColorPalett.pagePrimary3,
                     
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              Text(
                'No goals yet!',
                textAlign: TextAlign.center,
                style: MyFonts.headline1(ColorPalett.textPrimary3),
              ),
              addVerticalSpace(48),
              Text(
                'Add your first goal and start\nto built great habits',
                textAlign: TextAlign.center,
                style: MyFonts.headline1(ColorPalett.textPrimary3),
              ),
            ]),
      ),
    );
  }
}
