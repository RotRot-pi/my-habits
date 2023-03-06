import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:my_habits/services/settings/routes/routes_constants.dart';
import 'package:my_habits/widgets/scaffold_bottom_navigation_bar.dart';

import '../../../pages/pages.dart';
import '../../models/app_state.dart';

class PagesRoutes {
  static routePages(var navigatorKey, var shellKey, AsyncValue<User?> authState,
      AppState appState) {
    final GoRouter router = GoRouter(
      initialLocation: Routes.signUpPagePath,
      navigatorKey: navigatorKey,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: Routes.signUpPagePath,
          name: Routes.signUpPageName,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: SignUpPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          ),
        ),
        GoRoute(
          path: Routes.logInPagePath,
          name: Routes.logInPageName,
          pageBuilder: (context, state) => CustomTransitionPage(
            key: state.pageKey,
            child: LoginPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          ),
        ),
        GoRoute(
          path: Routes.onboardingPagePath,
          name: Routes.onboardingPageName,
          pageBuilder: (context, state) =>
              NoTransitionPage(child: OnboardingPage()),
        ),
        ShellRoute(
          navigatorKey: shellKey,
          builder: (context, state, child) =>
              ScaffoldWithBottomNavBar(child: child),
          routes: [
            GoRoute(
              path: Routes.homePagePath,
              name: Routes.homePageName,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: HomePage()),
            ),
            GoRoute(
              path: Routes.createPagePath,
              name: Routes.createPageName,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: CreatePage()),
            ),
            GoRoute(
              path: Routes.progressPagePath,
              name: Routes.progressPageName,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ProgressPage()),
            ),
            GoRoute(
              path: Routes.motivationgPagePath,
              name: Routes.motivationgPageName,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: MotivationPage()),
            ),
            GoRoute(
              path: Routes.settingPagePath,
              name: Routes.settingPageName,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: SettingPage()),
            ),
          ],
        ),
      ],
      //TODO:fix redirect when you sign out

      redirect: (context, state) {
        //is he in login page
        if (authState.isLoading || authState.hasError) return null;
        // debugPrint('authState.valueOrNull:${authState.valueOrNull}');
        //final isLoggedIn = authState.valueOrNull != null;
        final isLoggedIn = appState.isLoggedIn;
        final isInSigninPage = state.location == Routes.signUpPagePath;
        final isInLoginPage = state.location == Routes.logInPagePath;
        final isInHomePage= state.location == Routes.homePagePath;
        final isInOnboardingPage = state.location ==Routes.onboardingPagePath;
        if (isLoggedIn && isInSigninPage) {
          log('authstate:${authState.valueOrNull}');
          log('isloggedin :$isLoggedIn');
          if (appState.isOnboardingComplete) {
            log('appstate 1:${appState.isOnboardingComplete}');
            return Routes.homePagePath;
          } else {
            log('appstate 2:${appState.isOnboardingComplete}');
            return Routes.onboardingPagePath;
          }
        }
        if (  isInLoginPage && isLoggedIn||isInOnboardingPage&&isLoggedIn) {
          return Routes.homePagePath;
        }
        if(isInHomePage && !isLoggedIn){
          return Routes.signUpPagePath;
        }
        // // if (!isLoggedIn) {
        //   return !isInSigninPage ? Routes.signUpPagePath : null;
        // }
        // debugPrint('authState.valueOrNull2:${authState.valueOrNull}');
        // final isAuthenticated = authState.valueOrNull != null;
        // final isInLoginPage = state.location == Routes.logInPagePath;
        // final isInSigninPage = state.location == Routes.signInPagePath;
        //variable for onboarding page ,home page

        // return !isAuthenticated ? Routes.signInPagePath : Routes.homePagePath;
        return null;
      },
    );
    return router;
  }
}
