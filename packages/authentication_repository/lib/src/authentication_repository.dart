import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart'
    as facebook_auth;

class AuthenticationRepository {
  AuthenticationRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    facebook_auth.FacebookAuth? facebookAuth,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _facebookAuth = facebookAuth ?? facebook_auth.FacebookAuth.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final facebook_auth.FacebookAuth _facebookAuth;

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty()] if the user is not authenticated.
  Stream<User> get user =>
      _firebaseAuth.authStateChanges().map((firebaseUser) =>
          firebaseUser == null ? User.empty() : firebaseUser.toUser());

  /// Returns the current user.
  /// Defaults to [User.empty()] if there is no user.
  User get currentUser => _firebaseAuth.currentUser?.toUser() ?? User.empty();

  /// Starts the Sign In with Facebook flow.
  ///
  /// Throws a [SignInWithFacebookFailure] if an exception occurs.
  Future<void> signInWithFacebook() async {
    late final firebase_auth.AuthCredential credential;

    try {
      final loginResult = await _facebookAuth.login();
      final accessToken = loginResult.accessToken!.token;

      credential = firebase_auth.FacebookAuthProvider.credential(accessToken);

      await _firebaseAuth.signInWithCredential(credential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignInWithFacebookFailure.fromCode(e.code);
    } catch (_) {
      print(_);
      throw const SignInWithFacebookFailure();
    }
  }

  Future<void> signOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _facebookAuth.logOut(),
      ]);
    } catch (_) {
      throw const SignOutFailure();
    }
  }
}

extension on firebase_auth.User {
  User toUser() => User(
        id: uid,
        email: email,
        name: displayName,
        photo: photoURL,
      );
}
