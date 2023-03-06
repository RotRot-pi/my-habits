import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_habits/services/providers/providers.dart';
import 'package:my_habits/services/settings/routes/pages_routes.dart';
import 'package:my_habits/utils/colors/app_colors.dart';

import 'firebase_options.dart';


main() async {
  var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterNativeSplash.remove();
  runApp(const ProviderScope(child: MyHabits()));
}

class MyHabits extends ConsumerWidget {
  const MyHabits({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
    GlobalKey<NavigatorState>? shellKey = GlobalKey<NavigatorState>();
    GoogleFonts.config.allowRuntimeFetching = false;
    final authState = ref.watch(authStateChangesProvider);
    final appState = ref.watch(appStateManagerProvider);

    // ref.read(authenticationProvider).signout();
    return MaterialApp.router(
      theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
              hintStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                      color: ColorPalett.textSecondary3, width: 1.3)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                      color: ColorPalett.textSecondary3, width: 1.4)),
              // focusedErrorBorder: OutlineInputBorder(
              //     borderRadius: BorderRadius.circular(20),
              //     borderSide: const BorderSide(
              //         color: Colors.red, width: 1.4)),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ))),
      debugShowMaterialGrid: false,
      routerConfig: PagesRoutes.routePages(navigatorKey, shellKey, authState,appState),
    );
  }
}
