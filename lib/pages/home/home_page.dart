import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_habits/utils/colors/app_colors.dart';
import 'package:my_habits/utils/constants/constants.dart';
import 'package:my_habits/utils/themes/text_theme.dart';

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
              AllTaskDoneHomeScreenCircle(screen: screen),
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

class NoGoalsHomeScreenCircle extends StatelessWidget {
  const NoGoalsHomeScreenCircle({
    super.key,
    required this.screen,
  });

  final Size screen;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screen.height * 0.3,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: 170,
            height: 170,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: ColorPalett.pagePrimary1,
                shape: BoxShape.circle,
                boxShadow: [
                  const BoxShadow(
                    offset: Offset(4, 4),
                    color: ColorPalett.pagePrimary3,
                    spreadRadius: 2,
                    blurRadius: 5,
                    // inset: true,
                  ),
                  BoxShadow(
                      offset: const Offset(-4, -4),
                      color: ColorPalett.pageSecondary1.withOpacity(0.5),
                      blurRadius: 5,
                      spreadRadius: 2
                      // inset: true,
                      ),
                  // BoxShadow(
                  //   offset: const Offset(-1, -1),
                  //   color: ColorPalett.pageSecondary1.withAlpha(200),
                  //   spreadRadius: 0,
                  //   blurRadius: 2,
                  // ),
                  // const BoxShadow(
                  //   offset: Offset(1, 1),
                  //   color: ColorPalett.pagePrimary3,
                  //   blurRadius: 2,
                  // ),
                ],
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      ColorPalett.pagePrimary1,
                      ColorPalett.pagePrimary1,
                      ColorPalett.pagePrimary1,
                      ColorPalett.pagePrimary3,
                    ],
                    stops: [
                      0.1,
                      1,
                      1,
                      0.1
                    ])),
          ),
        ),
      ),
    );
  }
}

class AllTaskDoneHomeScreenCircle extends StatelessWidget {
  const AllTaskDoneHomeScreenCircle({
    super.key,
    required this.screen,
  });

  final Size screen;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screen.height * 0.3,
      child: Center(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 170,
                height: 170,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: ColorPalett.pagePrimary1,
                    shape: BoxShape.circle,
                    boxShadow: [
                      const BoxShadow(
                        offset: Offset(4, 4),
                        color: ColorPalett.pagePrimary3,
                        spreadRadius: 2,
                        blurRadius: 5,
                        // inset: true,
                      ),
                      BoxShadow(
                          offset: const Offset(-4, -4),
                          color: ColorPalett.pageSecondary1.withOpacity(0.5),
                          blurRadius: 5,
                          spreadRadius: 2
                          // inset: true,
                          ),
                      BoxShadow(
                        offset: const Offset(-1, -1),
                        color: ColorPalett.pageSecondary1.withOpacity(0.2),
                        blurRadius: 5,
                      ),
                      const BoxShadow(
                        offset: Offset(1, 1),
                        color: ColorPalett.pagePrimary3,
                        blurRadius: 2,
                      ),
                    ],
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          ColorPalett.pagePrimary1,
                          ColorPalett.pagePrimary1,
                          ColorPalett.pagePrimary1,
                          ColorPalett.pagePrimary3,
                        ],
                        stops: [
                          0.1,
                          1,
                          1,
                          0.1
                        ])),
              ),
            ),
            Positioned(
              left: 120,
              top: 20,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 100,
                  height: 100,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ColorPalett.pagePrimary1,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(3, 3),
                        color: ColorPalett.pageSecondary1.withAlpha(200),
                        blurRadius: 7,
                      ),
                      const BoxShadow(
                        offset: Offset(-4, -4),
                        color: ColorPalett.pagePrimary3,
                        blurRadius:7,
                      ),
                 
                    ],
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,

                        colors: [
                          ColorPalett.pagePrimary3,
                          ColorPalett.pagePrimary1,
                          ColorPalett.pagePrimary1,
                          ColorPalett.pagePrimary1,
                        ],
                        stops: [
                          0.1,
                          0.3,
                          0.9,
                          1
                        ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
