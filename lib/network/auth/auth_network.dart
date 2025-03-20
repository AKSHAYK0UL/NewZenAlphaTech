import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class AuthNetwork {
  final FirebaseAuth _firebaseAuthInstance;
  AuthNetwork({required FirebaseAuth firebaseAuth})
      : _firebaseAuthInstance = firebaseAuth;

  //signUp
  Future<void> signUp(String name, String email, String password) async {
    try {
      //create user
      await _firebaseAuthInstance.createUserWithEmailAndPassword(
          email: email, password: password);

      //update name
      await _firebaseAuthInstance.currentUser?.updateDisplayName(name);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //verification
  Future<bool> verifyEmail() async {
    try {
      Duration checkInterval = const Duration(seconds: 3);
      Duration timeout = const Duration(minutes: 2);
      // Get the current user
      var user = _firebaseAuthInstance.currentUser!;
      if (user.emailVerified) return true;

      await user.sendEmailVerification();
      final startTime = DateTime.now();

      while (!user.emailVerified &&
          DateTime.now().difference(startTime) < timeout) {
        await Future.delayed(checkInterval);
        await user.reload();
        user = _firebaseAuthInstance.currentUser!;
      }

      return user.emailVerified;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //signIn
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuthInstance.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //forgot password
  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuthInstance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //signout
  Future<void> signOut() async {
    try {
      await _firebaseAuthInstance.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
