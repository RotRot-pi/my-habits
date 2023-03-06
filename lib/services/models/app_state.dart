class AppState {
  // final bool isInitialized;
  final bool isLoggedIn;
  final bool isOnboardingComplete;

  AppState({
    // this.isInitialized = false,
    this.isLoggedIn = false,
    this.isOnboardingComplete = false,
  });

  AppState copyWith({
    bool? isLoggedIn,
    bool? isOnboardingComplete,
  }) {
    return AppState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isOnboardingComplete: isOnboardingComplete ?? this.isOnboardingComplete,
    );
  }
}
