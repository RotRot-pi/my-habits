import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_habits/services/functions/auth_fun.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'firebase_auth_provider.g.dart';

@riverpod
FirebaseAuth firebaseAuthInstance(FirebaseAuthInstanceRef ref) =>
    FirebaseAuth.instance;
@riverpod
FirebaseFirestore firebaseFirestore(FirebaseFirestoreRef ref) =>
    FirebaseFirestore.instance;

@riverpod
Stream<User?> authStateChanges(AuthStateChangesRef ref) {
  final authStateChanges =
      ref.watch(firebaseAuthInstanceProvider).authStateChanges();
  return authStateChanges;
}

@riverpod
Authentication authentication(AuthenticationRef ref) {
  final authentication = Authentication(
      ref.watch(firebaseAuthInstanceProvider),
      ref.watch(authStateChangesProvider),
      ref.watch(firebaseFirestoreProvider));
  return authentication;
}

//TODO:make the rest of firebase CRUD operations
//TODO: make the tests for firebase CRUD operations
//TODO: make the onboarding page 