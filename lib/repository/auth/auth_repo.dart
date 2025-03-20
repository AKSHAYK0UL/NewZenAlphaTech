import 'package:firebase_auth/firebase_auth.dart';
import 'package:newzenalphatech/model/user.dart' as u;
import 'package:newzenalphatech/network/auth/auth_network.dart';

class AuthRepo {
  final AuthNetwork _authNetwork;
  AuthRepo({required AuthNetwork authNetwork}) : _authNetwork = authNetwork;

  //signUp
  Future<void> signUp(u.User user) async {
    try {
      await _authNetwork.signUp(user.name, user.email, user.password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //verify
  Future<bool> verifyEmail() async {
    try {
      return await _authNetwork.verifyEmail();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //signIn
  Future<void> signIn(u.User user) async {
    try {
      await _authNetwork.signIn(user.email, user.password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //forgot
  Future<void> forgotPassword(String email) async {
    try {
      await _authNetwork.forgotPassword(email);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //sigOut
  Future<void> signOut() async {
    try {
      await _authNetwork.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
