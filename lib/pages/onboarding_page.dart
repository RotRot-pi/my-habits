import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_habits/services/services.dart';
import 'package:my_habits/utils/colors/app_colors.dart';
import 'package:my_habits/utils/constants/constants.dart';
import 'package:my_habits/utils/themes/text_theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends ConsumerWidget {
  final controller = PageController(initialPage: 0);

  OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log('onboarding');
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.black,
        //   elevation: 0.0,
        //   title: const Text('Getting Started'),
        // ),
        body: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              border: Border.all(
            width: 3.0,
            color: ColorPalett.textSecondary3,
          )),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    child: const Text('Skip'),
                    onPressed: () {
                      ref
                          .read(appStateManagerProvider.notifier)
                          .isOnboardingComplete();
                      context.go(Routes.homePagePath);
                    },
                  ),
                ],
              ),
              Expanded(child: buildPages()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildIndicator(),
                  buildActionButtons(context, ref),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildActionButtons(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MaterialButton(
          child: const Text('Next'),
          onPressed: () {
            if (controller.page! < 2) {
              debugPrint('controller.page:${controller.page}');
              debugPrint('controller.init:${controller.initialPage}');
              controller.nextPage(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut);
            }
            if (controller.page == 2) {
              debugPrint('controller.page 2 :${controller.page}');
              ref.read(appStateManagerProvider.notifier).isOnboardingComplete();
              context.go(Routes.homePagePath);
            }
          },
        ),
      ],
    );
  }

  Widget buildPages() {
    return PageView(
      controller: controller,
      onPageChanged: (index){
        
      },
      children: [
        onboardPageView(
            const AssetImage('assets/images/image1.png'),
            'Welcome To Routiner',
            "it's the most useful and easiest way to plan and check your routines."),
        onboardPageView(
            const AssetImage('assets/images/image2.png'),
            'Track your process',
            'Track your process daily weekly and monthly. it provide easy access to graphical and linear statics.'),
        onboardPageView(
            const AssetImage('assets/images/image3.png'),
            'Customizable Screen',
            'Custom your Home Screen as You wish\nAll colors markers and icons for you.'),
      ],
    );
  }

  Widget onboardPageView(
    ImageProvider imageProvider,
    String title,
    String content,
  ) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Image(
              fit: BoxFit.fitHeight,
              image: imageProvider,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: MyFonts.headline2(Colors.black),
                    textAlign: TextAlign.start,
                  ),
                  addVerticalSpace(16),
                  Text(
                    content,
                    style: MyFonts.body(Colors.black),
                    textAlign: TextAlign.start,
                  ),
                ],
              )),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget buildIndicator() {
    return SmoothPageIndicator(
      controller: controller,
      count: 3,
      effect: const WormEffect(activeDotColor: ColorPalett.textSecondary3),
    );
  }
}
