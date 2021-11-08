import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

export 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuthException, FirebaseException;

class AuthService {
  const AuthService();

  Stream<User?> get userChanges => _firebaseAuth.userChanges();
  User? get currentUser => _firebaseAuth.currentUser;

  Future<UserCredential> signInWithFacebook() async {
    final facebookAuth = FacebookAuth.instance;

    final loginResult = await facebookAuth.login();

    final accessToken = loginResult.accessToken!.token;

    final facebookAuthCredential = FacebookAuthProvider.credential(accessToken);

    return _firebaseAuth.signInWithCredential(facebookAuthCredential);
  }

  // TODO: signInWithApple

  // TODO: signInWithGoogle

  Future<void> signOut() => _firebaseAuth.signOut();

  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
}
