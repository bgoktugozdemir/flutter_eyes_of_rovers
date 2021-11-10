import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart'
    as facebook_auth;
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

const _mockFirebaseUserUid = 'mock-uid';
const _mockFirebaseUserEmail = 'mock-email';
const _mockFirebaseDisplayName = 'mock-name';

class MockAccessToken extends Mock implements facebook_auth.AccessToken {}

class MockFirebaseAuth extends Mock implements firebase_auth.FirebaseAuth {}

class MockFirebaseUser extends Mock implements firebase_auth.User {}

class MockFacebookAuth extends Mock implements facebook_auth.FacebookAuth {}

class MockLoginResult extends Mock implements facebook_auth.LoginResult {}

class MockUserCredential extends Mock implements firebase_auth.UserCredential {}

class FakeAuthCredential extends Fake implements firebase_auth.AuthCredential {}

class FakeAuthProvider extends Fake implements AuthProvider {}

class FakeOAuthCredential extends Fake
    implements firebase_auth.OAuthCredential {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFirebase.channel.setMockMethodCallHandler((call) async {
    if (call.method == 'Firebase#initializeCore') {
      return [
        {
          'name': defaultFirebaseAppName,
          'options': {
            'apiKey': '123',
            'appId': '123',
            'messagingSenderId': '123',
            'projectId': '123',
          },
          'pluginConstants': const <String, String>{},
        }
      ];
    } else if (call.method == 'Firebase#initializeApp') {
      final arguments = call.arguments as Map<String, dynamic>;

      return <String, dynamic>{
        'name': arguments['appName'],
        'options': arguments['options'],
        'pluginConstants': const <String, String>{},
      };
    }

    return null;
  });

  Firebase.initializeApp();

  const user = User(
    id: _mockFirebaseUserUid,
    email: _mockFirebaseUserEmail,
    name: _mockFirebaseDisplayName,
  );

  group('AuthenticationRepository', () {
    late firebase_auth.FirebaseAuth firebaseAuth;
    late facebook_auth.FacebookAuth facebookAuth;
    late AuthenticationRepository authenticationRepository;

    setUpAll(() {
      registerFallbackValue(FakeAuthCredential());
      registerFallbackValue(FakeAuthProvider());
      registerFallbackValue(FakeOAuthCredential());
    });

    setUp(() {
      firebaseAuth = MockFirebaseAuth();
      facebookAuth = MockFacebookAuth();
      authenticationRepository = AuthenticationRepository(
        firebaseAuth: firebaseAuth,
        facebookAuth: facebookAuth,
      );
    });

    test('creates FirebaseAuth instance internally when not injected', () {
      expect(() => AuthenticationRepository(), isNot(throwsException));
    });

    group('signInWithFacebook', () {
      const token = 'access-token';

      setUp(() {
        final loginResult = MockLoginResult();
        final accessToken = MockAccessToken();
        when(() => loginResult.accessToken).thenReturn(accessToken);
        when(() => accessToken.token).thenReturn(token);
        when(() => facebookAuth.login()).thenAnswer((_) async => loginResult);
        when(() => firebaseAuth.signInWithCredential(any()))
            .thenAnswer((_) async => MockUserCredential());
      });

      test('calls login authentication and signInWithCredential', () async {
        await authenticationRepository.signInWithFacebook();

        verify(() => facebookAuth.login()).called(1);
        verify(() => firebaseAuth.signInWithCredential(any())).called(1);
      });

      test('succeds when signIn succeeds', () {
        expect(authenticationRepository.signInWithFacebook(), completes);
      });

      test('throws SignInWithFacebook when exception occurs', () async {
        when(() => firebaseAuth.signInWithCredential(any()))
            .thenThrow(Exception());

        expect(
          authenticationRepository.signInWithFacebook(),
          throwsA(isA<SignInWithFacebookFailure>()),
        );
      });
    });

    group('signOut', () {
      test('calls signOut', () async {
        when(() => firebaseAuth.signOut()).thenAnswer((_) async => {});
        when(() => facebookAuth.logOut()).thenAnswer((_) async => {});

        await authenticationRepository.signOut();

        verify(() => firebaseAuth.signOut()).called(1);
        verify(() => facebookAuth.logOut()).called(1);
      });

      test('throws SignOutFailure when signOut throws', () {
        when(() => firebaseAuth.signOut()).thenThrow(Exception());

        expect(
          authenticationRepository.signOut(),
          throwsA(isA<SignOutFailure>()),
        );
      });
    });

    group('user', () {
      test('emits User.empty when firebase user is null', () async {
        when(() => firebaseAuth.authStateChanges())
            .thenAnswer((_) => Stream.value(null));

        await expectLater(
            authenticationRepository.user, emitsInAnyOrder(<User>[User.empty]));
      });

      test('emits User when firebase user is not null', () async {
        final firebaseUser = MockFirebaseUser();

        when(() => firebaseUser.uid).thenReturn(_mockFirebaseUserUid);
        when(() => firebaseUser.email).thenReturn(_mockFirebaseUserEmail);
        when(() => firebaseUser.displayName)
            .thenReturn(_mockFirebaseDisplayName);
        when(() => firebaseUser.photoURL).thenReturn(null);
        when(() => firebaseAuth.authStateChanges())
            .thenAnswer((_) => Stream.value(firebaseUser));

        await expectLater(
          authenticationRepository.user,
          emitsInOrder(const <User>[user]),
        );
      });
    });

    group('currentUser', () {
      test('returns User.empty when user is null', () {
        when(() => firebaseAuth.currentUser).thenReturn(null);

        expect(authenticationRepository.currentUser, equals(User.empty));
      });

      final firebaseUser = MockFirebaseUser();
      test('returns User when user is not null', () async {
        when(() => firebaseUser.uid).thenReturn(_mockFirebaseUserUid);
        when(() => firebaseUser.email).thenReturn(_mockFirebaseUserEmail);
        when(() => firebaseUser.displayName)
            .thenReturn(_mockFirebaseDisplayName);
        when(() => firebaseUser.photoURL).thenReturn(null);
        when(() => firebaseAuth.currentUser).thenReturn((firebaseUser));

        expect(authenticationRepository.currentUser, equals(user));
      });
    });
  });
}
