import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_habits/services/models/app_state.dart';


// Use the generated provider



final appStateManagerProvider =
    StateNotifierProvider<AppStateManager, AppState>(
  (ref) => AppStateManager(AppState()),
);

class AppStateManager extends StateNotifier<AppState> {
  AppStateManager(super.state);

  void isLoggedIn() {
    state = state.copyWith(isLoggedIn: true);
  }

  void isLoggedInWithGoogle(bool? isNewUser) {
    if (isNewUser!) {
      state = state.copyWith(isLoggedIn: true);
    } else if (!isNewUser) {
      state = state.copyWith(isOnboardingComplete: true);
    } else {
      log('error in isloggedinwithgoogle');
    }
  }

  void isOnboardingComplete() {
    state = state.copyWith(isOnboardingComplete: true);
  }

  void isLogout() {
    state = AppState();
  }
}
