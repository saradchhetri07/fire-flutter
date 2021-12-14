import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireflutter/models/user.dart';
import 'package:flutter/cupertino.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService extends ChangeNotifier {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool _isSigning = false;
  
  User? getuser() {
    return _firebaseAuth.currentUser;
  }

  Stream<User?> get authstatechanges => _firebaseAuth.authStateChanges();

  AuthenticationService();

  //final googlesignin = GoogleSignIn().signIn();

  bool get isSigning => _isSigning;

  set isSigning(bool isSigning) {
    _isSigning = isSigning;
    notifyListeners();
  }

  //final user = GoogleSignIn().signIn();
  firebaseUser? _userfromfirebase(User user) {
    return user != null ? firebaseUser(user.uid) : null;
  }

  Future<firebaseUser?> signIn(String _email, String _password) async {
    try {
      final res = await _firebaseAuth.signInWithEmailAndPassword(
          email: _email, password: _password);

      final newUser = res.user;

      return _userfromfirebase(newUser!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<firebaseUser?> signUp(String _email, String _password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: _email, password: _password);

      final newUser = userCredential.user;

      return _userfromfirebase(newUser!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }
  }

  Future signout() async {
    await _firebaseAuth.signOut();
  }
}
