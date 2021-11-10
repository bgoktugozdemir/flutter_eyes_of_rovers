/// {@template authentication_failure}
/// Abstract class for all AuthenticationFailures
/// Thrown if during the authentication process if a failure occurs.
/// {@endtemplate}

abstract class AuthenticationFailure implements Exception {
  /// {@macro authentication_failure}
  const AuthenticationFailure(this.message);

  /// The associated error message.
  final String message;
}

/// {@template sign_in_with_facebook_failure}
/// Thrown if during the sign up process if a failure occurs.
/// {@endtemplate}
class SignInWithFacebookFailure implements AuthenticationFailure {
  /// {@macro sign_in_with_facebook_failure}
  const SignInWithFacebookFailure(
      [this.message =
          'Something went wrong during the signing in with Facebook.'])
      : super();

  factory SignInWithFacebookFailure.fromCode(String code) {
    /// For more info about the error codes:
    /// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithCredential.html
    switch (code) {

      /// Thrown if there already exists an account with the email address
      /// asserted by the credential. Resolve this by calling
      /// [fetchSignInMethodsForEmail](https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/fetchSignInMethodsForEmail.html)
      /// and then asking the user to sign in using one of the returned
      /// providers. Once the user is signed in, the original credential can be
      /// linked to the user with linkWithCredential.
      case 'account-exists-with-different-credential':
        return const SignInWithFacebookFailure(
          'TAccount exists with different credentials.',
        );

      /// Thrown if the credential is malformed or has expired.
      case 'invalid-credential':
        return const SignInWithFacebookFailure(
          'The credential received is malformed or has expired.',
        );

      /// Thrown if the type of account corresponding to the credential
      /// is not enabled. Enable the account type in the Firebase Console,
      /// under the Auth tab.
      case 'operation-not-allowed':
        return const SignInWithFacebookFailure(
          'Operation is not allowed. Please, contact support.',
        );

      /// Thrown if the user corresponding to the given credential has been
      /// disabled.
      case 'user-disabled':
        return const SignInWithFacebookFailure(
          'The user has been disabled. Please, contact support for help.',
        );

      /// Thrown if signing in with a credential from
      /// [EmailAuthProvider.credential](https://pub.dev/documentation/firebase_auth_platform_interface/6.1.4/firebase_auth_platform_interface/EmailAuthProvider/credential.html)
      /// and there is no user corresponding to the given email.
      case 'user-not-found':
        return const SignInWithFacebookFailure(
          'Email is not found, please create an account.',
        );

      /// Thrown if signing in with a credential from
      /// [EmailAuthProvider.credential](https://pub.dev/documentation/firebase_auth_platform_interface/6.1.4/firebase_auth_platform_interface/EmailAuthProvider/credential.html)
      /// and the password is invalid for the given email, or if the account
      /// corresponding to the email does not have a password set.
      case 'wrong-password':
        return const SignInWithFacebookFailure(
          'Incorrect password, please try again.',
        );

      /// Thrown if the credential is a
      /// [PhoneAuthProvider.credential](https://pub.dev/documentation/firebase_auth_platform_interface/6.1.4/firebase_auth_platform_interface/PhoneAuthProvider/credential.html)
      /// and the verification code of the credential is not valid.
      case 'invalid-verification-code':
        return const SignInWithFacebookFailure(
          'he credential verification code received is invalid.',
        );

      /// Thrown if the credential is a
      /// [PhoneAuthProvider.credential](https://pub.dev/documentation/firebase_auth_platform_interface/6.1.4/firebase_auth_platform_interface/PhoneAuthProvider/credential.html)
      /// and the verification ID of the credential is not valid.id.
      case 'invalid-verification-id':
        return const SignInWithFacebookFailure(
          'he credential verification ID received is invalid.',
        );
      default:
        return const SignInWithFacebookFailure();
    }
  }

  @override
  final String message;
}

/// Thrown during the signout process if a failure occurs.
class SignOutFailure implements AuthenticationFailure {
  const SignOutFailure([this.message = 'Something went wrong.']);

  @override
  final String message;
}
