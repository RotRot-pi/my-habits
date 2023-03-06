// import 'package:flutter/material.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:my_habits/services/functions/auth_fun.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:my_habits/services/providers/firebase_auth_provider.dart';

// class MockUser extends Mock implements User {
//   static final MockUser _mockUser = MockUser();
// }

// class MockFirebaseAuth extends Mock implements FirebaseAuth {
//   @override
//   Stream<User> authStateChanges() {
//     return Stream.fromIterable([MockUser._mockUser]);
//   }
// }

// class MockUserCredential extends Mock implements UserCredential {}

// void main() async {
//   late MockFirebaseAuth mockFirebaseAuth;
//   late ProviderContainer providerContainer;
//   late MockUserCredential mockUserCredential;

//   setUpAll(() async {
//     mockFirebaseAuth = MockFirebaseAuth();
//     mockUserCredential = MockUserCredential();
//     providerContainer = ProviderContainer(overrides: [
//       authenticationProvider.overrideWithValue(
//         Authentication(mockFirebaseAuth, mockFirebaseAuth.authStateChanges()),
//       )
//     ]);
//   });
//   group('authentication tests ', () {
//     test('occur user', () async {
//       expectLater(providerContainer.read(authenticationProvider).authState,
//           emitsInOrder([MockUser._mockUser]));
//     });
//     test('create an account ', () async {
//       String email = 'email@gmail.com', password = '12345678', name = 'example';
//       BuildContext? context;

//       when(
//         () => mockFirebaseAuth.createUserWithEmailAndPassword(
//             email: email, password: password),
//       ).thenAnswer((_) async => mockUserCredential);
//       expect(
//           await providerContainer
//               .read(authenticationProvider)
//               .createAccountWithEmailAndPassword(
//                 context,
//                 username: name,
//                 email: email,
//                 password: password,
//               ),
//           'Successful sign up');
//     });
//     test('create an account exception', () async {
//       String email = 'email@gmail.com',
//           password = '12345678',
//           name = 'example',
//           confirmPassword = '12345678';
//       BuildContext? context;
//       when(
//         () => mockFirebaseAuth.createUserWithEmailAndPassword(
//             email: email, password: password),
//       ).thenAnswer((_) async => throw FirebaseAuthException(
//           code: 'FirebaseAuthException',
//           message: 'FirebaseAuthException in create account'));
//       expect(
//           await providerContainer
//               .read(authenticationProvider)
//               .createAccountWithEmailAndPassword(
//                 context,
//                 username: name,
//                 email: email,
//                 password: password,
//               ),
//           'FirebaseAuthException in create account');
//     });
//     test('log in ', () async {
//       String email = 'email@gmail.com', password = '12345678';
//       BuildContext? context;
//       when(
//         () => mockFirebaseAuth.signInWithEmailAndPassword(
//             email: email, password: password),
//       ).thenAnswer((_) async => mockUserCredential);
//       expect(
//           await providerContainer
//               .read(authenticationProvider)
//               .logInWithEmailAndPassword(context,
//                   email: email, password: password),
//           'Successful log in');
//     });
//     test('log in exception ', () async {
//       String email = 'email@gmail.com', password = '12345678';
//       BuildContext? context;
//       when(
//         () => mockFirebaseAuth.signInWithEmailAndPassword(
//             email: email, password: password),
//       ).thenAnswer((_) async => throw FirebaseAuthException(
//           code: 'FirebaseAuthException',
//           message: 'FirebaseAuthException in login'));
//       expect(
//           await providerContainer
//               .read(authenticationProvider)
//               .logInWithEmailAndPassword(context,
//                   email: email, password: password),
//           'FirebaseAuthException in login');
//     });

//     test('sign out', () async {
//       when(
//         () => mockFirebaseAuth.signOut(),
//       ).thenAnswer((_) async => _);
//       expect(await providerContainer.read(authenticationProvider).signout(),
//           isA<void>());
//     });
//   });
// }
