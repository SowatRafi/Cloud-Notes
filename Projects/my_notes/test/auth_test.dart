import 'package:my_notes/code_repeat.dart';
import 'package:my_notes/services/auth/auth_exception.dart';
import 'package:my_notes/services/auth/auth_provider.dart';
import 'package:my_notes/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final provider = MockAuthProvider();

    test('Should not be initialized to begin with', () {
      expect(
        provider.isInitialized,
        false,
      );
    });

    test("Can't log out if not initialized", () {
      expect(
        provider.logOut(),
        throwsA(const TypeMatcher<NotInitializedExcepttion>()),
      );
    });

    test('Should able to initialized', () async {
      await provider.initialize();
      expect(
        provider.isInitialized,
        true,
      );
    });

    test('Should be null after initialization', () {
      expect(
        provider.currentUser,
        null,
      );
    });

    test(
      'Should be able to initialize in less than 2 seconds',
      () async {
        await provider.initialize();
        expect(
          provider.isInitialized,
          true,
        );
      },
      timeout: const Timeout(
        Duration(seconds: 2),
      ),
    );

    test('Create user should delegate to logIn function', () async {
      final badEmailUser = provider.createUser(
        email: "first.last@email.com",
        password: "anypassword",
      );
      expect(
        badEmailUser,
        throwsA(
          const TypeMatcher<UserNotFoundAuthException>(),
        ),
      );

      final badPasswordUser = provider.createUser(
        email: "someone@email.com",
        password: "password",
      );
      expect(
        badPasswordUser,
        throwsA(
          const TypeMatcher<WrongPasswordAuthException>(),
        ),
      );

      final user = await provider.createUser(
        email: "first",
        password: "pass",
      );
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });

    test("Logged in user should be able to get verified", () {
      provider.sendEmailVerification();
      final user = provider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });

    test("Should be able to log out and log in again", () async {
      await provider.logOut();
      await provider.logIn(
        email: 'email',
        password: 'password',
      );
      final user = provider.currentUser;
      expect(
        user,
        isNotNull,
      );
    });
  });
}

class NotInitializedExcepttion implements Exception {}

class MockAuthProvider implements AuthProvider {
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;
  AuthUser? _user;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    // createUser
    if (!isInitialized) throw NotInitializedExcepttion();
    CodeRepeat().waiting(1);

    return logIn(
      email: email,
      password: password,
    );
  }

  @override
  // currentUser
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    // initialize
    CodeRepeat().waiting(1);
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) {
    // logIn
    if (!isInitialized) throw NotInitializedExcepttion();
    if (email == "first.last@email.com") throw UserNotFoundAuthException();
    if (password == "password") throw WrongPasswordAuthException();
    const user = AuthUser(isEmailVerified: false);
    _user = user;

    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    // logOut
    if (!isInitialized) throw NotInitializedExcepttion();
    if (_user == null) throw UserNotFoundAuthException();
    CodeRepeat().waiting(1);
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    // sendEmailVerification
    if (!isInitialized) throw NotInitializedExcepttion();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(isEmailVerified: true);
    _user = newUser;
  }
}
