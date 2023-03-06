import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  // ignore: prefer_typing_uninitialized_variables
  final _authState;

  Authentication(this._auth, this._authState, this._firestore);
  get authState => _authState;

  createAccountWithEmailAndPassword(
    BuildContext context, {
    required GlobalKey<FormState> formState,
    required String username,
    required String email,
    required String password,
  }) async {
    // if (password.trim() != confirmPassword.trim()) {
    //   showDialog(
    //       context: context!,
    //       builder: (context) => const AlertDialog(
    //             content: Text('Please confirme your password'),
    //           ));
    // }
    var formData = formState.currentState;
    if (formData!.validate()) {
      formData.save();
      try {
        final userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        debugPrint('create done');

        await _firestore.collection('users').doc(userCredential.user!.uid).set(
          {
            'id': userCredential.user!.uid,
            'username': username,
            'email': email,
          },
        );
        debugPrint('create cloud done');
        return userCredential;
      } on FirebaseAuthException catch (e) {
        log('Failed with firebase exception:${e.code}');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text('e1: ${e.message}'),
          ),
        );
      } catch (e) {
        debugPrint('e2:${e.toString()}');

        rethrow;
      }
    } else if (!formData.validate()) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text('Please check that every field is correct'),
        ),
      );
    }
  }

  logInWithEmailAndPassword(
    BuildContext context, {
    required GlobalKey<FormState> formState,
    required String email,
    required String password,
  }) async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      try {
        final userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        return 'Successful log in';
      } on FirebaseAuthException catch (e) {
        log('Failed with firebase exception:${e.code}');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text('e1: ${e.message}'),
          ),
        );
      } catch (e) {
        rethrow;
      }
    } else if (!formData.validate()) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text('Please check that every field is correct'),
        ),
      );
    }
  }

  void resetPassword(String email, GlobalKey<FormState> formState,
      BuildContext context) async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      try {
        await _auth.sendPasswordResetEmail(email: email);
        log('Reset password link sent');
      } on FirebaseAuthException catch (e) {
        log('Failed with error code: ${e.code}');
        log('${e.message}');
      } catch (e) {
        log('reset password error: $e');
      }
    } else if (!formData.validate()) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          content: Text('Please check that every field is correct'),
        ),
      );
    }
  }

  signout() async {
    await _auth.signOut();
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
log('step1');
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
log('step2');
    // Create a new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
log('step3');
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<bool?> handleSignInWithGoogle() async {
    try {
      // Sign in with Google and get the UserCredential
      UserCredential userCredential = await signInWithGoogle();
log('step1');

      // Get the User object from the UserCredential
      User? user = userCredential.user;
log('step2');

      // Check if the user is new or existing
      bool isNewUser = userCredential.additionalUserInfo!.isNewUser;
log('step3');
      // Display a welcome message or navigate to another screen
      if (isNewUser) {
        log('Welcome, ${user?.displayName}');
        // navigate to onboarding
        log('step4');
        return isNewUser;
      } else {
        log('Welcome back, ${user?.displayName}');
        //navigate to home
        log('step5');
        return isNewUser;
      }
    } on PlatformException catch (e) {
      log('platformexception error:${e.code}');
      log('error in handle signin :${e.message}');
    } catch (e) {
      log('message:$e');
    }
    return null;
  }
}
