import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_habits/services/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends ConsumerWidget {
  final controller = PageController();
  final Color rwColor = const Color.fromRGBO(64, 143, 77, 1);

  OnboardingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log('onboarding');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0.0,
          title: const Text('Getting Started'),
        ),
        body: Column(
          children: [
            Expanded(child: buildPages()),
            buildIndicator(),
            buildActionButtons(context, ref),
          ],
        ),
      ),
    );
  }

  Widget buildActionButtons(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MaterialButton(
          child: const Text('Skip'),
          onPressed: () {
            ref.read(appStateManagerProvider.notifier).isOnboardingComplete();
            context.go(Routes.homePagePath);
            // Provider.of<AppStateManager>(context, listen: false)
            //     .completeOnboarding();
          },
        ),
      ],
    );
  }

  Widget buildPages() {
    return PageView(
      controller: controller,
      children: [
        onboardPageView(
          '''Check out weekly recommended recipes and what your friends are cooking!''',
          Container(
            color: Colors.amber,
          ),
        ),
        onboardPageView(
          'Cook with step by step instructions!',
          Container(
            color: Colors.red,
          ),
        ),
        onboardPageView(
          'Keep track of what you need to buy',
          Container(
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget onboardPageView(
    // ImageProvider imageProvider,
    String text,
    Widget child,
  ) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: child,
            // child: Image(
            //   fit: BoxFit.fitWidth,
            //   image: imageProvider,
            // ),
          ),
          const SizedBox(height: 16),
          Text(
            text,
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget buildIndicator() {
    return SmoothPageIndicator(
      controller: controller,
      count: 3,
      effect: WormEffect(activeDotColor: rwColor),
    );
  }
}
