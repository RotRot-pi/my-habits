// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDB7qaLJC_j1I_47RhTukyZJzvDK1m9tqw',
    appId: '1:458959175277:web:bd21448c635d819b320964',
    messagingSenderId: '458959175277',
    projectId: 'my-habits-e34e3',
    authDomain: 'my-habits-e34e3.firebaseapp.com',
    storageBucket: 'my-habits-e34e3.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCBwZ3foSWCcFxlr3ygR01i8hG6pYUs3sY',
    appId: '1:458959175277:android:165fcf2bb4b18ec0320964',
    messagingSenderId: '458959175277',
    projectId: 'my-habits-e34e3',
    storageBucket: 'my-habits-e34e3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDvXIc6nvB8VZkjJ_n3hDJIH43K7NcEfls',
    appId: '1:458959175277:ios:d36ffe9e208a66d4320964',
    messagingSenderId: '458959175277',
    projectId: 'my-habits-e34e3',
    storageBucket: 'my-habits-e34e3.appspot.com',
    iosClientId: '458959175277-hhtrusvp29c85k2rs1nj1b6dfsdkd37s.apps.googleusercontent.com',
    iosBundleId: 'com.example.myHabits',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDvXIc6nvB8VZkjJ_n3hDJIH43K7NcEfls',
    appId: '1:458959175277:ios:d36ffe9e208a66d4320964',
    messagingSenderId: '458959175277',
    projectId: 'my-habits-e34e3',
    storageBucket: 'my-habits-e34e3.appspot.com',
    iosClientId: '458959175277-hhtrusvp29c85k2rs1nj1b6dfsdkd37s.apps.googleusercontent.com',
    iosBundleId: 'com.example.myHabits',
  );
}
